Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Nov 2009 13:36:01 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:57283 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493138AbZKTMfN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 20 Nov 2009 13:35:13 +0100
Received: by mail-pz0-f197.google.com with SMTP id 35so2380364pzk.22
        for <multiple recipients>; Fri, 20 Nov 2009 04:35:12 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=Fjklm2657ZmJtus0APuqoR4minsfCMZ6q1iVn5wSxeE=;
        b=VIkm5BqZbLzHKyYGQXCH4D3uJ/yH6+YOUQF7SdfNgHNE/H3xg6C3Ou9S+345+9HPmS
         UiPmLt9jvvoXHgFMc5YT0vkp1SAN7aNyh5+WMgFHkG4IaMXJ99i9p5jLftWO/S+AsJAX
         TsYjoTNYlE9aV9b8/RPEODPeJB5TQh1Q+ad9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K1/SXpLQj6wCgO3468BlmVpXvGt/0l5+OwrqMsvaux5T9hMJoD3n4wjH7i/mgL1x8q
         8U//nQ3lfhXz6LC5Injn+nakvj9s7RFR6uGBz/CcBzFqBslP+k6bu3OP61iCiXhgYVua
         kuXBdKqN+Dp67GKh1wqC33E5TxhbObVPxewwk=
Received: by 10.115.87.7 with SMTP id p7mr1932530wal.161.1258720512735;
        Fri, 20 Nov 2009 04:35:12 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm931632pzk.2.2009.11.20.04.35.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Nov 2009 04:35:12 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>, rostedt@goodmis.org
Cc:	Nicholas Mc Guire <der.herr@hofr.at>, zhangfx@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH v9 03/10] tracing: add an endian argument to scripts/recordmcount.pl
Date:	Fri, 20 Nov 2009 20:34:31 +0800
Message-Id: <267c0824194b659b46fc038ba43492df30369fec.1258719323.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <51e30436a435480f1f0dec146a82f2b250900690.1258719323.git.wuzhangjin@gmail.com>
References: <adf867c5a6864fa196c667d3f09a6a694f3903c5.1258719323.git.wuzhangjin@gmail.com>
 <51e30436a435480f1f0dec146a82f2b250900690.1258719323.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1258719323.git.wuzhangjin@gmail.com>
References: <cover.1258719323.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

MIPS and some other architectures need this argument to handle
big/little endian respectively.

Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
---
 scripts/Makefile.build  |    1 +
 scripts/recordmcount.pl |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 341b589..0b94d2f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -207,6 +207,7 @@ endif
 
 ifdef CONFIG_FTRACE_MCOUNT_RECORD
 cmd_record_mcount = set -e ; perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
+	"$(if $(CONFIG_CPU_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC)" "$(LD)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index f0d1445..24604d4 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -113,13 +113,13 @@ $P =~ s@.*/@@g;
 
 my $V = '0.1';
 
-if ($#ARGV != 10) {
-	print "usage: $P arch bits objdump objcopy cc ld nm rm mv is_module inputfile\n";
+if ($#ARGV != 11) {
+	print "usage: $P arch endian bits objdump objcopy cc ld nm rm mv is_module inputfile\n";
 	print "version: $V\n";
 	exit(1);
 }
 
-my ($arch, $bits, $objdump, $objcopy, $cc,
+my ($arch, $endian, $bits, $objdump, $objcopy, $cc,
     $ld, $nm, $rm, $mv, $is_module, $inputfile) = @ARGV;
 
 # This file refers to mcount and shouldn't be ftraced, so lets' ignore it
-- 
1.6.2.1
