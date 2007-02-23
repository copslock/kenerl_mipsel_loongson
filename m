Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 19:15:53 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:50416 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039014AbXBWTPt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 19:15:49 +0000
Received: (qmail 23405 invoked by uid 101); 23 Feb 2007 19:14:33 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by mother.pmc-sierra.com with SMTP; 23 Feb 2007 19:14:33 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1NJE8ql024782;
	Fri, 23 Feb 2007 11:14:31 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPBM6J>; Fri, 23 Feb 2007 11:14:08 -0800
Message-ID: <45DF3CF3.9070904@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Questions on the procedure/policy for patch submission
Date:	Fri, 23 Feb 2007 11:13:55 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 23 Feb 2007 19:13:56.0442 (UTC) FILETIME=[C3B763A0:01C7577E]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips



Yoichi Yuasa wrote:
> On Thu, 22 Feb 2007 15:05:21 -0800
> Marc St-Jean <Marc_St-Jean@pmc-sierra.com> wrote:
> 
>  > 1a. Do patches living completely in arch/mips and include/asm-mips 
> only have to be submitted to the l-m.o?
> 
> You can see the general rules Documentation/SubmittingPatches in kernel 
> source.

I have read, neither it or the FAQ cover per-architectural issues.

> You should submit MIPS part to linux-mips mailing list.
> 
>  > 1b. If so, does this imply that l-m.o will push them to kernel.org?
> 
> Yes.

Thanks for verifying.

>  > 2a. Do patches which are outside the above directories have the be 
> submitted to the kernel.org list?
> 
> You will be able to find a suitable mailing list in MAINTAINERS in 
> kernel source.
> 
>  > 2b. If so, how are dependencies between the two sets of submission 
> handled during the review process?
> 
> If they have dependency, you should add linux-mips mailing list to Cc:.

I intend to but this wont help the folks on the kernel.org list who won't
see the MIPS specific parts.

Marc
