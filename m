Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2004 20:12:18 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:49826 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8224954AbUAVUMR>;
	Thu, 22 Jan 2004 20:12:17 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1AjlBR-0006ar-Q8; Thu, 22 Jan 2004 15:12:09 -0500
Date: Thu, 22 Jan 2004 15:12:09 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Nathan Field <ndf@ghs.com>
Cc: Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Solving the cross-compiler issue (Was: Trouble compiling MIPS cross-compiler)
Message-ID: <20040122201209.GA11587@nevyn.them.org>
References: <400A1B5F.6010307@gentoo.org> <Pine.LNX.4.44.0401211633240.31973-101000@zcar.ghs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0401211633240.31973-101000@zcar.ghs.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 21, 2004 at 06:32:23PM -0800, Nathan Field wrote:
> This email is a bit long so here's the short version:
> 	Building cross tools is basically impossible without knowledge 
> which isn't available on the www.linux-mips.org web site
> 	glibc seems to have obvious syntax errors and won't even compile
> 	The prebuilt tools referenced in the FAQ are so out of date 
> they're useless
> 	Even tools provided by various commercial Linux vendors are out of 
> date (at least what MontaVista lets us see in their preview kits)

Try a different preview kit.  I'm told that some of the MIPS preview
kits were updated for 3.0 and some weren't, and that's all I know about
that.

> 	This could all be solved if someone wrote a script to do all the 
> work which contains all the logic necessary to get a known set of tools to 
> build
> 
> I've written a script which will do all the work, but because there are 

You _HAVE_ looked at crosstool, right?  Which does all of this, and
does work?

> sscanf (s, format)
>      const char *s;
>      const char *format;
> 
> Doesn't match the function, and it should be:
> 
> sscanf (const char *s, const char *format, ...)
> 
> Does no one even bother to test to see if these things compile before they 
> are released? I've had similar syntax error type problems when building 
> several older (2.2.x) versions of glibc for PPC.

Come on, think.  Glibc 2.3.2 was released before GCC 3.3.  It built at
the time; if you use GCC 3.2 that will compile.  If you want to use GCC
3.3, then use a newer CVS snapshot of glibc.  Which I recommend, but is
still not for the faint of heart.  If you're just trying to build a
kernel as you said later, why are you building glibc anyway?

> Anyway, after I fixed that I now get a link failure:
> 
> /space1/ndf/linux/mips/tools/glibc-build/elf/ld.so.1: undefined reference 
> to `elf_machine_rela.7'

Google will be delighted to explain the controversy of
-finline-limit-10000 to you.  Or use crosstool :)

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
