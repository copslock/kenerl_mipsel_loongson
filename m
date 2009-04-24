Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Apr 2009 07:00:22 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26764 "EHLO h5.dl5rb.org.uk")
	by ftp.linux-mips.org with ESMTP id S20021400AbZDXGAS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 24 Apr 2009 07:00:18 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n3O60HO7024935;
	Fri, 24 Apr 2009 08:00:17 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n3O60FnB024932;
	Fri, 24 Apr 2009 08:00:15 +0200
Date:	Fri, 24 Apr 2009 08:00:15 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH] MIPS: move out Alchemy stuff to separate Makefile
Message-ID: <20090424060015.GA24625@linux-mips.org>
References: <20090424054128.GA7093@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090424054128.GA7093@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22459
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 24, 2009 at 07:41:28AM +0200, Manuel Lauss wrote:

> Move Makefile information on all Alchemy boards to a separate file
> in the arch subdir.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> ---
> Applies on top of my Alchemy-gpio patches;  builds and runs fine on a few
> different alchemy systems.  It seems nicer to not have to modify the main
> mips makefile when adding new alchemy boards. What do you all think?
> 
>  arch/mips/Makefile         |  104 +------------------------------------------
>  arch/mips/alchemy/Makefile |  106 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+), 102 deletions(-)
>  create mode 100644 arch/mips/alchemy/Makefile

I think Sam Ravnbord has written something like the grand plan for the
cleanup a few days ago; I append his mail below.

  Ralf

Date:	Tue, 21 Apr 2009 21:43:43 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-arch@vger.kernel.org
Subject: Re: introduce arch/$ARCH/Kbuild ?
Message-ID: <20090421194343.GA24535@uranus.ravnborg.org>
References: <20090416183701.GA5810@uranus.ravnborg.org> <20090421131430.GA25098@linux-mips.org>
In-Reply-To: <20090421131430.GA25098@linux-mips.org>

> 
> Most of arch/mips uses -Werror these days and while painful at times it
> keeps everybody on their toes hopefully cleaner, less buggy code.  So if
> your solution allows adding -Werror to all subdirs automatically with
> a mechanism to remove -Werror from a few selected dirs then I'm interested.

It is already present in mainline - so go wild.

I took a look at mips.
mips supports an impressive amount of platform/boards.
The has resulted in lines like the following in the arch Makefile:

core-$(CONFIG_SGI_IP32)         += arch/mips/sgi-ip32/
cflags-$(CONFIG_SGI_IP32)       += -I$(srctree)/arch/mips/include/asm/mach-ip32
load-$(CONFIG_SGI_IP32)         += 0xffffffff80004000

But this is less then optimal. If two people add a paltform you will
have a merge issue.
And centralize information like that is also questionable.

mips would be better suited if you had all sgi_ip32 information located
in a single directory.

How about a setup like this:

arch/mips/sgi_ip32/Platform:
platfrom-y                      += arch/mips/sgi-ip32/
cflags-$(CONFIG_SGI_IP32)       += -I$(srctree)/arch/mips/include/asm/mach-ip32
load-$(CONFIG_SGI_IP32)         += 0xffffffff80004000


arch/mips/Kbuild.platforms:
#All platforms listed in alphabetic order
platforms-y += lasat/
platforms-y += sgi_ip32/

#include the platform specific files
include $(patsubst %, arch/misp/%Platform)


arch/mips/Kbuild:
subdir-ccflags-y := -Werror

include arch/mips/Kbuild.platforms
obj-y += $(platform-y)

obj-y +=  arch/mips/kernel/ arch/mips/mm/ arch/mips/math-emu/


arch/mips/Makefile:
core-y += arch/mips/
include arch/mips/Kbuild.platforms



The above does a few things:
1) It decentralize the plaform stuff (to the Platform files)
2) In troduces a arch/mips/Kbuild file that specify everything
   that is linked in as core-y
3) It adds a single subdir-ccflags-y := -Werror that covers
   all platforms and the core part of the kernel
   (Everything specified in arch/mips/Kbuild)
4) It reuses Kbuild.platforms in Kbuild and
   in Makefile.
   In Makefile it is used to find ccflags-y
   and load-y definitions.
   In Kbuild it is used to find the objects to add to obj-y.


The above is entirely untested - but I hope to have adressed the principles.

	Sam
