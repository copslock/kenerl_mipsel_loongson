Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 10:40:18 +0100 (BST)
Received: from [IPv6:::ffff:202.145.53.89] ([IPv6:::ffff:202.145.53.89]:45246
	"EHLO miao.coventive.com") by linux-mips.org with ESMTP
	id <S8225073AbTEIJkP>; Fri, 9 May 2003 10:40:15 +0100
Received: from pc208 (PC208.ia.kh.coventive.com [192.168.23.208] (may be forged))
	by miao.coventive.com (8.11.6/8.11.6) with SMTP id h499dsx22809;
	Fri, 9 May 2003 17:39:56 +0800
Message-ID: <000401c3160f$1a087bf0$d017a8c0@pc208>
From: "smills_ho" <smills_ho@coventive.com>
To: <kumba@gentoo.org>, <linux-mips@linux-mips.org>
References: <3EB0B329.9030603@ict.ac.cn> <16048.55936.346808.522687@cuddles.redhat.com> <3EB0DDC6.5080108@ict.ac.cn> <16048.57054.224964.883062@cuddles.redhat.com> <20030501085018.GA1885@greglaptop.attbi.com> <000a01c315cf$8171ac70$d017a8c0@pc208> <1052464867.2485.3.camel@ghostwheel.sfbay.redhat.com> <3EBB58C6.3070604@gentoo.org> <001f01c31603$1ed7fbd0$d017a8c0@pc208> <3EBB670E.4020200@gentoo.org>
Subject: Re: Problem of cross-mipsel-compiler GLIBC-2.3.X
Date: Fri, 9 May 2003 17:40:58 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <smills_ho@coventive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2319
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: smills_ho@coventive.com
Precedence: bulk
X-list: linux-mips

Dear Kumba,

    After try several versions of binutils and glibc , it works in crossing
XFree86 4.2.1.
binutils 2.13.2.1 + gcc 3.2.3 + glibc 2.3.2
and some patchs come from debian's packages ( binutils 2.13.90.0.18 ,
gcc-3.2.1,glibc-2.3.1)

Thanks and best regards,

Smills_ho

----- Original Message -----
From: "Kumba" <kumba@gentoo.org>
To: <linux-mips@linux-mips.org>
Sent: Friday, May 09, 2003 4:30 PM
Subject: Re: Problem of cross-mipsel-compiler GLIBC-2.3.X


>
> I'm not quite sure.  I don't see how trying it could hurt, maybe it
> will work, maybe it won't.  Although, 2.14.90.0.1 was just released as
> well, you might try that, or even CVS Head, as I heard that includes
> last-minute mips fixes.  I'm fairly new to the whole cross-compiler
> thing myself, and recently discovered the HOWTO mentioned in your
> previous mail, which I'm looking at to try and get an i686->mips
> cross-compiler going.  For now though, my sparc->mips cross-compiler
> works, so it's what I'll rely on the most.
>
> --Kumba
>
>
> smills_ho wrote:
> > Dear Kumba,
> >     Should we try this binutils-2.13.90.0.20?
> > We try the version binutils-2.13.90.0.18 (Debian used) and it is failed
on
> > cross-gcc step :-(
> >
> > Thanks and best regards,
> >
> > ----- Original Message -----
> > From: "Kumba" <kumba@gentoo.org>
> > To: <linux-mips@linux-mips.org>
> > Sent: Friday, May 09, 2003 3:29 PM
> > Subject: Re: Problem of cross-mipsel-compiler GLIBC-2.3.X
> >
> >
> >
> >>Oddly enough, I followed these basic steps and wound up with a working
> >>cross-compiler from sparc64 -> mipseb (Sun Blade 100 to mips
> >>big-endian).  Gcc nor glibc gave me any issues.....However, when I tried
> >>the same exact steps on i686, glibc complained about libgcc not being
> >>available, among other things.  It's got me baffled, but I'm not exactly
> >>complaining.  Currently, it's gcc-3.2.3 (propolice patched) +
> >>glibc-2.3.2 + binutils-2.13.90.0.20, which it'll get rebuilt for the new
> >>binutils 2.14.
> >>
> >>--Kumba
> >>
> >>
> >>
> >>Eric Christopher wrote:
> >>
> >>>On Thu, 2003-05-08 at 19:05, smills_ho wrote:
> >>>
> >>>
> >>>>Dear All,
> >>>>   I want to make a cross-compilered glibc-2.3.x and I get the source
> >
> > from
> >
> >>>>ftp.gun.org. GCC version is 3.2.3, binutils is 2.13.2.1. The step is
as
> >>>>following:
> >>>>
> >>>>1. Try to build binutils
> >>>>2. Try to make static GCC
> >>>>3. Try to make glibc -----> Then it is failed
> >>>>
> >>>>Is there anybody know what's going on or somebody had successfully to
> >
> > build
> >
> >>>>the crossed glibc-2.3.x?
> >>>
> >>>
> >>>A host cross host compiler for linux systems is a little more involved
> >>>than this :)
> >>>
> >>>However, I don't know where you went wrong since you really didn't
> >>>provide much in the way of information as to what you did or where it
> >>>failed.
> >>>
> >>>-eric
> >>>
> >>
> >>
> >
> >
> >
>
>
