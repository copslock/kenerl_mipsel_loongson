Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Oct 2005 00:08:11 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:20237
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133658AbVJ1XHy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 29 Oct 2005 00:07:54 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Oct 2005 16:08:09 -0700
Message-ID: <4362AF58.30403@avtrex.com>
Date:	Fri, 28 Oct 2005 16:08:08 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Chris Boot <bootc@bootc.net>
CC:	linux-mips@linux-mips.org
Subject: Re: Execute-in-Place (XIP)
References: <18E0376E-A524-42EE-A5ED-BDF9A0668DE6@bootc.net> <20051027102912.GB17645@linux-mips.org> <942B8B78-5F73-4647-AAA6-6025EABEDD1E@bootc.net> <6D27C791-80C1-42BA-8874-D117DC188F5C@bootc.net>
In-Reply-To: <6D27C791-80C1-42BA-8874-D117DC188F5C@bootc.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2005 23:08:09.0110 (UTC) FILETIME=[763D1B60:01C5DC14]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9380
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Chris Boot wrote:
> 
> Now, who knows how much initialisation a bootloader is expected to  
> perform? Does the vrboot loader do the necessary operations, in which  
> case I can just work on that instead of writing my own?
> 
It depends.

Depending on the hardware:

Initialize clocks (things like PLL divisors and such).

Initialize serial port so it can report on its progress.

Initialize memory controller (so that RAM functions).

(optionally) copy bootmonitor to ram so that it can run out of cached 
memory.

(optionally) copy kernel image to ram (possibley uncompressing it) and 
transfersing control to the kernel.

If you are doing XIP, the last two steps are probably skipped.


I have no idea what the vrboot loader does, but that is what the Xilleon 
boot loaders do.

David Daney
