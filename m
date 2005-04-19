Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Apr 2005 16:52:30 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:60400 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8226197AbVDSPwP>; Tue, 19 Apr 2005 16:52:15 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Tue, 19 Apr 2005 11:47:30 -0400
Message-ID: <4265292D.5040704@timesys.com>
Date:	Tue, 19 Apr 2005 11:52:13 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	linux-mips@linux-mips.org
Subject: Re: sysv ipc msg functions
References: <426518D0.5080506@timesys.com> <20050419150549.GA29564@nevyn.them.org>
In-Reply-To: <20050419150549.GA29564@nevyn.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Apr 2005 15:47:30.0109 (UTC) FILETIME=[180DB6D0:01C544F7]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7766
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:

>On Tue, Apr 19, 2005 at 10:42:24AM -0400, Greg Weeks wrote:
>  
>
>>I needed this glibc patch to get the sysv ipc msgctl functions to work 
>>correctly. This looks a bit hackish to me, so I wanted to run it past 
>>everybody here before filing it with glibc.
>>    
>>
>
>What's your configuration?  Big or little endian, userland ABI, kernel
>ABI.  Glibc version.  Kernel version.  What specific things don't work. 
>Not even enough information here to make a guess.
>
>You're updating the userspace msqid_ds to match the kernel's
>msqid64_ds.  They're not normally the same type.  Rather, see
><linux/msg.h> for the type o32 generally uses.
>
>  
>

glibc-2.3.3-200407050320
2.6.11.7 kernel but it's the issue is the same on the 2.6.12-rc from cvs.
The board is a malta 4kc in LE mode.
If you want to see a failure the LTP msgctl/msgsnd tests fail.

Greg Weeks
