Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Aug 2004 18:50:05 +0100 (BST)
Received: from avtrex.com ([IPv6:::ffff:216.102.217.178]:5704 "EHLO avtrex.com")
	by linux-mips.org with ESMTP id <S8225216AbUHLRuB>;
	Thu, 12 Aug 2004 18:50:01 +0100
Received: from avtrex.com ([192.168.0.111] RDNS failed) by avtrex.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 12 Aug 2004 10:47:32 -0700
Message-ID: <411BAD50.6070004@avtrex.com>
Date: Thu, 12 Aug 2004 10:48:00 -0700
From: David Daney <ddaney@avtrex.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manish Lohani <mlohani@gmail.com>
CC: linux-mips@linux-mips.org
Subject: Re: Busybox v0.60.2 insmod gives segmentation fault without any messages
 when trying to load a loadable module
References: <b318a0150408121030389aa24c@mail.gmail.com>
In-Reply-To: <b318a0150408121030389aa24c@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Aug 2004 17:47:32.0625 (UTC) FILETIME=[71D0F010:01C48094]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Manish Lohani wrote:
> I have a driver loadable module which i am compiling with the same gcc
> flags as used to compile a kernel for a MIPS R5432 based NEC board.
> 
> On the development machine, to compile files driver1.c and driver2.c:
> $ mips_fp_le-gcc -fomit-frame-pointer -fno-strict-aliasing -G 0
> -mno-abicalls -fno-pic -pipe -mtune=r5000 -mlong-calls -mips2 -Wall -c
> driver1.c
> 
> $mips_fp_le-ld -r -o driver --printmap --cref driver1.o driver2.o
> 
> mips_fp_le-gcc (GCC) version 3.3.1
> mips_fp_le-ld (GNU ld) version 2.14
> 
> I have Busybox v0.60.2 on the target.
> 
> On the target:
> # insmod ./driver
> Using driver
> Segmentation fault
> #
> 
> Does anybody have any suggestions as to what could be wrong?
> 

BusyBox0.60.x's insmod does not work with gcc-3.3 and above.

I use a patched version of the real insmod:

# insmod --version
insmod version 2.4.25

I forget where I put the patch, but the insmod author told me that the
patches were in a later version.  So if I were you, I would use version
2.4.26 or higher.

David Daney.
