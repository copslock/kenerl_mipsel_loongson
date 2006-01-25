Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jan 2006 01:03:58 +0000 (GMT)
Received: from sccrmhc14.comcast.net ([204.127.202.59]:23990 "EHLO
	sccrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133576AbWAYBDl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 25 Jan 2006 01:03:41 +0000
Received: from [192.168.1.4] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (sccrmhc14) with ESMTP
          id <2006012501075601400efnpoe>; Wed, 25 Jan 2006 01:07:56 +0000
Message-ID: <43D6CF69.1050204@gentoo.org>
Date:	Tue, 24 Jan 2006 20:07:53 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: check of endianess?
References: <20060124233846.GA10784@deprecation.cyrius.com>
In-Reply-To: <20060124233846.GA10784@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> I just compiled a kernel for SGI IP32 and got some very interesting
> results when booting it: 0 MHz CPU, no RAM... Later I found out that
> I made a copy&paste typo in my build script and used mipsel-linux-cc
> to compile.  Shouldn't this be detected earlier on?

That actually booted? I thought SGIs were hardwired specifically for BE, and the 
prom should've rejected an LE kernel (Granted, there is a jumper on the IP32 
board labelled "Big Endian", so it's anyone's guess).


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
