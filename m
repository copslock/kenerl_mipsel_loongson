Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2003 06:12:26 +0100 (BST)
Received: from web41205.mail.yahoo.com ([IPv6:::ffff:66.218.93.38]:28777 "HELO
	web41205.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225244AbTFDFMW>; Wed, 4 Jun 2003 06:12:22 +0100
Message-ID: <20030604051214.7695.qmail@web41205.mail.yahoo.com>
Received: from [64.132.226.151] by web41205.mail.yahoo.com via HTTP; Wed, 04 Jun 2003 15:12:14 EST
Date: Wed, 4 Jun 2003 15:12:14 +1000 (EST)
From: =?iso-8859-1?q?fpga=20dsp?= <fpga_dsp@yahoo.com.au>
Subject: toolchains compiling, issue with i_am_not_a_leaf reference
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <fpga_dsp@yahoo.com.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2512
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fpga_dsp@yahoo.com.au
Precedence: bulk
X-list: linux-mips


Hi all,

I got trouble with compiling mipsel gnu toolchains.
Basicly, i downloaded all the required source code to
build a cross compiling toolchains for MIPS

binutils-2.13.90.0.10.tar.gz
gcc-3.2.tar.gz
glibc-2.2.5.tar.gz
glibc-linuxthreads-2.2.5.tar.gz
glibc-2.2.5-mips-build-gmon.diff

the building process went fine, i can compile kernel
and sereral packages, However, when I compile zlib
package with the toolchain, it complaint that can not
reference to i_am_not_a_leaf. Do a search on runtime
library, there is no such thing but clearly, this
external variable is declared in glibc csu/initfini.c.
The mipsel-linux-gcc remove this dummy variable
somehow. Now, i compile glibc using sdelinux-mipsel
from MIPS site. This compiler keeps the variable
reference in the object file. So end up I have to use
glibc compiled by sdelinux and gnu-gcc from gnu, a
problem with this is mipsel-linux-strip can't strip
library linked by sdelinux linkder. 

Anyone got any ideas why?

Many thanks!



http://mobile.yahoo.com.au - Yahoo! Mobile
- Check & compose your email via SMS on your Telstra or Vodafone mobile.
