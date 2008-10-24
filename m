Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 21:13:47 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:51358 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22314335AbYJXUNQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 21:13:16 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49022c2e0000>; Fri, 24 Oct 2008 16:12:30 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 13:12:28 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 13:12:28 -0700
Message-ID: <49022C2C.3030201@caviumnetworks.com>
Date:	Fri, 24 Oct 2008 13:12:28 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 11/37] Cavium OCTEON: ebase isn't just CAC_BASE
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-12-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.1.10.0810242054420.31223@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0810242054420.31223@ftp.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2008 20:12:28.0608 (UTC) FILETIME=[D6B32400:01C93614]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 23 Oct 2008, ddaney@caviumnetworks.com wrote:
> 
>> From: David Daney <ddaney@caviumnetworks.com>
>>
>> On Cavium, the ebase isn't just CAC_BASE, but also the part of
>> read_c0_ebase() too.
> 
>  How is that unique to CONFIG_CPU_CAVIUM_OCTEON?  That's a general feature 
> of the MIPS revision 2 architecture, so please make it right from the 
> beginning.  You'll avoid an ugly #ifdef this way too.
> 

Thanks for the feedback.  We will submit a patch that uses the runtime 
value of mipsr2 to do the adjustment.

David Daney
