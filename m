Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Sep 2015 06:41:32 +0200 (CEST)
Received: from resqmta-ch2-03v.sys.comcast.net ([69.252.207.35]:41039 "EHLO
        resqmta-ch2-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006867AbbIHElbSEvvj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Sep 2015 06:41:31 +0200
Received: from resomta-ch2-01v.sys.comcast.net ([69.252.207.97])
        by resqmta-ch2-03v.sys.comcast.net with comcast
        id EUhA1r00226dK1R01UhLl4; Tue, 08 Sep 2015 04:41:20 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-01v.sys.comcast.net with comcast
        id EUhK1r0070w5D3801UhK88; Tue, 08 Sep 2015 04:41:20 +0000
To:     Linux/MIPS <linux-mips@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: CONFIG_DEBUG_LOCK_ALLOC prevents booting on IP27/IP30?
X-Enigmail-Draft-Status: N1110
Message-ID: <55EE66E8.6010601@gentoo.org>
Date:   Tue, 8 Sep 2015 00:41:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1441687280;
        bh=eVUGd8U8lmfHYeZYcke68UJKYfvTf/eIk9y16/MGLew=;
        h=Received:Received:To:From:Subject:Message-ID:Date:MIME-Version:
         Content-Type;
        b=mXi6/gL5EzjK2pLfnSeTw2TDE3F0kay4xLqB1JycgvtAXlHbhW3xjef4NGPEROgoj
         h30ACGepf4Uhul0hH9Izw6U4pOqlaYtRE49RfdGFpGOLnaVsnpDmrUDboTET6ZZhvQ
         3C9vAKYzoUT50SOqveaZJTHV+Cirqsgn7cWBe2J2Tn4dNlKb0BJegSLvMnXD0IHwd9
         p03C1Yv30FUZo2AySSwwktp6bKbaFD4rHgUIkFdZFkKHVRpyo1xDbJ6LyLgrkOhI3i
         SG+KKPPsdkW5o9vilrJCMAQ3PaN1C1moyBi9mY7kCdHXM8p5Hy4uEC4PPprGWNmdOO
         X3OhAwdoW4dHg==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49132
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

This one has constantly stumped me, but if I compile a kernel for either Octane
(IP30) or Origin/Onyx (IP27), and enable CONFIG_DEBUG_LOCK_ALLOC, ARCS refuses
to load the kernel over netboot, citing this error:

Option? 5
Command Monitor.  Type "exit" to return to the menu.
>> bootp(): console=ttyS0,9600 root=/dev/md0
Setting $netaddr to 192.168.1.4 (from server )
Obtaining  from server

Cannot load bootp():.
Text start 0x1c000, size 0x16e1320 doesn't fit in a FreeMemory area.
Unable to execute bootp()::  not enough space
>>

Booting from the volume header of the disk also doesn't work and ARCS reutrns
the same error.

Not really an issue on IP30 anymore, as I think I've worked out the spinlocking
problems there (just BRIDGE DMA bugs now, at some point).  But IP27 still has
that pesky hardlock with disk I/O that I just can't pin down.  Even an NMI
reset won't register anything on the console.

So I was hoping that debugging spinlocks might shed light on the issue, but not
if I can't boot the kernel from network or disk.

Any idea how to go about figuring this one out?  It's gotta be something with
the way the 'vmlinux' binary is linked together, but I'm not sure what.

--J
