import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/auth_provider.dart';
import '../../../shared/models/enums.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildConstrained({required Widget child, double maxWidth = 1200}) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider);
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildConstrained(child: _buildHeader(context, isDesktop)),
            const SizedBox(height: 32),
            if (isDesktop)
              _buildConstrained(
                child: Padding(
                  key: _homeKey,
                  padding: const EdgeInsets.symmetric(horizontal: 64.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _buildHeroText(context, user)),
                      Expanded(child: _buildHeroImage()),
                    ],
                  ),
                ),
              )
            else
              _buildConstrained(
                child: Padding(
                  key: _homeKey,
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      _buildHeroImage(),
                      const SizedBox(height: 32),
                      _buildHeroText(context, user),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 64),
            Container(key: _featuresKey, child: _buildFeaturesSection(context)),
            const SizedBox(height: 64),
            Container(key: _aboutKey, child: _buildAboutSection(context)),
            Container(key: _contactKey, child: _buildGetInTouchSection(context)),
            _buildNewsletterSection(context),
            _buildFooterSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.eco_rounded, color: AppTheme.emerald, size: 32),
              const SizedBox(width: 8),
              Text(
                'Pehchan',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          if (isDesktop)
            Row(
              children: [
                _buildNavTextButton('Home', _homeKey),
                const SizedBox(width: 24),
                _buildNavTextButton('Features', _featuresKey),
                const SizedBox(width: 24),
                _buildNavTextButton('About Us', _aboutKey),
                const SizedBox(width: 24),
                _buildNavTextButton('Get in Touch', _contactKey),
              ],
            ),
          Row(
            children: [
              TextButton(
                onPressed: () => context.push('/verify'),
                style: TextButton.styleFrom(foregroundColor: AppTheme.emerald),
                child: const Text('Verify Certificate', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => context.push('/sign-in'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.emerald,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNavTextButton(String text, GlobalKey key) {
    return TextButton(
      onPressed: () => _scrollTo(key),
      style: TextButton.styleFrom(
        foregroundColor: Colors.black87,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      ),
      child: Text(text),
    );
  }

  Widget _buildHeroText(BuildContext context, user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.emerald.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "INDIA'S NGO MANAGEMENT SOFTWARE",
            style: TextStyle(
              color: AppTheme.emerald,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Empowering Non-Profits,\nOne Community at a Time',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w900,
            color: Colors.black87,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Pehchan is India's all-in-one NGO management software — donor CRM, volunteer tracking, certificate generation, and event management. Join the largest network of NGOs and volunteers to create sustainable social change.",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: 250,
          child: ElevatedButton(
            onPressed: () {
              if (user != null) {
                switch (user.role) {
                  case UserRole.volunteer:
                    context.go('/volunteer/overview');
                    break;
                  case UserRole.ngo:
                    context.go('/ngo/dashboard');
                    break;
                  case UserRole.admin:
                    context.go('/admin/dashboard');
                    break;
                  default:
                    context.go('/volunteer/overview');
                }
              } else {
                context.go('/volunteer/overview');
              }
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Get Started',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        image: const DecorationImage(
          image: AssetImage('assets/images/hero_volunteers.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: Colors.white,
      child: _buildConstrained(
        child: Column(
          children: [
            // Section Title
            Text(
            'We Change Your Life & World',
            style: TextStyle(
              fontFamily: 'Caveat', // Assuming a handwriting font if available, fallback to italic
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: Colors.redAccent.shade200,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Charity With Difference',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 60),
          
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1050) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.public,
                      iconColor: Colors.blue,
                      title: 'Get Inspire And Help',
                      description: 'Please donate to change the world if you are inspired by us.',
                    ),
                    const SizedBox(width: 32),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.volunteer_activism,
                      iconColor: Colors.orange,
                      title: 'Send Us Donations',
                      description: 'Want to help with this pandemic, please join us as a volunteer.',
                    ),
                    const SizedBox(width: 32),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.group,
                      iconColor: Colors.pink,
                      title: 'Become A Volunteer',
                      description: 'Creating a donation event can help us directly or indirectly.',
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.public,
                      iconColor: Colors.blue,
                      title: 'Get Inspire And Help',
                      description: 'Please donate to change the world if you are inspired by us.',
                    ),
                    const SizedBox(height: 32),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.volunteer_activism,
                      iconColor: Colors.orange,
                      title: 'Send Us Donations',
                      description: 'Want to help with this pandemic, please join us as a volunteer.',
                    ),
                    const SizedBox(height: 32),
                    _buildFeatureCard(
                      context: context,
                      icon: Icons.group,
                      iconColor: Colors.pink,
                      title: 'Become A Volunteer',
                      description: 'Creating a donation event can help us directly or indirectly.',
                    ),
                  ],
                );
              }
            },
          )
        ],
      ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          // Icon Illustration mimic
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppTheme.emerald.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Icon(icon, size: 64, color: iconColor),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              height: 1.5,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_circle, size: 16, color: Colors.black87),
            label: const Text(
              'READ MORE',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Pehchan: Where Passion Meets\nTechnology',
          style: TextStyle(
            fontSize: isDesktop ? 32 : 28,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF0F172A),
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 80,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Pehchan is India's NGO management and platform — built to empower non-profits with the tools they need to grow their donor base, streamline operations, and amplify their impact. We believe that every organisation working for the common good deserves access to world-class technology, regardless of its size or budget. We started Pehchan because we saw the same problem in NGO after NGO: passionate teams doing extraordinary work, held back by manual processes, scattered donor data, and no digital presence. We set out to change that.",
          style: TextStyle(
            fontSize: 16,
            height: 1.6,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    );

    Widget image = Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/about_us_high_res.jpg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 24, vertical: 40),
      child: _buildConstrained(
        child: isDesktop
            ? Row(
                children: [
                  Expanded(child: content),
                  const SizedBox(width: 80),
                  Expanded(child: image),
                ],
              )
            : Column(
                children: [
                  content,
                  const SizedBox(height: 40),
                  image,
                ],
              ),
      ),
    );
  }

  Widget _buildGetInTouchSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;
    
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAF9), // Light grayish green background
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 24, vertical: 80),
      child: _buildConstrained(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isDesktop)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Get in Touch',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "We're here to support those who change the world. Choose your path below\nto get the help you need.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.emerald.withOpacity(0.8),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.help_outline, color: Colors.black87, size: 18),
                  label: const Text('View Help Center FAQs', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.emerald.withOpacity(0.15),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Get in Touch',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "We're here to support those who change the world. Choose your path below to get the help you need.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.emerald.withOpacity(0.8),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.help_outline, color: Colors.black87, size: 18),
                  label: const Text('View Help Center FAQs', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.emerald.withOpacity(0.15),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
            
          const SizedBox(height: 48),
          
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildContactFormCard(
                        isDonor: true,
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: _buildContactFormCard(
                        isDonor: false,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildContactFormCard(isDonor: true),
                    const SizedBox(height: 32),
                    _buildContactFormCard(isDonor: false),
                  ],
                ),
        ],
      ),
      ),
    );
  }

  Widget _buildContactFormCard({required bool isDonor}) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.emerald.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isDonor ? Icons.favorite_border : Icons.handshake_outlined,
                  color: AppTheme.emerald,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isDonor ? 'I am a Donor' : 'I am an NGO Partner',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      isDonor ? 'Support for your impact journey' : 'Enterprise-grade operational support',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.emerald.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            isDonor 
                ? 'Find support for your donations, request tax receipts, and track your personal impact across global projects.'
                : 'Access technical documentation, manage your partnership tier, and connect with your dedicated account manager.',
            style: TextStyle(
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildQuickLink(isDonor ? Icons.verified_outlined : Icons.code, isDonor ? 'TAX RECEIPTS' : 'API DOCS'),
              const SizedBox(width: 24),
              _buildQuickLink(isDonor ? Icons.history : Icons.menu_book, isDonor ? 'DONATION HISTORY' : 'GRANT GUIDE'),
            ],
          ),
          const SizedBox(height: 32),
          
          Row(
            children: [
              Expanded(child: _buildTextField(isDonor ? 'YOUR NAME' : 'NGO NAME', 'John Doe')),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField(isDonor ? 'EMAIL ADDRESS' : 'PARTNER ID (OPTIONAL)', isDonor ? 'john@example.com' : 'NGO-12345')),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _buildTextField(isDonor ? 'MOBILE NUMBER' : 'CONTACT PERSON', isDonor ? '9876543210' : 'Your Name')),
              const SizedBox(width: 16),
              Expanded(child: _buildTextField(isDonor ? 'INQUIRY TYPE' : 'WORK EMAIL', isDonor ? 'Tax Receipt Request' : 'partner@ngo.org')),
            ],
          ),
          if (!isDonor) ...[
            const SizedBox(height: 16),
            _buildTextField('CONTACT PHONE', '9876543210'),
          ],
          const SizedBox(height: 16),
          _buildTextField(isDonor ? 'MESSAGE' : 'REQUEST DETAILS', isDonor ? 'How can we help you today?' : 'Details of your technical or partnership request...', maxLines: 4),
          const SizedBox(height: 24),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.send_outlined, size: 18),
              label: Text(
                isDonor ? 'Submit Donor Inquiry' : 'Request Partner Support',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Divider(color: Colors.grey.shade200),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              Text('Urgent? Email us at:', style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
              Text('bucolicmobilesolutions@gmail.com', style: TextStyle(color: AppTheme.emerald, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickLink(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.emerald),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: AppTheme.emerald,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF8FAF9),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsletterSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 24, vertical: 100),
      decoration: const BoxDecoration(
        color: Color(0xFF1E874B), // Emerald green background
        // To mimic the circular watermark lines, we could use a custom painter or a background image,
        // but for now we'll use a solid background with a subtle gradient to give it depth.
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.5,
          colors: [
            Color(0xFF26A65B),
            Color(0xFF1E874B),
          ],
        ),
      ),
      child: _buildConstrained(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
            'STAY CONNECTED',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'NGO Management Tips & Impact\nStories in Your Inbox',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: isDesktop ? 42 : 32,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: isDesktop ? 800 : double.infinity,
            child: Text(
              'Subscribe to the Pehchan newsletter for monthly NGO management guides, 80G & FCRA compliance updates, fundraising best practices, new NGO spotlights, and platform news. Join 10,000+ donors and NGO leaders already subscribed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 48),
          
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildEmailInput(),
                    const SizedBox(width: 16),
                    _buildSubscribeButton(),
                  ],
                )
              : Column(
                  children: [
                    _buildEmailInput(),
                    const SizedBox(height: 16),
                    _buildSubscribeButton(isExpanded: true),
                  ],
                ),
        ],
      ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Email Address',
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        ),
      ),
    );
  }

  Widget _buildSubscribeButton({bool isExpanded = false}) {
    final button = ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0F172A), // Dark blue/black color
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        elevation: 0,
      ),
      child: const Text(
        'Subscribe Now',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );

    if (isExpanded) {
      return SizedBox(width: double.infinity, child: button);
    }
    return button;
  }

  Widget _buildFooterSection(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFF1E2430), // Dark blue/gray background
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 24, vertical: 60),
      child: _buildConstrained(
        child: Column(
          children: [
            isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 2, child: _buildFooterBrand()),
                    Expanded(child: _buildFooterLinks('Quick Links', ['Home', 'Pricing'])),
                    Expanded(child: _buildFooterLinks('Legal', ['Refund Policy', 'Terms of Service', 'Privacy Policy'])),
                    Expanded(flex: 2, child: _buildFooterContact()),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFooterBrand(),
                    const SizedBox(height: 32),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildFooterLinks('Quick Links', ['Home', 'Pricing'])),
                        Expanded(child: _buildFooterLinks('Legal', ['Refund Policy', 'Terms of Service', 'Privacy Policy'])),
                      ],
                    ),
                    const SizedBox(height: 32),
                    _buildFooterContact(),
                  ],
                ),
          const SizedBox(height: 48),
          Divider(color: Colors.white.withOpacity(0.1)),
          const SizedBox(height: 24),
          Text(
            '© 2026 Bucolic solutions private limited. All rights reserved.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildFooterBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pehchan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Empowering Generosity, Changing Lives\nTogether',
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: () {},
                child: Text(
                  link,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildFooterContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        _buildContactRow(Icons.email_outlined, 'bucolicmobilesolutions@gmail.com'),
        const SizedBox(height: 12),
        _buildContactRow(Icons.phone_outlined, '+91 70000 82905'),
        const SizedBox(height: 12),
        _buildContactRow(Icons.location_on_outlined, 'M-163, XXX, Greater kailash II, Delhi\n110048'),
      ],
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.grey.shade400, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
