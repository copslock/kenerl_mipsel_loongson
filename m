Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9P8Tlv27207
	for linux-mips-outgoing; Thu, 25 Oct 2001 01:29:47 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9P8TgD27202
	for <linux-mips@oss.sgi.com>; Thu, 25 Oct 2001 01:29:42 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA22794;
	Thu, 25 Oct 2001 01:28:20 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id BAA03252;
	Thu, 25 Oct 2001 01:28:18 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f9P8SIa29367;
	Thu, 25 Oct 2001 10:28:19 +0200 (MEST)
Message-ID: <3BD7CD22.A9FEBC3@mips.com>
Date: Thu, 25 Oct 2001 10:28:18 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "H . J . Lu" <hjl@lucon.org>
CC: linux-mips@oss.sgi.com
Subject: Re: I am looking for a mips machine
References: <20011024080356.A2440@lucon.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I promised you a Malta some time ago, but we have been short on the
boards.
We should get some in the very near future, so I hope to be able to send
you a board.
You can run the board in both endianness.
I can probably not give you a very fast system at the moment, but
hopefully when we have some faster CPUs, I can ship a faster daughter
card.

/Carsten

"H . J . Lu" wrote:

> Hi,
>
> I am looking for a mips machine to continue working on my mips port
> of RedHat. My requirements are
>
> 1. It has the stable, up to date kernel support. That means I can do
>
> # ./configure
> # make bootstrap
> # make check
>
> for gcc 3.1 without a kernel oops.
>
> 2. It has decent CPU. I hate to wait a day for
>
> # make bootstrap
>
> 3. Inexpensive.
>
> 4. Support serial console.
>
> 5. Little endian is preferred.
>
> Does anyone have any recommendations?
>
> Thanks.
>
> H.J.

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
