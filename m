Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 16:26:33 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:21515
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133556AbVJGP0L (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 16:26:11 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 7 Oct 2005 08:26:09 -0700
Message-ID: <43469391.3050307@avtrex.com>
Date:	Fri, 07 Oct 2005 08:26:09 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	"Gleb O. Raiko" <raiko@niisi.msk.ru>
CC:	linux-mips@linux-mips.org
Subject: Re: Bug in the syscall tracing code
References: <43455D2D.1010901@niisi.msk.ru> <20051006205308.GB31717@hattusa.textio> <43459374.5080802@avtrex.com> <434628D3.9050307@niisi.msk.ru>
In-Reply-To: <434628D3.9050307@niisi.msk.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2005 15:26:09.0505 (UTC) FILETIME=[71644D10:01C5CB53]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9183
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Gleb O. Raiko wrote:
> David Daney wrote:
> 
>> That is the conclusion I came to in:
>>
>> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=4207C3E0.7070405%40avtrex.com 
> 
> 
> 
> Saving in the PT_SCRATCH area (pad0 in C) was a solution for 2.4. 
> Unfortunately, syscall arguments are stored there (and that's why pad0 
> exists in pt_regs after all). So, using PT_SCRATCH as a temporary 
> storage for t2 will break tracing syscalls with more than 4 args for o32 
> ABI.

I know.  I meant for you to look at the very end of the message (The 
part where I said to store it in the slots for k0 or k1).

David Daney.
