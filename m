Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Aug 2003 12:41:00 +0100 (BST)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:44979
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225346AbTH3Lk5>; Sat, 30 Aug 2003 12:40:57 +0100
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <RGSFMMYX>; Sat, 30 Aug 2003 16:34:48 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA382627229@1aurora.enabtech>
From: Adeel Malik <AdeelM@avaznet.com>
To: Dan Aizenstros <daizenstros@quicklogic.com>
Cc: linux-mips@linux-mips.org
Subject: RE: RE: Information required
Date: Sat, 30 Aug 2003 16:34:40 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Return-Path: <AdeelM@avaznet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3111
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@avaznet.com
Precedence: bulk
X-list: linux-mips

Hi Dan,
       I have been able to resolve all the unresolved function symbols, by
properly configuring the MODVERSIONING in the module code. Only two symbols
are left:

1. unresolved symbol Atomic_add
2. unresolved symbol Atomic_sub

These symbols are not even in /proc/ksyms and System.map file of the
cross-compild linux-2.4 directory.

So can you guide me further,

Thanks in advance,

Adeel



-----Original Message-----
From: Dan Aizenstros [mailto:daizenstros@quicklogic.com]
Sent: Thursday, August 28, 2003 8:43 PM
To: AdeelM@avaznet.com
Subject: Re: RE: Information required


Hello Adeel,

You need to pass -mlong-calls to the compiler.
You can add it the CFLAGS.

Regards,

Dan Aizenstros
Software Engineering Manager
QuickLogic Canada

>>> Adeel Malik <AdeelM@avaznet.com> 08/28/03 08:22 AM >>>
Hello Jun,

Thanks for the reply.I have checked for the unresolved function symbols like
"printk" and "register_chrdev", and found that they are present in
/proc/ksyms. So it appears to me that I may be compiling the module with
incorrect parameters.

Below is the Makefile for the Loadable Module:

/***************************************************************************
**************************************/

CROSS_COMPILE=
/backup/buildroot-QuickMIPS/build/staging_dir/bin/mipsel-uclibc-

TARGET = example_driver

INCLUDE = /backup/buildroot-QuickMIPS/build/linux-2.4.20/include

CC = $(CROSS_COMPILE)gcc -I${INCLUDE}

CFLAGS = -DMODVERSIONS -I${INCLUDE}/linux/modversions.h

${TARGET}.o: ${TARGET}.c

.PHONY: clean

clean:

rm -rf ${TARGET}.o

/***************************************************************************
*************************************/

Do you think that I need to modify the makefile or add some more options to
CFLAGS.

I have ensured that the kernel is compiled with "module-option" turned on.

Also my module uses symbol versioning (sometimes called module versioning).

I use the following lines of code at the start of header file to accomplish
this:

/***************************************************************************
**********************************/

#if defined (CONFIG_MODVERSIONS) && ! defined (MODVERSIONS)

#include <linux/modversions.h>

#define MODVERSIONS

#endif

/***************************************************************************
*********************************/

I have successfully cross-compiled user-space applications on the target
platform. Only when i do the kernel work, this unresolved symbol (like
printk, register_chrdev, etc..) phenomenon happens.

ADEEL MALIK,

 

-----Original Message-----

From: linux-mips-bounce@linux-mips.org

[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Jun Sun

Sent: Wednesday, August 27, 2003 9:51 PM

To: Adeel Malik

Cc: linux-mips@linux-mips.org; jsun@mvista.com

Subject: Re: Information required

 

On Wed, Aug 27, 2003 at 07:30:26PM +0500, Adeel Malik wrote:

> Hi All,

> I am involved in Embedded Linux Development for MIPS Processor. I

> need to write a device driver for a MIPS Target Platform. When I insmod
the

> driver.o file, the linux bash script running on the target hardware gives
me

> the error message like ;

> 1. unable to resolve the printk function

> 2. unable to resolve the register_chardev function

> etc.

> Can you plz give me the direction as to how to proceed to tackle this

> situation.

Make sure your kernel compiled with module option turned on.

Does it use module version (CONFIG_MODVERSIONS)?

If so, add -DMODVERSIONS -include $(KERNEL_PATH)/include/linux/modversions.h

to your CFLAGS.

Jun

 
