Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0H8QAf03624
	for linux-mips-outgoing; Thu, 17 Jan 2002 00:26:10 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0H8Q6P03612;
	Thu, 17 Jan 2002 00:26:06 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id XAA21946;
	Wed, 16 Jan 2002 23:25:55 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id XAA18673;
	Wed, 16 Jan 2002 23:25:54 -0800 (PST)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id g0H7PbA14998;
	Thu, 17 Jan 2002 08:25:37 +0100 (MET)
Message-ID: <3C467C84.AB9FFDB5@mips.com>
Date: Thu, 17 Jan 2002 08:25:56 +0100
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: linux-mips@oss.sgi.com
Subject: Re: fsck fails on latest 2.4 kernel
References: <3C454D61.ACF98623@mips.com> <3C459383.5C8A6C8B@mips.com> <20020116142628.D20408@dea.linux-mips.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Wed, Jan 16, 2002 at 03:51:47PM +0100, Carsten Langgaard wrote:
>
> > ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/binutils-mipsel-linux-2.9.5-3.i386.rpm
> > and
> >  ftp://oss.sgi.com/pub/linux/mips/crossdev/i386-linux/mipsel-linux/egcs-mipsel-linux-1.1.2-4.i386.rpm
> > , which seems to be the latest on the SGI FTP server.
> >
> > What are the recommended toolchain ?
>
> Don't use these for building userspace apps.

I'm only building the kernel with these.
What are you using for building the kernel ?

>
>   Ralf

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
