Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2009 16:16:58 +0100 (CET)
Received: from mail-qy0-f202.google.com ([209.85.221.202]:57162 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493090AbZJZPOz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2009 16:14:55 +0100
Received: by mail-qy0-f202.google.com with SMTP id 40so1399194qyk.22
        for <multiple recipients>; Mon, 26 Oct 2009 08:14:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=pBZTzVswMy/zvfM3ijDgCd58cYG6Q6BHEJM7Jbeitvc=;
        b=pDpTAMUmIvdEkv0CPoewH4u/TBnCGfIZ41F4TvRrDRe98JiLaqrFD2wDQ1z0iHrl0Z
         6J4P9S8FqE9kzRf8qUQCl2C9h42oG8ofr9K9VCqRZyi+zJxAuLau0yUwtMG9eEnhlbdU
         h+aw9/3LjTSDieVWIJtL/syr2p1o4mTRCfPTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=icZaCp1MyKWMzySCrfXoryK9cg1e23RASnR0431VcuI64a1L7mRc052aR4Ox3FqRut
         2ilo5GwpBT9MxuuZSxFf9UhICQ28Ha0/D/SaXu03+DZwOZYt1UYgJ+qljQvBB8ubgmYB
         oy6aJVwmJBdH+ZdzBhMhmj5hyQYCaY/RcKsv4=
Received: by 10.224.110.210 with SMTP id o18mr7286899qap.383.1256570095250;
        Mon, 26 Oct 2009 08:14:55 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm3876989qyk.0.2009.10.26.08.14.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Oct 2009 08:14:53 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>,
	Frederic Weisbecker <fweisbec@gmail.com>, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ralf Baechle <ralf@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Adam Nemet <anemet@caviumnetworks.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Wu Zhangjin <wuzj@lemote.com>
Subject: [PATCH -v6 06/13] tracing: add an endian argument to scripts/recordmcount.pl
Date:	Mon, 26 Oct 2009 23:13:23 +0800
Message-Id: <3c82af564d70be05b92687949ed134ce034bf8db.1256569489.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
 <747deea2f18d5ccffe842df95a9dd1c86251a958.1256569489.git.wuzhangjin@gmail.com>
 <3f47087b70a965fd679b17a59521671296457df1.1256569489.git.wuzhangjin@gmail.com>
 <f290e125634d164ec65b09b24b269815f78455ab.1256569489.git.wuzhangjin@gmail.com>
 <07dc907ec62353b1aca99b2850d3b2e4b734189a.1256569489.git.wuzhangjin@gmail.com>
 <374da7039d2e1b97083edd8bcd7811356884d427.1256569489.git.wuzhangjin@gmail.com>
In-Reply-To: <cover.1256569489.git.wuzhangjin@gmail.com>
References: <cover.1256569489.git.wuzhangjin@gmail.com>
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24514
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
index bfb8b2c..465fe5e 100755
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
