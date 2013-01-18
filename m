Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jan 2013 14:25:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:50977 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6823128Ab3ARNZBIsggt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 18 Jan 2013 14:25:01 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0IDP05M027875;
        Fri, 18 Jan 2013 14:25:00 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0IDOxcZ027874;
        Fri, 18 Jan 2013 14:24:59 +0100
Date:   Fri, 18 Jan 2013 14:24:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <sjhill@mips.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v4] OF: MIPS: sead3: Implement OF support.
Message-ID: <20130118132459.GC19406@linux-mips.org>
References: <1358444223-17247-1-git-send-email-sjhill@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1358444223-17247-1-git-send-email-sjhill@mips.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35491
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

On Thu, Jan 17, 2013 at 11:37:03AM -0600, Steven J. Hill wrote:

> From: "Steven J. Hill" <sjhill@mips.com>
> 
> Activate USE_OF for SEAD-3 platform. Add basic DTS file and convert
> memory detection and reservations to use OF.

Applied with this little patch on top:


 arch/mips/include/asm/mips-boards/generic.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mips-boards/generic.h b/arch/mips/include/asm/mips-boards/generic.h
index c01e286..3fc764a 100644
--- a/arch/mips/include/asm/mips-boards/generic.h
+++ b/arch/mips/include/asm/mips-boards/generic.h
@@ -20,6 +20,7 @@
 #ifndef __ASM_MIPS_BOARDS_GENERIC_H
 #define __ASM_MIPS_BOARDS_GENERIC_H
 
+#include <linux/of_fdt.h>
 #include <asm/addrspace.h>
 #include <asm/byteorder.h>
 #include <asm/mips-boards/bonito64.h>

Otherwise including generic.h might result in an error if <linux/of_fdt.h>
has not been included before.

@@ -87,9 +88,7 @@
 
 extern int mips_revision_sconid;
 
-#ifdef CONFIG_OF
 extern struct boot_param_header __dtb_start;
-#endif

There's no need to wrap this declaration.

  Ralf
