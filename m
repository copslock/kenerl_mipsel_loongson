Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2005 14:54:58 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:55337 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224929AbVBJOyi>;
	Thu, 10 Feb 2005 14:54:38 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1AEsaH20913;
	Thu, 10 Feb 2005 15:54:36 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1AEsac32205;
	Thu, 10 Feb 2005 15:54:36 +0100
Message-ID: <420B75AC.4080209@schenk.isar.de>
Date:	Thu, 10 Feb 2005 15:54:36 +0100
From:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
References: <41ED20E3.60309@schenk.isar.de> <20050204004028.GC22311@linux-mips.org> <42072264.6000001@schenk.isar.de> <20050208001742.GA15336@linux-mips.org> <42088CFA.6090605@schenk.isar.de> <20050209000640.GA10651@linux-mips.org> <4209C492.4050201@schenk.isar.de> <20050210134043.GA30792@linux-mips.org>
In-Reply-To: <20050210134043.GA30792@linux-mips.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Feb 09, 2005 at 09:06:42AM +0100, Rojhalat Ibrahim wrote:
> 
> 
>>Ok, thanks. If I can try anything that might help track down
>>the problem, please let me know.
> 
> 
> Try this patch which is meant to be used in combination with the previous
> patch.  It moves a test which determines if we actually need to perform a
> cacheflush to the right place.  That's a bug which is harmless on UP but
> a severe bug on SMP.
> 

I did a CVS update, which apparently includes this
patch, and I get this:

   LD      .tmp_vmlinux1
arch/mips/mm/built-in.o(.init.text+0x98): In function `fixrange_init':
: undefined reference to `__pud_offset'
make: *** [.tmp_vmlinux1] Error 1

What's __pud_offset?

Thanks
Rojhalat Ibrahim
