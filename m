Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2003 14:54:15 +0100 (BST)
Received: from p508B52B7.dip.t-dialin.net ([IPv6:::ffff:80.139.82.183]:39303
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225208AbTDINyO>; Wed, 9 Apr 2003 14:54:14 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h39Ds0F30884;
	Wed, 9 Apr 2003 15:54:00 +0200
Date: Wed, 9 Apr 2003 15:54:00 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Madhavi <madhavis@sasken.com>
Cc: linux-mips@linux-mips.org
Subject: Re: cross-compiler for mips (r5432)
Message-ID: <20030409155400.A26124@linux-mips.org>
References: <Pine.LNX.4.33.0304091136220.1873-100000@pcz-madhavis.sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0304091136220.1873-100000@pcz-madhavis.sasken.com>; from madhavis@sasken.com on Wed, Apr 09, 2003 at 11:47:51AM +0530
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1958
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 09, 2003 at 11:47:51AM +0530, Madhavi wrote:

> I want to install a cross-compiler for MIPS(R5432 CPU) on an i686 host.
> Since R4000 is compatible with R5432, I am using "mips3" as the target.
> binutils-2.13 and I phase compilation of gcc-3.2 happened without any
> problems. But, glibc-2.2.5 is giving many compilation problems. This is
> how I configured glibc:
> 
> configure --build=i686-linux --host=mips3el-linux --enable-add-ons
> --prefix=/usr.
> 
> Could someone guide me on this or give me some pointers for installation?
> Is the target option "mips3" the right choice for R5432?

Never.  Use mipsel-linux for your box.

  Ralf
