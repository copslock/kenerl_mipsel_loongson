Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2003 02:43:59 +0100 (BST)
Received: from dsl093-172-017.pit1.dsl.speakeasy.net ([IPv6:::ffff:66.93.172.17]:24203
	"EHLO nevyn.them.org") by linux-mips.org with ESMTP
	id <S8224802AbTGPBn5>; Wed, 16 Jul 2003 02:43:57 +0100
Received: from drow by nevyn.them.org with local (Exim 3.36 #1 (Debian))
	id 19cbKX-0003Ey-00; Tue, 15 Jul 2003 21:43:41 -0400
Date: Tue, 15 Jul 2003 21:43:41 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: David Daney <ddaney@avtrex.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Help wanted WRT multigot...
Message-ID: <20030716014340.GA12436@nevyn.them.org>
References: <3F149B49.9010303@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F149B49.9010303@avtrex.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 15, 2003 at 05:24:41PM -0700, David Daney wrote:
> We are using gcj/gcc-3.3 to run java programs on a mipsel-linux 
> platform, and were able to work around GOT overflow error by hacking the 
>  build to pass -xgot to gas.
> 
> After searching the web, it appeared that using binutils 2.14 or 
> binutils-2.14.90.0.4 might enable multigot objects.  However it not 
> clear to me if there is multigot support in these versions of binutils, 
> or how to turn it on if there is.
> 
> Is there a multigot assembler/linker that can be used with gcc-3.3?
> 
> Or are we stuck with -xgot?

If you just try using 2.14, it should work.  No extra flags, no
anything special.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
