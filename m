Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 15:01:35 +0100 (BST)
Received: from sccrmhc15.comcast.net ([63.240.77.85]:52124 "EHLO
	sccrmhc15.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021501AbXGQOBb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jul 2007 15:01:31 +0100
Received: from [192.168.1.4] (c-69-140-18-238.hsd1.md.comcast.net[69.140.18.238])
          by comcast.net (sccrmhc15) with ESMTP
          id <20070717140124015005g03se>; Tue, 17 Jul 2007 14:01:24 +0000
Message-ID: <469CCBB4.60005@gentoo.org>
Date:	Tue, 17 Jul 2007 10:01:24 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.4 (Windows/20070604)
MIME-Version: 1.0
To:	Andrew Sharp <andy.sharp@onstor.com>
CC:	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
References: <4687DCE2.8070302@gentoo.org>	<468825BE.6090001@gmx.net>	<50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu>	<20070704152729.GA2925@linux-mips.org>	<20070704192208.GA7873@linux-mips.org>	<469B5C2E.5080905@niisi.msk.ru>	<20070716123343.GA13439@linux-mips.org> <20070716103823.3fe9aef4@ripper.onstor.net>
In-Reply-To: <20070716103823.3fe9aef4@ripper.onstor.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Andrew Sharp wrote:
> 
> I hungrily await said patch, as I believe this is a problem on RM9000
> processors as well.  I'm seeing "random" SIGILLs on user processes,
> particularly large complicated shell scripts like configure on an RM9k
> platform.

This was more or less exactly what I was seeing on an O2 RM7000 setup until the 
fix for errata #28 was put in (which should already be enabled for RM9000 systems).

Check include/asm-mips/war.h and make sure your machine is included in the list 
that define ICACHE_REFILLS_WORKAROUND_WAR.  If not, add it and test; and fire 
off a patch.  Should fix that issue (especially if bash is the only userland 
process dying while complex g++ compiles behave fine)


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
