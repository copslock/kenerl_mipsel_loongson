Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2004 02:39:53 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:51841
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225339AbUJOBjr>; Fri, 15 Oct 2004 02:39:47 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id i9F1dWlh014612;
	Thu, 14 Oct 2004 18:39:32 -0700 (PDT)
Received: from uhler-linux.mips.com (uhler-linux [192.168.65.120])
	by mercury.mips.com (8.12.11/8.12.11) with ESMTP id i9F1dXVP001944;
	Thu, 14 Oct 2004 18:39:33 -0700 (PDT)
Subject: Re: Problem caused by forcing interrupt vector location to
	0x91xx0200 instead of 0x80000200
From: Michael Uhler <uhler@mips.com>
To: Kang <huangyk@gmail.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <8498a8b0041014182933ca742a@mail.gmail.com>
References: <8498a8b0041014182933ca742a@mail.gmail.com>
Content-Type: text/plain
Organization: MIPS Technologies, Inc.
Message-Id: <1097804372.6997.81.camel@uhler-linux.mips.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 14 Oct 2004 18:39:32 -0700
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

Prior to Release 2 of the MIPS32 Architecture, the exception vectors
were fixed at a base of 0x80000000, which put the vectored interrupt
offset at 0x80000200.

The MIPS32 4Kc processor is an implementation of Release 1 of the
Architecture, so it has a fixed exception vector base.  (Note that
the MIPS32 4KEc - the added 'E' is significant - implements Release 2
so in case you mis-typed, there is a solution using the 4KEc).

So with a Release 1 implementation, your only really solution is
to put a jump at 0x80000200 to where you want the code to be.
I suspect that this isn't really what you want.

/gmu

On Thu, 2004-10-14 at 18:29, Kang wrote:
> Hello buddies,
> 
> I am working on a MIPS4Kc based reference design board. For some
> reason, I need to force the interrupt vector location to address
> 0x91xx0200 instead of 0x80000200 in arch/mips/kernel/traps.c. The
> kernel was loaded into 0x91xxxxxx space as well.
> 
> The kernel hung just after the interrupt was first time opened, after
> sti(), before calibrate_delay() in init/main.c. It was weird that I
> didn't see any problem if I put interrupt vector to location
> 0x80000200 while all other exception vectors to 0x91xxxxxx.
> 
> Was interrupt vector location hardcode to the address 0x80000200? Or
> some other place I need to change to walk around it. Any idea?
> 
> Thanks a bunch for your help.
> 
> Leo
-- 

Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com
1225 Charleston Road
Mountain View, CA 94043
