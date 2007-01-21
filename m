Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Jan 2007 21:33:00 +0000 (GMT)
Received: from tmailer.gwdg.de ([134.76.10.23]:35019 "EHLO tmailer.gwdg.de")
	by ftp.linux-mips.org with ESMTP id S20046926AbXAUVcy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 21 Jan 2007 21:32:54 +0000
Received: from linux01.gwdg.de ([134.76.13.21])
	by mailer.gwdg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <jengelh@linux01.gwdg.de>)
	id 1H8kJ4-0005T7-Ce; Sun, 21 Jan 2007 22:32:54 +0100
Received: from linux01.gwdg.de (localhost [127.0.0.1])
	by linux01.gwdg.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id l0LLVPGR029370;
	Sun, 21 Jan 2007 22:31:27 +0100
Received: from localhost (jengelh@localhost)
	by linux01.gwdg.de (8.13.3/8.13.3/Submit) with ESMTP id l0LLVPDA029364;
	Sun, 21 Jan 2007 22:31:25 +0100
Date:	Sun, 21 Jan 2007 22:31:25 +0100 (MET)
From:	Jan Engelhardt <jengelh@linux01.gwdg.de>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	sathesh babu <sathesh_edara2003@yahoo.co.in>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Running Linux on FPGA
In-Reply-To: <20070121001457.GA9123@linux-mips.org>
Message-ID: <Pine.LNX.4.61.0701212228340.29213@yvahk01.tjqt.qr>
References: <20070120234237.49126.qmail@web7912.mail.in.yahoo.com>
 <20070121001457.GA9123@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: (clean) by exiscan+sophie
Return-Path: <jengelh@linux01.gwdg.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jengelh@linux01.gwdg.de
Precedence: bulk
X-list: linux-mips


On Jan 21 2007 00:14, Ralf Baechle wrote:
>On Sat, Jan 20, 2007 at 11:42:37PM +0000, sathesh babu wrote:
>
>>   I am trying to run Linux-2.6.18.2 ( with preemption enable)
>>   kernel on FPGA board which has MIPS24KE processor runs at 12
>>   MHZ. Programmed the timer to give interrupt at every 10msec. I
>>   am seeing some inconsistence behavior during boot up processor.
>>   Some times it stops after "NET: Registered protocol family 17"
>>   and "VFS: Mounted root (jffs2 filesystem).". Could some give
>>   some pointers why the behavior is random. Is it OK to program
>>   the timer to 10 msec? or should it be more.
>
>The overhead of timer interrupts at this low clockrate is
>significant so I recommend to minimize the timer interrupt rate as
>far as possible. This is really a tradeoff between latency and
>overhead and matters much less on hardcores which run at hundreds of
>MHz.

Hm I've been running 2.6.13 on a 10/20 MHz (switchable) i386 @ 100 Hz
before without any hangs during boot or operation.


	-`J'
-- 
