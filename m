Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Oct 2009 16:50:02 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4830 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492756AbZJ1Pt4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 Oct 2009 16:49:56 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,5,4,7535)
	id <B4ae868140001>; Wed, 28 Oct 2009 08:49:40 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 28 Oct 2009 08:40:23 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 28 Oct 2009 08:40:23 -0700
Message-ID: <4AE865E5.2080008@caviumnetworks.com>
Date:	Wed, 28 Oct 2009 08:40:21 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	loody <miloody@gmail.com>
CC:	Mulyadi Santosa <mulyadi.santosa@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>,
	Kernel Newbies <kernelnewbies@nl.linux.org>
Subject: Re: kernel panic about kernel unaligned access
References: <3a665c760910270627u784d43b8t2978731110c920a4@mail.gmail.com>	 <f284c33d0910272056n4cd082et2ba1a4b5e228bb0e@mail.gmail.com> <3a665c760910272103gd4a6b78idb5e1175ba288b7e@mail.gmail.com>
In-Reply-To: <3a665c760910272103gd4a6b78idb5e1175ba288b7e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2009 15:40:23.0123 (UTC) FILETIME=[F6619230:01CA57E4]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

loody wrote:
> hi
> 
> 2009/10/28 Mulyadi Santosa <mulyadi.santosa@gmail.com>:
>> Hi...
>>
>> On Tue, Oct 27, 2009 at 8:27 PM, loody <miloody@gmail.com> wrote:
>>> Dear all:
>>> I use kernel 2.6.18 and I get the kernel panic as below:
>>> Unhandled kernel unaligned access[#1]:
>>> Cpu 0
>>> $ 0   : 00000000 11000001 0000040a 8721f0d8
>>> $ 4   : 874a6c00 80001d18 00000000 00000000
>>> $ 8   : 00000000 ffffa438 00000000 874c2000
>>> $12   : 00000000 00000000 00005800 00011000
>>> $16   : 80001d10 874a6c40 874a6c00 87d7bf00
>>> $20   : 874a6c78 871a0000 87370000 874a6c80
>>> $24   : 00000000 2aacc770
>>> $28   : 87d7a000 87d7be88 ffffa438 8709ed20
>>> Hi    : 00000000
>>> Lo    : 00000000
>>> epc   : 8709e72c sync_sb_inodes+0x9c/0x320     Not tainted
>>> ra    : 8709ed20 writeback_inodes+0xb4/0x160
>> Hmmm, your machine is not x86, is it? So, I guess this panic is caused
>> by unaligned memory access.
> Yes, my machine is mips machine.
> if do_ade in unaligned.c is a trap, where do  we register it?
> I grep the source code but I only find the definition but cannot get
> the place where we register the trap.


Look in genex.S for lines like:

	BUILD_HANDLER adel ade ade silent		/* #4  */
	BUILD_HANDLER ades ade ade silent		/* #5  */

And also in traps.c for lines like:

	set_except_vector(4, handle_adel);
	set_except_vector(5, handle_ades);


David Daney
