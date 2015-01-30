Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 17:37:06 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52993 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012309AbbA3QhEczc5c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 17:37:04 +0100
Date:   Fri, 30 Jan 2015 16:37:04 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: Re: [PATCH 2/2] MIPS: Makefile: Set default ISA level
In-Reply-To: <1422629056-27715-2-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1501301621090.28301@eddie.linux-mips.org>
References: <1422629056-27715-1-git-send-email-markos.chandras@imgtec.com> <1422629056-27715-2-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45583
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 30 Jan 2015, Markos Chandras wrote:

> When we configure the toolchain, we can set the default
> ISA level to be used when none is set in the command line.
> This, however, has some undesired consequences when the parameters
> used in the command line are incompatible with the built-in ISA
> level of the toolchain. In order to minimize such problems, we set
> a good default ISA level if the Makefile hasn't set one for the
> selected processor.

 Agreed, but does it happen for any actual configuration?  If so, then the 
configuration is broken and your proposal papers over it, an explicit 
`-march=' option is supposed to be there for all the possible CPU_foo 
settings.  At first look it seems to be the case in arch/mips/Makefile, 
but maybe I'm missing something.  Besides, a default of `-march=mips32' or 
whatever may not really be adequate for the CPU selected.

> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 0608ec524d3d..a244fb311a37 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -226,6 +226,15 @@ cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
>  drivers-$(CONFIG_PCI)		+= arch/mips/pci/
>  
>  #
> +# Don't trust the toolchain defaults. Use a sensible -march
> +# option but only if we don't have one already.
> +#
> +ifeq (,$(findstring march=, $(cflags-y)))
> +cflags-$(CONFIG_32BIT)			+= -march=mips32
> +cflags-$(CONFIG_64BIT)			+= -march=mips64
> +endif

 So I'd rather see some form of diagnostics instead, e.g.:

ifeq (,$(filter -march=% -mips%, $(cflags-y)))
$(error Configuration bug, no `-march=' option set for the CPU selected!)
endif

or suchlike (`-mips%' for the legacy stuff; we should probably drop it 
sometime).  WDYT?

  Maciej
