Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jan 2005 01:59:10 +0000 (GMT)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:50834 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225558AbVAOB7F>; Sat, 15 Jan 2005 01:59:05 +0000
Received: from [192.168.1.4] (pcp05077810pcs.waldrf01.md.comcast.net[68.54.246.193])
          by comcast.net (rwcrmhc13) with ESMTP
          id <2005011501585801500d6264e>; Sat, 15 Jan 2005 01:58:59 +0000
Message-ID: <41E87A18.8090807@gentoo.org>
Date: Fri, 14 Jan 2005 21:04:08 -0500
From: Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: initrd support.
References: <20050114091715.47318.qmail@web25107.mail.ukl.yahoo.com> <20050114154147.GM31149@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20050114154147.GM31149@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> 
> Actually, there are three:
> - the generic initramfs method for compiled in initrds

Is there any docs for this floating around outside of the blurb on the LMO wiki?

Doing a few tests with this, I was unable to get a kernel to see the ramdisk. 
  Despite there being an initramfs built into the kernel, there were no 
"RAMDISK: Compressed ramdisk found at block 0" messages, or no "checking if 
image is initramfs...it isn't (no cpio magic); looks like an initrd" messages 
that I've commonly seen with built-in ramdisks.

I figure in the end, either the problem is PEBKAC, invalid kernel command line 
params (root=/dev/ram0?), or broken code.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: small 
hands do them because they must, while the eyes of the great are elsewhere." 
--Elrond
