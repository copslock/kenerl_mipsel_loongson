Received:  by oss.sgi.com id <S553843AbRALWXV>;
	Fri, 12 Jan 2001 14:23:21 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:59380 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553836AbRALWXO>;
	Fri, 12 Jan 2001 14:23:14 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f0CMKZC08645;
	Fri, 12 Jan 2001 14:20:35 -0800
Message-ID: <3A5F83D4.7D435618@mvista.com>
Date:   Fri, 12 Jan 2001 14:23:16 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     carlson@sibyte.com
CC:     linux-mips@oss.sgi.com
Subject: Re: broken RM7000 in CVS
References: <01011213554701.08038@plugh.sibyte.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Justin Carlson wrote:
> 
 
> I still would rather stick to the switch style of doing things in the future,
> though, because it's a bit more flexible; if you've got companies that fix
> errata without stepping PrID revisions or some such, then the table's going to
> have some strange special cases that don't quite fit.
> 

Ahh, in that case I suppose the mips_cpu_config function pointer in that entry
should not be NULL.  Instead it should modify the mips_cpu struct to fix
whatever quirks there.  Because this function is associated with a particular
CPU, this solution is probably cleaner than having all the quirk fixes
embedded inside a case block.

> 
> Luckily, in the end, you have to convince saner people than me.  :)
> 

Or I should wake up from hallucination.  :-)

Jun
