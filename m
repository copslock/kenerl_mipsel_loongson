Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Jul 2004 09:42:24 +0100 (BST)
Received: from skl1.ukl.uni-freiburg.de ([IPv6:::ffff:193.196.199.1]:37846
	"EHLO relay1.uniklinik-freiburg.de") by linux-mips.org with ESMTP
	id <S8225215AbUGNImT>; Wed, 14 Jul 2004 09:42:19 +0100
Received: from ktl77.ukl.uni-freiburg.de (ktl77.ukl.uni-freiburg.de [193.196.226.77])
	by relay1.uniklinik-freiburg.de (Email) with ESMTP
	id 741422F3FB; Wed, 14 Jul 2004 10:42:14 +0200 (CEST)
From: Max Zaitsev <maksik@gmx.co.uk>
Organization: Mutella Dev co.
To: linux-mips@linux-mips.org
Subject: is there *any* way to boot IP32 from hard drive ?
Date: Wed, 14 Jul 2004 10:42:18 +0200
User-Agent: KMail/1.6.2
Cc: Guido Guenther <agx@sigxcpu.org>, Ilya Volynets <ilya@theIlya.com>,
	Kumba <kumba@gentoo.org>, Jan Seidel <tuxus@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407141042.18505.maksik@gmx.co.uk>
Return-Path: <maksik@gmx.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksik@gmx.co.uk
Precedence: bulk
X-list: linux-mips

Hi List,

I've asked the very same question here before, but got no answer. Probably, 
the experts, who might have known the answer just overlooked it... (sorry 
guys for addressing some of you directly, but I'm really in trouble). The 
thing is that I desperately need to get the O2 to boot from its HDD, it's all 
installed and supposed to be used as a standalone box.

I'm using kernel 2.6.6 with minimal patches from Ilya and as to be expected it 
does not boot from the volume header. Arcboot seems to be the way to go, but 
I'm not able to compile the bootable arcboot.IP32 image. When I've tried to 
self-compile it with gcc 3.3.3 the image size was over 500K and it did not do 
anything at all. Self-compilation with gcc 3.4 fails during linking. In a 
mean time I've extracted the binary arcboot.IP32 image from the debian 
package and this one at least does something: it loads the kernel into memory 
(goes very slow), recognises a 64-bit executable and even starts it... But 
immediately after the kernel crashes. Any idea why it could be happening? In 
some other thread, Ilya have mentioned, that he has a "highly hacked" version 
of arcboot. Is it available anywhere? Or are other other solutions?

Thanks in advance,
Max
