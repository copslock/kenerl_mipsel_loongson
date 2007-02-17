Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2007 16:03:40 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:21485 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037680AbXBQQDf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2007 16:03:35 +0000
Received: from localhost (p5247-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.247])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6AE37B904; Sun, 18 Feb 2007 01:02:14 +0900 (JST)
Date:	Sun, 18 Feb 2007 01:02:14 +0900 (JST)
Message-Id: <20070218.010214.74565177.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] Make some __setup functions static
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This fixes some sparse warnings. ("warning: symbol 'foo' was not
declared. Should it be static?")

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/kernel/cpu-probe.c |    2 +-
 arch/mips/kernel/setup.c     |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index f59ef27..212329b 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -97,7 +97,7 @@ static void au1k_wait(void)
 
 static int __initdata nowait = 0;
 
-int __init wait_disable(char *s)
+static int __init wait_disable(char *s)
 {
 	nowait = 1;
 
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 394540f..11ab222 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -543,7 +543,7 @@ void __init setup_arch(char **cmdline_p)
 #endif
 }
 
-int __init fpu_disable(char *s)
+static int __init fpu_disable(char *s)
 {
 	int i;
 
@@ -555,7 +555,7 @@ int __init fpu_disable(char *s)
 
 __setup("nofpu", fpu_disable);
 
-int __init dsp_disable(char *s)
+static int __init dsp_disable(char *s)
 {
 	cpu_data[0].ases &= ~MIPS_ASE_DSP;
 
