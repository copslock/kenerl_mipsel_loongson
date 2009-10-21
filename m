Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:37:34 +0200 (CEST)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:41500 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493558AbZJUOfj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:35:39 +0200
Received: by mail-bw0-f221.google.com with SMTP id 21so243449bwz.24
        for <multiple recipients>; Wed, 21 Oct 2009 07:35:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=ucomfRM6niwnC0XY25k6tMC12WqhaqbcBV1/QP9hovA=;
        b=iAtNT0zgPydfwawyzW+fgprocbZKTv+p+WK17Cp6N8DAnJPQ0sr1CFLXkWxKh6utza
         oKgvzMvUfz9qKd5xSwkYZWuyrMfmmLfemcHEa3ns2dUYirItgttXTT4j+U7XUgms9+MV
         1b14Haq1b+E/+WEWtJKzyuuJ9nIbsro14PcD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=v1zIlRRhc/e3gN7Z0tAbCEQse9hlU+YbNgX0xUABF4fbrQdRJZJ1Hb5zLqBRCO7c1l
         hbzQmc6en6sWe8mXJYpRoPoytODnHBuvhEg2PmkJbLOMoXBEmS6Yffh3fOmX3RqtsvFr
         z/xST/+Rtouzl6TXlquLm9Ony2kq4IFCgUojs=
Received: by 10.204.2.73 with SMTP id 9mr8035548bki.159.1256135739364;
        Wed, 21 Oct 2009 07:35:39 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 1sm303459fkt.11.2009.10.21.07.35.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 07:35:38 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	Steven Rostedt <rostedt@goodmis.org>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH -v4 6/9] tracing: add an endian argument to scripts/recordmcount.pl
Date:	Wed, 21 Oct 2009 22:35:00 +0800
Message-Id: <5dda13e8e3a9c9dba4bb7179183941bda502604f.1256135456.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
References: <028867b99ec532b84963a35e7d552becc783cafc.1256135456.git.wuzhangjin@gmail.com>
 <2f73eae542c47ac5bbb9f7280e6c0271d193e90d.1256135456.git.wuzhangjin@gmail.com>
 <3f0d3515f74a58f4cfd11e61b62a129fdc21e3a7.1256135456.git.wuzhangjin@gmail.com>
 <ea8aa927fbd184b54941e4c2ae0be8ea0b4f6b8a.1256135456.git.wuzhangjin@gmail.com>
 <96110ea5dd4d3d54eb97d0bb708a5bd81c7a50b5.1256135456.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256135456.git.wuzhangjin@gmail.com>
References: <cover.1256135456.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

MIPS architecture need this argument to handle big/little endian
respectively.

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
