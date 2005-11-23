Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2005 01:11:24 +0000 (GMT)
Received: from amdext4.amd.com ([163.181.251.6]:740 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8134465AbVKWBLC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2005 01:11:02 +0000
Received: from SAUSGW02.amd.com (sausgw02.amd.com [163.181.250.22])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id jAN1DeTs012025;
	Tue, 22 Nov 2005 19:13:40 -0600
Received: from 163.181.250.1 by SAUSGW02.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Tue, 22 Nov 2005 19:13:31 -0600
X-Server-Uuid: 5FC0E2DF-CD44-48CD-883A-0ED95B391E89
Received: from ldcmail.amd.com (ldcmail.amd.com [147.5.200.40]) by
 amdint2.amd.com (8.12.8/8.12.8/AMD) with ESMTP id jAN1DUeP004994; Tue,
 22 Nov 2005 19:13:30 -0600 (CST)
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 631041FF4; Tue, 22 Nov 2005
 18:13:30 -0700 (MST)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id jAN1IjOF007058; Tue, 22 Nov 2005 18:18:45
 -0700
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id jAN1Ij9r007057; Tue, 22 Nov 2005 18:18:45
 -0700
Date:	Tue, 22 Nov 2005 18:18:45 -0700
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Dan Malek" <dan@embeddedalley.com>
cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: Fix board type in db1x00
Message-ID: <20051123011845.GA6502@cosmic.amd.com>
References: <20051122221526.GZ18119@cosmic.amd.com>
 <6dabaec28e238ccc915f20f51ee28327@embeddedalley.com>
 <20051123001534.GA18119@cosmic.amd.com>
 <968d9f47767cad14f9924abc1d07972b@embeddedalley.com>
MIME-Version: 1.0
In-Reply-To: <968d9f47767cad14f9924abc1d07972b@embeddedalley.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F9D1DB11M8617281-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 22/11/05 19:24 -0500, Dan Malek wrote:
> 
> On Nov 22, 2005, at 7:15 PM, Jordan Crouse wrote:
> 
> >....  That means either the mess goes in here or it goes
> >in asm-mips/mach-db1x00/db1x00.h,
> 
> You are already doing this for other things, like the BCSR
> differences with the db1550.  Why not put it all on one place?
> You could even generate out of the Kconfig process and
> not need it in any file. :-)  The problem is if you propagate
> stuff like this "...  because there isn't an include file ..." others
> will also take that attitude.  Someone has to start the
> process.  For something as generic as these boards, the
> next one should simply be an include file update, not the
> need to edit various source files as is necessary today.

I'll buy into the general idea, but I'll defer to Ralf to see if
he wants us to start inflicting this on the tree, or if he would
just prefer to let sleeping dogs lay.  One one hand, its nice to 
clean things up, but on the other hand, we're not making any more
DB boards :( so its doubtful the ugliness will grow much further then
this.

Thanks for your comments,
Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>
