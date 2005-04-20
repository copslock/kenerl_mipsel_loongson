Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2005 11:28:00 +0100 (BST)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:3594 "EHLO
	bacchus.net.dhis.org") by linux-mips.org with ESMTP
	id <S8226057AbVDTK1k>; Wed, 20 Apr 2005 11:27:40 +0100
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.1/8.13.1) with ESMTP id j3KARPrY009172;
	Wed, 20 Apr 2005 11:27:25 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j3KARO7p009171;
	Wed, 20 Apr 2005 11:27:24 +0100
Date:	Wed, 20 Apr 2005 11:27:24 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andy Isaacson <adi@hexapodia.org>
Cc:	Henk <Henk.Vergonet@gmail.com>,
	Waldemar Brodkorb <wbx@openbsd-geek.de>,
	linux-mips@linux-mips.org
Subject: Re: Porting mips based routers
Message-ID: <20050420102724.GD5212@linux-mips.org>
References: <20050414210645.GB30585@god.dyndns.org> <20050415065558.GD25962@openbsd-geek.de> <20050418124809.GA27967@god.dyndns.org> <20050419183259.GA623@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419183259.GA623@hexapodia.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 19, 2005 at 11:32:59AM -0700, Andy Isaacson wrote:

> > General comments on the WRT code:
> 
> The code is full of "Broadcom Proprietary" and "All Rights Reserved"
> notices.  Does anyone have a clear written statement from Broadcom that
> it's redistributable?  (If you're depending on the GPL release
> requirements to justify relicensing, clear documentation of the chain of
> release would be helpful.)

Broadcom's interpretation of these comments is that they don't contradict
the GPL.

> I think there are other OCP busses supported in the kernel; ISTR seeing
> some PPC SoC from IBM that uses OCP... so perhaps this should be brought
> up on l-k for general discussion.
> 
> But it's challenging to come up with a useful abstraction that covers
> both the b44 scenario and the SoC scenario.

OCP is basically ISA on steroids - no configuration space, no nothing so
there is not terribly much OCP code that could potencially be shared.
Right now we treat OCP devices such as on PMC-Sierra's RM9000 series as
platform devices.

I'm clearly less than impressed by OCP ...

  Ralf
