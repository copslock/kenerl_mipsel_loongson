Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 17:34:27 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:31219 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225211AbTDXQe0>;
	Thu, 24 Apr 2003 17:34:26 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3OGYKa28380;
	Thu, 24 Apr 2003 09:34:20 -0700
Date: Thu, 24 Apr 2003 09:34:20 -0700
From: Jun Sun <jsun@mvista.com>
To: Steven Seeger <sseeger@stellartec.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [patch] wait instruction on vr4181
Message-ID: <20030424093420.C28275@mvista.com>
References: <20030424141217.A23893@linux-mips.org> <076701c30a6b$429b0560$3501a8c0@wssseeger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <076701c30a6b$429b0560$3501a8c0@wssseeger>; from sseeger@stellartec.com on Thu, Apr 24, 2003 at 07:10:28AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2165
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips


On Thu, Apr 24, 2003 at 07:10:28AM -0700, Steven Seeger wrote:
> The VR4181 does work with the wait instruction. This is a patch for that.
> (arch/mips/cpu-probe.c)
> 
> Steve
> 

The CPU mannual (v1.1 draft) I have for Vr4181 does not say about "wait"
instruction.  How do you know it has "wait"?

I will ask NEC for confirmation.


Jun
