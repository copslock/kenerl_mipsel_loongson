Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2007 20:01:38 +0000 (GMT)
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:46537 "EHLO
	rwcrmhc11.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20039473AbXBRUBd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 18 Feb 2007 20:01:33 +0000
Received: from [192.168.1.4] (c-68-34-70-207.hsd1.md.comcast.net[68.34.70.207])
          by comcast.net (rwcrmhc11) with ESMTP
          id <20070218200049m11008dkple>; Sun, 18 Feb 2007 20:00:49 +0000
Message-ID: <45D8B070.7070405@gentoo.org>
Date:	Sun, 18 Feb 2007 15:00:48 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0b2 (Windows/20070116)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: IP32 prom crashes due to __pa() funkiness
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14153
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


Initially, booting a straight git checkout on an IP32 will cause it to prom 
crash, usually somewhere in between init_bootmem() and init_bootmem_core().  I 
bisected git to trace this back to one of the inital __pa() introduction patches 
from commit d4df6d4 (get ride of CPHYSADDR()).  It actually appears that the 
actual commit that broke things was 620a480 (Make __pa() aware of XKPHYS/CKSEG0 
address mix for 64 bit kernels).

The [short-term] fix highlighted by Ilya is to make __pa() unconditionally be 
defined to "((unsigned long)(x) < CKSEG0 ? PAGE_OFFSET : CKSEG0)"; Discovered by 
building IP32 with CONFIG_BUILD_ELF64=n.

Normally, this shouldn't be possible, as CONFIG_BUILD_ELF64=n was originally 
only allowed by using the old o64 hack, which has subsequently died and been 
replaced with the newer -msym32 form.  As far as I know, CONFIG_BUILD_ELF64 is 
apparently supposed to be removed at some point in the future, since I believe 
it existed only for quirky 64bit-in-32bit kernels for IP22 and more commonly, 
IP32.  From 2.6.17 onwards, I've been building IP32 kernels with 
CONFIG_BUILD_ELF64=y and using gcc-4, and haven't had problems up until now.

Anyways, I'm not sure if this is an IP32-specific oddity or not (probably is), 
but it needs the define highlighted above to work properly.  Plain PAGE_OFFSET 
won't work for these machines.  Given the same trick os -msym32 is used for the 
rare IP22 64bit kernel, I would not be surprised if the same problem and fix 
both occur and work for those machines as well.  Something to maybe test later, 
I suppose.

But for now, anyone got thoughts as to a sane workaround for this?  Perhaps some 
conditional tweaks in mach-ip32/*.h files somewheres, would it be simpler to 
just switch to:

#if defined(CONFIG_64BIT) && (!defined(CONFIG_BUILD_ELF64) || 
defined(CONFIG_SGI_IP32))

(assuming that IP22 doesn't need it; I'll find out later)



--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
