Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 20:38:23 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:39572 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8224902AbVDGTiI>; Thu, 7 Apr 2005 20:38:08 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 7 Apr 2005 15:33:56 -0400
Message-ID: <42558C1E.4020906@timesys.com>
Date:	Thu, 07 Apr 2005 15:38:06 -0400
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
X-OriginalArrivalTime: 07 Apr 2005 19:33:56.0187 (UTC) FILETIME=[BD07B2B0:01C53BA8]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7644
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
>  
>
OK, I checked.

Most of what's in our patches should be in gdb HEAD. We're currently at 
6.2.1 and don't want to take the time to move to head. If you're 
interested and no one objects I can post them to the mips list. There 
are 37 patches totaling 285K. Not all are mips related and gdb isn't 
totally working for me yet.

Greg Weeks
