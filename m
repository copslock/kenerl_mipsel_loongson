Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2003 22:52:24 +0000 (GMT)
Received: from p508B6365.dip.t-dialin.net ([IPv6:::ffff:80.139.99.101]:12182
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225346AbTKPWwM>; Sun, 16 Nov 2003 22:52:12 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAGMpZA0013174;
	Sun, 16 Nov 2003 23:51:36 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAGMpXkR013173;
	Sun, 16 Nov 2003 23:51:33 +0100
Date: Sun, 16 Nov 2003 23:51:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: durai <durai@isofttech.com>
Cc: linux-mips@linux-mips.org
Subject: Re: file handling in kernel mode
Message-ID: <20031116225133.GA7808@linux-mips.org>
References: <92F2591F460F684C9C309EB0D33256FA01B750B8@trid-mail1.tridentmicro.com> <20031115125329.GA324@linux-mips.org> <007801c3ac20$070adff0$0205a8c0@DURAI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <007801c3ac20$070adff0$0205a8c0@DURAI>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 16, 2003 at 02:30:05PM +0530, durai wrote:

> Hello,
> I need to read a file from a device driver and i wrote a sample driver
> like this
> 
> This kernel mode code which try to read the file until end of file is
> reached. This code had been is working without any problems in RedHat
> linux and uClinux.
> But the same code causes a General Protection Fault in my mips linux.
> I tested the same code in mips running on uClinux which runs well.
> what is wrong with mips linux?

If the screen says general protection fault it's wasn't a MIPS box :-)

> #define __KERNEL_SYSCALLS__
> 
> #include <linux/version.h>
> #ifdef MODULE
> #ifdef MODVERSIONS
> #include <linux/modversions.h>
> #endif
> #include <linux/module.h>
> #else
> #define MOD_INC_USE_COUNT
> #define MOD_DEC_USE_COUNT
> #endif

Ouch.  You can replace that all with a single line:

#include <linux/module.h>

> int init_module(void)

[...]

> void cleanup_module(void)

[...]

The use of init_module and cleanup_module is deprecated, use something
like this instead:

#include <linux/init.h>

static int __init foo_init_module(void)
{
	return 0;
}

static void __exit foo_cleanup_module(void)
{
}

module_init(foo_init_module);
module_exit(foo_cleanup_module);


> int test_open(void )
> {
>     int ifp,bcount;
>     mm_segment_t fs;
>     char buffer[0x1000];
                  ^^^^^^

And this is the BIG no-no.  Never allocate large amounts of data on the
kernel stack which is only 8k which are used for various other stuff
also..

> 
>     // for file opening temporarily tell the kernel I am not a user for
>     // memory management segment access
>     fs = get_fs();
>     set_fs(KERNEL_DS);
>     // open the file with the firmware for uploading
>     if (ifp = open( "/etc/hotplug/isl3890.arm", O_RDONLY, 0 ), ifp < 0)
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^

Hard coding file names is generally considered bad design; this topic has
been discussed to death numerous times on linux-kernel.  The general
recommendation is to use a special such as /dev/foodevice; the firmware
would then simply be loader by cat bar > //dev/foodevice or similar.

For 2.4.23 (I'm going to merge with 2.4.23-rc1 tonight) and 2.6 the
recommendation is to use CONFIG_FW_LOADER, the new standard interface
for loading firmware.

  Ralf
