Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7A0mbw25752
	for linux-mips-outgoing; Thu, 9 Aug 2001 17:48:37 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7A0mZV25749
	for <linux-mips@oss.sgi.com>; Thu, 9 Aug 2001 17:48:35 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id CAA203706
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 02:48:34 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15V0TZ-00035d-00
	for <linux-mips@oss.sgi.com>; Fri, 10 Aug 2001 02:48:33 +0200
Date: Fri, 10 Aug 2001 02:48:33 +0200
To: linux-mips@oss.sgi.com
Subject: Re: R10K I2 Solid Impact
Message-ID: <20010810024833.A385@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108100018.RAA29996@saturn.mikemac.com>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Mike McDonald wrote:
> 
>   I just got a R10K I2 Solid Impact that I'm going to attempt to play
> with linux on.

At least my I2 R10K's Firmware doesn't boot anything else than
ELF64 Kernels loaded at 0x8000000020002000. I'm currently developing
a mips64-linux in 64bit address space due to this. I'd like to know
how your machine behaves WRT this.

> But first I need to find some more basic info. Does
> anyone know where the connectors are documented? In particular, the
> video connectors on the Solid Impact.

What I've figured out via google is this pinout:

13W3-SGI | DB15-VGA | 13W3-SUN
------------------------------
A1      ---    1   ---  A1
A1-GND  ---    6   ---  A1-GND
A2      ---    2   ---  A2
A2-GND  ---    7   ---  A2-GND
A3      ---    3   ---  A3
A3-GND  ---    8   ---  A3-GND
3-CSYNC ---        ---  5
4-HSYNC ---   13   --- 
5-VSYNC ---   14   --- 
        ---   10   --- 10

The Impact normally uses HSYNC/VSYNC but can be set to CSYNC mode.

> The SGI search engine just tells
> be they don't refurbish Indigos anymore. The serial port pinouts would
> be useful too. (Wasn't it 'man serial' once I get it running?)

The pinout for a cross cable can be found in the I2 Howto.


Thiemo
