Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Dec 2007 00:07:11 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:5544 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20035415AbXLMAHD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Dec 2007 00:07:03 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id CC6193111CE;
	Thu, 13 Dec 2007 00:06:37 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Thu, 13 Dec 2007 00:06:37 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Dec 2007 16:06:14 -0800
Message-ID: <47607775.4020907@avtrex.com>
Date:	Wed, 12 Dec 2007 16:06:13 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: questions on struct sigcontext
References: <47601DEE.4090200@nortel.com> <20071212190032.GA30506@caradoc.them.org> <47607327.5090709@nortel.com>
In-Reply-To: <47607327.5090709@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2007 00:06:14.0296 (UTC) FILETIME=[F9B68980:01C83D1B]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Chris Friesen wrote:
> Daniel Jacobowitz wrote:
> 
>> There used to be slots for badvaddr and cause.  You'll have to ask
>> Ralf why he decided to clobber them for DSP state, I don't remember
>> :-)  I suspect they may never have held useful information for you;
>> we don't context switch them for userspace, so an intervening fault
>> in kernel space or in another thread could change them.
> 
> I'm a bit confused as to how they would never have held useful 
> information--did you mean the registers themselves, or the entries in 
> struct sigcontext?

The entries in the sigcontext.  As Ralf said, they never held valid values.

> 
> If the cause/badvaddr entries in struct sigcontext were filled in by the 
> exception handler in the kernel,

It would appear that they are not.

> wouldn't the values in that struct be 
> completely valid even if the registers themselves were changed before 
> userspace could handle the signal?
> 
> If this is not the case then it seems like si_addr/si_code wouldn't be 
> trustworthy either.

This I am not sure about :(, However knowing the values of all registers 
(and perhaps /proc/self/maps) and $pc you can easily derive what happened.


David Daney
