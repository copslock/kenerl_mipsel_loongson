Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Oct 2009 16:20:02 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:45028 "EHLO
	mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492512AbZJYPSA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 Oct 2009 16:18:00 +0100
Received: by mail-pw0-f45.google.com with SMTP id 11so939668pwi.24
        for <multiple recipients>; Sun, 25 Oct 2009 08:17:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=zXRLfLRIs5bUi4Fup5fZwpm+lLatrm2O/2uQjhNM7wY=;
        b=VCFSWlC5FTmuJSvWeELs2lsabP37+j1owg9XyGm2EpYT4wgo1sCTKdY+oa6o7kpO+s
         46R73IYFXxn0Ia1YnxXaQ+L6KNeSoAEG1/puzUEmdWRuNuqzBobkj74ItQBeX+x+J5HR
         aXWrOBPxoWUCayS3f2xiaGXGwwwd4MY70k2uw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MurdN73g7pzMULDQ5e4yUQktoMkKKotkeuRKEqLVww5BJhfkIKakurb5tmq7ZLUY2n
         BVq2m/wIsaBef7hN95OZWBJ5g1jRM6drwYmDtv0DxNKLwvep8uXigQMGZSGfMfWbmASb
         CS/LIqKEc8VHWSGX0srayX0YOFrumcovLNyV0=
Received: by 10.115.87.7 with SMTP id p7mr8375580wal.161.1256483879611;
        Sun, 25 Oct 2009 08:17:59 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 22sm1742515pxi.14.2009.10.25.08.17.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:17:58 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH -v5 06/11] tracing: add an endian argument to scripts/recordmcount.pl
Date:	Sun, 25 Oct 2009 23:16:57 +0800
Message-Id: <72f2270f7b6e01ca7a4cdf4ac8c21778e5d9652f.1256483735.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256482555.git.wuzhangjin@gmail.com>
 <028867b99ec532b84963a35e7d552becc783cafc.1256483735.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256483735.git.wuzhangjin@gmail.com>
 <3e0c2d7d8b8f196a8153beb41ea7f3cbf42b3d84.1256483735.git.wuzhangjin@gmail.com>
 <54c417629e91f40b2bbb4e08cda2a4e6527824c0.1256483735.git.wuzhangjin@gmail.com>
 <29bccff04932e993ecd9f516d8b6dcf84e2ceecf.1256483735.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256483735.git.wuzhangjin@gmail.com>
References: <cover.1256483735.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

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
index 090d300..daee038 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -99,13 +99,13 @@ $P =~ s@.*/@@g;
 
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
1.6.2.1
