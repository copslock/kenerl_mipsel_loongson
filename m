Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 May 2003 22:45:41 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:4013 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225237AbTE3Vpj>;
	Fri, 30 May 2003 22:45:39 +0100
Received: (qmail 30151 invoked by uid 6180); 30 May 2003 21:45:35 -0000
Date: Fri, 30 May 2003 14:45:35 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: n_gale@ok.ru
Cc: linux-mips@linux-mips.org
Subject: Re: DBAu1500 board flash downloading
Message-ID: <20030530144535.T29389@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <web-13584424@backend4.aha.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <web-13584424@backend4.aha.ru>; from n_gale@ok.ru on Sat, May 31, 2003 at 12:29:57AM +0400
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

Serguei:

Rather than building an EJTAG interface, I recommend the Raven EJTAG interface.
It plugs into your LPT port, and will plug into the EJTAG interface on your
DBAu1500 board.

The device is available through {http://www.macraigor.com}.

Linux software for this device is available at {http://www.ocdemon.com/}.

I assume that you will probably be trying to re-load YAMON onto the flash
device. I never tried re-loading YAMON, so I cannot comment about problems you
might have hear.


But here's the path that I essentially followed. I co-authored a bootloader
that can execute out of RAM, and wrote a driver for the AMD flash device.  My
bootloader uses a chunk of hacked-up YAMON code so that an SREC can be loaded
through serial, and I wrote a simple driver for AMD mirror-bit flash.

The trick was to set the CP0 configuration registers over GDB so that you can
load a bootloader into RAM, and then jump to the appropriate start address.

1. Plug in the RAVEN, turn it on.

2. Set the CP0 configuration registers through GDB so that RAM will refresh
   properly.

3. Load bootloader into uncached RAM through GDB and tell GDB to jump to
   the bootloader entry point.

4. Use the bootloader to erase flash.

5. The bootloader can also load an SREC through the serial port, and write it
   to flash. In your case, you would load YAMON.srec, and then write it to
   flash.

Good luck. Hopefully AMD support will be able to help you, too.

-Jeff



On Sat, May 31, 2003 at 12:29:57AM +0400, n_gale@ok.ru wrote:
> First Name: Serguei
> Last Name: Soloviev
> Email: n_gale@ok.ru
> Company: 
> Category: DBAu1500 board question
> 
> Dear sirs. Few days ago I started the work with DBAu1500 
> but unfortunatly among included software toolchain I 
> didn't find 
> any utility to download startup code into clean flash.
> 
> Does anybody have any flash programming utility wich 
> probably works via EJTAG to download code to DBAu-flash or 
> if I have absolutely clean or bad written flash due to 
> uncleanly interrupted programming process for example due 
> to power fail I need to insert it to the programmer to 
> download boot software? 
> I can not belive that there is no any simple utility 
> working via LPT-port to do this.
> Pls. help me find such utility and a primitive sheme with 
> one HC244 and few resistors how to solder an adapter from 
> LPT to JTAG.
> 
>   Thank u in advance.
> 
> ---
> Professional hosting for everyone - http://www.host.ru
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
