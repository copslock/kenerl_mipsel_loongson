Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2003 01:49:49 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:63900 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225397AbTKSBth>;
	Wed, 19 Nov 2003 01:49:37 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1AMHTG-0001Ft-1z; Tue, 18 Nov 2003 20:49:30 -0500
Date: Tue, 18 Nov 2003 20:49:29 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: David Daney <ddaney@avtrex.com>
Cc: linux-mips@linux-mips.org
Subject: Re: How reliable is GCC-3.3.1 wrt building mipsel-linux kernel?
Message-ID: <20031119014929.GA4811@nevyn.them.org>
References: <3FBACA0F.7070207@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FBACA0F.7070207@avtrex.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 18, 2003 at 05:40:31PM -0800, David Daney wrote:
> The subject line kind of says it all.
> 
> We are running linux 2.4.18 on a mips4Kc core (ATI Xilleon 225) and find 
> it to be quite stable when compiled with gcc 2.96/binutils 2.11.92.0.10
> 
> When the kernel is compiled with gcc 3.3.1/binutils 2.14.90.0.5 it also 
> seems to be quite stable, except for when one certian driver is used 
> (basically an mpeg decoder driver).  Under certian conditions the system 
> seems to "freeze" (no messages printed anywhere and only a hard reset 
> will recover).
> 
> Yeah that is a good bug report...
> 
> But my main question is this:  Have other people experienced 
> miscompilation (ie bad code generation) with gcc 3.3.1?
> 
> One thing I am aware of is that if -fno-common is not used, bad code is 
> generated for accessing some large structures.  But I we use -fno-common 
> for all compilation.
> 
> I am trying to figrue out if I should be looking more at bugs in the 
> driver, or if I should give up on gcc 3.3.1 and be done with it.
> 
> Thanks in advance for any insight.

We haven't had problems here.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
