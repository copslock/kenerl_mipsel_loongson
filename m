Received:  by oss.sgi.com id <S553761AbQLNVCW>;
	Thu, 14 Dec 2000 13:02:22 -0800
Received: from wn42-146.sdc.org ([209.155.42.146]:65263 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S553759AbQLNVB6>;
	Thu, 14 Dec 2000 13:01:58 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S868680AbQLNU7d>;
	Thu, 14 Dec 2000 13:59:33 -0700
Date:	Thu, 14 Dec 2000 21:59:33 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Carsten Langgaard <carstenl@mips.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: 64 bit build fails
Message-ID: <20001214215933.C28871@bacchus.dhis.org>
References: <3A379CBC.ED1D9F@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A379CBC.ED1D9F@mips.com>; from carstenl@mips.com on Wed, Dec 13, 2000 at 04:58:52PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Dec 13, 2000 at 04:58:52PM +0100, Carsten Langgaard wrote:

> I'm trying to build a 64bit kernel, but it fails with following message:
> 
> mips64-linux-gcc -D__KERNEL__
> -I/home/soc/proj/work/carstenl/sw/linux-2.4.0/include -Wall
> -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
> -mabi=64 -G 0 -mno-abicalls -fno-pic -Wa,--trap -pipe -mcpu=r8000 -mips4
> -Wa,-32   -c head.S -o head.o
> head.S: Assembler messages:
> head.S:69: Error: Missing ')' assumed

Looks like an attempt to build a 64-bit Indy kernel.  Various people working
on the Origin support have completly broken the support for anything else in
their battle tank-style approach ...

  Ralf
