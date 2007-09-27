Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 15:29:11 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.169]:24688 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20029344AbXI0O3C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 15:29:02 +0100
Received: by ug-out-1314.google.com with SMTP id u2so1534222uge
        for <linux-mips@linux-mips.org>; Thu, 27 Sep 2007 07:28:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        bh=K0SogIDqYho/zPiqy2cF7Gfi4lSwI7giI9mjaaVJxCY=;
        b=AYQyv0p4jkeSftxIi8oVgD6SpH4TudWNmL4JSDhzUBvLakDvWA7IFtR50ig6W5zNbz7ot3RQ0rfWMZm4iayw+Vw19ZPfrtFMjp+vvAbyON2k+mtqiyLYf7C9FML0wJ5K+GnMCqVnp8CiG20a/Ch4+8tnM8oso74mdAWdBis5A8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:x-enigmail-version:content-type:content-transfer-encoding;
        b=jkcd4OMT8e44Z6dwP5tsqXTyL+hph3Mtwo9H6rYaw4l0tzAdx+pikEvNYsrZ+LCW0eQbC6ZyopjBl/Gzv+UjI3+3vi31x4lP8H5GoEj50hAhahl4CHvtXDtlpLnngsys55IAe0QlPY7d/RDez0KpZi4INqXr1z+Uo9k2izkB9To=
Received: by 10.66.240.12 with SMTP id n12mr3670295ugh.1190903324468;
        Thu, 27 Sep 2007 07:28:44 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id k30sm5890079ugc.2007.09.27.07.28.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Sep 2007 07:28:43 -0700 (PDT)
Message-ID: <46FBBDA0.4090403@gmail.com>
Date:	Thu, 27 Sep 2007 16:26:40 +0200
From:	Franck Bui-Huu <fbuihuu@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] Don't abort the build process if '-msym32' isn't supported
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

-msym32 and previously the strategy to tell the compiler to generate
64-bit code but the assembler to put it into 32-bit ELF was initially
a hack to get around the lack of proper 64-bit binutils support and
later turned into a neat optimization with significant code size
savings.  But it's really just an optimization so there is nothing
wrong with just dropping the option (and whatever else goes along with
it, I forgot all the nasty details) on the floor if due to a vintage
compiler it can't be suported.

Signed-off-by: Franck Bui-Huu <fbuihuu@gmail.com>
---

 Ralf,

 This patch is based on your linux-queue repository.
 Thanks for the commit message ;)

		Franck

 arch/mips/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index b0fac2d..ebd5d02 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -602,7 +602,9 @@ ifdef CONFIG_64BIT
   endif
 
   ifeq ($(KBUILD_SYM32), y)
-    cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+    ifeq ($(call cc-option-yn,-msym32), y)
+      cflags-y += -msym32 -DKBUILD_64BIT_SYM32
+    endif
   endif
 endif
 
-- 
1.5.3.2
