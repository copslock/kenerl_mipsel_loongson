Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2004 07:34:32 +0100 (BST)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:33366
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8224858AbUJ0Ge1>; Wed, 27 Oct 2004 07:34:27 +0100
Received: from narendra narendradv [202.88.156.133]
	by smtp-send.myrealbox.com with NetMail SMTP Agent $Revision: 1.1.1.1 $ on Novell NetWare;
	Wed, 27 Oct 2004 00:34:23 -0600
Message-ID: <000e01c4bbee$8ba25a20$0e00a8c0@narendra>
From: "Narendra Kulkarni" <narendradv@myrealbox.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: <linux-mips@linux-mips.org>
References: <000b01c4bb6a$f87b1580$0e00a8c0@narendra> <20041026150433.GA30620@linux-mips.org>
Subject: Re: errors while  insmoding usb-skeleton.o (changed to suit our requirements)
Date: Wed, 27 Oct 2004 12:00:17 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Return-Path: <narendradv@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: narendradv@myrealbox.com
Precedence: bulk
X-list: linux-mips

Hi,

I have used the functions copy_to_user and copy_from_user in the driver to
get and send data to user space. If  I comment the above statements,  i dont
get the errors when i insmod usb-skeleton.o which i get when i use the
copy_to_user and copy _from_user functions.
errors --->

Using usb-skeleton.o
insmod: Relocation overflow of type 4 for __copy_user
insmod: Relocation overflow of type 4 for __copy_user
insmod: Relocation overflow of type 4 for __copy_user

Narendra


----- Original Message ----- 
From: "Ralf Baechle" <ralf@linux-mips.org>
To: "Narendra Kulkarni" <narendra@econtek.com>
Cc: "'Narendra Kulkarni'" <narendra@spacomp.com>;
<linux-mips@linux-mips.org>
Sent: Tuesday, October 26, 2004 8:34 PM
Subject: Re: errors while insmoding usb-skeleton.o (changed to suit our
requirements)


> On Tue, Oct 26, 2004 at 08:19:14PM +0530, Narendra Kulkarni wrote:
>
> > I am building a module usb-skeleton.o with following compiler options
(The
> > complier options are same as the options of used for building kernel)
> >
> >
opt/brcm/hndtools-mipsel-linux-3.2.3/bin/mipsel-linux-gcc -D__KERNEL__  -I/
> >
usr/src/mipslinux/src/linux/linux/include -Wall -Wstrict-prototypes -Wno-tri
> >
graphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -I/usr/src/
> >
mipslinux/src/linux/linux/../../include -I/usr/src/mipslinux/src/linux/linux
> > /include/asm/gcc -G
>
>  -mno-abicalls -fno-pic -pipe -mips2  -mlong-calls  -nostdinc -iwithprefix
> > include -DKBUILD_BASENAME=usb-skeleton  -c -o usb-skeleton.o
usb-skeleton.c
> >
> >  When insmoding the usb-skeleton.o,  insmod usb-skeleton.o
> > I am getting the following erros
> >  Using usb-skeleton.o
> >  insmod: Relocation overflow of type 4 for __copy_user
> >  insmod: Relocation overflow of type 4 for __copy_user
> >  insmod: Relocation overflow of type 4 for __copy_user
> >
> > Where am i going wrong.  Help would be appreciated.
>
> Seems your compiler command line is missing -DMODULE.
>
>   Ralf
>
>
