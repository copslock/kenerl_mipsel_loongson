Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 23:48:13 +0000 (GMT)
Received: from zcars04f.nortel.com ([47.129.242.57]:34274 "EHLO
	zcars04f.nortel.com") by ftp.linux-mips.org with ESMTP
	id S20035406AbXLLXsE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 23:48:04 +0000
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zcars04f.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id lBCNluY21944;
	Wed, 12 Dec 2007 23:47:56 GMT
Received: from [47.130.25.105] ([47.130.25.105] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Dec 2007 18:47:55 -0500
Message-ID: <47607327.5090709@nortel.com>
Date:	Wed, 12 Dec 2007 17:47:51 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Daniel Jacobowitz <dan@debian.org>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: questions on struct sigcontext
References: <47601DEE.4090200@nortel.com> <20071212190032.GA30506@caradoc.them.org>
In-Reply-To: <20071212190032.GA30506@caradoc.them.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2007 23:47:55.0847 (UTC) FILETIME=[6AFC8570:01C83D19]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17803
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

Daniel Jacobowitz wrote:

> There used to be slots for badvaddr and cause.  You'll have to ask
> Ralf why he decided to clobber them for DSP state, I don't remember
> :-)  I suspect they may never have held useful information for you;
> we don't context switch them for userspace, so an intervening fault
> in kernel space or in another thread could change them.

I'm a bit confused as to how they would never have held useful 
information--did you mean the registers themselves, or the entries in 
struct sigcontext?

If the cause/badvaddr entries in struct sigcontext were filled in by the 
exception handler in the kernel, wouldn't the values in that struct be 
completely valid even if the registers themselves were changed before 
userspace could handle the signal?

If this is not the case then it seems like si_addr/si_code wouldn't be 
trustworthy either.

Chris
