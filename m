Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2003 09:50:35 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@3ffe:8260:2028:fffe::1)) by linux-mips.org
	id <S8225202AbTDOIue>; Tue, 15 Apr 2003 09:50:34 +0100
Date: Tue, 15 Apr 2003 09:50:34 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: Kumba <kumba@gentoo.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Oddities with CVS Kernels, Memory on Indigo2
Message-ID: <20030415095034.A29593@ftp.linux-mips.org>
References: <3E98F206.5050206@gentoo.org> <20030414140717.GA805@simek> <3E9BC44B.8080708@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E9BC44B.8080708@gentoo.org>; from kumba@gentoo.org on Tue, Apr 15, 2003 at 04:35:23AM -0400
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 15, 2003 at 04:35:23AM -0400, Kumba wrote:
> 	A question with the CVS Kernel.  Are there any known issues as to the 
> specific toolchain used to build it?  Currently I'm using GCC 3.2.2 + 
> Glibc 2.3.2 + Binutils 2.13.90.0.16.  I tried a CVS updateshortly after 
> testing this kernel, and it still doesn't boot, so either my timing is 
> really bad, or I'm using a toolchain with known issues.  I have noticed 
> the toolchain does not support -mcpu in .18 of binutils, and I 
> originally thought this was only going to be a GCC change in 3.3, but my 
> guess if it's the same in .18/.20, and as such I'll need to use the 
> instructions posted about a month about to use -mabi/-march?

silly question: you specified -r linux_2_4 when checkouting kernel, didn't
you? otherwise you are trying to boot 2.5.47, which has broken serial console
support.

anyway, toolchains i'm using to build 32-bit kernel:
$ mips-linux-gcc -v
Reading specs from /home/ladis/mips-tools/lib/gcc-lib/mips-linux/3.2/specs
Configured with: ../gcc-3.2/configure --prefix=/home/ladis/mips-tools --disable-shared --with-gnu-as --enable-languages=c --disable-nls --with-newlib --enable-checking=no --disable-threads --with-headers=/home/ladis/src/linux/include --target=mips-linux
Thread model: single
gcc version 3.2
$ mips-linux-ld -v
GNU ld version 2.13

64-bit kernel (egcs is patched with egcs-1.1.2.diff.gz from linux-mips.org ftp):
$ mips64-linux-gcc -v
Reading specs from /home/ladis/mips-tools/lib/gcc-lib/mips64-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)
$ mips64-linux-ld -v
GNU ld version 2.13

	ladis
