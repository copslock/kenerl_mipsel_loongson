Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 19:19:11 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:64250 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225314AbUCPTTK>;
	Tue, 16 Mar 2004 19:19:10 +0000
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id LAA32254;
	Tue, 16 Mar 2004 11:19:05 -0800
Subject: Re: 2.6 Support for MyCable XXS1500 board?
From: Pete Popov <ppopov@mvista.com>
To: Marcel Beltz <marcel@beltz.info>
Cc: Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <3E72150D-775C-11D8-952A-000A95AA826A@beltz.info>
References: <3E72150D-775C-11D8-952A-000A95AA826A@beltz.info>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1079464816.10414.28.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Mar 2004 11:20:17 -0800
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4553
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, 2004-03-16 at 07:11, Marcel Beltz wrote:
> hello,
> 
> i am a newbie on this list. i want to run a 2.6 kernel on a xxs1500 
> board. is there a working configuration? i run successfully a 2.4.21 
> kernel and i don't know how to convert the .config file.

The board has been updated but not tested. Right now I have the Db1500
and Pb1500 booting, but not all drivers are up to date yet. I recently
updated the pcmcia driver but haven't updated all the board files. The
XXS1500 might not boot without some minor work, but it should be pretty
trivial to get it running. There is an alpha 36 bit address support
patch in ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.6 that you
must apply. The PCI bus on the 1500 and the pcmcia driver worked fine
with it. If you're looking for production quality kernel, the 2.6 Au1x
is not there yet. 

Pete
