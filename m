Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g478oXwJ004629
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 7 May 2002 01:50:33 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g478oWjE004628
	for linux-mips-outgoing; Tue, 7 May 2002 01:50:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from guest (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g478oTwJ004624
	for <linux-mips@oss.sgi.com>; Tue, 7 May 2002 01:50:30 -0700
Received: (from ralf@localhost)
	by guest (8.11.6/8.11.6) id g46HrDG13452;
	Tue, 7 May 2002 01:53:13 +0800
Date: Tue, 7 May 2002 01:53:13 +0800
From: Ralf Baechle <ralf@oss.sgi.com>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Jun Sun <jsun@mvista.com>, linux-mips <linux-mips@oss.sgi.com>
Subject: Re: what is the right behavior of copy_to_user(0x0, ..., ...)?
Message-ID: <20020507015313.A13262@guest.intrengr>
References: <3CD3052B.1050400@mvista.com> <20020503162337.A27366@dea.linux-mips.net> <3CD32044.9040109@mvista.com> <20020503184000.A1238@dea.linux-mips.net> <3CD794BC.43264E9E@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3CD794BC.43264E9E@mips.com>; from carstenl@mips.com on Tue, May 07, 2002 at 10:47:56AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, May 07, 2002 at 10:47:56AM +0200, Carsten Langgaard wrote:

> It fix a problem I have had for quite a while in the r4k_fpu.S. The code in
> question is:
>         jr      ra
>         .set    nomacro
>          EX(sw  t0,SC_FPC_EIR(a0))
>         .set    macro
> 
> I have fixed it locally by removing the SW from the delay-slot, but obviously
> your fix is the right one.
> But I guess we need the same fix in arch/mips/kernel/unaligned.c.

Good spotting.  I'll use a slightly different fix using the new inline
function exception_epc() in <asm/branch.h> to implement that slightly
more elegant.

Thanks,

  Ralf
