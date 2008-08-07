Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Aug 2008 14:35:16 +0100 (BST)
Received: from xen.sig21.net ([88.198.19.73]:9410 "EHLO bar.sig21.net")
	by ftp.linux-mips.org with ESMTP id S20021608AbYHGNfJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 7 Aug 2008 14:35:09 +0100
Received: from [88.198.146.81] (helo=void.local)
	by bar.sig21.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <js@sig21.net>)
	id 1KR5dq-00064p-Qk
	for linux-mips@linux-mips.org; Thu, 07 Aug 2008 15:35:05 +0200
Received: from js by void.local with local (Exim 4.69)
	(envelope-from <js@sig21.net>)
	id 1KR5dq-0004MK-21
	for linux-mips@linux-mips.org; Thu, 07 Aug 2008 15:34:58 +0200
Date:	Thu, 7 Aug 2008 15:34:58 +0200
From:	Johannes Stezenbach <js@linuxtv.org>
To:	linux-mips@linux-mips.org
Subject: Re: Debugging MIPS cpu with a probe, how?
Message-ID: <20080807133458.GA16456@linuxtv.org>
References: <18830812.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18830812.post@talk.nabble.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <js@sig21.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20150
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@linuxtv.org
Precedence: bulk
X-list: linux-mips

On Tue, Aug 05, 2008, TriKri wrote:
> 
> I have an embedded system, a box, with a MIPS processor on it, which I need
> to debug (stop and start the processor, tell what instructions it has
> previously executed, etc.). I also have an EJTAG probe, which I have
> connected between the computer's usb and the box, and written software for
> it. The software can communicate with the probe, which in its own turn can
> communicate with the box through the tap (test access port), by giving the
> tap certain instructions. It can also, through the tap, feed the MIPS
> processor with instructions, and read/write data from processor registers.
> 
> The question is now, how can debug the processor? How do I stop it, do I
> have to send any certain instructions to it? How can I set a breakpoint
> (which I understand is a quite crucial point)? Can I use GDB with my
> software to help debug the processor and how do I do that?

I looked for Open Source EJTAG software a while ago and found
two projects which may be of interest to you:

http://svn.berlios.de/svnroot/repos/openocd/branches/mips/
http://www.totalembedded.com/open_source/jtag/mips32_ejtag/

But I didn't try to use any of it so far.


Johannes
