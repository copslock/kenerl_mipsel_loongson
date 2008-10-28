Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2008 13:30:35 +0000 (GMT)
Received: from mba.ocn.ne.jp ([122.1.235.107]:24276 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22582824AbYJ1Na1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2008 13:30:27 +0000
Received: from localhost (p3097-ipad313funabasi.chiba.ocn.ne.jp [123.217.229.97])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id EF2E0AF04; Tue, 28 Oct 2008 22:30:21 +0900 (JST)
Date:	Tue, 28 Oct 2008 22:30:23 +0900 (JST)
Message-Id: <20081028.223023.93205850.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: [PATCH] tc35815: Define more Rx status bits
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21056
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This change does not change driver's behaviour, just make its debug
output a bit meaningful.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/net/tc35815.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tc35815.c b/drivers/net/tc35815.c
index df20caf..385b174 100644
--- a/drivers/net/tc35815.c
+++ b/drivers/net/tc35815.c
@@ -236,7 +236,7 @@ struct tc35815_regs {
 #define Rx_Halted	       0x00008000 /* Rx Halted			     */
 #define Rx_Good		       0x00004000 /* Rx Good			     */
 #define Rx_RxPar	       0x00002000 /* Rx Parity Error		     */
-			    /* 0x00001000    not use			     */
+#define Rx_TypePkt	       0x00001000 /* Rx Type Packet		     */
 #define Rx_LongErr	       0x00000800 /* Rx Long Error		     */
 #define Rx_Over		       0x00000400 /* Rx Overflow		     */
 #define Rx_CRCErr	       0x00000200 /* Rx CRC Error		     */
@@ -244,8 +244,9 @@ struct tc35815_regs {
 #define Rx_10Stat	       0x00000080 /* Rx 10Mbps Status		     */
 #define Rx_IntRx	       0x00000040 /* Rx Interrupt		     */
 #define Rx_CtlRecd	       0x00000020 /* Rx Control Receive		     */
+#define Rx_InLenErr	       0x00000010 /* Rx In Range Frame Length Error  */
 
-#define Rx_Stat_Mask	       0x0000EFC0 /* Rx All Status Mask		     */
+#define Rx_Stat_Mask	       0x0000FFF0 /* Rx All Status Mask		     */
 
 /* Int_En bit asign -------------------------------------------------------- */
 #define Int_NRAbtEn	       0x00000800 /* 1:Non-recoverable Abort Enable  */
-- 
1.5.6.3
