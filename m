Received:  by oss.sgi.com id <S554029AbQKHUHV>;
	Wed, 8 Nov 2000 12:07:21 -0800
Received: from mx.mips.com ([206.31.31.226]:52197 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553986AbQKHUHI>;
	Wed, 8 Nov 2000 12:07:08 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA25451;
	Wed, 8 Nov 2000 12:06:45 -0800 (PST)
Received: from lsf17.mips.com (lsf17 [192.168.10.205])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA00424;
	Wed, 8 Nov 2000 12:07:03 -0800 (PST)
Received: from mips.com (localhost [127.0.0.1])
	by lsf17.mips.com (8.9.3/8.9.0) with ESMTP id MAA16405;
	Wed, 8 Nov 2000 12:07:04 -0800 (PST)
Message-ID: <3A09B268.73303E91@mips.com>
Date:   Wed, 08 Nov 2000 12:07:04 -0800
From:   "Kevin D. Kissell" <kevink@mips.com>
Organization: MIPS Technologies Inc.
X-Mailer: Mozilla 4.61 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     Nicu Popovici <octavp@isratech.ro>, linux-mips@oss.sgi.com
Subject: Re: MIPS kernel!
References: <3A09753F.DB2457EE@isratech.ro> <004101c04969$b744b160$0323c0d8@Ulysses> <20001108151048.A13841@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Wed, Nov 08, 2000 at 10:53:14AM +0100, Kevin D. Kissell wrote:
> 
> > In general, at MIPS, we generally build native or semi-native
> > (mipsel on mipseb machines and vice versa).  In cross-builds
> > of other components, however, I have observed that problems
> > such as those you describe can result from include files
> > on the host platform being erroneously pulled in to the cross-build.
> > Cross-gcc and the makefiles have been known to be set up such
> > that, if the needed include file can be found neither in the explicitly
> > requested directories nor in the cross-compiler's default includes,
> > it will silently search the host /usr/include directories.
> 
> This is either a bug in the version that you're using, a wrongly installed
> compiled or simply wrong -I directives passed to the compiler.  

Obviously.  And my thought was that Nicu may well be being
bit by one or the other.

> The crosscompiler rpms as distributed on oss will only search:
> 
>  /usr/lib/gcc-lib/mips-linux/egcs-2.91.66/include
>  /usr/mips-linux/include
> 
> by default.  I just tried, egcs-1.1.2-2 also doesn't search silently in
> other directories.  So it's not a problem of gcc itself which leaves the
> makefiles.  If you find any instance of the wrong directories being
> searched, please tell me.  Or better, include a patch :-)

I saw an instance of this on the order of a year ago.  I don't
remember which compiler I was using, nor where I got it.  I have
no ability nor really much desire to try to reconstruct the
environment to reproduce the problem!

			Kevin K.
