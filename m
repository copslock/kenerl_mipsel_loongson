Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 01:29:18 +0000 (GMT)
Received: from lennier.cc.vt.edu ([IPv6:::ffff:198.82.162.213]:19858 "EHLO
	lennier.cc.vt.edu") by linux-mips.org with ESMTP
	id <S8225002AbUKXB3O>; Wed, 24 Nov 2004 01:29:14 +0000
Received: from vivi.cc.vt.edu (IDENT:mirapoint@evil-vivi.cc.vt.edu [10.1.1.12])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id iAO1QqJM007174;
	Tue, 23 Nov 2004 20:26:53 -0500
Received: from [192.168.1.2] (68-232-97-125.chvlva.adelphia.net [68.232.97.125])
	by vivi.cc.vt.edu (MOS 3.4.8-GR)
	with ESMTP id CBN05516 (AUTH spbecker);
	Tue, 23 Nov 2004 20:29:02 -0500 (EST)
Message-ID: <41A3E3E7.7020701@gentoo.org>
Date: Tue, 23 Nov 2004 20:29:11 -0500
From: "Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: TheNop <TheNop@gmx.net>
CC: linux-mips@linux-mips.org
Subject: Re: Cross tool chain based on gcc-3.4.x
References: <41A3CE25.7040406@gmx.net>
In-Reply-To: <41A3CE25.7040406@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6428
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

TheNop wrote:
> Hello,
> 
> I try to get a cross compiler based on
> gcc-3.4.2
> glibc-2.3.2
> binutils-2.15
> working;  without success.
> 
> Is anyone using a cross compiler base on  gcc-3.4.x for a mips big 
> endian target?
> 
> Best regarts
> TheNop
> 

I've got a very recent i686->mips-unknown-linux-gnu cross-toolchain 
available at:http://dev.gentoo.org/~geoman/mips-glibc-crosstools.tar.bz2 
if you are too frustrated with building your own.

It includes gcc-3.4.3, glibc-2.3.4 (20041102), and binutils 2.15.91.0.2.

Steve
