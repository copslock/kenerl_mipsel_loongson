Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jul 2003 03:55:12 +0100 (BST)
Received: from crack.them.org ([IPv6:::ffff:146.82.138.56]:22157 "EHLO
	crack.them.org") by linux-mips.org with ESMTP id <S8225072AbTGGCyj>;
	Mon, 7 Jul 2003 03:54:39 +0100
Received: from dsl093-172-017.pit1.dsl.speakeasy.net
	([66.93.172.17] helo=nevyn.them.org ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 19ZM9l-00055B-00; Sun, 06 Jul 2003 21:55:09 -0500
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 19ZM8T-00042y-00; Sun, 06 Jul 2003 22:53:49 -0400
Date: Sun, 6 Jul 2003 22:53:43 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Rahul Pande <rahul.pande@wipro.com>
Cc: linux-mips@linux-mips.org
Subject: Re: gdbserver on mips
Message-ID: <20030707025343.GA15510@nevyn.them.org>
References: <52C85426D39B314381D76DDD480EEE0CDA556C@blr-m3-msg.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52C85426D39B314381D76DDD480EEE0CDA556C@blr-m3-msg.wipro.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 04, 2003 at 07:13:14PM +0530, Rahul Pande wrote:
> 
> Hi,
>  
>  I am working on a AMD Au1500 based board and want some information. I
> am using the Linux 2.4.21pre. The problem happens when i run an
> application under "gdbserver" on the board, it does not allow me to
> single step into functions/code. The following error is displayed :
>                 "ptrace : Input/Output error". 
>  
> The  "ptrace.c" file under arch/mips/kernel/ does not have support for
> PTRACE_SINGLESTEP because of which the above error is occuring. I would
> like to know why single stepping support is not there for mips
> architecture under linux, whereas it is there for others like i386,
> alpha, arm etc ?

You're using too old of a GDB then.  It should not attempt to
single-step.

> **************************Disclaimer************************************
> 
> Information contained in this E-MAIL being proprietary to Wipro Limited is 
> 'privileged' and 'confidential' and intended for use only by the individual
>  or entity to which it is addressed. You are notified that any use, copying 
> or dissemination of the information contained in the E-MAIL in any manner 
> whatsoever is strictly prohibited.
> 
> ***************************************************************************

Don't do that again.  Period.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
