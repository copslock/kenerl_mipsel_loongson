Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f336ckT23147
	for linux-mips-outgoing; Mon, 2 Apr 2001 23:38:46 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f336chM23143;
	Mon, 2 Apr 2001 23:38:43 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA29728;
	Mon, 2 Apr 2001 23:38:45 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA04937;
	Mon, 2 Apr 2001 23:38:44 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.9.1/8.9.0) with ESMTP id IAA23156;
	Tue, 3 Apr 2001 08:38:06 +0200 (MEST)
Message-ID: <3AC96FCE.D004D515@mips.com>
Date: Tue, 03 Apr 2001 08:38:06 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: RedHat7.0
References: <3AC884AA.A0B2C595@mips.com> <20010402201538.A23535@bacchus.dhis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Mon, Apr 02, 2001 at 03:54:51PM +0200, Carsten Langgaard wrote:
>
> > Ralf, which compiler and tools did you use to compile the RedHat7.0
> > source RPMs ?
>
> The binutils are included in redhat 7 as on oss are not the original
> binutils from Redhat 7.0 but a CVS snapshot with MIPS patches.  This
> distribution does not contain a gcc rpm because I haven't yet built a
> package from it.  I can however upload a tar ball of my build directory
> so you can install my gcc with just ``make install'', if you want.

That would be great, please do.

>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
