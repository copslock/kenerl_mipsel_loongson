Received:  by oss.sgi.com id <S553673AbQJSL3N>;
	Thu, 19 Oct 2000 04:29:13 -0700
Received: from gandalf1.physik.uni-konstanz.de ([134.34.144.69]:46347 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553659AbQJSL2t>; Thu, 19 Oct 2000 04:28:49 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 13mDsM-0004rJ-00; Thu, 19 Oct 2000 13:28:46 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13mDsM-0007Ma-00; Thu, 19 Oct 2000 13:28:46 +0200
Date:   Thu, 19 Oct 2000 13:28:45 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Guido Guenther <guido.guenther@gmx.net>, ian@ichilton.co.uk,
        linux-mips@oss.sgi.com
Subject: Re: CVS GCC Problem
Message-ID: <20001019132845.A27629@bilbo.physik.uni-konstanz.de>
References: <20001014125855.A28429@woody.ichilton.co.uk> <20001014211850.A2774@bilbo.physik.uni-konstanz.de> <20001016030053.G15377@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001016030053.G15377@bacchus.dhis.org>; from ralf@oss.sgi.com on Mon, Oct 16, 2000 at 03:00:53AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Oct 16, 2000 at 03:00:53AM +0200, Ralf Baechle wrote:
> On Sat, Oct 14, 2000 at 09:18:50PM +0200, Guido Guenther wrote:
> 
> > On Sat, Oct 14, 2000 at 12:58:55PM +0100, Ian Chilton wrote:
> > > /crossdev/mips-linux/bin/ld: cannot open crti.o: No such file or directory
> > I see the same thing here. gcc from cvs 000925 seems to be o.k. 
> 
> The file crti.o should be in /crossdev/mips-linux/lib/crti.o.  Is it actually
> there?  Can you checkout where the x-compiler is actually searching
> for those files?
It's not there, it seems like binutils(cvs 001013 + rel32 patch) 
don't build/install it. xgcc searches in:

.../crossdev/src/gcc/egcs-001018/build/gcc/ 
.../crossdev/src/gcc/egcs-001018/build/mips-linux/newlib/ 
.../crossdev/src/gcc/egcs-001018/build/mips-linux/newlib/targ-include 
.../crossdev/src/gcc/egcs-001018/newlib/libc/include 
.../crossdev/mips-linux-2.2/mips-linux/bin/ 
.../crossdev/mips-linux-2.2/mips-linux/lib/ 
.../crossdev/mips-linux-2.2/mips-linux/include 

Regards,
 -- Guido
