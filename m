Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Mar 2008 17:03:33 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:55465 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S28602383AbYCERDb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Mar 2008 17:03:31 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 207183153C9;
	Wed,  5 Mar 2008 17:03:30 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed,  5 Mar 2008 17:03:29 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 5 Mar 2008 09:03:15 -0800
Message-ID: <47CED252.20800@avtrex.com>
Date:	Wed, 05 Mar 2008 09:03:14 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	Andi <opencode@gmx.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Problems booting Linux kernel on Sigma SMP8634 #2
References: <47CE9388.9050808@gmx.net>
In-Reply-To: <47CE9388.9050808@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2008 17:03:15.0676 (UTC) FILETIME=[CD9371C0:01C87EE2]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Andi wrote:
> Hey folks,
> 
> first of all, sorry for _waisting_ the list with that topic again and again!
> 
> this question is related to that one here, posted sooner on this list:
> http://www.linux-mips.org/archives/linux-mips/2008-02/msg00032.html
> 
> I spent a bit more time on this topic and found out that there is
> seriously something going wrong with memory initialization and/or
> handling during Linux startup.
> 
> I simply add "mem=32m" to the kernel command line, and the kernel runs
> longer, at least a bit. However, it than stops with nearly the same
> issue: Unable to handle kernel paging request at virtual address, but
> different addresses. Tried "16m, 64m" and other values, all behave in
> different way. Resulting to a crash at the position w/o any parameter or
>  a bit later on.
> 
> Since I am not so familiar MIPS and especially the fact that our hard-
> and software is more than closed, I am asking you guys to point me where
> to spend more time on in order to get this issue fixed and fire up a
> kernel on this box.

I build and successfully run kernels on the 8634 every day, so I don't 
think it is a problem with the 8634 port in general.

You should probably ask for technical support from whomever supplied 
your hardware.  They would know the technical details about how to 
configure the memory controller, the amount and location of the RAM on 
the board, etc.

> 
> I am sure there some more guys around using the smp8634.

Likely there are.  It is used in many blu-ray disk players, among other 
things.

> Is it necessary
> to load the microcode in order to get the kernel starting up?

No.


> Maybe we don't need the audio/video-ucode but irq-handler-ucode looks
> very usefull ;-) Do we just have to copy this code at a certain memory
> address?

N/A, the kernel does not rely on any microcode.

The drivers for the audio/video handling hardware on the 8634 do require 
  microcode, but in many cases it is loaded after the kernel is running. 
  But the microcode is not needed for just running a bare bones kernel.

David Daney
