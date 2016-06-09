Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 17:10:25 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:39750 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27041232AbcFIPKBeMQ-Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Jun 2016 17:10:01 +0200
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 2/2] arch: mips: lantiq: use the real EXIN count
Date:   Thu,  9 Jun 2016 17:09:52 +0200
Message-Id: <1465484992-40808-2-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1465484992-40808-1-git-send-email-john@phrozen.org>
References: <1465484992-40808-1-git-send-email-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53963
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

We runtime load the available external interrupts into an array and store
the number inside exin_avail. Some of the code however uses MAX_EIU for
looping over the array which may partially be 0. This is a cosmetic fix as
the existing code works as is. It is just nicer to only loop over the array
elements that were actually populated during probe.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/lantiq/irq.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 6746d7f..0d39270 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -125,7 +125,7 @@ static int ltq_eiu_settype(struct irq_data *d, unsigned int type)
 {
 	int i;
 
-	for (i = 0; i < MAX_EIU; i++) {
+	for (i = 0; i < exin_avail; i++) {
 		if (d->hwirq == ltq_eiu_irq[i]) {
 			int val = 0;
 			int edge = 0;
@@ -173,7 +173,7 @@ static unsigned int ltq_startup_eiu_irq(struct irq_data *d)
 	int i;
 
 	ltq_enable_irq(d);
-	for (i = 0; i < MAX_EIU; i++) {
+	for (i = 0; i < exin_avail; i++) {
 		if (d->hwirq == ltq_eiu_irq[i]) {
 			/* by default we are low level triggered */
 			ltq_eiu_settype(d, IRQF_TRIGGER_LOW);
@@ -195,7 +195,7 @@ static void ltq_shutdown_eiu_irq(struct irq_data *d)
 	int i;
 
 	ltq_disable_irq(d);
-	for (i = 0; i < MAX_EIU; i++) {
+	for (i = 0; i < exin_avail; i++) {
 		if (d->hwirq == ltq_eiu_irq[i]) {
 			/* disable */
 			ltq_eiu_w32(ltq_eiu_r32(LTQ_EIU_EXIN_INEN) & ~BIT(i),
-- 
1.7.10.4
