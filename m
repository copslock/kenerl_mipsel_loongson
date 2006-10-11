Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 01:03:00 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:8977 "EHLO MMS3.broadcom.com")
	by ftp.linux-mips.org with ESMTP id S20037437AbWJKAC5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 11 Oct 2006 01:02:57 +0100
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Tue, 10 Oct 2006 17:02:41 -0700
X-Server-Uuid: 450F6D01-B290-425C-84F8-E170B39A25C9
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 6D82F2AF; Tue, 10 Oct 2006 17:02:41 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 2907C2AF for
 <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 17:02:41 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EHF33112; Tue, 10 Oct 2006 17:02:39 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 9696C20504 for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 17:02:39
 -0700 (PDT)
Received: from localhost.localdomain ([10.240.253.63]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Tue, 10 Oct 2006 17:02:39 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k9B03H7e022650
 for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 17:03:23 -0700
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k9B03AtS022649 for linux-mips@linux-mips.org;
 Tue, 10 Oct 2006 17:03:10 -0700
Date:	Tue, 10 Oct 2006 17:03:10 -0700
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] Fix compilation warnings in
 arch/mips/sibyte/bcm1480/smp.c
Message-ID: <20061011000310.GA22605@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 11 Oct 2006 00:02:39.0433 (UTC)
 FILETIME=[90D80B90:01C6ECC8]
X-WSS-ID: 6932EB2B3AK39907-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12893
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips


Modified types of mailbox register arrays in order to prevent compilation
warnings.  Changes are against 2.6.18-rc4, but should apply cleanly to the
tip as well.

Signed-off-by: Mark Mason <mason@broadcom.com>
---
 arch/mips/sibyte/bcm1480/smp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/sibyte/bcm1480/smp.c b/arch/mips/sibyte/bcm1480/smp.c
index 584a4b3..4f60142 100644
--- a/arch/mips/sibyte/bcm1480/smp.c
+++ b/arch/mips/sibyte/bcm1480/smp.c
@@ -34,21 +34,21 @@ extern void smp_call_function_interrupt(
  * independent of board/firmware
  */
 
-static void *mailbox_0_set_regs[] = {
+static volatile void *mailbox_0_set_regs[] = {
 	IOADDR(A_BCM1480_IMR_CPU0_BASE + R_BCM1480_IMR_MAILBOX_0_SET_CPU),
 	IOADDR(A_BCM1480_IMR_CPU1_BASE + R_BCM1480_IMR_MAILBOX_0_SET_CPU),
 	IOADDR(A_BCM1480_IMR_CPU2_BASE + R_BCM1480_IMR_MAILBOX_0_SET_CPU),
 	IOADDR(A_BCM1480_IMR_CPU3_BASE + R_BCM1480_IMR_MAILBOX_0_SET_CPU),
 };
 
-static void *mailbox_0_clear_regs[] = {
+static volatile void *mailbox_0_clear_regs[] = {
 	IOADDR(A_BCM1480_IMR_CPU0_BASE + R_BCM1480_IMR_MAILBOX_0_CLR_CPU),
 	IOADDR(A_BCM1480_IMR_CPU1_BASE + R_BCM1480_IMR_MAILBOX_0_CLR_CPU),
 	IOADDR(A_BCM1480_IMR_CPU2_BASE + R_BCM1480_IMR_MAILBOX_0_CLR_CPU),
 	IOADDR(A_BCM1480_IMR_CPU3_BASE + R_BCM1480_IMR_MAILBOX_0_CLR_CPU),
 };
 
-static void *mailbox_0_regs[] = {
+static volatile void *mailbox_0_regs[] = {
 	IOADDR(A_BCM1480_IMR_CPU0_BASE + R_BCM1480_IMR_MAILBOX_0_CPU),
 	IOADDR(A_BCM1480_IMR_CPU1_BASE + R_BCM1480_IMR_MAILBOX_0_CPU),
 	IOADDR(A_BCM1480_IMR_CPU2_BASE + R_BCM1480_IMR_MAILBOX_0_CPU),
-- 
1.1.6.g4e27f
