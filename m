Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBA8xDL24273
	for linux-mips-outgoing; Mon, 10 Dec 2001 00:59:13 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBA8x3o24270
	for <linux-mips@oss.sgi.com>; Mon, 10 Dec 2001 00:59:03 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA24953;
	Sun, 9 Dec 2001 23:58:52 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA28061;
	Sun, 9 Dec 2001 23:58:52 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fBA7wjA08572;
	Mon, 10 Dec 2001 08:58:48 +0100 (MET)
Message-ID: <3C146B3B.B20CAA4C@mips.com>
Date: Mon, 10 Dec 2001 08:58:51 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Garrick Evans <sginux@yahoo.com>
CC: linux-mips@oss.sgi.com
Subject: Re: Mozilla/Netscape on MIPS
References: <3C0CDB7B.C13AE2B3@mips.com> <20011204161157.A9410@galadriel.physik.uni-konstanz.de> <3C10A5CB.FB92B3A@mips.com> <3C10C526.56F65E57@mips.com> <00a301c18073$5d29a810$6401a8c0@autodesk.com> <3C13B9C1.94C050DD@mips.com> <004301c180fa$8ff06400$6501a8c0@autodesk.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Garrick Evans wrote:

> really? while the browser display works, there are only 2 menus "Debug" and
> "QA" and no text anywhere and none of the buttons work - in addition to
> consuming about 100+ mb of RAM

Strange, that doesn't happen to me.

>
> anyway, i've been trying to build moz for a while now and it always crashes
> out when it hits the content/build dir
>
> thoughts?

Just read the README.build from our FTP site.
 ftp://ftp.mips.com/pub/linux/mips/installation/apps/mozilla/src/README.build

>
> ----- Original Message -----
> From: "Carsten Langgaard" <carstenl@mips.com>
> To: "Garrick Evans" <sginux@yahoo.com>
> Cc: "Guido Guenther" <agx@sigxcpu.org>; <linux-mips@oss.sgi.com>
> Sent: Sunday, December 09, 2001 11:21 AM
> Subject: Re: Mozilla/Netscape on MIPS
>
> > No it's not a debug/test version, that would chew even more memory, but
> you
> > should be able to build a less "hungry" version yourself.
> > Just grip the sources and disable whatever you don't need.
> >
> > /Carsten
> >
> > Garrick Evans wrote:
> >
> > > this is a debug/test debug no? i mean it chews up RAM... got a thinner
> > > version?
> > >
> > > ----- Original Message -----
> > > From: "Carsten Langgaard" <carstenl@mips.com>
> > > To: "Guido Guenther" <agx@sigxcpu.org>; <linux-mips@oss.sgi.com>
> > > Sent: Friday, December 07, 2001 5:33 AM
> > > Subject: Re: Mozilla/Netscape on MIPS
> > >
> > > > Carsten Langgaard wrote:
> > > >
> > > > > Guido Guenther wrote:
> > > > >
> > > > > > On Tue, Dec 04, 2001 at 03:19:39PM +0100, Carsten Langgaard wrote:
> > > > > > > There has previous been some request about running Mozilla on a
> MIPS
> > > > > > > system.
> > > > > > > We have put a bigendian and a littleendian image on our FTP
> site.
> > > > > > >
> > > > > > > It runs on the current RedHat7.1 distribution with some minor
> > > updates.
> > > > > > > The needed RPMs is also available on our FTP site:
> > > > > > >     ftp://ftp.mips.com/pub/linux/mips/installation/apps/mozilla/
> > > > > > Were any special patches needed? Could you please also put the
> source
> > > > > > rpms there?
> > > > >
> > > > > Ok, I will put the sources on our FTP.
> > > > > Inorder to build the sources you also need to install some extra
> RPMs
> > > and
> > > > > rebuild crtbeginS.o, crti.o and libc_nonshared.a with the -Wa,-xgot
> > > option.
> > > >
> > > > It now on FTP, you will also find precompiled version of crtbeginS.o,
> > > crti.o
> > > > and libc_nonshared.a (compiled with -Wa,-xgot).
> > > > Please read the README.build file for howto build the sources.
> > > >
> > > > The link are:
> > > > ftp://ftp.mips.com/pub/linux/mips/installation/apps/mozilla/src/
> > > >
> > > > >
> > > > > >
> > > > > > Regards,
> > > > > >  -- Guido
> > >
> > > _________________________________________________________
> > > Do You Yahoo!?
> > > Get your free @yahoo.com address at http://mail.yahoo.com
>
> _________________________________________________________
> Do You Yahoo!?
> Get your free @yahoo.com address at http://mail.yahoo.com

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
