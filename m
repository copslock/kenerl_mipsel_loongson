Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Oct 2017 22:38:03 +0200 (CEST)
Received: from resqmta-po-05v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:164]:50190
        "EHLO resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992310AbdJHUhzyyrcH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Oct 2017 22:37:55 +0200
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id 1IHte8xnD40UY1IIEeVAt6; Sun, 08 Oct 2017 20:35:22 +0000
Received: from [192.168.1.13] ([73.173.137.35])
        by resomta-po-18v.sys.comcast.net with SMTP
        id 1IICeUv6THfSP1IIDe2UDY; Sun, 08 Oct 2017 20:35:22 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: commit 8031c3ddc70a breaks RAID5 on MIPS kernel where PAGE_SIZE ==
 64K
To:     linux-raid@vger.kernel.org
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Message-ID: <db0e511c-f5db-99fe-70ac-150864432db0@gentoo.org>
Date:   Sun, 8 Oct 2017 16:34:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOXHJgphPsBux5plum49ZjtBq9xEwNOJFyVV9LgPlAfmcT5VetP51bCqOZ/gR6kC/oIWEHk42+6J9o9BMigy4I5FW9B7a5gFC2ynMghB7Vsu0j1FEw9T
 0vGXXnfoid0ausEWWFrRQItP+5q8cf4ryAaR+3cwhMiXk/5TxOS+m2FvFTW1m5SLxcRHsfm7XkmatyWHFkl5ixgKTiTCe4v8bw4=
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60325
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

Hi,

Testing 4.13.5 out on my SGI Octane, I discovered that my RAID5 arrays were no
longer auto-assembling.  The error being thrown was an "attempt to access
beyond the end of the device".  I've hand-transcribed a block of these errors
from a manual attempt to assemble the array via mdadm from a netboot image:

/ # mdadm -A /dev/md0 /dev/sda1 /dev/sdb1 /dev/sdc1
[   56.303339] md: md0 stopped.
[   56.323565] md/raid:md0: device sda1 operational as raid disk 0
[   56.334556] md/raid:md0: device sdb1 operational as raid disk 2
[   56.345396] md/raid:md0: device sdc1 operational as raid disk 1
[   56.350750] md/raid:md0: raid level 5 active with 3 out of 3 devices,
algorithm 2
[   56.369529] attempt to access beyond end of device
[   56.380149] sda1: rw=2048, want=4194312, limit=4194305
[   56.390823] attempt to access beyond end of device
[   56.401500] sdc1: rw=2048, want=4194312, limit=4194305
[   56.412313] attempt to access beyond end of device
[   56.423146] sdb1: rw=2048, want=4194312, limit=4194305
[   56.433985] md0: failed to create bitmap (-5)
mdadm: failed to RUN_ARRAY /dev/md0: input/output error
[   56.457979] md: md0 stopped.
/ #

I've traced the offending commit down to 8031c3ddc70a ("md/bitmap: copy correct
data for bitmap super"):

https://git.linux-mips.org/cgit/ralf/linux.git/commit/?id=8031c3ddc70ab93099e7d1814382dba39f57b43e

Per the commit message, it makes an assumption that PAGE_SIZE is 4K.  MIPS
kernels allow you to change the value of PAGE_SIZE at compile time to something
other than 4K.  It appears that 4K and 16K both work, while 64K, which is what
I use on this machine, is broken with this commit applied.

Reverting this patch or setting PAGE_SIZE to 4K or 16K will resolve the issue,
but there are advantages to using 64K PAGE_SIZEs on these platforms.  I am not
sure that 16K is wholly safe either, FWIW, given the assumption made in the commit.

Thoughts?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
