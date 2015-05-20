Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2015 07:23:47 +0200 (CEST)
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:47316 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012554AbbETFXprp8-K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 May 2015 07:23:45 +0200
Received: from resomta-po-20v.sys.comcast.net ([96.114.154.244])
        by resqmta-po-04v.sys.comcast.net with comcast
        id W5Ph1q0015Geu28015PhB2; Wed, 20 May 2015 05:23:41 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-po-20v.sys.comcast.net with comcast
        id W5Pf1q00B42s2jH015Pgsi; Wed, 20 May 2015 05:23:41 +0000
Message-ID: <555C1A53.9010803@gentoo.org>
Date:   Wed, 20 May 2015 01:23:31 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: IP30: SMP, Almost there?
References: <55597B21.4010704@gentoo.org> <5559D483.905@gentoo.org>
In-Reply-To: <5559D483.905@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1432099421;
        bh=lvKnpykCf8ufXhOkjJGKhUyiS6saop8Ozot96+3sBWE=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=d/gfPQB0NLuJkGZHpTJRVQlcFkWxvD7dCMowQ3mPyekiRh4uS7XLj0h2nBi9pChi1
         m7cD8G031CkKxQfGYudjhmD8R1eaLEYMurFL2uearUEDkTfFTid27rGswBcqH29nBS
         r1hbTiv09p3RwIKAEx6yMj7SfxxcYIgsHiCsS1ltdaihD2+NUTNp8Dte09MIdWrBbQ
         GMs7Jali1z7QFWmj05WLAX957ktQryTQXQLQ6JyCZLLgPjGeCyrZY8j+b+W1VmpEuN
         +2J8Dl/UNhKsGoyfSHOFgThiLY46yvBgrycVbfjx1VPBqbYBWQ2zNJJ2pKrpaodXxI
         xRJtRt0UujvJA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47484
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

On 05/18/2015 08:01, Joshua Kinard wrote:
> On 05/18/2015 01:39, Joshua Kinard wrote:
>> So I've gotten the second CPU in Octane to "tick" again...somehow.  I am
>> certain someone's cat went missing in the process...
>>
>> Anyways, it's booting into an initramfs and dying almost immediately with
>> errors from do_page_fault:

I've stripped the kernel config down to practically nothing (9MB w/ debugging,
-Os, and a small initramfs), yet still, when CPU1 starts up and starts
scheduling, I am running into "scheduling while atomic" warnings (due to
enabling that option in kernel debugging).  CPU0 then joins in with scheduling
while atomic.  I've tried switching to mutexes instead of spinlocks, but no
dice.  It seems to be stemming from core kernel code, but I know the problem
has to be in the IP30 SMP code.

I've looked at all of the other MIPS SMP implementations, and by far the one
that looks the closest is the Sibyte 1250 SMP code.  Everything else is far too
different, what with multicores and multithreading.  However, adopting most of
the Sibyte semantics for CPU1 bringup doesn't appear to work.  Only thing I
haven't done yet is handle CPU affinity.

Do I need to define the irq_set_affinity() function pointer in struct irq_chip?
 IP27 doesn't have this and no real ill effects w/ SMP are seen on that system
(just the random hardlock due to that vmscan BUG() or disk I/O).  Am I not
masking all IRQs correctly and running into a case of recursive interrupts?  Is
there still a way to halt all interrupts globally (the old big lock) and use
that as a debugging aid?

--J
