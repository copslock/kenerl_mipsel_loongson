Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Mar 2005 02:50:06 +0100 (BST)
Received: from web15801.mail.cnb.yahoo.com ([IPv6:::ffff:202.165.102.81]:14220
	"HELO web15801.mail.cnb.yahoo.com") by linux-mips.org with SMTP
	id <S8225996AbVCaBtt>; Thu, 31 Mar 2005 02:49:49 +0100
Message-ID: <20050331014935.81645.qmail@web15801.mail.cnb.yahoo.com>
Received: from [210.76.108.109] by web15801.mail.cnb.yahoo.com via HTTP; Thu, 31 Mar 2005 09:49:35 CST
Date:	Thu, 31 Mar 2005 09:49:35 +0800 (CST)
From:	dfsd df <tomcs163@yahoo.com.cn>
Subject: Re: Some questions about kernel tailoring
To:	linux-mips@linux-mips.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-Path: <tomcs163@yahoo.com.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tomcs163@yahoo.com.cn
Precedence: bulk
X-list: linux-mips

Thanks for your reply!

> That's correct... 'vmlinux' is your kernel.  mips
> doesn't use zImages.

But , the vmlinux is too big, Waht should I do? Is the
vmlinux already compressed?

> (PS... Please refrain from HTML email on this list)

Sorry, I'm a newbie, I really don't know what you
mean. :-)

--- Stuart Longland <stuartl@longlandclan.hopto.org>
wrote:
> dfsd df wrote:
> > Hello, everybody:
> >      Now, I participate to porting linux to MIPS
> platform. I'm a newbie.
> >  
> >      I met some questions, I hope somebody can
> tell me why or give me
> > some hints! thanks!
> >  
> > The board is Malta, CPU is MIPS4kc. I downloaded
> kernel src from
> > ftp.mips.com <ftp://ftp.mips.com>
> >  
> > 1. I use "make zImage" for kernel-2.4.3,
> everything is ok!
> > But using "make zImage" for kernel-2.4.18, I
> failed, It could only
> > build a vmlinux file.
> 
> That's correct... 'vmlinux' is your kernel.  mips
> doesn't use zImages.
> 
> > I find it's because of no rules in
> arch/mips/boot/Makefile to build
> > zImage.
> > So I modified the arch/mips/boot/Makefile, It
> worked fine.
> >  but when excuted "./mkboot zImage.tmp zImage", It
> generated a very big
> > zImage file. After noticing "file size exceed",
> the system delete the
> > zImage file automatically!
> > 
> 
> Try running mkboot on the vmlinux file.
> 
> > what's wrong about it? It's ok for kernel-2.4.3.
> and I can make sure
> > that the mkboot is no problem.
> 
> A newer kernel mightn't be a bad idea either...
> 2.4.3 is very old now.
> 
> > 2. I only selectd board and cpu type when
> compiling the kernel-2.4.3.
> > If using make ,the vmlinux size is about 780k. If
> using "make zImage",
> > the zImage file is about 580k.
> > I think that's a minimun size by using "make
> menuconfig".
> > but I use gzip to compress this two files, its
> size became only 1/3 of
> > their original size.
> >  
> > So I'm puzzled why "make zImage" don't use gzip
> compress method? If so ,
> > we can get a more small kernel, isn't it?
> >  
> > thanks again!
> 
> I'll let the guru's chime in here :-)
> 
> (PS... Please refrain from HTML email on this list)
> 
> -- 
>
+-------------------------------------------------------------+
> | Stuart Longland -oOo-
> http://stuartl.longlandclan.hopto.org |
> | Atomic Linux Project     -oOo-   
> http://atomicl.berlios.de |
> | - - - - - - - - - - - - - - - - - - - - - - - - -
> - - - - - |
> | I haven't lost my mind - it's backed up on a tape
> somewhere |
>
+-------------------------------------------------------------+
> 

_________________________________________________________
Do You Yahoo!?
注册世界一流品质的雅虎免费电邮
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/
