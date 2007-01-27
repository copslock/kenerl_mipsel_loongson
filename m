Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Jan 2007 22:31:09 +0000 (GMT)
Received: from mx5.wp.pl ([212.77.101.9]:8835 "EHLO mx1.wp.pl")
	by ftp.linux-mips.org with ESMTP id S20037670AbXA0WbE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 27 Jan 2007 22:31:04 +0000
Received: (wp-smtpd smtp.wp.pl 4724 invoked from network); 27 Jan 2007 23:30:00 +0100
Received: from apn-237-18.gprsbal.plusgsm.pl (HELO [87.251.237.18]) (laurentp@[87.251.237.18])
          (envelope-sender <laurentp@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with AES256-SHA encrypted SMTP
          for <florian.fainelli@int-evry.fr>; 27 Jan 2007 23:30:00 +0100
Message-ID: <45BBD308.4060207@wp.pl>
Date:	Sat, 27 Jan 2007 23:32:40 +0100
From:	"W.P." <laurentp@wp.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050920
X-Accept-Language: pl, en, en-us
MIME-Version: 1.0
To:	Florian Fainelli <florian.fainelli@int-evry.fr>,
	linux-mips@linux-mips.org
Subject: Re: RTL-8186 follow-up
References: <5C1FD43E5F1B824E83985A74F396286E041B10FB@bby1exm08.pmc_nt.nt.pmc-sierra.bc.ca> <200701271354.41905.florian.fainelli@int-evry.fr> <45BB8C5D.50405@wp.pl> <200701272238.08482.florian.fainelli@int-evry.fr>
In-Reply-To: <200701272238.08482.florian.fainelli@int-evry.fr>
Content-Type: multipart/mixed;
 boundary="------------040507080700060002020505"
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO 0000000                                      
Return-Path: <laurentp@wp.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurentp@wp.pl
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040507080700060002020505
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

<cut>

>There might be version mismatch, or other modules to load before this one. 
>This can also be a kernel configuration problem, related to modules that are 
>expected to be in-kernel.
>
>  
>
You gave me an idea: i think it's related to fact, that those modules
expect to be linked into kernel (they complain about basic kernel
symbols too). But how to make sure?? - not risking to render board unusable?
If you find a method (maybe trying to link a non network-critical module
into kernel, like ipsec), please provide step-by-step instructions to me.


<cut>
>>Well, unless you have erased the booloader, I think you should still
be able
>>to reflash the device using bootloader commands, even via xmodem if
the loader allows it.

You THINK or you KNOW? (in case of 8186!)

>>I think you should have a look at this page [1], where there are
ressources to create custom rtl8181 firmwares.

I will, but on my board there is 8186, not 8181. And very beginning of
bootstrap, in bootloader i can see no option of TFTP (see atached file).

W.P.

--------------040507080700060002020505
Content-Type: text/plain;
 name="bootloader.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bootloader.txt"


UART1 output test ok
Uart init
mfid=000000c2 devid=00002249
Found 1 x 2M flash memory

---RealTek(RTL8186)at 2005.06.06-11:22+0800 version 1.3c [32bit](180MHz)

---Escape booting by user
<RealTek>help
----------------- COMMAND MODE HELP ------------------
HELP (?)				    : Print this help message
D <Address> <Len>
EW <Address> <Value1> <Value2>...
EH <Address> <Value1> <Value2>...
EB <Address> <Value1> <Value2>...
EC <Address> <Value1> <Length>...
CMP: CMP <dst><src><length>
IPCONFIG:<TargetAddress>
J: Jump to <TargetAddress>
FLW: FLW <dst><src><length>
FLR: FLR <dst><src><length>
LOADADDR: <Load Address>
AUTOBURN: 0/1
<RealTek>
--------------040507080700060002020505--
