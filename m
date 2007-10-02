Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Oct 2007 10:33:22 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:19099 "EHLO ict.ac.cn")
	by ftp.linux-mips.org with ESMTP id S20023756AbXJBJdO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 2 Oct 2007 10:33:14 +0100
Received: (qmail 20744 invoked by uid 507); 2 Oct 2007 17:31:33 +0800
Received: from unknown (HELO ?192.168.1.8?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 2 Oct 2007 17:31:33 +0800
Message-ID: <470210B4.8020902@ict.ac.cn>
Date:	Tue, 02 Oct 2007 17:34:44 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: IceDove 1.5.0.10 (X11/20070329)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: cmpxchg broken in some situation
References: <46FF7BC2.5050905@ict.ac.cn> <20071001025340.GA7091@linux-mips.org> <47010E15.7060109@ict.ac.cn> <20071001152620.GB15820@linux-mips.org>
In-Reply-To: <20071001152620.GB15820@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

The problem is here:

switch (sizeof(__ptr)) { // --> should be sizeof(*(__ptr))
case 4:
...
Recompiling..

Ralf Baechle 写道:
> On Mon, Oct 01, 2007 at 11:11:17PM +0800, Fuxin Zhang wrote:
>
>   
>> Sorry that it seems not work:
>> the kernel oops at sysfs_open_file->sysfs_get_active with unaligned 
>> access(last seen exception on screen, no serial console by hand so it 
>> may not be the first exception). It is probably caused by 
>> "atomic_cmpxchg" there.
>> And keep the old kernel using new modules with patched cmpxchg also lead 
>> to glxgears die(should be lock problem like before).
>>     
>
> Can you look at the disassembly of the generated code?  It should hopefully
> be relativly obvious in the disassembly.
>
>   Ralf
>
>
>
>   
