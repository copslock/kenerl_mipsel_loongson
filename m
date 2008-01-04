Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2008 01:28:10 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:47051 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20024116AbYADB2A (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Jan 2008 01:28:00 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 0799F311B0A;
	Fri,  4 Jan 2008 01:28:07 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Fri,  4 Jan 2008 01:28:06 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 3 Jan 2008 17:27:44 -0800
Message-ID: <477D8B90.9020701@avtrex.com>
Date:	Thu, 03 Jan 2008 17:27:44 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	Anirban Sinha <ASinha@zeugmasystems.com>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: BUG: BUS error while returning from read() in /dev/oprofile/buffer
References: <DDFD17CC94A9BD49A82147DDF7D545C56440FC@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C56440FC@exchange.ZeugmaSystems.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Jan 2008 01:27:44.0793 (UTC) FILETIME=[01C3A890:01C84E71]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Anirban Sinha wrote:
> Hi:
> 
>  
> 
> I have been trying to hunt down this bug for several days now. What 
> mainly happens is that when oprofiled wakes up from read() in 
> /dev/oprofile/buffer on receiving a signal USR1 (i.e, when someone does 
> opcontrol –start after doing opcontrol—start-daemon), it somehow gets 
> SIGBUS within glibc read().  We are using a mips machine with Sybyte SB1 
> processor. On intel, this error does not show up. Interestingly, when I 
> tried running a small test program that simply reads 
> /dev/oprofile/buffer, the error can’t be reproduced!
> 
>  
> 
> Ralf and others, any insights, suggestions or useful comments from 
> experience will be really really appreciated. I am spending a lot of 
> time trying to fix this bug.
> 

Likely you did a cross build of bash and your signal numbers are incorrect.

On the system where you built bash, SIGUSR1 is 10.

On the mips-linux target signal 10 is SIGBUS so when the bash kill 
builtin thinks it is sending SIGUSR1 it is really sending SIGBUS.

David Daney
