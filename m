Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 20:00:48 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35817 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027483AbbEKRz4XaDVc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:56 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 945CEBC4;
        Mon, 11 May 2015 17:55:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 29/72] MIPS: Makefile: Fix MIPS ASE detection code
Date:   Mon, 11 May 2015 10:54:35 -0700
Message-Id: <20150511175437.980676146@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------


From: Markos Chandras <markos.chandras@imgtec.com>

Commit 5306a5450824691e27d68f711758515debedeeac upstream.

Commit 32098ec7bcba ("MIPS: Makefile: Move the ASEs checks after
setting the core's CFLAGS") re-arranged the MIPS ASE detection code
and also added the current cflags to the detection logic. However,
this introduced a few bugs. First of all, the mips-cflags should not
be quoted since that ends up being passed as a string to subsequent
commands leading to broken detection from the cc-option-* tools.
Moreover, in order to avoid duplicating the cflags-y because of how
cc-option works, we rework the logic so we pass only those cflags which
are needed by the selected ASE. Finally, fix some typos resulting in MSA
not being detected correctly.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: Commit 32098ec7bcba ("MIPS: Makefile: Move the ASEs checks after setting the core's CFLAGS")
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9661/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/Makefile |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -197,11 +197,17 @@ endif
 # Warning: the 64-bit MIPS architecture does not support the `smartmips' extension
 # Pass -Wa,--no-warn to disable all assembler warnings until the kernel code has
 # been fixed properly.
-mips-cflags				:= "$(cflags-y)"
-cflags-$(CONFIG_CPU_HAS_SMARTMIPS)	+= $(call cc-option,$(mips-cflags),-msmartmips) -Wa,--no-warn
-cflags-$(CONFIG_CPU_MICROMIPS)		+= $(call cc-option,$(mips-cflags),-mmicromips)
+mips-cflags				:= $(cflags-y)
+ifeq ($(CONFIG_CPU_HAS_SMARTMIPS),y)
+smartmips-ase				:= $(call cc-option-yn,$(mips-cflags) -msmartmips)
+cflags-$(smartmips-ase)			+= -msmartmips -Wa,--no-warn
+endif
+ifeq ($(CONFIG_CPU_MICROMIPS),y)
+micromips-ase				:= $(call cc-option-yn,$(mips-cflags) -mmicromips)
+cflags-$(micromips-ase)			+= -mmicromips
+endif
 ifeq ($(CONFIG_CPU_HAS_MSA),y)
-toolchain-msa				:= $(call cc-option-yn,-$(mips-cflags),mhard-float -mfp64 -Wa$(comma)-mmsa)
+toolchain-msa				:= $(call cc-option-yn,$(mips-cflags) -mhard-float -mfp64 -Wa$(comma)-mmsa)
 cflags-$(toolchain-msa)			+= -DTOOLCHAIN_SUPPORTS_MSA
 endif
 
