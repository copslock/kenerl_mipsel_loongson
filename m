Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4I18t600704
	for linux-mips-outgoing; Thu, 17 May 2001 18:08:55 -0700
Received: from smtp.psdc.com (smtp.psdc.com [209.125.203.83])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4I18tF00701
	for <linux-mips@oss.sgi.com>; Thu, 17 May 2001 18:08:55 -0700
Received: from BANANA ([209.125.203.85])
	by smtp.psdc.com (8.8.8/8.8.8) with SMTP id SAA11903;
	Thu, 17 May 2001 18:14:42 -0700
Message-ID: <001201c0df37$2befb920$dde0490a@pcs.psdc.com>
From: "Steven Liu" <stevenliu@psdc.com>
To: "Keith M Wesolowski" <wesolows@foobazco.org>
Cc: <linux-mips@oss.sgi.com>
References: <000801c0a572$b7471e40$dde0490a@BANANA> <20010305205516.A25870@foobazco.org>
Subject: Re: mips-tfile
Date: Thu, 17 May 2001 18:09:17 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi, All:

I have a question about GCC:

How can we make gcc do not use the MIPS instructions lwl, lwr, swl, and swr?

Thanks,

Steven
----- Original Message -----
From: "Keith M Wesolowski" <wesolows@foobazco.org>
To: "Steven Liu" <stevenliu@psdc.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Monday, March 05, 2001 9:55 PM
Subject: Re: mips-tfile


> On Mon, Mar 05, 2001 at 04:49:28AM -0800, Steven Liu wrote:
>
> > I am working on cross-compiler for mips R3000 on Linux now and meet a
problem in egcs.
> >
> > My host system is i386 with Rad Hat 7.0 installed.
> >
> > First, I successfully built and installed binutils-2.8.1 by using
> > binutils-2.8.1.tar.gz and egcs-mips-linux-1.1.2-2.i386.rpm. This created
> > bin, lib, mips-linux subdirectories.
>
> This makes no sense...how/why did you use an rpm of egcs to build
> binutils from source?  That doesn't really make any sense.  Could you
> please indicate what exact files you are using and where you got them
> from?  If you are applying patches, please mention those as well.
>
> > Second, I installed the linux kernel source code for mips by using
> > linux-2.2.14-000715.tar.gz and configured it and enabled
> > CONFIG_CROSSCOMPILE.  Made soft links: let  mips-linux/include/asm
> > pointd to linux-2.2.14-000715/include/asm-mips and
> > mips-linux/include/linux pointd to linux-2.2.14-000715/include/linux.
>
> This is not needed to build either gcc or the kernel.
>
> > Third, unziped the egcs-1.1.2.tar.gz, added the patch
> > egcs-mips-linux-1.1.2-2.i386.rpm and configured it as following:
> >      ./configure --prefix=3D/home/sliu --with-newlib --target=mips-linux
> > and made it this way:
> >      make SUBDIRS=3D"libiberty texinfo gcc" ALL_TARGET_MODULES=3D =
> > CONFIGURE_TARGET_MODULES=3D INSTALL_TARGET_MODULES=3D LANGUAGES=3D"c"
>
> What are you doing with both an rpm and a source tarball?  An RPM is
> surely not a patch.  Also, it is traditional to build gcc outside the
> source directory; it's possible that that is a source of trouble.  The
> random "3D" in your output there is either another source of trouble
> or an artifact of your mailer; in either case it should be fixed.
>
> If you are having trouble building a cross-toolchain, you might
> consider getting make-cross from
> ftp://oss.sgi.com/pub/linux/mips/mips-linux/simple/crossdev - it takes
> most of the hard parts out of it.  There's also a source toolchain
> there that seems to work fairly well; it compiles glibc, for example,
> which no version of egcs 1.1.2 I have seen will.  Of course, if you
> want to use different versions you can do that as well.
>
> --
> Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
> ------(( Project Foobazco Coordinator and Network Administrator ))------
> "I should have crushed his marketing-addled skull with a fucking bat."
>
