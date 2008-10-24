Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 21:17:22 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:24995 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22314460AbYJXURL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 21:17:11 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49022d3c0000>; Fri, 24 Oct 2008 16:17:00 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 13:16:59 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 13:16:59 -0700
Message-ID: <49022D3A.90305@caviumnetworks.com>
Date:	Fri, 24 Oct 2008 13:16:58 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 29/37] Don't clobber spinlocks in 8250.
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com> <1224809821-5532-30-git-send-email-ddaney@caviumnetworks.com> <alpine.LFD.1.10.0810242105160.31223@ftp.linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0810242105160.31223@ftp.linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2008 20:16:59.0137 (UTC) FILETIME=[77F29710:01C93615]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20954
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
>> In serial8250_isa_init_ports(), the port's lock is initialized.  We
>> should not overwrite it.  Only copy in the fields we need.
> 
>  I suggest you to send all the 8250 patches to 
> linux-serial@vger.kernel.org and most probably the LKML.  I don't think 
> the relevant maintainers read this list -- note that they will be the 
> general Linux maintainers as the serial subsystem doesn't have a dedicated 
> one at the moment.  Please always consult the MAINTAINERS file before 
> posting patches (see Documentation/SubmittingPatches too).

Thanks, we are aware of this.  All the serial patches had been 
previously sent as you suggest.

The next revision of this patch set will go to a wider audience, 
including linux-serial@ as appropriate.

David Daney
