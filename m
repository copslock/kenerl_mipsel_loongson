Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Mar 2017 16:18:14 +0100 (CET)
Received: from resqmta-po-12v.sys.comcast.net ([IPv6:2001:558:fe16:19:96:114:154:171]:58978
        "EHLO resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992111AbdCDPSHXBGSX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 4 Mar 2017 16:18:07 +0100
Received: from resomta-po-02v.sys.comcast.net ([96.114.154.226])
        by resqmta-po-12v.sys.comcast.net with SMTP
        id kBREctKruCGpRkBRdcIQgY; Sat, 04 Mar 2017 15:18:05 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-po-02v.sys.comcast.net with SMTP
        id kBRccnT9qntHNkBRccdGiH; Sat, 04 Mar 2017 15:18:05 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: RFC: Proper locking tips for IRQ handlers?
To:     Linux/MIPS <linux-mips@linux-mips.org>
Message-ID: <2c6f8c8d-6380-2f0b-69be-72115e2012c7@gentoo.org>
Date:   Sat, 4 Mar 2017 10:17:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIvy/VBQ6fle9RzqHmljtTLgkE3+lQMQdo6Xk9sGmCbPPmv/d5kUxreAAAWNDxF9FjuBs3zpURvFL+ZV0tp7Pxl+kLM5QAWuAz/LNBTYR6OMHeYNzd9O
 Nr+kBdXjW9ImVaKQ5AQN//fu6a3ipQwjJPHACWd7R8B6OQN27vDax8J0
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57035
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

Hi all,

I am looking for some feedback on how to improve IRQ handlers on IP30 (SGI
Octane).  Since switching to the use of per_cpu data structures, I've
apparently not needed to do any locking when handling IRQs.  However, it looks
like around ~Linux-4.8.x, there's some noticeable contention going on with
heavy disk I/O, and it's worse in 4.9 and 4.10.  Under 4.8, untar'ing a basic
Linux kernel source tarball completed fine, but as of 4.9/4.10, there's a
chance to trigger either an oops or oom killer.  While the untar operation
happens, I can watch the graphics console and the blinking cursor will
sometimes pause momentarily, which suggests contention somewhere.

So my question is in struct irq_chip accessors like irq_ack, irq_mask,
irq_mask_ack, etc, should spinlocks be used prior to accessing the HEART ASIC?
And if so, normal spinlocks, raw spinlocks, or the irq save/restore variants?

I've looked at the IRQ implementations for a few other MIPS boards, but because
each system is so unique, there's no clear consensus on the right way to do it.
 Octeon, uses irq_bus_lock and irq_bus_sync_unlock, along with a mutex, for
locking, while netlogic uses locking only during irq_enable or irq_disable, and
loongsoon-3 doesn't appear to employ any locking at all.  Other archs appear to
be a mix as well, and I'm even seeing newer constructs like the use of
irq_data_get_irq_chip_data() to fetch a common data structure where the
spinlock variable is defined.  Other systems use a global spinlock.

Any advice would be greatly appreciated.  Thanks!

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
