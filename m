Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 20:08:35 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:21376 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225305AbVDGTIU>; Thu, 7 Apr 2005 20:08:20 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Apr 2005 15:04:08 -0400
Message-ID: <42558523.30404@timesys.com>
Date:	Thu, 07 Apr 2005 15:08:19 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Brian Kuschak <bkuschak@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: gdb backtrace with core files
References: <20050407190327.21692.qmail@web40905.mail.yahoo.com>
In-Reply-To: <20050407190327.21692.qmail@web40905.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2005 19:04:08.0953 (UTC) FILETIME=[93C16E90:01C53BA4]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Brian Kuschak wrote:

>Greg,
>
>Is your GDB hosted on MIPS or another machine?  Are
>those patches freely available?  If so, can you
>provide a link?  Google seems to find mostly kgdb
>patches - are these what you used?
>
>  
>
I have an i386 hosted gdb and a mips native gdb. The backtrace test I 
did was for the native gdb.

I'm not sure which patches are available. I'll check. I'm in the process 
of working up our first BSP with this toolchain.

Greg Weeks
