Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Aug 2005 20:35:24 +0100 (BST)
Received: from outmx002.isp.belgacom.be ([IPv6:::ffff:195.238.3.52]:20176 "EHLO
	outmx002.isp.belgacom.be") by linux-mips.org with ESMTP
	id <S8225281AbVHETfG>; Fri, 5 Aug 2005 20:35:06 +0100
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
        by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id j75JcdFr020253
        for <linux-mips@linux-mips.org>; Fri, 5 Aug 2005 21:38:39 +0200
        (envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (64-90.244.81.adsl.skynet.be [81.244.90.64])
        by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id j75JcaZr020244
        for <linux-mips@linux-mips.org>; Fri, 5 Aug 2005 21:38:37 +0200
        (envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.245] (246tNt-laptop.lan.ayanami.246tNt.com [10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id 793EE1CAC0D
	for <linux-mips@linux-mips.org>; Fri,  5 Aug 2005 21:38:29 +0200 (CEST)
Message-ID: <42F3C05E.7060002@246tNt.com>
Date:	Fri, 05 Aug 2005 21:39:10 +0200
From:	Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050610)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: AMD Au1100 problems (USB & Ethernet)
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tnt@246tNt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8697
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tnt@246tNt.com
Precedence: bulk
X-list: linux-mips

Hello,

I've been trying to adapt linux ( the HEAD CVS version ) to a
custom board based around a Au1100. To be more precise, the board
use a "cpu module" (CSB650 from Cogent
http://www.cogcomp.com/csb_csb650.htm ) that's placed on a custom PCB.


I've compiled and booted a kernel sucessfully, I see the message on the
serial console. It's in Big Endian mode since the boot loaded on the
card is big endian only and I could manage to get it to switch to little
endian ...

Now, let's go on with the problems :

 * About USB. First time I tried, it just hung but I quicly found out
that it was because I didn't route the 48Mhz clock to USB module. After
that, I had to slightly adapt the ohci bus glue to enable the OHCI big
endian mode. After that, when a USB stick is inserted, it gets detected,
I can mount it and read small files. But when I try to read bigger files
( just 1 or 2 MB ), I get stuff like :

[4294743.146000] usb 1-1: reset full speed USB device using au1xxx-ohci
and address 2

[4294743.618000] usb 1-1: reset full speed USB device using au1xxx-ohci
and address 2

[4294743.891000] usb 1-1: reset full speed USB device using au1xxx-ohci
and address 2

[4294744.151000] usb 1-1: reset full speed USB device using au1xxx-ohci
and address 2

[4294744.328000] au1xxx-ohci au1xxx-ohci.0: bad entry       4b


[4294744.346000] au1xxx-ohci au1xxx-ohci.0: bad entry ac450000


[4294744.363000] au1xxx-ohci au1xxx-ohci.0: bad entry 8f820014


[4294744.381000] au1xxx-ohci au1xxx-ohci.0: bad entry 38210001


[4294744.495000] hub 1-0:1.0: port 1 disabled by hub (EMI?),
re-enabling...

[4294744.515000] usb 1-1: USB disconnect, address 2


[4294745.532000] au1xxx-ohci au1xxx-ohci.0: IRQ INTR_SF lossage


[4294745.532000] usb 1-1: sg_complete, unlink --> -19


[4294745.532000] usb 1-1: sg_complete, unlink --> -19




Which means absolutly nothing to me ;( Has anyone got a clue ?
I can't say for sure it's not hardware but the cpu module is used by
others and on the base board, it's just a couple of differential pair
with 90ohm differential impedance, nothing more ...


 * About ethernet : It works, I have a network access. However I have
two kind of errors. On the RX side, I get quite a lot of "rx miss"
errors (when au1x00_eth debug is on). About 5% of packets are dropped.
That's not _too_ much of a problem as log as it doesn't increase. But
what can that be due too ?

A more annoying problem is that I get a lot of :
[  506.397000] NETDEV WATCHDOG: eth0: transmit timed out


[  506.412000] eth0: au1000_tx_timeout: dev=8048b400

theses are quite comment when  I transmitt a lot
                         and they completly ruin the transmission
(_real_ slow !).

Heres is some stats from ifconfig :

          RX packets:50496 errors:76 dropped:76 overruns:0 frame:0


          TX packets:49573 errors:47 dropped:0 overruns:0 carrier:74





Any insight / suggestion is appreciated, I'm getting desperate ;)


	Sylvain
