Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2005 06:15:37 +0100 (BST)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:24477 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225214AbVFJFPU>; Fri, 10 Jun 2005 06:15:20 +0100
Received: from [192.168.1.4] (pcp0011842295pcs.waldrf01.md.comcast.net[69.251.97.45])
          by comcast.net (sccrmhc12) with ESMTP
          id <20050610051512012000ute6e>; Fri, 10 Jun 2005 05:15:13 +0000
Message-ID: <42A922A3.9020304@gentoo.org>
Date:	Fri, 10 Jun 2005 01:18:27 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	gentoo-mips@gentoo.org, gentoo-dev@gentoo.org
CC:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Gentoo/MIPS SGI LiveCD RC4 (a.k.a., Round 2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8063
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


Alright ladies and germs^Wgentlemen, here we go, round #2 of the Mips LiveCD 
attempt.  This time, it works a heck of a lot better than before.

Most of theory behind this CD is made possible by Stanislaw Skowronek and his 
rather revolutionary new bootloader, ARCLoad.  Coming soon to a portage tree 
near you!

See the README file at the top level of the livecd directory for a far more 
thorough description of how it works, how it boots, and how it's more or less 
put together.  the cdboort-ip* files are example sof how the CD boots on my 
available systems.  Your's should more or less closely follow what's shown there.

Please report bugs, glitches, feedback, suggestions for improvementm etc, to Bug 
#95631 at http://bugs.gentoo.org

All that said, you can find everything here:
http://dev.gentoo.org/~kumba/mips/releases/livecd-rc4/

Tools, mainly just the miniroot (embedded into the kernel) and the CD "real 
root" can be found in the tools/ subfolder.  Other bits and pieces used to make 
this CD Image will probably appear there over time as well.


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
