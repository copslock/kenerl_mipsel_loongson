Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Apr 2009 15:32:07 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:58083 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20023535AbZDKOcB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 11 Apr 2009 15:32:01 +0100
Received: from localhost (p7156-ipad205funabasi.chiba.ocn.ne.jp [222.146.102.156])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id C6587A828; Sat, 11 Apr 2009 23:31:54 +0900 (JST)
Date:	Sat, 11 Apr 2009 23:31:50 +0900 (JST)
Message-Id: <20090411.233150.25909696.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	ddaney@caviumnetworks.com, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Include linux/errno.h from
 arch/mips/include/asm/compat.h
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20090410191611.GB23582@linux-mips.org>
References: <1239388895-27305-1-git-send-email-ddaney@caviumnetworks.com>
	<20090410191611.GB23582@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Fri, 10 Apr 2009 12:16:11 -0700, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Apr 10, 2009 at 11:41:35AM -0700, David Daney wrote:
> 
> > The recent change that added #include <linux/seccomp.h> breaks
> > (because EINVAL is not defined) when building
> > arch/mips/kernel/asm-offsets.s if CONFIG_SECCOMP is not defined.
> > Including errno.h fixes the problem.
> 
> NAK, <linux/seccomp.h> should include <linux/errno.h>.

Then how about this?

------------------------------------------------------
Subject: [PATCH] Do not include seccomp.h from compat.h
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

The compat.h does not need seccomp.h since TIF_32BIT was moved to
thread_info.h

This fixes a build error of 64-bit kernel without CONFIG_SECCOMP.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/include/asm/compat.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index 6c5b409..f58aed3 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -3,7 +3,6 @@
 /*
  * Architecture specific compatibility types
  */
-#include <linux/seccomp.h>
 #include <linux/thread_info.h>
 #include <linux/types.h>
 #include <asm/page.h>
