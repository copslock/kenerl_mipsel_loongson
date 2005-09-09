Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Sep 2005 08:21:19 +0100 (BST)
Received: from outmx015.isp.belgacom.be ([IPv6:::ffff:195.238.2.87]:37550 "EHLO
	outmx015.isp.belgacom.be") by linux-mips.org with ESMTP
	id <S8224987AbVIIHUy>; Fri, 9 Sep 2005 08:20:54 +0100
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
        by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id j897RuM7010943
        for <linux-mips@linux-mips.org>; Fri, 9 Sep 2005 09:27:56 +0200
        (envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (21-156.245.81.adsl.skynet.be [81.245.156.21])
        by outmx015.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with ESMTP id j897Rlgm010843;
	Fri, 9 Sep 2005 09:27:47 +0200
        (envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.245] (246tNt-laptop.lan.ayanami.246tNt.com [10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id 9B32510E7BD;
	Fri,  9 Sep 2005 09:27:30 +0200 (CEST)
Message-ID: <432139F4.6040302@246tNt.com>
Date:	Fri, 09 Sep 2005 09:29:56 +0200
From:	Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050610)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	ML Linux USB Devel <linux-usb-devel@lists.sourceforge.net>,
	ML Linux MIPS <linux-mips@linux-mips.org>
Subject: Alchemy Au1100 USB Problem
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <tnt@246tNt.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tnt@246tNt.com
Precedence: bulk
X-list: linux-mips

Hello,


I'm working a a Au1100 System composed of a Cogent CSB650
(http://www.cogcomp.com/csb_csb650.htm) mounted on a custom base board.

This uses a Au1100 to offer two USB host port, one being directly
connected to a on-board smart card controller and the other to a USB
connector so user can plug-in stuff.


Now, I'm running a 2.6 linux-mips.org kernel of a few weeks ago and
using the big-endian mode of the CPU. My problem is with the USB host
controller.

At different times I get URB with condition cone 5 (TIMEOUT) so that
reports error -115 (ETIMEDOUT) to the driver. At first, even at boot the
peripheral plugged in wouldn't be detected at all, but then setting the
Au1100 frequency to 384Mhz (instead of 396Mhz) seemed to help, I haven't
see that issue recently. But when using a usb stick, transfering small
files works at first, but when trying to transfer more data, then it
makes that same -145 error.


Here is an example of what it does :

[4294872.583000] drivers/usb/host/ohci-dbg.c: SUB 811a4080 dev=3
ep=2in-bulk flags=15 len=0/40960 stat=-150

[4294872.597000] au1xxx-ohci au1xxx-ohci.0: urb 811a4080 path 1 ep2in
5ed20000 cc 5 --> status -145

[4294872.597000] au1xxx-ohci au1xxx-ohci.0: urb 811a4080 td a1185140 (3)
cc 5, len=12032/40960

[4294872.597000] drivers/usb/host/ohci-dbg.c: RET 811a4080 dev=3
ep=2in-bulk flags=15 len=12032/40960 stat=-145

[4294872.669000] au1xxx-ohci au1xxx-ohci.0: GetStatus roothub.portstatus
[0] = 0x00120103 PRSC PESC PPS PES CCS

[4294872.680000] usb 1-1: reset full speed USB device using au1xxx-ohci
and address 3


Does some one has anyide how I could : workaround, solve, debug, ...
that problem ?



Thanks,

	Sylvain Munaut
