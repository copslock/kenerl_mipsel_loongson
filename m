Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2003 00:46:55 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:47094 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225241AbTFDXqx>;
	Thu, 5 Jun 2003 00:46:53 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h54Nkqm24427;
	Wed, 4 Jun 2003 16:46:52 -0700
Date: Wed, 4 Jun 2003 16:46:52 -0700
From: Jun Sun <jsun@mvista.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [RFC] synchronized CPU count registers on SMP machines
Message-ID: <20030604164652.J19122@mvista.com>
References: <20030604153930.H19122@mvista.com> <20030604231547.GA22410@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030604231547.GA22410@linux-mips.org>; from ralf@linux-mips.org on Thu, Jun 05, 2003 at 01:15:47AM +0200
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Jun 05, 2003 at 01:15:47AM +0200, Ralf Baechle wrote:
> On Wed, Jun 04, 2003 at 03:39:30PM -0700, Jun Sun wrote:
> 
> > 1) clocks on different CPUs don't have the same frequency
> > 2) clocks on different CPUs drift to each other
> > 2) some fancy power saving feature such as frequency scaling
> > 
> > But I think for a foreseeable future most MIPS SMP machines
> > don't have the above issues (true?).  And it is probably worthwile
> > to synchronize count registers for them.
> 
> 1) and 2) affect most SGI systems.
>

Assuming SGI systems represent the past of MIPS, we are still ok
future-wise. :)

Jun
