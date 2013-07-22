Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Jul 2013 22:39:25 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:39012 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824761Ab3GVUjXYosUY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 Jul 2013 22:39:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 91ACA19BE32;
        Mon, 22 Jul 2013 23:39:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id ubda5iXSwWYu; Mon, 22 Jul 2013 23:39:18 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id 5CCB85BC003;
        Mon, 22 Jul 2013 23:39:17 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Mon, 22 Jul 2013 23:39:12 +0300
Date:   Mon, 22 Jul 2013 23:39:12 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Faidon Liambotis <paravoid@debian.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: cavium-octeon: fix I/O space setup on non-PCI
 systems
Message-ID: <20130722203912.GA31864@blackmetal.musicnaut.iki.fi>
References: <1374522901-30290-1-git-send-email-aaro.koskinen@iki.fi>
 <51ED9153.4080904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51ED9153.4080904@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Mon, Jul 22, 2013 at 01:08:51PM -0700, David Daney wrote:
> On 07/22/2013 12:55 PM, Aaro Koskinen wrote:
> >Fix I/O space setup, so that on non-PCI systems using inb()/outb()
> >won't crash the system. Some drivers may try to probe I/O space and for
> >that purpose we can just allocate some normal memory initially. Drivers
> >trying to reserve a region will fail early as we set the size to 0. If
> >a real I/O space is present, the PCI/PCIe support code will re-adjust
> >the values accordingly.
> >
> >Tested with EdgeRouter Lite by enabling CONFIG_SERIO_I8042 that caused
> >the originally reported crash.
> >
> >Reported-by: Faidon Liambotis <paravoid@debian.org>
> >Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> >---
> >
> >	v2: Address the issues found from the first version of the patch
> >	    (http://marc.info/?t=137434204000002&r=1&w=2).
> >
> >  arch/mips/cavium-octeon/setup.c | 28 ++++++++++++++++++++++++++++
> >  arch/mips/pci/pci-octeon.c      |  9 +++++----
> >  2 files changed, 33 insertions(+), 4 deletions(-)
> >
> >diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> >index 48b08eb..6775bd1 100644
> >--- a/arch/mips/cavium-octeon/setup.c
> >+++ b/arch/mips/cavium-octeon/setup.c
> >@@ -8,6 +8,7 @@
> >   *   written by Ralf Baechle <ralf@linux-mips.org>
> >   */
> >  #include <linux/compiler.h>
> >+#include <linux/vmalloc.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/console.h>
> >@@ -1139,3 +1140,30 @@ static int __init edac_devinit(void)
> >  	return err;
> >  }
> >  device_initcall(edac_devinit);
> >+
> >+static void __initdata *octeon_dummy_iospace;
> >+
> >+static int __init octeon_no_pci_init(void)
> >+{
> >+	/*
> >+	 * Initially assume there is no PCI. The PCI/PCIe platform code will
> >+	 * later re-initialize these to correct values if they are present.
> >+	 */
> >+	octeon_dummy_iospace = vzalloc(IO_SPACE_LIMIT);
> >+	set_io_port_base((unsigned long)octeon_dummy_iospace);
> >+	ioport_resource.start = MAX_RESOURCE;
> >+	ioport_resource.end = 0;
> >+	return 0;
> >+}
> >+arch_initcall(octeon_no_pci_init);
> >+
> 
> Do we have any guarantee that this will happen before the
> arch/mips/pci/* arch_initcalls ?

Yes, it's guaranteed by the linking order ie. in which order the obj-y
stuff gets listed in mips/Makefile. Currently cavium-octeon/ is processed
before pci/.

Quoting including/linux/init.h:

/* initcalls are now grouped by functionality into separate 
 * subsections. Ordering inside the subsections is determined
 * by link order. 

A.
