Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2003 16:20:37 +0100 (BST)
Received: from [IPv6:::ffff:203.82.55.162] ([IPv6:::ffff:203.82.55.162]:60289
	"EHLO 1aurora.enabtech") by linux-mips.org with ESMTP
	id <S8225314AbTH1PUf>; Thu, 28 Aug 2003 16:20:35 +0100
Received: by 1aurora.enabtech with Internet Mail Service (5.5.2650.21)
	id <RGSFMMXF>; Thu, 28 Aug 2003 20:14:07 +0500
Message-ID: <10C6C1971DA00C4BB87AC0206E3CA3826271C3@1aurora.enabtech>
From: Adeel Malik <AdeelM@avaznet.com>
To: linux-mips@linux-mips.org
Cc: jsun@mvista.com
Subject: RE: Information required
Date: Thu, 28 Aug 2003 20:14:06 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C36D77.05BDE7E0"
Return-Path: <AdeelM@avaznet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: AdeelM@avaznet.com
Precedence: bulk
X-list: linux-mips

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C36D77.05BDE7E0
Content-Type: text/plain;
	charset="iso-8859-1"

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
**********************************/

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

 


------_=_NextPart_001_01C36D77.05BDE7E0
Content-Type: text/html;
	charset="iso-8859-1"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">


<META content="MSHTML 6.00.2600.0" name=GENERATOR></HEAD>
<BODY style="COLOR: #000000; FONT-FAMILY: Arial">
<DIV><FONT size=2>
<P>Hello Jun,</P>
<P>Thanks for the reply.I have checked for the unresolved function symbols like 
"printk" and "register_chrdev", and found that they are present in /proc/ksyms. 
So it appears to me that I may be compiling the module with incorrect 
parameters.</P>
<P>Below is the Makefile for the Loadable Module:</P>
<P>/*****************************************************************************************************************/</P>
<P>CROSS_COMPILE= 
/backup/buildroot-QuickMIPS/build/staging_dir/bin/mipsel-uclibc-</P>
<P>TARGET = example_driver</P>
<P>INCLUDE = /backup/buildroot-QuickMIPS/build/linux-2.4.20/include</P>
<P>CC = $(CROSS_COMPILE)gcc -I${INCLUDE}</P>
<P>CFLAGS = -DMODVERSIONS -I${INCLUDE}/linux/modversions.h</P>
<P>${TARGET}.o: ${TARGET}.c</P>
<P>.PHONY: clean</P>
<P>clean:</P>
<P>rm -rf ${TARGET}.o</P>
<P>/****************************************************************************************************************/</P>
<P>Do you think that I need to modify the makefile or add some more options to 
CFLAGS.</P>
<P>I have ensured that the kernel is compiled with "module-option" turned 
on.</P>
<P>Also my module uses symbol versioning (sometimes called module 
versioning).</P>
<P>I use the following lines of code at the start of header file to accomplish 
this:</P>
<P>/*************************************************************************************************************/</P>
<P>#if defined (CONFIG_MODVERSIONS) &amp;&amp; ! defined (MODVERSIONS)</P>
<P>#include &lt;linux/modversions.h&gt;</P>
<P>#define MODVERSIONS</P>
<P>#endif</P>
<P>/*************************************************************************************************************/</P>
<P>I have successfully cross-compiled user-space applications on the target 
platform. Only when i do the kernel work, this unresolved symbol (like printk, 
register_chrdev, etc..) phenomenon happens.</P>
<P>ADEEL MALIK,</P>
<P>&nbsp;</P>
<P>-----Original Message-----</P>
<P>From: linux-mips-bounce@linux-mips.org</P>
<P>[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of Jun Sun</P>
<P>Sent: Wednesday, August 27, 2003 9:51 PM</P>
<P>To: Adeel Malik</P>
<P>Cc: linux-mips@linux-mips.org; jsun@mvista.com</P>
<P>Subject: Re: Information required</P>
<P>&nbsp;</P>
<P>On Wed, Aug 27, 2003 at 07:30:26PM +0500, Adeel Malik wrote:</P>
<P>&gt; Hi All,</P>
<P>&gt; I am involved in Embedded Linux Development for MIPS Processor. I</P>
<P>&gt; need to write a device driver for a MIPS Target Platform. When I insmod 
the</P>
<P>&gt; driver.o file, the linux bash script running on the target hardware 
gives me</P>
<P>&gt; the error message like ;</P>
<P>&gt; 1. unable to resolve the printk function</P>
<P>&gt; 2. unable to resolve the register_chardev function</P>
<P>&gt; etc.</P>
<P>&gt; Can you plz give me the direction as to how to proceed to tackle 
this</P>
<P>&gt; situation.</P>
<P>Make sure your kernel compiled with module option turned on.</P>
<P>Does it use module version (CONFIG_MODVERSIONS)?</P>
<P>If so, add -DMODVERSIONS -include 
$(KERNEL_PATH)/include/linux/modversions.h</P>
<P>to your CFLAGS.</P>
<P>Jun</P>
<P>&nbsp;</P></FONT></DIV></BODY></HTML>

------_=_NextPart_001_01C36D77.05BDE7E0--
