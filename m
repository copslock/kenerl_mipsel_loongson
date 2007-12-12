Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 18:12:26 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:18410 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20034738AbXLLSMS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 18:12:18 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 0690E3112A0;
	Wed, 12 Dec 2007 18:12:18 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 12 Dec 2007 18:12:17 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Dec 2007 10:12:02 -0800
Message-ID: <47602471.9080706@avtrex.com>
Date:	Wed, 12 Dec 2007 10:12:01 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: questions on struct sigcontext
References: <47601DEE.4090200@nortel.com>
In-Reply-To: <47601DEE.4090200@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2007 18:12:02.0396 (UTC) FILETIME=[7E97F1C0:01C83CEA]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Chris Friesen wrote:
> 
> Hi all,
> 
> First, I'm not subscribed to the list so I'd appreciate being cc'd on 
> any replies.
> 
> We have a project getting started with MIPS, and one of the things that 
> we're trying to bring in is some exception-handling code that logs 
> various information about the ways that apps fail.
> 
> In particular, the guys working on this have asked for the STATUS, 
> CAUSE, BADVADDR, and FPC_EIR registers to be made available as part of 
> struct sigcontext so that they can determine exactly why the app is 
> failing.
> 
> Looking at include/asm-mips/sigcontext.h I can see that these registers 
> appear to be in the struct, but are either marked as "unused" or now 
> have different names.
> 
> Am I correct that these registers are not currently exported to 
> userspace on a fault?

No.

Most of the information is available.  The si_addr and si_code of the 
sigcontext are populated as well as the ucontext at the fault.

Given all this and the code at $pc when the fault occurred, it is a 
simple matter to determine what happened.

I have seen some kernels patched so that an OOPS type dump was created 
in the trap handler, but this doesn't really add anything to the 
information that is already available in user space.

David Daney
