Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Mar 2009 17:03:09 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9107 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21366218AbZCERDG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Mar 2009 17:03:06 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49b005760001>; Thu, 05 Mar 2009 12:01:42 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Mar 2009 09:01:04 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Mar 2009 09:01:04 -0800
Message-ID: <49B00550.5050303@caviumnetworks.com>
Date:	Thu, 05 Mar 2009 09:01:04 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Brian Foster <brian.foster@innova-card.com>
CC:	"David VomLehn (dvomlehn)" <dvomlehn@cisco.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	"Maciej W. Rozycki" <macro@codesourcery.com>,
	linux-mips@linux-mips.org, libc-ports@sourceware.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: MIPS RI/XI & trampolines [was:- [PATCH, RFC] MIPS: Implement
 the getcontext API ]
References: <alpine.DEB.1.10.0902282326580.4064@tp.orcam.me.uk> <FF038EB85946AA46B18DFEE6E6F8A289BE0B68@xmb-rtp-218.amer.cisco.com> <49AF01E8.80705@caviumnetworks.com> <200903050858.32232.brian.foster@innova-card.com>
In-Reply-To: <200903050858.32232.brian.foster@innova-card.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2009 17:01:04.0207 (UTC) FILETIME=[F7FD9DF0:01C99DB3]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Brian Foster wrote:
> On Wednesday 04 March 2009 23:34:16 David Daney wrote:
[...]
>> That said, we do have RI/XI working well in our kernel (for non-stack
>> memory), so it is something we are interested in pursuing.
> 
> David,
> 
>  I am Very Interested in this.  we also want RI/XI,
>  at least for for userland (and, very importantly,
>  including the stack), but haven't yet time to deal
>  with the issue.  (our platform is the 4KSd, which
>  has SmartMIPS (and thus has RI/XI)).
> 
>  is what you have at linux-mips.org someplace?
> 

Not at this time, I will see if we can get it merged for 2.6.30...

David Daney
