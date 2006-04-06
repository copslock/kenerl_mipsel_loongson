Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Apr 2006 17:23:41 +0100 (BST)
Received: from amdext4.amd.com ([163.181.251.6]:56015 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133525AbWDFQX3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 6 Apr 2006 17:23:29 +0100
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k36GXjLN003251;
	Thu, 6 Apr 2006 11:34:40 -0500
Received: from 163.181.22.101 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Thu, 06 Apr 2006 11:34:24 -0500
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.0); Thu, 6 Apr 2006 09:34:23 -0700
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 952CC2028; Thu, 6 Apr 2006
 10:34:22 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k36HAMxf002053; Thu, 6 Apr 2006 11:10:22
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k36HAMsY002052; Thu, 6 Apr 2006 11:10:22 -0600
Date:	Thu, 6 Apr 2006 11:10:21 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
cc:	"Linux MIPS" <linux-mips@linux-mips.org>,
	"Rodolfo Giometti" <giometti@linux.it>,
	"Pete Popov" <ppopov@embeddedalley.com>
Subject: Re: Oops! - Re: Power management for au1000_eth.c
Message-ID: <20060406171021.GK22446@cosmic.amd.com>
References: <20060405154711.GL7029@enneenne.com>
 <20060405222332.GO7029@enneenne.com>
 <20060405222620.GP7029@enneenne.com> <4435290C.50607@ru.mvista.com>
MIME-Version: 1.0
In-Reply-To: <4435290C.50607@ru.mvista.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 06 Apr 2006 16:34:24.0152 (UTC)
 FILETIME=[F6C29980:01C65997]
X-WSS-ID: 682B9C9A3H42809518-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 06/04/06 18:43 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Rodolfo Giometti wrote:
> 
> >>>I'm trying to add power management support to au1000_eth.c driver.
> 
> >>Solved! :)
> 
> >>Here a patch to implement power management functions for au1000_eth.
> 
>    Actually, the network driver patches should be sent to Jeff Garzik and 
> Andrew Morton.

And the description is wrong - this isn't exactly just power management,
there are lots of changes here.  You should separate them out into multiple
patches. 

> >>Note that this patch needs my previous one who implements new power
> >>management's sysfs interface.

Thats OK, as long as this patch can be applied on its own, without requiring
the previous patch.  It is one thing to write a new PM interface for the 
whole system, but the driver suspend and resume functions should never be
system specific.  That makes life easier for future developers.

>    Funny, I've also been cooking a patch to straighten Alchemy Ethernet 
> probing code a bit...

I think we can all get along here.  The PM stuff looks decent to me, and
Sergei had some good comments about the rest of the patch.  I don't see
any reason why the two of you can't get together and bang out a few patches
to fix all of our ills.

Jordan

--
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
