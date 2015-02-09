Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2015 09:50:21 +0100 (CET)
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:44710 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010586AbbBIIuRrwcHx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Feb 2015 09:50:17 +0100
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-01v.sys.comcast.net with comcast
        id q8qA1p0012VvR6D018qBVH; Mon, 09 Feb 2015 08:50:11 +0000
Received: from [192.168.1.13] ([69.250.160.75])
        by resomta-ch2-19v.sys.comcast.net with comcast
        id q8qA1p0061duFqV018qAr0; Mon, 09 Feb 2015 08:50:11 +0000
Message-ID: <54D874BF.3040003@gentoo.org>
Date:   Mon, 09 Feb 2015 03:50:07 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: Random hard locks after ~16hrs uptime
References: <54D6D0D5.8020704@gentoo.org> <alpine.LFD.2.11.1502081003060.22715@eddie.linux-mips.org> <54D80515.3040208@gentoo.org>
In-Reply-To: <54D80515.3040208@gentoo.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1423471811;
        bh=S/XxSEzNNncmo1/P1CYOjZMvju8XD7yVqT6QQ5dIU3I=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=XY06SrNDRanvRwLXeY8BU+EAZNUG/aLQ+Ct3JOOvVaRzTX7zkAtnmFVSASAnkEinY
         K4u0qjHVrMhkLfHULZbSB0l6Wk7JJEr7kC8ozYQSTntYgjBE4u12YW2F7NzT4hmoaq
         Ml2aNJ2miftNvqUEKS27BL81yQcUFesUH4TgaEdwE8yc8H2FxHnrnYOmWnUaKxJ+WI
         M9oEh45m/3Ne8B7ylEJ7wpjLqBKeZO021K+zFnMhu/Lk5P8i1nPE7YQ1sqJqhO65LI
         G4xXCFmx6i5+S1wKxAfH7jysAcEvtK3uAmlbb/WWL5PGKA0VpFLfrBDIbreEq+Fb7Q
         nzormuYLuLxiA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45778
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

On 02/08/2015 19:53, Joshua Kinard wrote:
> On 02/08/2015 07:06, Maciej W. Rozycki wrote:
>> On Sat, 7 Feb 2015, Joshua Kinard wrote:
>>
>>> I've had my Onyx2 running quite a bit lately doing compile runs, and it seems
>>> that after about ~16 hours, there's a random possibility that the machine just
>>> completely stops.  No errors printed anywhere, serial becomes completely
>>> unresponsive.  I have to issue a 'rst' from the MSC to bring it back up again.
>>
>>  If the time spent up is always similar, then one possibility is a counter 
>> wraparound or suchlike that is not handled correctly (i.e. the carry from 
>> the topmost bit is not taken into account), causing a kernel deadlock.
> 
> I believe I've pinned the problem down to the block I/O layer and points
> beneath, such as SCSI core, qla1280, etc.  I am using an out-of-tree patch to
> add the BFQ I/O scheduler in, so that may also be a cause to consider.
> 
> I had a very similar hardlock on the Octane, too, when I upgraded the RAM to
> 3.5GB the other day, but going back to 2GB solves the problem there.  Octane
> is, for all intents and purposes, a single-node Origin system w/ graphics
> options, HEART instead of HUB, and a much more simplified PROM).  Both use the
> same SCSI chip, a QLogic ISP1040B, and thus the same driver, qla1280.o.  The
> difference with the Octane is I can reproduce the hardlock on demand by
> untarring a large tarball (a Gentoo stage3, to be exact).  Compared to the
> Onyx2, which has 8GB of RAM, and the lock seems more random.
> 
> I'll have to reconfigure the Octane later on with 3.5GB of RAM again, but test
> BFQ, CFQ, and Deadline out to see if the hardlock happens with all three.  I
> know BFQ is largely derived from the CFQ code, so if the system remains stable
> with Deadline, but not CFQ or BFQ, then I know the subsystem.  Then, if it only
> happens on BFQ, I'll go pester their upstream for debugging advice.

For the Octane, it looks like it's something with the scheduler.  If I use
"No-op", the machine can unpack a stage3 just fine.  If I use Deadline or CFQ,
it dies.  I did get several oopses under both, but they're not specific to
Octane or MIPS code, and the Oops output doesn't always trigger with each
attempt.  Several were actually "Reserved instruction in kernel code", but the
failing instruction was an "sw", which should work fine.  Other weird one was
"do_cpu invoked from kernel context!" -- new to me.  Saved all of them in case
anyone is interested in it.

I'll have to test this on the Onyx2 later to see if similar results
happen there.  That way, I'll know that I am chasing the same bug down.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
