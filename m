Received:  by oss.sgi.com id <S553812AbRCBShw>;
	Fri, 2 Mar 2001 10:37:52 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:50173 "EHLO
        orion.mvista.com") by oss.sgi.com with ESMTP id <S553802AbRCBShh>;
	Fri, 2 Mar 2001 10:37:37 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id KAA16949;
	Fri, 2 Mar 2001 10:34:49 -0800
Date:   Fri, 2 Mar 2001 10:34:49 -0800
From:   Jun Sun <jsun@mvista.com>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Bug in get_insn_opcode.
Message-ID: <20010302103449.B16933@mvista.com>
References: <3A9FD0D0.887E372F@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A9FD0D0.887E372F@mips.com>; from carstenl@mips.com on Fri, Mar 02, 2001 at 05:56:48PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Mar 02, 2001 at 05:56:48PM +0100, Carsten Langgaard wrote:
> There is a bug in the function get_insn_opcode in traps.c
> 
> As 'epc' is an int pointer here, it should only be increased by 1 (4
> byte) and not by 4 (4*4 = 16 bytes).
> See the patch below.
> 
> /Carsten
>

Good catch!

I am surprised that trap on branch delay slot is rare that we only discover
this bug now ...

Jun 
