Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 19:27:17 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:39672 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8225211AbTDXS1Q>;
	Thu, 24 Apr 2003 19:27:16 +0100
Received: (from jsun@localhost)
	by orion.mvista.com (8.11.6/8.11.6) id h3OIRBp28739;
	Thu, 24 Apr 2003 11:27:11 -0700
Date: Thu, 24 Apr 2003 11:27:11 -0700
From: Jun Sun <jsun@mvista.com>
To: Steven Seeger <sseeger@stellartec.com>
Cc: linux-mips@linux-mips.org, jsun@mvista.com
Subject: Re: [patch] wait instruction on vr4181
Message-ID: <20030424112711.E28275@mvista.com>
References: <20030424093420.C28275@mvista.com> <078a01c30a8c$a4cb9350$3501a8c0@wssseeger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <078a01c30a8c$a4cb9350$3501a8c0@wssseeger>; from sseeger@stellartec.com on Thu, Apr 24, 2003 at 11:09:26AM -0700
Return-Path: <jsun@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Thu, Apr 24, 2003 at 11:09:26AM -0700, Steven Seeger wrote:
> Hey, when I try to patch in standby, it says that opcode isn't available for
> the R6000. Why does arch/mips/Makefile use -mcpu=r4600 for the VR41XX?
>

"standby" opcode is probably only recognized by using "-mcpu=r4100". 

I am not sure what impact would it be to change the flag.

Another way to work around is to use the binary value for instruction.

Jun
