Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2003 14:28:56 +0000 (GMT)
Received: from bay7-f37.bay7.hotmail.com ([IPv6:::ffff:64.4.11.37]:39689 "EHLO
	hotmail.com") by linux-mips.org with ESMTP id <S8225205AbTLRO2r>;
	Thu, 18 Dec 2003 14:28:47 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Thu, 18 Dec 2003 06:28:37 -0800
Received: from 203.196.146.243 by by7fd.bay7.hotmail.msn.com with HTTP;
	Thu, 18 Dec 2003 14:28:36 GMT
X-Originating-IP: [203.196.146.243]
X-Originating-Email: [samavarthy@hotmail.com]
X-Sender: samavarthy@hotmail.com
From: "samavarthy c" <samavarthy@hotmail.com>
To: linux-mips@linux-mips.org
Subject: USB on MIPS
Date: Thu, 18 Dec 2003 19:58:36 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY7-F37p6I65awhyxk00043bd8@hotmail.com>
X-OriginalArrivalTime: 18 Dec 2003 14:28:37.0071 (UTC) FILETIME=[395B6DF0:01C3C573]
Return-Path: <samavarthy@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3791
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: samavarthy@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am working on a PDA based board which has a NEC MIPS VR4131
processor.
The board has a companion chip MediaQ 1132 which has OHCI support
builtin.
The kernel used is MontaVista HardHat 2.4.18. I am trying to configure
MQ1132 for USB Host support. It looks like the Host controller
(MQ1132) is initialized properly but not sure. When I plug in a USB
stick on to the USB port, I get the following messages.
-----------------------------------------------------------------
hub.c: USB new device connect on bus1/1, assigned device number 2
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-145)

hub.c: USB new device connect on bus1/1, assigned device number 3
usb_control/bulk_msg: timeout
usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=3 (error=-145)
-------------------------------------------------------------------
Has anyone experienced the same out there. Could any one suggest how
to debug this error. What could be the problem?.

Thanks in advance.

Regards,
aks

_________________________________________________________________
Add glamour to your desktop. Let your screen sizzle. 
http://server1.msn.co.in/msnchannels/Entertainment/wallpaperhome.asp 
Download the hottest wallpapers.
