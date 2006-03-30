Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 11:39:05 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:473 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8127231AbWC3Ki6
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Mar 2006 11:38:58 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k2UAnPjP027306;
	Thu, 30 Mar 2006 02:49:25 -0800 (PST)
Received: from ukservices1.mips.com (ukservices1 [192.168.192.240])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id k2UAnOuf018502;
	Thu, 30 Mar 2006 02:49:24 -0800 (PST)
Received: from shoreditch-home.mips-uk.com ([172.20.192.99] helo=[127.0.0.1])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FOuiO-000772-00; Thu, 30 Mar 2006 11:49:20 +0100
Message-ID: <442BB7B2.1010204@mips.com>
Date:	Thu, 30 Mar 2006 11:49:22 +0100
From:	Nigel Stephens <nigel@mips.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	colin <colin@realtek.com.tw>
CC:	linux-mips@linux-mips.org
Subject: Re: Using hardware watchpoint for applications debugging
References: <024c01c65337$63931c90$106215ac@realtek.com.tw> <442A94D0.1020106@mips.com> <002d01c6539f$d040a200$106215ac@realtek.com.tw>
In-Reply-To: <002d01c6539f$d040a200$106215ac@realtek.com.tw>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10991
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



colin wrote:
> As to adding watchpoint to kernel, there will be another problem.
> ASID in kernel is variable. Therefore, we cannot indicate which thread we
> want to watch by ASID.
> What we can do is setting G (global) bit to WatchHi Register and then all
> threads accessing that address will cause the exception.
> In the exception, it will filter the threads by PID to find out the thread
> we are watching.
>
>   

They're variable, but not very variable: the PID->ASID mapping will only
change when the ASIDs roll over and the ASID gets reallocated to a
different process, which will only happen after another 256 processes
have been created. But in that case your watched process will have to be
allocated a new ASID before it can run again. So you could, perhaps,
modify the TLB management code to clear the Watch registers whenever an
ASID belong to a process with watchpoints is recycled, and then
reprogram the Watch registers when such a process is allocated a new
ASID. Alternatively you could maintain pre-process copies of the Watch
registers, and context switch them along with other per-process register
state -- though that is adding context switch overhead to processes
which don't use watchpoints, and might not be popular with the maintainer.

Nigel
