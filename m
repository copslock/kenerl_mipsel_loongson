Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Dec 2004 12:25:52 +0000 (GMT)
Received: from sccrmhc11.comcast.net ([IPv6:::ffff:204.127.202.55]:24461 "EHLO
	sccrmhc11.comcast.net") by linux-mips.org with ESMTP
	id <S8225203AbULSMZr>; Sun, 19 Dec 2004 12:25:47 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (sccrmhc11) with ESMTP
          id <2004121912253001100atp6me>; Sun, 19 Dec 2004 12:25:30 +0000
Message-ID: <41C57431.8000900@gentoo.org>
Date: Sun, 19 Dec 2004 07:29:37 -0500
From: Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Frederic TEMPORELLI <frederic.temporelli@laposte.net>
Subject: Re: SGI O2 - RAM 320MBytes - linux reports 245MBytes  (/proc/meminfo)
References: <20041219023850Z8225215-1340+5@linux-mips.org> <41C556C3.401@laposte.net>
In-Reply-To: <41C556C3.401@laposte.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Frederic TEMPORELLI wrote:
> Hello,
> 
> no way to see (use ?) all available RAM (320MB) on SGI O2 with 
> 2.6.10-rc3 (latest cvs)
> 
> Hardware => SGI O2 with 320MBytes in this way:
> dimm 1: 32MBytes - dimm2: 32MBytes
> dimm 3: 32MBytes - dimm4: 32MBytes
> dimm 5: 32MBytes - dimm6: 32MBytes
> dimm 7: 64MBytes - dimm8: 64MBytes
> 
> Firmware => "hinv" is reporting 320MBytes (OK, match hardware)
> 
> Linux Kernel (32 and 64 bits) => /proc/meminfo is reporting a MemTotal 
> of 245436KB
> "top" command is reporting same wrong value (more than 64MB missing)
> 
> where can I look for in sources to report/use all available RAM ?
> can you help me ?

O2, like Indy and I2/R4x00, are limited to 256MB max RAM currently.  To see 
any further, O2 needs HIGHMEM support, which last I checked, doesn't exist.

Patches welcome :)


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
