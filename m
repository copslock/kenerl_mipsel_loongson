Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 18:45:08 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:9651 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20034942AbXLLSpA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 18:45:00 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 6D2B6310FA8;
	Wed, 12 Dec 2007 18:44:29 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 12 Dec 2007 18:44:29 +0000 (UTC)
Received: from [192.168.7.26] ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Dec 2007 10:44:14 -0800
Message-ID: <47602BFE.4050606@avtrex.com>
Date:	Wed, 12 Dec 2007 10:44:14 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 1.5.0.12 (X11/20071019)
MIME-Version: 1.0
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: questions on struct sigcontext
References: <47601DEE.4090200@nortel.com> <47602471.9080706@avtrex.com> <476029AB.80702@nortel.com>
In-Reply-To: <476029AB.80702@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2007 18:44:14.0594 (UTC) FILETIME=[FE45F620:01C83CEE]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17799
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Chris Friesen wrote:
> David Daney wrote:
> 
>> Most of the information is available.  The si_addr and si_code of the 
>> sigcontext are populated as well as the ucontext at the fault.
> 
> I assume this should be siginfo rather than sigcontext?

Yes.  In the three parameter form of the signal handler the second and 
third parameters are pointers to the siginfo and ucontext.

> 
>> Given all this and the code at $pc when the fault occurred, it is a 
>> simple matter to determine what happened.
> 
> Okay.  I'll pass that information on and see if it's sufficient.
> 
> Thanks,
> 
> Chris
