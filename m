Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2005 16:44:01 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:52509
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133641AbVI2Pnn (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Sep 2005 16:43:43 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 29 Sep 2005 08:43:41 -0700
Message-ID: <433C0BAD.5040804@avtrex.com>
Date:	Thu, 29 Sep 2005 08:43:41 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Arravind babu <aravindforl@yahoo.co.in>
CC:	linux-mips@linux-mips.org
Subject: Re: Problem in detecting RAM size by bootloader
References: <20050929125251.46023.qmail@web35402.mail.mud.yahoo.com>
In-Reply-To: <20050929125251.46023.qmail@web35402.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2005 15:43:41.0713 (UTC) FILETIME=[91408010:01C5C50C]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Arravind babu wrote:
> Hi all,
> 
> 
> 
>          We are using PMON bootloader on MIPS based
> board.Earlier we have 64MB of RAM.Now we upgraded to
> 128MB RAM.But bootloader is not detecting as 128MB.It
> is giving 64MB only.Where i have to look to resolve
> this issue?
> 

I would look at the boot monitor source code.  On some systems (Xilleon 
for example) the memory configuration is hardcoded.  In this case, if 
you change the physical memory configuration, you have to make a 
corresponding change to the boot monitor.

David Daney
