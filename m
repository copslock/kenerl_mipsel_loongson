Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2018 01:59:44 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:39464
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990588AbeBWA7gSfRJH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Feb 2018 01:59:36 +0100
Received: by mail-pl0-x242.google.com with SMTP id s13so3930985plq.6
        for <linux-mips@linux-mips.org>; Thu, 22 Feb 2018 16:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hQSLaSQoOTesXcd6FZ63dwhw4CUA3nQCDGP5+m7urV8=;
        b=YiyF4AOctAPXwb3gnZBDXYwVGeJ2gnoK/MTxXshRrf4ITvPh1yVXgPEB6u9NJz5B5Q
         O5XDHsAlormmDIUYxX74UjGN8KSnWqjh60cAT9JPGC1gWsonIl5mR1RAPO4McYz5sMf7
         XkThdE6K7SV7NsgZ0pB4cCYQ2XOFhfu/JS97o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hQSLaSQoOTesXcd6FZ63dwhw4CUA3nQCDGP5+m7urV8=;
        b=rkv2oOPCORS/vX6tBPE8sRPvOxusErNEAVBE6IhR25EJQkwplidaaTobgGAYHAN2zx
         mXOjin2OBackKxiv8IgpvhVqTeaMCCOJ+i3TdqYp2wFlUGAU+iTg3hgPjAHLLtO/zUnb
         KPkUCWMHqmF/6gd3YEKY1Xs6DrAtdYjIrisfCSBw9uKkOnGKdoH68R95oGv/UX0sTFGv
         qPGjyp6NQBsrDSmxAgo5MdcZ5oAPJijSyW1Be3xodURVPpDfSktTPhg2EG81cTHgsnlJ
         bdNjw+rNylLGxX4S5PP5mPFFzsbeF9h3MddNV7hZ9GBHtpga0VyNTG8LJ379B1Kzb811
         tYig==
X-Gm-Message-State: APf1xPClI7WjpZxi7x/Og65SJ9UmnyrhVOMQv6imrIqKgER1E9S8lMkC
        h5kgFjfxAuA3YtFRbRzINJhKrA==
X-Google-Smtp-Source: AH8x225XgsQHroguEEFespii9Br3NnuijQMpoxJuJYx3sBlU9pes2IN00YO85WTkEwJ95OevBiJ+dw==
X-Received: by 2002:a17:902:7045:: with SMTP id h5-v6mr8394505plt.217.1519347568959;
        Thu, 22 Feb 2018 16:59:28 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j7sm1676170pfh.39.2018.02.22.16.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Feb 2018 16:59:27 -0800 (PST)
Date:   Thu, 22 Feb 2018 16:59:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kbuild test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: boot: Define __ASSEMBLY__ for its.S build
Message-ID: <20180223005926.GA18630@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

The MIPS %.its.S compiler command did not define __ASSEMBLY__, which meant
when compiler_types.h was added to kconfig.h, unexpected things appeared
(e.g. struct declarations) which should not have been present. As done in
the general %.S compiler command, __ASSEMBLY__ is now included here too.

The failure was:

    Error: arch/mips/boot/vmlinux.gz.its:201.1-2 syntax error
    FATAL ERROR: Unable to parse input tree
    /usr/bin/mkimage: Can't read arch/mips/boot/vmlinux.gz.itb.tmp: Invalid argument
    /usr/bin/mkimage Can't add hashes to FIT blob

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 28128c61e08e ("kconfig.h: Include compiler types to avoid missed struct attributes")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/boot/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/boot/Makefile b/arch/mips/boot/Makefile
index 1bd5c4f00d19..c22da16d67b8 100644
--- a/arch/mips/boot/Makefile
+++ b/arch/mips/boot/Makefile
@@ -126,6 +126,7 @@ $(obj)/vmlinux.its.S: $(addprefix $(srctree)/arch/mips/$(PLATFORM)/,$(ITS_INPUTS
 
 quiet_cmd_cpp_its_S = ITS     $@
       cmd_cpp_its_S = $(CPP) $(cpp_flags) -P -C -o $@ $< \
+			-D__ASSEMBLY__ \
 		        -DKERNEL_NAME="\"Linux $(KERNELRELEASE)\"" \
 			-DVMLINUX_BINARY="\"$(3)\"" \
 			-DVMLINUX_COMPRESSION="\"$(2)\"" \
-- 
2.7.4


-- 
Kees Cook
Pixel Security
