Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Jan 2006 05:15:54 +0000 (GMT)
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:28340 "EHLO
	rwcrmhc14.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133541AbWA1FPc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 28 Jan 2006 05:15:32 +0000
Received: from [192.168.1.4] (unknown[69.140.185.48])
          by comcast.net (rwcrmhc14) with ESMTP
          id <20060128052005m1400lji73e>; Sat, 28 Jan 2006 05:20:06 +0000
Message-ID: <43DAFEFE.8060009@gentoo.org>
Date:	Sat, 28 Jan 2006 00:19:58 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: R10K/R12K Based O2's
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips


Okay, this is being sent to try and spur some activity on the front of getting 
R10K O2's to work somewhat better.  I toyed around with such a machine to see 
how long I could get it to stay online, and thought I'd post some results.

To start, I merged the generic pieces of Peter Fuerst's IP28 patches into an 
IP32 tree (piece that touch generic MIPS code, like memcpy.S, strcpy.S, etc to 
add R10K cache barriers) and built an R10K IP32 kernel with the gcc cache 
barriers patch he also has up.  End result seemed to be a kernel, that while 
definitely not production ready, stays up longer than others.

As told to me by Ilya, using the network device too much or even remotely trying 
to use scsi instantly killed the machine (based on his tests a while back).  My 
results were a bit different in that I was able to use the network for a 
prolonged time (over ssh too)  and even managed to use the scsi disk some, 
downloading and unpacking a 40MB tbz2 of a Gentoo stage3 (uclibc) tarball on the 
system.  It didn't finally lock up until an 'emerge sync', which hits the disk 
heavily with lots of small files (which as Ilya predicted, would kill it).

Whether this was the result of using the R10K cache barriers in both the IP28 
patch and gcc, or just general kernel improvements in those drivers, is anyone's 
guess, but I got farther than I initially expected (I didn't hold out hope that 
such a system would even boot, let alone get to userland).


IP28 used protected intermediate buffers for DMA input on the sgiwd93 (scsi) 
driver, but not on sgiseeq (net), as this had access to bounce buffers for 
incoming packets.  IP32's meth (net) driver was designed specifically to avoid 
the need of bounce buffers, though, so likely it needs some solution to work 
around the speculative execution bit.  IP32 likely needs the same or similar 
implements in its scsi driver (aic7xxx) as well).

It seems when speculative execution triggers, this is seen on the primary console:

CRIME CPU error at 0x00b74fa90 status 0x00000004
CRIME CPU error at 0x00b74fa90 status 0x00000004
CRIME CPU error at 0x01005fcc0 status 0x00000004
CRIME CPU error at 0x00b74fa90 status 0x00000004
CRIME CPU error at 0x00b74fa90 status 0x00000004
CRIME CPU error at 0x00b74fa90 status 0x00000004

(once per hit; they don't happen very often unless scsi is getting a workout. 
The two repeating addresses are constant, it seems).


Thoughts?


For testing, I have an IP32 R10K netboot kernel available, based on 2.6.15.1, if 
anyone wants to try it out for themselves and report their findings.

http://dev.gentoo.org/~kumba/mips/netboot/testing/ip32/r10k/



--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
