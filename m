Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Sep 2002 21:15:58 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:25866 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122977AbSICTP5>;
	Tue, 3 Sep 2002 21:15:57 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17mK5R-0000Qr-00; Tue, 03 Sep 2002 15:15:45 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17mJ9E-0007aL-00; Tue, 03 Sep 2002 15:15:36 -0400
Date: Tue, 3 Sep 2002 15:15:36 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jay Carlson <nop@nop.com>
Cc: linux-mips@linux-mips.org
Subject: Re: soft-float defines in mips-linux gcc config
Message-ID: <20020903191536.GA28999@nevyn.them.org>
References: <648A6FF8-BF38-11D6-B21F-0030658AB11E@nop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648A6FF8-BF38-11D6-B21F-0030658AB11E@nop.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 69
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 03, 2002 at 08:26:37AM -0400, Jay Carlson wrote:
> Right now there is a small bug in how mips-linux configures gcc for 
> softfloat.
> 
> In gcc/config/mips/t-linux, we set up libgcc to include the soft 
> floating point code, using the GNU names, like __addsi3.  But because 
> mips/linux.h includes mips/ecoff.h, gcc produces calls to the GOFAST 
> style names (like dpmul, very namespace-contaminating.)
> 
> mips/netbsd.h cleans up after mips/elf.h by doing:
> 
> #undef US_SOFTWARE_GOFAST
> #undef INIT_SUBTARGET_OPTABS
> #define INIT_SUBTARGET_OPTABS
> 
> which would fix the problem for mips/linux.h as well.

When commenting on GCC issues, please say which version you're talking
about - I'm pretty sure this is fixed in 3.2, and I know you aren't
talking about HEAD, since HEAD hasn't built right on mips-linux in a
month (Eric will fix this in a bit).

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
