Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 12:25:45 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:62619 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225361AbVDHLZ3>; Fri, 8 Apr 2005 12:25:29 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 8 Apr 2005 07:21:13 -0400
Message-ID: <42566A25.6080208@timesys.com>
Date:	Fri, 08 Apr 2005 07:25:25 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Brian Kuschak <bkuschak@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: gdb backtrace with core files
References: <20050407204526.52640.qmail@web40914.mail.yahoo.com>
In-Reply-To: <20050407204526.52640.qmail@web40914.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2005 11:21:13.0640 (UTC) FILETIME=[12CAC280:01C53C2D]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Brian Kuschak wrote:

>Which kernel version are you using?  Are you getting a
>complete backtrace with the x86-hosted gdb?
>
>  
>
2.6.12-rcwhatever from the malta linux tree. I also have a 2.6.11.6 tree 
I'm playing with. I've not tried the x86 hosted gdb yet. It wouldn't 
surprise me if that one didn't work. The Timesys gdb has historically 
had problems with core dumps on the x86 hosted gdb.

Greg Weeks
