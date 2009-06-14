Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Jun 2009 17:58:52 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.178]:1889 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492192AbZFNP6q (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 14 Jun 2009 17:58:46 +0200
Received: by wa-out-1112.google.com with SMTP id n4so628146wag.0
        for <multiple recipients>; Sun, 14 Jun 2009 08:58:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pueyoD/A9IYpdD5073UD3a2qyFHvcNnQrpwOjNKYMKc=;
        b=vs3bv9In1iM7D7l/OEj711tV93rRI9nH7/XcVvSXf60vj/cGKxYW/ItMtgLaus5HR2
         yiZiOZKVuOR9DVeMQa8+siMV18oleLiVND6hnDlxTLb7yA4sgPs/rHDHmeqJcuTGxk1v
         HgV7J3W+lZQ7+ey9kwAl1sVto0zhrPdxJBhR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BUcFjYxPhtKqANYiBol25wti6IvREcSPzpPkSXOguQ6S7CVBssyxW9KG2O8/o05Wpr
         ppceG8qfS7YoE1R8dUbf5r5TJ0AryS1+Y08AeOcUYkTpC2l6SO8xHScKT4aRIZgzZ//n
         ZUuYGt2unzY5Pw204et/2V6MLBo1ZqvU7++d0=
Received: by 10.114.211.1 with SMTP id j1mr9934628wag.176.1244994743393;
        Sun, 14 Jun 2009 08:52:23 -0700 (PDT)
Received: from localhost.localdomain ([219.246.59.144])
        by mx.google.com with ESMTPS id v32sm4691023wah.13.2009.06.14.08.52.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Jun 2009 08:52:22 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wang Liming <liming.wang@windriver.com>,
	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Ingo Molnar <mingo@elte.hu>
Subject: [PATCH v3] add an endian argument to scripts/recordmcount.pl
Date:	Sun, 14 Jun 2009 23:52:13 +0800
Message-Id: <0ed3bc52c8259e429283d2bc26ddaa36dbfdd0eb.1244994151.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1244994151.git.wuzj@lemote.com>
References: <cover.1244994151.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzj@lemote.com>

mips architecture need this argument to handle big/little endian
differently.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 scripts/Makefile.build  |    1 +
 scripts/recordmcount.pl |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 5c4b7a4..548d575 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -207,6 +207,7 @@ endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
 cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
+	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 0fae7da..f1e3e9c 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -100,13 +100,13 @@ $P =~ s@.*/@@g;
 
 my $V = '0.1';
 
-if ($#ARGV < 7) {
-	print "usage: $P arch bits objdump objcopy cc ld nm rm mv is_module inputfile\n";
+if ($#ARGV < 8) {
+	print "usage: $P arch endian bits objdump objcopy cc ld nm rm mv is_module inputfile\n";
 	print "version: $V\n";
 	exit(1);
 }
 
-my ($arch, $bits, $objdump, $objcopy, $cc,
+my ($arch, $endian, $bits, $objdump, $objcopy, $cc,
     $ld, $nm, $rm, $mv, $is_module, $inputfile) = @ARGV;
 
 # This file refers to mcount and shouldn't be ftraced, so lets' ignore it
-- 
1.6.0.4
