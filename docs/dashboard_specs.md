# PEHCHAN DASHBOARD ARCHITECTURE & PROMPTS

## Common implementation rules
Build this as a Flutter + Dart cross-platform application. Do not replace Flutter with React, Next.js or plain HTML/CSS.
Use Material 3, Riverpod, go_router, Firebase Auth/Firestore/Cloud Storage, Clean Architecture and Repository Pattern. Make every dashboard responsive for Android, iOS, Web and Desktop.
Design language: modern social-impact SaaS, trustworthy, human, professional, nature-inspired green with blue support, warm neutral background, white cards, 16–20px radius, strong typography, subtle shadows, accessible contrast, meaningful icons, minimal gradients.

Use a shared responsive shell:
- Mobile: AppBar + NavigationBar
- Tablet: NavigationRail
- Desktop/Web: NavigationRail or NavigationDrawer + top header

Every data screen needs loading, populated, empty and error states. Use reusable Flutter widgets such as StatCard, StatusChip, SectionHeader, FilterBar, ChartCard, EmptyState, ErrorState, LoadingSkeleton and ConfirmDialog.
Do not create dead buttons. Every action should work or be clearly disabled.

---

## 1. NGO Event Management Dashboard
Goal: Manage active/upcoming events, volunteer registration, capacity, and attendance.
Key features: KPI cards, upcoming events table, event status overview, registration trend, volunteer capacity, calendar preview, impact preview, create event flow.

## 2. Volunteer Management Dashboard
Goal: Track volunteers, approvals, assignments, hours, and attendance.
Key features: KPI cards, volunteer directory, pending approvals, event coverage, volunteer hours, volunteer profile, attendance marking, certificate eligibility.

## 3. Certificate Generation Dashboard
Goal: Manage and generate certificates for eligible volunteers.
Key features: Certificate queue, eligibility rules (requires registration, attendance, and completion), single/bulk generation flow, certificate preview, public verification route.

## 4. Money Donations Dashboard
Goal: Track financial inflows, donors, and donation purposes.
Key features: KPI cards, donation trend chart, purpose breakdown (donut chart), recent donations list, detailed donation view.

## 5. Material Donations Dashboard
Goal: Manage physical donations and inventory.
Key features: Inbox for pending receipts, detail screen, receive flow, inventory preview (quantities of items), category breakdown.

## 6. NGO Wallet Dashboard
Goal: Internal financial ledger for funds.
Key features: Hero balance, KPI cards, cash flow chart, transaction history, financial analytics. No manual balance editing.

## 7. Expense Management Dashboard
Goal: Create, review, approve, and track expenses.
Key features: Expense queue, pending approvals, create expense form (with receipt upload), approval flow linked to wallet debit.

## 8. Social Impact Tracking Dashboard
Goal: Measure real-world impact metrics.
Key features: KPI cards (hours, trees planted, etc.), impact trend chart, event impact details, volunteer contribution, impact stories.

## 9. Shared Role-Aware Dashboard
Goal: Role-specific home pages utilizing a shared shell.
- Volunteer: Events, certificates, impact, donations.
- NGO: Events, volunteers, wallet, inventory, impact.
- Admin: Platform oversight, NGO verification, system metrics.
