Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB96Zwm28475
	for linux-mips-outgoing; Sat, 8 Dec 2001 22:35:58 -0800
Received: from smtp011.mail.yahoo.com (smtp011.mail.yahoo.com [216.136.173.31])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB96Zro28472
	for <linux-mips@oss.sgi.com>; Sat, 8 Dec 2001 22:35:53 -0800
Received: from unknown (HELO garrickevansw2k) (12.236.169.95)
  by smtp.mail.vip.sc5.yahoo.com with SMTP; 9 Dec 2001 05:35:52 -0000
Message-ID: <00a301c18073$5d29a810$6401a8c0@autodesk.com>
From: "Garrick Evans" <sginux@yahoo.com>
To: "Carsten Langgaard" <carstenl@mips.com>,
   "Guido Guenther" <agx@sigxcpu.org>, <linux-mips@oss.sgi.com>
References: <3C0CDB7B.C13AE2B3@mips.com> <20011204161157.A9410@galadriel.physik.uni-konstanz.de> <3C10A5CB.FB92B3A@mips.com> <3C10C526.56F65E57@mips.com>
Subject: Re: Mozilla/Netscape on MIPS
Date: Sat, 8 Dec 2001 21:35:51 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

this is a debug/test debug no? i mean it chews up RAM... got a thinner
version?

----- Original Message -----
From: "Carsten Langgaard" <carstenl@mips.com>
To: "Guido Guenther" <agx@sigxcpu.org>; <linux-mips@oss.sgi.com>
Sent: Friday, December 07, 2001 5:33 AM
Subject: Re: Mozilla/Netscape on MIPS


> Carsten Langgaard wrote:
>
> > Guido Guenther wrote:
> >
> > > On Tue, Dec 04, 2001 at 03:19:39PM +0100, Carsten Langgaard wrote:
> > > > There has previous been some request about running Mozilla on a MIPS
> > > > system.
> > > > We have put a bigendian and a littleendian image on our FTP site.
> > > >
> > > > It runs on the current RedHat7.1 distribution with some minor
updates.
> > > > The needed RPMs is also available on our FTP site:
> > > >     ftp://ftp.mips.com/pub/linux/mips/installation/apps/mozilla/
> > > Were any special patches needed? Could you please also put the source
> > > rpms there?
> >
> > Ok, I will put the sources on our FTP.
> > Inorder to build the sources you also need to install some extra RPMs
and
> > rebuild crtbeginS.o, crti.o and libc_nonshared.a with the -Wa,-xgot
option.
>
> It now on FTP, you will also find precompiled version of crtbeginS.o,
crti.o
> and libc_nonshared.a (compiled with -Wa,-xgot).
> Please read the README.build file for howto build the sources.
>
> The link are:
> ftp://ftp.mips.com/pub/linux/mips/installation/apps/mozilla/src/
>
> >
> > >
> > > Regards,
> > >  -- Guido


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com
