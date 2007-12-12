Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2007 18:42:19 +0000 (GMT)
Received: from zrtps0kn.nortel.com ([47.140.192.55]:51342 "EHLO
	zrtps0kn.nortel.com") by ftp.linux-mips.org with ESMTP
	id S20034876AbXLLSmL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Dec 2007 18:42:11 +0000
Received: from zcarhxs1.corp.nortel.com (zcarhxs1.corp.nortel.com [47.129.230.89])
	by zrtps0kn.nortel.com (Switch-2.2.6/Switch-2.2.0) with ESMTP id lBCIYXA28791;
	Wed, 12 Dec 2007 18:34:33 GMT
Received: from [47.9.29.61] ([47.9.29.61] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 12 Dec 2007 13:34:22 -0500
Message-ID: <476029AB.80702@nortel.com>
Date:	Wed, 12 Dec 2007 12:34:19 -0600
From:	"Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	David Daney <ddaney@avtrex.com>
CC:	linux-mips@linux-mips.org
Subject: Re: questions on struct sigcontext
References: <47601DEE.4090200@nortel.com> <47602471.9080706@avtrex.com>
In-Reply-To: <47602471.9080706@avtrex.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2007 18:34:22.0171 (UTC) FILETIME=[9D2962B0:01C83CED]
Return-Path: <CFRIESEN@nortel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cfriesen@nortel.com
Precedence: bulk
X-list: linux-mips

David Daney wrote:

> Most of the information is available.  The si_addr and si_code of the 
> sigcontext are populated as well as the ucontext at the fault.

I assume this should be siginfo rather than sigcontext?

> Given all this and the code at $pc when the fault occurred, it is a 
> simple matter to determine what happened.

Okay.  I'll pass that information on and see if it's sufficient.

Thanks,

Chris
