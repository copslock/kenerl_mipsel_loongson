Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GBS4k23979
	for linux-mips-outgoing; Mon, 16 Jul 2001 04:28:04 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GBRsV23964;
	Mon, 16 Jul 2001 04:27:54 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA24153;
	Mon, 16 Jul 2001 04:27:45 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id EAA00561;
	Mon, 16 Jul 2001 04:27:42 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f6GBQWa03636;
	Mon, 16 Jul 2001 13:26:32 +0200 (MEST)
Message-ID: <3B52CF68.4687EBCB@mips.com>
Date: Mon, 16 Jul 2001 13:26:32 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: Jun Sun <jsun@mvista.com>, ralf@oss.sgi.com, vhouten@kpn.com,
   linux-mips@oss.sgi.com
Subject: Re: Illegal instruction
References: <3B4573B8.9F89022B@mips.com> <3B4635FB.1ED5D222@mvista.com> <3B4AE384.52049D47@mips.com> <20010710103121.L19026@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" wrote:

> On Tue, Jul 10, 2001 at 01:14:12PM +0200, Carsten Langgaard wrote:
> > Thanks, that did the trick.
> > Now I would like to try to install H.J. Lu's RedHat7.1 RPM packages.
> > If I just do a:
> >     rpm -Uvh --root /mnt/harddisk *.rpm
>
> Those rpms have to be installed in the right order. I have a set up
> to do that. I will see what I can do.

Thanks, please do.
Another thing, I can see your distribution is lacking kernel header
files, I guess they are needed to do a native compile of the source RPMs.

Are you only cross compiling the RPMs.
It would be great, if you could put together a RPM containing the kernel
header files.

>
> H.J.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
