Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Dec 2002 22:53:26 +0000 (GMT)
Received: from p508B5DCD.dip.t-dialin.net ([IPv6:::ffff:80.139.93.205]:43399
	"EHLO p508B5DCD.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225382AbSLRWx0>; Wed, 18 Dec 2002 22:53:26 +0000
Received: from sccrmhc03.attbi.com ([IPv6:::ffff:204.127.202.63]:10191 "EHLO
	sccrmhc03.attbi.com") by ralf.linux-mips.org with ESMTP
	id <S868141AbSLRWxY>; Wed, 18 Dec 2002 23:53:24 +0100
Received: from lucon.org (12-234-88-146.client.attbi.com[12.234.88.146])
          by sccrmhc03.attbi.com (sccrmhc03) with ESMTP
          id <20021218225235003006m0eue>; Wed, 18 Dec 2002 22:52:35 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id BCBB72C69A; Wed, 18 Dec 2002 14:52:34 -0800 (PST)
Date: Wed, 18 Dec 2002 14:52:34 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: Chien-Lung Wu <cwu@deltartp.com>
Cc: 'Brad Barrett' <brad@patton.com>, linux-mips@linux-mips.org
Subject: Re: Help in cross-compiler--gcc3.2-7.1 error
Message-ID: <20021218145234.B3726@lucon.org>
References: <A4E787A2467EF849B00585F14C9005590689B5@dprn03.deltartp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <A4E787A2467EF849B00585F14C9005590689B5@dprn03.deltartp.com>; from cwu@deltartp.com on Wed, Dec 18, 2002 at 05:21:39PM -0500
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 18, 2002 at 05:21:39PM -0500, Chien-Lung Wu wrote:
> Hi, Brad:
> 
> Thanks for your information.
> I download:
> 	binutils			v2.13.90.0.10 (H.J. Lu)
> 	GCC				v3.2-7.1 (H.J. Lu)
> 	glibc				v2.2.5
> 	glibc-linuxthreads	v2.2.5
> 
> and follow your build note to build a big-endian mips cross-compiler.
> 

The cross compile toolchain, toolchain-20021126-1.src.rpm, I provided
is based on gcc 2.96. Although I do have one based gcc 3.2:

# /export/tools-3.2-redhat-8/bin/mips-linux-gcc
Reading specs from /export/tools-3.2-redhat-8/lib/gcc-lib/mips-linux/3.2.1/specs
Configured with: /export/linux/src/tools-3.2-redhat-8/tools/configure --disable-multilib --enable-clocale=gnu --with-system-zlib --target=mips-linux --prefix=/export/tools-3.2-redhat-8 --with-local-prefix=/export/tools-3.2-redhat-8 --enable-threads=posix --enable-haifa --enable-shared --disable-checking
Thread model: posix
gcc version 3.2.1 20021125 (Red Hat Linux 8.0 3.2.1-1)

it is the part of my RedHat 8.x port, which hasn't been finished yet.


H.J.
