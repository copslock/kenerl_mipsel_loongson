Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2004 09:37:14 +0100 (BST)
Received: from mail.oricom.de ([IPv6:::ffff:62.116.167.249]:43712 "EHLO
	oricom4.internetx.de") by linux-mips.org with ESMTP
	id <S8225385AbUGMIhK>; Tue, 13 Jul 2004 09:37:10 +0100
Received: from mycable.de (c192176.adsl.hansenet.de [213.39.192.176])
	(authenticated bits=0)
	by oricom4.internetx.de (8.13.0/8.13.0) with ESMTP id i6D8bNE2015286;
	Tue, 13 Jul 2004 10:37:27 +0200
Message-ID: <40F39F31.70102@mycable.de>
Date: Tue, 13 Jul 2004 10:37:05 +0200
From: Tiemo Krueger - mycable GmbH <tk@mycable.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6a) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: safiudeen Ts <safiudeen@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: Jtag spec. and the firmware for Au1100
References: <BAY15-F33CIq1eE3VsX00049230@hotmail.com>
In-Reply-To: <BAY15-F33CIq1eE3VsX00049230@hotmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tk@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5460
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tk@mycable.de
Precedence: bulk
X-list: linux-mips

Normally you could use a boatloader like Yamon or uboot to load something
from a tftp-server or serial conenction on the board. If there isn't any 
bootloader
on the board you have to flash one on your board. This should normally 
be provided
with the board (which one do you have?).

Ejtag: The pin specification for ejtag should be in the board 
documentation, normally
it's quite easy to build an adapter to connect it to ejtag hardware like 
the bdi2000 or similar.

firmware: So you mean a kernel and maybe a rootfile-system? Didn't came 
anything with the board?
Depending on the HW-components on the board you may require your own 
kernel which
you can build from the sources on Linux-mips.org, try at first a default 
configuration for the Au1100.

Tiemo

safiudeen Ts wrote:

> How can we copy the kernel image to target board (processor au1100  )?
> if we want to use JTAG where can I get the jatg schemetic detailes and 
> the firmware for Red Hat linux 9
> please any one can help me in this regards
>
> than you
> safi
>
> _________________________________________________________________
> Protect your PC - get McAfee.com VirusScan Online 
> http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
>
>
>
