Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Feb 2004 17:37:20 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:44532 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225237AbUBQRhT>;
	Tue, 17 Feb 2004 17:37:19 +0000
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i1HHbHtS015311;
	Tue, 17 Feb 2004 09:37:17 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i1HHbHjI015309;
	Tue, 17 Feb 2004 09:37:17 -0800
Date: Tue, 17 Feb 2004 09:37:17 -0800
From: Jun Sun <jsun@mvista.com>
To: Nilanjan Roychowdhury <nilanjan@genesis-microchip.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: Linux booting on malta board
Message-ID: <20040217173717.GA15296@mvista.com>
References: <9A45247F1AEBB94189B16E7083981F930588A9@INDIAEXCH.gmi.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9A45247F1AEBB94189B16E7083981F930588A9@INDIAEXCH.gmi.domain>
User-Agent: Mutt/1.4i
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4375
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Tue, Feb 17, 2004 at 08:26:21PM +0530, Nilanjan Roychowdhury wrote:
> 
> 
> 
> 
> I have a MIPS based malta board. For this board I also have two LINUX  images. One the non real time flavor obtained from MIPS technologies and other is a small footprint embedded image from monta vista.
> 
> I have first booted the board with the monitor program and then tried to download the linux images from my linux host using NFS + TFTP.
> Now I am able to load the images but when I say go in the monitor prompt...it shows me a message like "LINUX started" in my mincom screen @ host ;also the LED on the board shows "LINUX" but after that the board just hangs. ( it does not respond to any ping ).
> The same problem occurs with both the non real time as well as the image from monta vista.
> 
> 
> Have you ever faced any such issues??? Any first hand comments???

What is your cpu and the cpu daughter board?  What is the version of kernel?

It is possible they might mistmatch in your case. 

MontaVista's image was tested against 4kc and 5kc cpu boards.

Jun
