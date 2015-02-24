Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Feb 2015 23:50:55 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007145AbbBXWuxmIWK1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Feb 2015 23:50:53 +0100
Date:   Tue, 24 Feb 2015 22:50:53 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
cc:     Zenon Fortuna <zenon.fortuna@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        IMG - MIPS Linux Kernel developers 
        <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with
 non-DMA I/O.
In-Reply-To: <54ECF3E6.9080606@imgtec.com>
Message-ID: <alpine.LFD.2.11.1502242235160.17311@eddie.linux-mips.org>
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com> <54EBD023.8090706@imgtec.com>
 <alpine.LFD.2.11.1502240224500.17311@eddie.linux-mips.org> <54ECE7CE.4040407@imgtec.com> <alpine.LFD.2.11.1502242140220.17311@eddie.linux-mips.org> <54ECF3E6.9080606@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 24 Feb 2015, Leonid Yegoshin wrote:

> >   For simplicity perhaps on SMP we should just always use hit operations
> > regardless of the size requested.
> 
> High performance folks may not like doing a lot of stuff for 8MB VMA release
> instead of flushing 64KB.

 What kind of a use case is that, what does it do?

> Especially taking into account TLB exceptions and postprocessing in
> fixup_exception() for swapped-out/not-yet-loaded-ELF blocks.

 The normal use for cacheflush(2) I know of is for self-modifying or other 
run-time-generated code, to synchronise caches after a block of machine 
code has been patched in -- SYNCI can also be used for that purpose these 
days, but the syscall long predates the presence of this instruction in 
the architecture .

 I fail to see any other need to force data out of cache in a user program 
(apart from also the corner case of benchmarking cold caches, such as in 
Zenon's case, but there the performance of the preparatory cache 
invalidation does not really matter).  Why would you expect VM to have 
been swapped out or not loaded where data has just been written?  Why 
would you want to call cacheflush(2) for blocks of data that haven't been 
written?

  Maciej
