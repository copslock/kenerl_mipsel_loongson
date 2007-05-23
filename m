Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 May 2007 04:52:15 +0100 (BST)
Received: from sccrmhc14.comcast.net ([204.127.200.84]:8874 "EHLO
	sccrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S20021363AbXEWDwO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 23 May 2007 04:52:14 +0100
Received: from [192.168.1.4] (c-76-106-119-205.hsd1.md.comcast.net[76.106.119.205])
          by comcast.net (sccrmhc14) with ESMTP
          id <2007052303513001400576gbe>; Wed, 23 May 2007 03:51:31 +0000
Message-ID: <4653BA42.3060104@gentoo.org>
Date:	Tue, 22 May 2007 23:51:30 -0400
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 2.0.0.0 (Windows/20070326)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Subject: Re: SGI O2 meth: missing sysfs device symlink
References: <1178743456.15447.41.camel@scarafaggio> <20070516151939.GH19816@deprecation.cyrius.com> <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org> <20070517151636.GJ3586@deprecation.cyrius.com> <20070521154726.GE5943@linux-mips.org> <20070522110956.GB29118@linux-mips.org>
In-Reply-To: <20070522110956.GB29118@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, May 21, 2007 at 04:47:26PM +0100, Ralf Baechle wrote:
> 
> Below patch is meant to cure the problem.  It's against HEAD but should
> apply to somewhat older problems as well.
> 
> I appreciate testing asap so I can try to still push this upstream
> for 2.6.22.
> 
> Thanks,
> 
>   Ralf
> 

Didn't test on 2.6.22 (yet), but 2.6.21.1 works:

# ls -ld /sys/class/net/*{,/device}
drwxr-xr-x 3 root root 0 May 22 18:19 /sys/class/net/eth0/
lrwxrwxrwx 1 root root 0 May 22 18:19 /sys/class/net/eth0/device -> 
../../../devices/platform/meth/
drwxr-xr-x 3 root root 0 May 22 18:19 /sys/class/net/lo/


Btw, If we wanted to protect meth from the speculative execution issues of the 
R10000 processor, what's the right way for that?  I believe IP28 used a special 
type of buffer for protecting Seeq from the DMA wonkiness that occurs, but I got 
the indication that Meth would need a different approach.


--Kumba

-- 
Gentoo/MIPS Team Lead

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
