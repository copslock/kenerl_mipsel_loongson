Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6P7lQn03248
	for linux-mips-outgoing; Wed, 25 Jul 2001 00:47:26 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6P7lPO03245
	for <linux-mips@oss.sgi.com>; Wed, 25 Jul 2001 00:47:25 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA26805;
	Wed, 25 Jul 2001 00:45:39 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id AAA02627;
	Wed, 25 Jul 2001 00:45:40 -0700 (PDT)
Received: from mips.com (copsun17 [192.168.205.27])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f6P7iSa25576;
	Wed, 25 Jul 2001 09:44:29 +0200 (MEST)
Message-ID: <3B5E78DB.70F7D97F@mips.com>
Date: Wed, 25 Jul 2001 09:44:27 +0200
From: Carsten Langgaard <carstenl@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Thornton <andrew.thornton@insignia.com>
CC: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
   James Simmons <jsimmons@transvirtual.com>,
   Linux-MIPS <linux-mips@oss.sgi.com>
Subject: Re: ATI Victoria on Malta
References: <013f01c1145b$e41dc420$d11110ac@snow.isltd.insignia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Andrew Thornton wrote:

> Geert,
>
> >> I guess this is not surprising because the Malta firmware isn't a PC
> BIOS.
> >
> >If the RAGE XL is the officially supported video board for the Malta, I
> >wouldn't have been surprised if its firmware would have contained code to
> >initialize the RAGE XL. But unfortunately this doesn't seem to be the case.
>
> I don't know if YAMON supports anything other than a serial terminal for its
> console.

YAMON doesn't initialize the RAGE XL as it is a PCI plug-in card.
The video driver in the 'supported' OS initialize the card.

>
> >Next question: is there sample code available (e.g. with the `supported' OS
> for
> >the Malta) to initialize the RAGE XL?
>
> It has been pointed out to me that there is some source code, but this
> originates from a non-suitable source for use in Linux. Need I say more?

I'm afraid we can't provide you with the sources, you need to contact the
OS vendor yourself.

>
> Andrew Thornton

--
_    _ ____  ___   Carsten Langgaard   Mailto:carstenl@mips.com
|\  /|||___)(___   MIPS Denmark        Direct: +45 4486 5527
| \/ |||    ____)  Lautrupvang 4B      Switch: +45 4486 5555
  TECHNOLOGIES     2750 Ballerup       Fax...: +45 4486 5556
                   Denmark             http://www.mips.com
