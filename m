Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2004 07:59:44 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:61593
	"EHLO relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8225848AbUFBG7k>; Wed, 2 Jun 2004 07:59:40 +0100
Received: from wh85.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP
	id 6177E2F341; Wed,  2 Jun 2004 08:59:33 +0200 (CEST)
From: Max Zaitsev <maksik@gmx.co.uk>
Organization: Mutella Dev co.
To: kumba@gentoo.org
Subject: Re: help needed : cannot install linux on SGI O2 R5000
Date: Wed, 2 Jun 2004 08:59:36 +0200
User-Agent: KMail/1.5.3
References: <200405281210.05259.maksik@gmx.co.uk> <40B7ABCE.3070809@gentoo.org>
In-Reply-To: <40B7ABCE.3070809@gentoo.org>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406020859.36095.maksik@gmx.co.uk>
Return-Path: <maksik@gmx.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksik@gmx.co.uk
Precedence: bulk
X-list: linux-mips

Hi Kumba,

thanks for your tips. Actually, I've got some progress (after I've realised 
why your kernels did not work) and found that the kernel from Glaurung 
(http://www.linux-mips.org/~glaurung/) has a framebuffer support and accepts 
the netboot root (initrd image) from your distribution. So I've proceeded 
building stage1 system, but got following errors while compiling GCC:
-----
Bootstrap comparison failure!
insn-recog.o differs
make[1]: *** [compare-lean] Error 1
make[1]: Leaving directory `/var/tmp/portage/gcc-3.3.3-r3/work/build/gcc'
make: *** [bootstrap-lean] Error 2

!!! ERROR: sys-devel/gcc-3.3.3-r3 failed.
!!! Function src_compile, Line 533, Exitcode 2
!!! (no error message)

gentoo-mips-20040426 portage #
-----
I'm not sure if this is the correct list to *complain* though. I'm also 
wondering if this can occur due to the version of kernel that I'm using.

Another question is more related to the gentoo philosophy: is it possible to 
make bootstrap script to only finish things that have not been finished, 
without repeating the whole thing before?

Thanks for your help,
Max
