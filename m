Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 16:59:31 +0000 (GMT)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:44807 "EHLO
	smtp2.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21366218AbZCEQ71 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Mar 2009 16:59:27 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by smtp2.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49b004c60000>; Thu, 05 Mar 2009 11:58:47 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Mar 2009 08:58:18 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Mar 2009 08:58:18 -0800
Message-ID: <49B004AA.8050006@caviumnetworks.com>
Date:	Thu, 05 Mar 2009 08:58:18 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@codesourcery.com>
CC:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Richard Sandiford <rdsandiford@googlemail.com>
Subject: Re: [PATCH, RFC] MIPS: Implement the getcontext API
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <49AD6139.60209@caviumnetworks.com> <alpine.DEB.1.10.0903051530080.6558@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.1.10.0903051530080.6558@tp.orcam.me.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2009 16:58:18.0505 (UTC) FILETIME=[95397F90:01C99DB3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Adding Richard S. as he may be interested...

Maciej W. Rozycki wrote:
> On Tue, 3 Mar 2009, David Daney wrote:
> 
>> Note the libgcc currently makes the assumption that the layout of the stack
>> for signal handlers is fixed.  The DWARF2 unwinder needs this information to
>> be able to unwind through signal frames (see gcc/config/mips/linux-unwind.h),
>> so it is already a de facto part of the ABI.
> 
>  I do hope it was agreed upon at some point.

As with many things, there was no formal agreement.

> I certainly cannot recall a 
> discussion at the linux-mips list, but I did not always follow it closely 
> enough either, so I may have missed the discussion.

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=473957B6.3030202%40avtrex.com
http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=4739CCD6.2080306%40avtrex.com

> The interface is 
> meant to be internal to Linux, so the usual rule of volatility apply.  The 
> structure is not defined in a header even.
> 

Certainly it started out that way, but if the kernel doesn't supply 
DWARF2 unwind tables for its signal trampolines (which it currently does 
not), then I think using the structures is the only way for user-space 
applications to unwind through signal trampolines.

I was pointing this out not as any type of objection to your plan, but 
as further support for formalizing the interfaces.

>>>  Furthermore I am requesting that the kernel recognises the special meaning
>>> of the value of one stored in the slot designated for the $zero register and
>>> never places such a value itself there.
>> Seems reasonable to me as currently a zero is unconditionally stored there.
> 
>  It is, but is should be architected, not assumed.  Also contexts built 
> with the *context() functions are meant to be usable by them only -- 
> software will still be able to assume the value in the slot when 
> constructed by the kernel.
> 

Agreed.

Thanks for working on this,
David Daney
