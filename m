Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Oct 2006 22:20:17 +0100 (BST)
Received: from mms3.broadcom.com ([216.31.210.19]:23568 "EHLO
	MMS3.broadcom.com") by ftp.linux-mips.org with ESMTP
	id S20038561AbWJLVUP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Oct 2006 22:20:15 +0100
Received: from 10.10.64.154 by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.2.2)); Thu, 12 Oct 2006 14:20:00 -0700
X-Server-Uuid: 450F6D01-B290-425C-84F8-E170B39A25C9
Received: by mail-irva-10.broadcom.com (Postfix, from userid 47) id
 5791A2AF; Thu, 12 Oct 2006 14:20:00 -0700 (PDT)
Received: from mail-irva-8.broadcom.com (mail-irva-8 [10.10.64.221]) by
 mail-irva-10.broadcom.com (Postfix) with ESMTP id 330F32AE for
 <linux-mips@linux-mips.org>; Thu, 12 Oct 2006 14:20:00 -0700 (PDT)
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.16.128.215]) by mail-irva-8.broadcom.com (MOS 3.7.5a-GA) with ESMTP
 id EHK52593; Thu, 12 Oct 2006 14:19:59 -0700 (PDT)
Received: from NT-SJCA-0750.brcm.ad.broadcom.com (nt-sjca-0750
 [10.16.192.220]) by mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id
 D319B20501 for <linux-mips@linux-mips.org>; Thu, 12 Oct 2006 14:19:59
 -0700 (PDT)
Received: from localhost.localdomain ([10.240.253.52]) by
 NT-SJCA-0750.brcm.ad.broadcom.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 12 Oct 2006 14:19:59 -0700
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k9CLJSh7012918
 for <linux-mips@linux-mips.org>; Thu, 12 Oct 2006 14:19:36 -0700
Received: (from mason@localhost) by localhost.localdomain (
 8.13.4/8.13.4/Submit) id k9CLJLwN012916 for linux-mips@linux-mips.org;
 Thu, 12 Oct 2006 14:19:21 -0700
Date:	Thu, 12 Oct 2006 14:19:21 -0700
From:	"Mark Mason" <mason@broadcom.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH] BCM1250/BCM1125 recognize more silicon revisions
Message-ID: <20061012211921.GB12830@localhost.localdomain>
MIME-Version: 1.0
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 12 Oct 2006 21:19:59.0676 (UTC)
 FILETIME=[2C66CFC0:01C6EE44]
X-WSS-ID: 69306E0A3AK724083-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <mark.e.mason@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12923
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mason@broadcom.com
Precedence: bulk
X-list: linux-mips


This is a simple update to allow the BCM1250/BCM1125 port to recognize
additional (recent) silicon revisions as legal.  This change also uses
the proper macro to detect C0 silicon (instead of the internal,
deprecated PASS3 macro).

Signed-off-by: Mark Mason <mason@broadcom.com>

---
 arch/mips/sibyte/sb1250/setup.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/mips/sibyte/sb1250/setup.c b/arch/mips/sibyte/sb1250/setup.c
index d0ee1d5..1e495db 100644
--- a/arch/mips/sibyte/sb1250/setup.c
+++ b/arch/mips/sibyte/sb1250/setup.c
@@ -98,7 +98,7 @@ static int __init setup_bcm1250(void)
 		pass_str = "B2";
 		war_pass = K_SYS_REVISION_BCM1250_PASS2_2;
 		break;
-	case K_SYS_REVISION_BCM1250_PASS3:
+	case K_SYS_REVISION_BCM1250_C0:
 		periph_rev = 3;
 		pass_str = "C0";
 		break;
@@ -106,6 +106,14 @@ static int __init setup_bcm1250(void)
 		periph_rev = 3;
 		pass_str = "C1";
 		break;
+	case K_SYS_REVISION_BCM1250_C2:
+		periph_rev = 3;
+		pass_str = "C2";
+		break;
+	case K_SYS_REVISION_BCM1250_C3:
+		periph_rev = 3;
+		pass_str = "C3";
+		break;
 	default:
 		if (soc_pass < K_SYS_REVISION_BCM1250_PASS2_2) {
 			periph_rev = 2;
@@ -139,6 +147,14 @@ static int __init setup_bcm112x(void)
 		periph_rev = 3;
 		pass_str = "A2";
 		break;
+	case K_SYS_REVISION_BCM112x_A3:
+		periph_rev = 3;
+		pass_str = "A3";
+		break;
+	case K_SYS_REVISION_BCM112x_A4:
+		periph_rev = 3;
+		pass_str = "A4";
+		break;
 	default:
 		prom_printf("Unknown %s rev %x\n", soc_str, soc_pass);
 		ret = 1;
-- 
1.1.6.g4e27f
