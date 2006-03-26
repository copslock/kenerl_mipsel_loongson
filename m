Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Mar 2006 04:14:12 +0100 (BST)
Received: from firewall.dcbnet.com ([12.96.67.19]:51655 "EHLO
	firewall.dcbnet.com") by ftp.linux-mips.org with ESMTP
	id S8126484AbWCZDN7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Mar 2006 04:13:59 +0100
Received: from [205.166.54.127] (mschank1.dcbnet.com [205.166.54.127])
	by firewall.dcbnet.com (8.12.10/8.12.10) with ESMTP id k2Q3O4i4024501;
	Sat, 25 Mar 2006 21:24:05 -0600
Message-ID: <44260954.5010707@dcbnet.com>
Date:	Sat, 25 Mar 2006 21:24:04 -0600
From:	Mark Schank <mschank@dcbnet.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To:	Jon Anders Haugum <jonah@omegav.ntnu.no>
CC:	linux-mips@linux-mips.org
Subject: Re: Alchemy Au1550 Early Console
References: <5.1.0.14.2.20060322165104.02a32800@205.166.54.3> <20060324114653.S15728@invalid.ed.ntnu.no>
In-Reply-To: <20060324114653.S15728@invalid.ed.ntnu.no>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mschank@dcbnet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10940
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschank@dcbnet.com
Precedence: bulk
X-list: linux-mips

Hi Jon,

Thanks for the reply. I do have CONFIG_SERIAL_8250_CONSOLE enabled.
The console does work once the kernel boots and the driver init routines 
run.
However, if the kernel crashes before the driver init routines are run, 
then I wasn't
getting any output. The old au1x00_uart.c driver was able to support an 
early console,
console_init() in start_kernel(), on the Alchemy uart. However, after 
looking at the new
8250 driver more closely, I see that it can not support the Alchemy uart 
until after the
driver init routines are run.

I finally wrote a simple early console driver that relied on the boot 
monitor setting up
the uart. This enabled me to figure out why the kernel was crashing 
during boot.

Thanks again,
Mark

Jon Anders Haugum wrote:
> On Wed, 22 Mar 2006, Mark Schank wrote:
>
>> I am working with a Au1550 based system an am trying to upgrade
>> from the 2.6.12 kernel to the 2.6.16 kernel . I have noticed that the
>> au1x00_uart.c driver has been remove and replaced with functionality in
>> 8250.c and 8250_au1x00.c. So far, I have been unable to get the early
>> console running. Under this new driver model, what is the proper
>> way to bring up an early console on a Au1550 internal serial port?
>
> Have you enabled the console for 8250-based serial ports?
> (CONFIG_SERIAL_8250_CONSOLE)
>
> Another issue might be if you have got some PCI-based serial ports in 
> the system, because they will be assigned before the internal ones. So 
> you might end up having the console on a PCI serial port.
>
> Third: There is a bug in the new driver regarding divisor settings, 
> but the console should still be working since the boot loader will 
> init the uart properly. (I've posted a patch for this bug earlier: 
> http://www.linux-mips.org/archives/linux-mips/2006-03/msg00041.html).
>
>
> Jon
>
