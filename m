Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Oct 2009 21:05:44 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:53170 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493118AbZJ0UFi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Oct 2009 21:05:38 +0100
Received: by bwz21 with SMTP id 21so113071bwz.24
        for <linux-mips@linux-mips.org>; Tue, 27 Oct 2009 13:05:32 -0700 (PDT)
Received: by 10.103.76.37 with SMTP id d37mr6662671mul.99.1256673932019;
        Tue, 27 Oct 2009 13:05:32 -0700 (PDT)
Received: from ?192.168.168.171? ([123.121.192.119])
        by mx.google.com with ESMTPS id i5sm314912mue.38.2009.10.27.13.05.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Oct 2009 13:05:31 -0700 (PDT)
Message-ID: <4AE75283.4040404@qi-hardware.com>
Date:	Wed, 28 Oct 2009 04:05:23 +0800
From:	Xiangfu Liu <xiangfu@qi-hardware.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:	vinit dhatrak <vinit.dhatrak@gmail.com>
CC:	loody <miloody@gmail.com>, linux-mips <linux-mips@linux-mips.org>,
	Kernel Newbies <kernelnewbies@nl.linux.org>
Subject: Re: kernel panic about kernel unaligned access
References: <3a665c760910270627u784d43b8t2978731110c920a4@mail.gmail.com> <edf0f34e0910271003k66440e9did790c07a0a79919b@mail.gmail.com>
In-Reply-To: <edf0f34e0910271003k66440e9did790c07a0a79919b@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <xiangfu@qi-hardware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xiangfu@qi-hardware.com
Precedence: bulk
X-list: linux-mips

vinit dhatrak wrote:
>> my questions are:
>> 1. what does "Not tainted" mean?
>> 2. I grep the kernel and I find the above message comes from do_ade in
>> unaligned.c, If I guess correctly.
>>    but from the call trace I cannot find out who call it.
>>    who and how kernel pass the information to do_ade?
>> 3. as far as i know, inode is the data structure we used to record file.
>> From what information in the inode I can find out the file name the
>> writeback_inodes try to write?
>> appreciate your help,
>> miloody
>>
> 
> I can answer your first question. Loading a proprietary or
> non-GPL-compatible module will 'taint' the running kernel—meaning that
> any problems or bugs experienced will be less likely to be
> investigated by the maintainers. See this "Tainted Kernel" document
> from Novell.
> http://www.novell.com/support/viewContent.do?externalId=3582750&sliceId=1
> 
> In your case, it seems that your kernel is not tainted by any external code.
> Also, what you see as call trace is actually just stack dump, not
> exactly a backtrace.

Hi I also got similar panic in my board (ben nanonote). the process is "Process ksoftirqd/0"
Q: how to get the backtrace? 
