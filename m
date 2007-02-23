Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2007 21:28:20 +0000 (GMT)
Received: from father.pmc-sierra.com ([216.241.224.13]:22916 "HELO
	father.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20039032AbXBWV2P (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Feb 2007 21:28:15 +0000
Received: (qmail 11153 invoked by uid 101); 23 Feb 2007 21:27:21 -0000
Received: from unknown (HELO pmxedge1.pmc-sierra.bc.ca) (216.241.226.183)
  by father.pmc-sierra.com with SMTP; 23 Feb 2007 21:27:21 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by pmxedge1.pmc-sierra.bc.ca (8.13.4/8.12.7) with ESMTP id l1NLRLcc001624;
	Fri, 23 Feb 2007 13:27:21 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <FGCPBRFD>; Fri, 23 Feb 2007 13:27:21 -0800
Message-ID: <45DF5C2F.9000700@pmc-sierra.com>
From:	Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/5] mips: PMC MSP71xx mips common
Date:	Fri, 23 Feb 2007 13:27:11 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
x-originalarrivaltime: 23 Feb 2007 21:27:11.0537 (UTC) FILETIME=[612A1210:01C75791]
user-agent: Thunderbird 1.5.0.9 (X11/20061206)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <Marc_St-Jean@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Marc_St-Jean@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> Hello.
> 
> Marc St-Jean wrote:
> 
>  >> > +config PMC_MSP_UNCACHED
>  >> > +     bool "Run uncached"
>  >> > +     select MIPS_UNCACHED
>  >> > +   
>  >> > +endmenu
>  >> > +
> 
>  >>    Erm, was there really a need for separate option?
> 
>  > Are you aware of an existing option to accomplish the same
>  > results? I have not found it.
> 
>     How's that when you're using it! "Run uncached" is in the "Kernel 
> hacking"
> menu.

Hmmm, I can only assume the developer who added this wanted it to be
in a more obvious place under out board settings. I will drop it
from the next submission.

Marc
