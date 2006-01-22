Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Jan 2006 13:09:38 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:36868 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133437AbWAVNJR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 22 Jan 2006 13:09:17 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3FFCB64D3D; Sun, 22 Jan 2006 13:13:22 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 5974C8545; Sun, 22 Jan 2006 13:11:54 +0000 (GMT)
Date:	Sun, 22 Jan 2006 13:11:53 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Subject: Re: DECstation compile fails: opcode not supported (eret)
Message-ID: <20060122131153.GB5543@deprecation.cyrius.com>
References: <20060121195956.GA15498@deprecation.cyrius.com> <43D2F4D9.6010406@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D2F4D9.6010406@gentoo.org>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Kumba <kumba@gentoo.org> [2006-01-21 21:58]:
> >  AS      arch/mips/kernel/genex.o
> >arch/mips/kernel/genex.S: Assembler messages:
> >arch/mips/kernel/genex.S:240: Error: opcode not supported on this 
> >processor: mips1 (mips1) `eret'
> >make[1]: *** [arch/mips/kernel/genex.o] Error 1
> >make: *** [arch/mips/kernel] Error 2
> >
> >Toolchain used:
> >gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)
> >binutils: 2.16.91 20051117 Debian GNU/Linux
> 
> I think this broke it:

That's right, reverting Ralf's commit
  Remove stray .set mips3 resulting in 64-bit instruction in 32-bit kernels.
makes it compile.

-- 
Martin Michlmayr
http://www.cyrius.com/
