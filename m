Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8E7qp125517
	for linux-mips-outgoing; Fri, 14 Sep 2001 00:52:51 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8E7qme25514
	for <linux-mips@oss.sgi.com>; Fri, 14 Sep 2001 00:52:48 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA22147;
	Fri, 14 Sep 2001 00:52:37 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA10053;
	Fri, 14 Sep 2001 00:52:38 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f8E7qca28443;
	Fri, 14 Sep 2001 09:52:39 +0200 (MEST)
Message-ID: <3BA1B747.834A875A@mips.com>
Date: Fri, 14 Sep 2001 09:52:39 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: Update for RedHat 7.1
References: <20010907230009.A1705@lucon.org> <3BA0CB8D.ED5AB42B@mips.com> <20010913081450.B24910@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:

> On Thu, Sep 13, 2001 at 05:06:53PM +0200, Carsten Langgaard wrote:
> > I now tried to installing the bigendian RedHat7.1 RPMs and I noticed the
> > following.
> >
> > /etc/localtime is lacking in glibc-2.2.4-11.2.mips.rpm (but it's contain
> > in the little endian version).
> > All the timezone information is lacking under /usr/share/zoneinfo in
> > glibc-common-2.2.4-11.2 (but it's in the little endian version).
>
> Everything is cross compiled. Since x86 is little endian, I don't
> cross compile big endian data files, like locale and timezone. You
> can rebuild glibc natively to get all those data files.
>
> >
> > I can't changes the root password, I get the following:
> > # passwd root
> > Changing password for user root
> > New UNIX password:
> > /usr/lib/cracklib_dict: magic mismatch
> > PWOpen: Success
> >
>
> It may be the endian issue. Please recompile cracklib natively and let
> me know if it fixes the problem for you.

I recompiled cracklib natively and yes it works, thanks a lot.
Do you want the RPM binaries for your distribution ?

>
> H.J.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
