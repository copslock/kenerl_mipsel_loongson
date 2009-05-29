Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 May 2009 16:05:29 +0100 (BST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:39363 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023916AbZE2PFX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 29 May 2009 16:05:23 +0100
Received: by pzk40 with SMTP id 40so5439282pzk.22
        for <multiple recipients>; Fri, 29 May 2009 08:05:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xD+EfyvJ1cJ95VWtO9dUklc0lDMhIT4QpIx5YI2E1jI=;
        b=nNm1sTN8ycfYOiZ6+xPUBNV4OXAyekpfth+ONY44ryJuITsUANks95Lns6hk6yTDE8
         dg4/+BbCrnacMZO2uZjF8XPVVOT7KzQA/DcEmOPT2RKYP+4apdlvDG6gVv7c6T2E3vh/
         E0cwKRR5yVnJ+O/gd9VNfqCG/LHPAKG+jmwd0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=unrhXlGN9Z5FZGRPKACBCwUTx+H8Xh3bQvLsdQ2xdt0Eor+d7QCdGnWV3c90hQKuh9
         zX+i3Nv9Ui5yyLlnGSQT+p2ydQqmbPZ/1ENB6sCDsrpioNA5kaC80oS+1Qj1ADwvdNQn
         VgAQGxisuibRG49Q7KCKreho24MHcCDOVdxHA=
Received: by 10.114.53.1 with SMTP id b1mr4152869waa.24.1243609515938;
        Fri, 29 May 2009 08:05:15 -0700 (PDT)
Received: from localhost.localdomain ([202.201.14.140])
        by mx.google.com with ESMTPS id l37sm2210789waf.40.2009.05.29.08.05.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 08:05:14 -0700 (PDT)
From:	wuzhangjin@gmail.com
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzj@lemote.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Nicholas Mc Guire <der.herr@hofr.at>
Subject: [PATCH v2 3/6] add an endian argument to scripts/recordmcount.pl
Date:	Fri, 29 May 2009 23:04:50 +0800
Message-Id: <6f4f65069c0ace1f0cffd9ce152f226f09edad9b.1243604390.git.wuzj@lemote.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <cover.1243604390.git.wuzj@lemote.com>
References: <cover.1243604390.git.wuzj@lemote.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23055
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
 scripts/recordmcount.pl |   21 +++++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

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
index a5d2ace..57a2b6a 100755
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
@@ -216,9 +216,18 @@ if ($arch eq "x86_64") {
 
 } elsif ($arch eq "mips") {
 	$mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
-	$ld .= " -melf".$bits."btsmip";
+	$objdump .= " -Melf-trad".$endian."mips ";
 
-	$cc .= " -mno-abicalls -fno-pic ";
+	if ($endian eq "big") {
+		$endian = " -EB ";
+		$ld .= " -melf".$bits."btsmip";
+	} else {
+		$endian = " -EL ";
+		$ld .= " -melf".$bits."ltsmip";
+	}
+
+	$cc .= " -mno-abicalls -fno-pic -mabi=" . $bits . $endian;
+	$ld .= $endian;
 
     if ($bits == 64) {
 		$type = ".dword";
-- 
1.6.0.4
