Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Jan 2013 23:54:14 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48877 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6833227Ab3AQWyNgL88h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 17 Jan 2013 23:54:13 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0HMsBeM017711;
        Thu, 17 Jan 2013 23:54:11 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0HMsAIW017710;
        Thu, 17 Jan 2013 23:54:10 +0100
Date:   Thu, 17 Jan 2013 23:54:10 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     "Steven J. Hill" <sjhill@mips.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: microMIPS: Redefine value of BRK_BUG.
Message-ID: <20130117225410.GB19406@linux-mips.org>
References: <1358444216-17213-1-git-send-email-sjhill@mips.com>
 <50F83FD5.2060908@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50F83FD5.2060908@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35489
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Jan 17, 2013 at 10:15:49AM -0800, David Daney wrote:

> >diff --git a/arch/mips/include/asm/break.h b/arch/mips/include/asm/break.h
> >index 9161e68..df9d090 100644
> >--- a/arch/mips/include/asm/break.h
> >+++ b/arch/mips/include/asm/break.h
> >@@ -27,6 +27,7 @@
> >  #define BRK_STACKOVERFLOW 9	/* For Ada stackchecking */
> >  #define BRK_NORLD	10	/* No rld found - not used by Linux/MIPS */
> >  #define _BRK_THREADBP	11	/* For threads, user bp (used by debuggers) */
> >+#define BRK_BUG_MM	12	/* Used by BUG() in microMIPS mode */
> >  #define BRK_BUG		512	/* Used by BUG() */
> 
> Can we move the CONFIG_CPU_MICROMIPS to here and just call the thing
> BRK_BUG?
> 
> Or perhaps redefining it unconditionally.  I am not sure what the
> implications of doing that would be.
> 
> That way...

The kernel decodes break and trap instruction in traps.c.  For a microMIPS-
enabled kernel it needs to be able to decode both classic and microMIPS
encoded instructions so we want separate symbols.

Or we do something like

#define BRK_MM_BUG	 12      /* Used by BUG() in microMIPS mode */
#define BRK_CM_BUG	512     /* Used by BUG() */

#ifdef __mips_micromips
#define BRK_BUG		BRK_MM_BUG
#else
#define BRK_BUG		BRK_CM_BUG
#endif

This makes the BRK_MM_* / BRK_CM_* macros available for decoding instructions
and the microMIPS-agnostic BRK_BUG for code such as BUG().

> >  #define BRK_KDB		513	/* Used in KDB_ENTER() */
> >  #define BRK_MEMU	514	/* Used by FPU emulator */
> >diff --git a/arch/mips/include/asm/bug.h b/arch/mips/include/asm/bug.h
> >index 540c98a..b716fb9 100644
> >--- a/arch/mips/include/asm/bug.h
> >+++ b/arch/mips/include/asm/bug.h
> >@@ -7,6 +7,10 @@
> >  #ifdef CONFIG_BUG
> >
> >  #include <asm/break.h>
> >+#ifdef CONFIG_CPU_MICROMIPS
> >+#undef BRK_BUG
> >+#define BRK_BUG		BRK_BUG_MM
> >+#endif
> >
> 
> ...We don't need this bit.   Doing an #undef risks using different
> values for BRK_BUG depending on whether or not asm/bug.h is
> included.

And generally is not very elegant.

  Ralf
