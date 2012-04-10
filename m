Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Apr 2012 20:03:56 +0200 (CEST)
Received: from dns0.mips.com ([12.201.5.70]:37039 "EHLO dns0.mips.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903709Ab2DJSDt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 Apr 2012 20:03:49 +0200
Received: from exchdb01.mips.com (exchhub01.mips.com [192.168.36.84])
        by dns0.mips.com (8.13.8/8.13.8) with ESMTP id q3AI3eWi031710;
        Tue, 10 Apr 2012 11:03:41 -0700
Received: from [192.168.65.146] (192.168.65.146) by exchhub01.mips.com
 (192.168.36.84) with Microsoft SMTP Server id 14.1.270.1; Tue, 10 Apr 2012
 11:03:35 -0700
Message-ID: <4F8475F7.9060809@mips.com>
Date:   Tue, 10 Apr 2012 11:03:35 -0700
From:   Leonid Yegoshin <yegoshin@mips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     "Steven J. Hill" <sjhill@mips.com>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>
Subject: Re: [PATCH] Revert "MIPS: cache: Provide cache flush operations for
 XFS"
References: <1333987989-1178-1-git-send-email-sjhill@mips.com> <CAJiQ=7AjtSB8KQ9+edUOvW+70nAWzh6c8B26ehnEpuud6QeMJA@mail.gmail.com>
In-Reply-To: <CAJiQ=7AjtSB8KQ9+edUOvW+70nAWzh6c8B26ehnEpuud6QeMJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EMS-Proccessed: 6LP3oGfGVdcdb8o1aBnt6w==
X-EMS-STAMP: ieBl1dS+trVrMX0FtBhyCw==
X-archive-position: 32925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yegoshin@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 04/09/2012 07:44 PM, Kevin Cernekee wrote:
> On Mon,Is there a reason why Ralf's original approach was not workable?

It doesn't work with HIGHMEM + cache aliasing. It also uses cache flush 
(blast_dcache) to buffer instead of cache invalidate after read I/O is 
completed.


> I suspect that reimplementing the *_kernel_vmap_range functions using
> _dma_cache_* would result in a double L2 flush on the same memory
> regions on systems with cache aliases, and an unnecessary L1+L2 flush
> on systems without aliases.

Good point. I put that to set it working. Now, after your comment, I 
think it has sense to try with L1 only.

- Leonid.
