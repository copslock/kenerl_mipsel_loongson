Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jun 2012 21:30:42 +0200 (CEST)
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:44418
        "EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903662Ab2FWTah (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jun 2012 21:30:37 +0200
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
        by qmta03.westchester.pa.mail.comcast.net with comcast
        id RuiT1j00C17dt5G53vWXcA; Sat, 23 Jun 2012 19:30:31 +0000
Received: from [192.168.1.13] ([76.106.69.86])
        by omta13.westchester.pa.mail.comcast.net with comcast
        id RvWY1j0011rgsis3ZvWYQF; Sat, 23 Jun 2012 19:30:33 +0000
Message-ID: <4FE6195F.7030505@gentoo.org>
Date:   Sat, 23 Jun 2012 15:30:39 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: booting linux-3.3 or linux 3.4 on an SGI O2?
References: <20120605190047.GA6263@alumni-linux.ccs.neu.edu> <4FCE593B.10808@cavium.com>
In-Reply-To: <4FCE593B.10808@cavium.com>
X-Enigmail-Version: 1.4.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 06/05/2012 3:08 PM, David Daney wrote:
> On 06/05/2012 12:00 PM, Jim Faulkner wrote:
>> Hi all, I haven't been able to boot any kernels after linux 3.2 on my
>> SGI O2.  I've tried linux-3.3.5 and linux-3.4.0, but neither would boot.
>> Unfortunately I don't have further information such as a kernel panic,
>> since I don't get any video output after the kernel is loaded.  I've
>> attached my linux-3.4 .config.  Anybody know what patches I might need
>> to get the latest kernels booting on this system?
>>
> 
> I have had problems as well.
> 
> Someone should configure a serial console and early printk to see if they
> can see what is happening.

Early printk on O2 systems probably has the same issues as on IP22/IP28
where it's overwriting PROM memory somewhere.  The system will hang very
early in the bootmem allocator if you kludge early printk to work on these
systems:

System Maintenance Menu

1) Start System
2) Install System Software
3) Run Diagnostics
4) Recover System
5) Enter Command Monitor

Option? 5
Command Monitor.  Type "exit" to return to the menu.
> $ba
Setting $netaddr to 192.168.1.12 (from server )
Obtaining  from server
5305628+400900 entry: 0x80009920
Initializing cgroup subsys cpu
Linux version 3.4.4-mipsgit-20120623 (root@helcaraxe) (gcc version 4.6.2
(Gentoo 4.6.2 p1.3, pie-0.5.0) ) #2 Sat Jun 23 15:20:20 EDT 2012
ARCH: SGI-IP32
PROMLIB: ARC firmware Version 1 Revision 10
CRIME id a rev 1 at 0x0000000014000000
CRIME MC: bank 0 base 0x0000000000000000 size 128MiB
CRIME MC: bank 1 base 0x0000000008000000 size 128MiB
CRIME MC: bank 2 base 0x0000000050000000 size 128MiB
CRIME MC: bank 3 base 0x0000000058000000 size 128MiB
bootconsole [early0] enabled
CPU revision is: 00002733 (RM7000)
FPU revision is: 00002720
Checking for the multiply/shift bug... no.
Checking for the daddiu bug... no.
Determined physical RAM map:
 memory: 0000000010000000 @ 0000000000000000 (usable)
 memory: 0000000010000000 @ 0000000050000000 (usable)
Zone PFN ranges:
  Normal   0x00000000 -> 0x00060000
Movable zone start PFN for each node
Early memory PFN ranges
    0: 0x00000000 -> 0x00010000
    0: 0x00050000 -> 0x00060000


I tried chasing this down once, years ago, and it was triggered by a pointer
to a function in a struct suddenly becoming NULL.  That was back in 2.6.15
(or .14?), so no idea if the same issue is causing it.  Most likely.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And
our lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
