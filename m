Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 05:48:28 +0100 (BST)
Received: from rwcrmhc11.comcast.net ([IPv6:::ffff:204.127.198.35]:12794 "EHLO
	rwcrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8226113AbVGAEsL>; Fri, 1 Jul 2005 05:48:11 +0100
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005070104475401300rngcie>; Fri, 1 Jul 2005 04:47:54 +0000
Message-ID: <42C4CBDF.1030609@gentoo.org>
Date:	Fri, 01 Jul 2005 00:51:43 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: -march=r10000 Support for MIPS Targets (Old 3.4.x Patch; requires
 porting, assistance requested)
References: <42C0D94F.3030809@gentoo.org> <200506281007.12754.stevenb@suse.de>
In-Reply-To: <200506281007.12754.stevenb@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Steven Bosscher wrote:
> Looks like all the arith->shift attribute changes from the patch you
> posted are already in mainline, so all you really need to add r10000
> support is a pipeline model.  All the MIPSen were converted from the
> old pipeline description (i.e. "define_function_unit") to the new one
> (i.e. "define_insn_reservation" and friends) in a big patch posted
> last year: http://gcc.gnu.org/ml/gcc-patches/2004-07/msg01065.html.
> Maybe you can find in the trhead surrounding that message some ideas
> on how to convert your r10000 pipeline model.
> 
> HTH,
> 
> Gr.
> Steven

Yeah, I've poked around at how the new pipeline descriptions work, but my 
relative lack of understanding in regards to compiler internals makes it 
difficult to understand some terms and especially what the numbers in portions 
of define_function_unit do, and as such, I have no idea where to place them in 
the newer define_insn_reservation.  Not really having the free time to 
constantly rebuild gcc to test to see if numbers were placed appropriately, I've 
looked for other means to get this patch converted.

I did find a script on the gcc-patches ML that was a very early auto-converter 
for old gcc-3.4.x define_function_unit to gcc-4 define_insn_reservation, but it 
was written in gawk, and for some reason, I couldn't coax my copy of gawk to 
execute it correctly.  If there's a straight-forward guide to converting, I'd be 
interested in reading it (assuming it doesn't have a pre-requisite of deep gcc 
internals knowledge).


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
