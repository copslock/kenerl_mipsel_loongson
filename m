Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2007 03:21:39 +0100 (BST)
Received: from alnrmhc11.comcast.net ([204.127.225.91]:56538 "EHLO
	alnrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021856AbXC3CVi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 30 Mar 2007 03:21:38 +0100
Received: from [192.168.1.4] (c-69-251-93-234.hsd1.md.comcast.net[69.251.93.234])
          by comcast.net (alnrmhc11) with ESMTP
          id <20070330022052b1100lum3ge>; Fri, 30 Mar 2007 02:20:53 +0000
Message-ID: <460C7404.2020209@gentoo.org>
Date:	Thu, 29 Mar 2007 22:20:52 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ths@networkno.de, ralf@linux-mips.org,
	Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH]: Remove CONFIG_BUILD_ELF64 entirely
References: <46086A90.7070402@gentoo.org>	<20070327.235310.128618679.anemo@mba.ocn.ne.jp>	<460A6CED.1070308@gentoo.org> <20070329.002453.18311528.anemo@mba.ocn.ne.jp>
In-Reply-To: <20070329.002453.18311528.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Wed, 28 Mar 2007 09:26:05 -0400, Kumba <kumba@gentoo.org> wrote:
>> Well, what's the need to use the move/lui/ld sequence over 
>> move/lui/daddui/dsll/daddui/dsll//ld anyways?  I'll have to warm the Indy up and 
>> try a 64bit kernel there I guess, to see if it exhibits similar issues with this 
>> segment of code.
> 
> Just an optimization.  For CKSEG0 symbol, a LUI instruction can fill
> high 32-bit by sign-extention.  Either code should work for CKSEG0
> kernel.

Well, thinking about it some more, can this stackframe change be segmented out 
of Frank's main patches, so we can get them into git, and spend time in 
2.6.21/2.6.22/2.6.23 chasing down what exactly is up with this specific asm 
sequence?

Of course, wiring in a quick check on !defined(CONFIG_SGI_IP32) would also work, 
but that's not proper to go kludging in specific machine checks in a generic 
file like stackframe, IMHO.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
