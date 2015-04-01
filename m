Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 08:50:10 +0200 (CEST)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:40118 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008182AbbDAGuI2qF2l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 08:50:08 +0200
Received: from resomta-ch2-11v.sys.comcast.net ([69.252.207.107])
        by resqmta-ch2-10v.sys.comcast.net with comcast
        id AWq21q0032Ka2Q501Wq2DW; Wed, 01 Apr 2015 06:50:02 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-11v.sys.comcast.net with comcast
        id AWq11q00A42s2jH01Wq1Zj; Wed, 01 Apr 2015 06:50:02 +0000
Message-ID: <551B9513.5020606@gentoo.org>
Date:   Wed, 01 Apr 2015 02:49:55 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: [PATCH]: MIPS: Select CONFIG_MIPS_O32_FP64_SUPPORT if 64bit kernel
 and o32
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1427871002;
        bh=FUwtiTtiaG05VkqYOP+X8UBNLjYYTeziQsGBS0ilZtU=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=HUtViAzUh1+SMpLos3SxqKDaqb59GtK3rXwtasFXvoj3EbAwh33qwAlU1eu2/z2k4
         Tza4prCjEEXsY2SP+advLNg1/W0sNBh6L7wjO8C5Bho1eMVaDfOoT46K9M9mY2YAfy
         RY/Ym0kPWfUyf5YANGrRaB8rxnV6oeSY1owyDKyHwqZvBqO9nhZo1v+u2UNru7lfad
         +kugYW/0/sHV2RXj3oRftBCmU36KJctBFv4u2XnLjX1fZ3UQF4M7IFDhAYA/+VZYOw
         SJufTfYX/1mbIkHXhNXTWi3NVC3Ubb4AvPWgRPOFbVUdFG7P973u1N80sQ5e6M8K4j
         XB7hCb4YBWnOg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46679
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Select CONFIG_MIPS_O32_FP64_SUPPORT by default if CONFIG_64BIT and
CONFIG_MIPS32_O32 are selected.  This avoids breaking things when
booting into an o32 userland under a 64bit kernel.  Symptoms of not
selecting CONFIG_MIPS_O32_FP64_SUPPORT can include OpenSSH claiming that
the "PRNG is not seeded" and Python programs to fail with either a
SIGSEGV or errors regarding "float NaN".

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
---
 arch/mips/Kconfig |    1 +
 1 file changed, 1 insertion(+)

mips-fix-o32-fp64-on-mips64.patch
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 294f82e..1b826ed 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2736,6 +2736,7 @@ config MIPS32_O32
 	select COMPAT
 	select MIPS32_COMPAT
 	select SYSVIPC_COMPAT if SYSVIPC
+	select MIPS_O32_FP64_SUPPORT if 64BIT
 	help
 	  Select this option if you want to run o32 binaries.  These are pure
 	  32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
