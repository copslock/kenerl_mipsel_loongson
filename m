Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Dec 2002 17:51:09 +0100 (CET)
Received: from crack.them.org ([65.125.64.184]:10143 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S8225193AbSLJQvI>;
	Tue, 10 Dec 2002 17:51:08 +0100
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 18LpTH-0004wZ-00; Tue, 10 Dec 2002 12:51:07 -0600
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 18LnbZ-0002Ly-00; Tue, 10 Dec 2002 11:51:33 -0500
Date: Tue, 10 Dec 2002 11:51:33 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: GDB patch
Message-ID: <20021210165133.GA8818@nevyn.them.org>
References: <3DF5D902.22E5AA55@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DF5D902.22E5AA55@mips.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 10, 2002 at 01:07:31PM +0100, Carsten Langgaard wrote:
> I've attached a patch for gdb-stub.c to make it work better with the
> sde-gdb.
> These changes should be backwards compatible with a standard gdb, so it
> shouldn't break anything.
> Ralf, could you please apply it.

Strongly object.  While I didn't check the implementation, it's nice to
see 'X' implemented.  And P.  But what the heck is this?

> @@ -816,13 +839,64 @@
>  		case 'k' :
>  			break;		/* do nothing */
>  
> +		case 'R':
> +			/* RNN[:SS],	Set the value of CPU register NN (size SS) */
> +			/* FALL THROUGH */

> -		/*
> -		 * Reset the whole machine (FIXME: system dependent)
> -		 */
>  		case 'r':
> -			break;
> +			/* rNN[:SS]	Return the value of CPU register NN (size SS) */


We're not making up a protocol here, we're implementing one.  R and r
don't have anything to do with setting registers.

> +		case 'D':
> +			putpacket("OK");
> +			return;
> +			/* NOTREACHED */
>  
>  		/*
>  		 * Step to next instruction

'D' should generally resume the machine, by the way.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
