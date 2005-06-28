Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 05:57:17 +0100 (BST)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:28138 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8226018AbVF1E45>; Tue, 28 Jun 2005 05:56:57 +0100
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (sccrmhc12) with ESMTP
          id <2005062804561601200hd8sue>; Tue, 28 Jun 2005 04:56:21 +0000
Message-ID: <42C0D94F.3030809@gentoo.org>
Date:	Tue, 28 Jun 2005 00:59:59 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	gcc-patches@gcc.gnu.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: -march=r10000 Support for MIPS Targets (Old 3.4.x Patch; requires
 porting, assistance requested)
Content-Type: multipart/mixed;
 boundary="------------030705090300090608010901"
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------030705090300090608010901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I've poked around on this patch to gcc-3.4.x from time-to-time (When I get the 
time to do so), and haven't really gotten anywhere.  It's a patch I 
forward-ported some time ago from gcc-3.0 up to gcc-3.4.2/3.4.3.  It's worked 
fine in gcc-3.4.3 on MIPS userlands under IP28, IP30, and IP27 systems for 
several months now (probably closer to a year at this point).  Based on feedback 
I've gotten from Eric Christopher back in Aug '04 (Hi Eric) the patch itself 
looks sane, and with me and multiple users running it, it's not had any reported 
problems thus far, so I consider it stable enough to try and submit it in its 
current 3.4.x form to this list.

The downside is, with everyone moving to 4.x series now, 3.4.x isn't going to be 
around much longer.  I'm not much of a compiler guru, so with the massive 
changes between 3.4.x and 4.x's mips.md format (and deprecating 
define_function_insn and splitting of mips.md to cpu-specific md's), most of my 
ability to analyze and port changes is vastly reduced (since I usually look for 
similarities in code and adjust accordingly).

If at all possible I'd like to see it make it into gcc at some point in time, 
not necessarily gcc-4.1, as the patch as it currently stands needs someone to do 
the work of porting it to fit into 4.x, but I figure if I keep holding onto it, 
it'll be gcc-5.x before this thing ever gets anywheres.

So if anyone wants to take a stab at porting it, I'd be interested to see the 
results (so I can compare it to 3.4.x and maybe get an idea of how the changes 
really port over to 4.x).

For historical reference, the original patch was submitted for gcc-3.0 back in 
July 2001, and can be seen here:
http://gcc.gnu.org/ml/gcc-patches/2001-07/msg01161.html



--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond

--------------030705090300090608010901
Content-Type: application/x-gzip;
 name="gcc-3.4.x-mips-add-march-r10k.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="gcc-3.4.x-mips-add-march-r10k.patch.gz"

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
--------------030705090300090608010901--
