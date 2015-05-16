Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 May 2015 04:42:40 +0200 (CEST)
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:45713 "EHLO
        resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006516AbbEPCmikgSnr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 May 2015 04:42:38 +0200
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-04v.sys.comcast.net with comcast
        id USiX1q0042S2Q5R01SiXxH; Sat, 16 May 2015 02:42:31 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-16v.sys.comcast.net with comcast
        id USiW1q00D42s2jH01SiWNC; Sat, 16 May 2015 02:42:31 +0000
Message-ID: <5556AE85.4030500@gentoo.org>
Date:   Fri, 15 May 2015 22:42:13 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS64: Support of at least 48 bits of SEGBITS
References: <20150515013351.7450.12130.stgit@ubuntu-yegoshin> <20150515215320.GI2322@linux-mips.org> <555675BA.9000700@imgtec.com>
In-Reply-To: <555675BA.9000700@imgtec.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1431744151;
        bh=pwXJS7F/8XykdzCyJVWoy3xjj6tfQRe9n2fib9Ip1Qk=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=uxhwTP834ykacZp2L0yqlvJ+k61p3F++ln+cAaDyKOYrHaol3GvTfJZV9g+kjzjqs
         /xTqJ1xMwdcWvJYuQqO7Y/ssa63uVZNJv1L9dBzv+SQ1hK6GY/kiIu38LiqCTZ6OKn
         /ogp9qNN5jcByKYKoZlfkQMHuu5VRaXV+4lUNFi+Vz01Cf0/gxMCschSqb2u1R3000
         FXbQlg01sdymCVN7qMLz1M8i6M9A5mMt/7JmN/g1eTDnMVX4MRgqFaJRzcmSEYNvsv
         Ct9KsStPjBKILA5/QCYDYYfmInxYyICzC4wYfzti+QBzDFeIbIN518XAMyO697F4tb
         Ye4x8XwH6NiPQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47431
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

On 05/15/2015 18:39, Leonid Yegoshin wrote:
> On 05/15/2015 02:53 PM, Ralf Baechle wrote:
>> On Thu, May 14, 2015 at 06:34:43PM -0700, Leonid Yegoshin wrote:
>>
>> The order 1 allocation for the PGD are concerning me a little.  On a
>> system under even moderate memory pressure that might become a bit of
>> a reliability or performance issue.
>>
>> With 4kB pages we already need order 1 or even 2 allocations for the
>> allocation of the stack and some folks have reported that to be an issue
>> so we may have to start using the PUD for very large VA spaces.
>>
>>    Ralf
> 
> I don't think it is an issue here - people, who wants to exercise 256 TERABAIT
> of memory PER PROCESS may even doesn't note that they have PGD = 2 pages. It is
> definitely not for systems with 4GB physmemory.
> 
> I also recommend for low memory to look into CONFIG_COMPACTION, it may be a
> great help for them here, look into mm/vmscan.c, in_reclaim_compaction().
> 
> Besides that, I defined this feature for 16KB and 64KB pages only, not for 4KB.

There's something screwy with R14000 CPUs and 16kb/64kb pages.  I haven't
figured it out yet, but you get random SIGSEGV and SIGBUS errors running that
PAGE_SIZE.  I figure it's some unknown/undocumented bit that SGI added and
never disclosed anywhere.

--J
