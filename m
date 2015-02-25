Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Feb 2015 01:07:59 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27006911AbbBYAH4qWcnZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Feb 2015 01:07:56 +0100
Date:   Wed, 25 Feb 2015 00:07:56 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
cc:     David Daney <ddaney.cavm@gmail.com>,
        Zenon Fortuna <zenon.fortuna@imgtec.com>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        IMG - MIPS Linux Kernel developers 
        <IMG-MIPSLinuxKerneldevelopers@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V2 1/3] MIPS: Fix cache flushing for swap pages with
 non-DMA I/O.
In-Reply-To: <54ED06F4.8020607@imgtec.com>
Message-ID: <alpine.LFD.2.11.1502242358170.17311@eddie.linux-mips.org>
References: <1424362664-30303-1-git-send-email-Steven.Hill@imgtec.com> <1424362664-30303-2-git-send-email-Steven.Hill@imgtec.com> <CAJiQ=7DMBznB5Ths0sAZORf2hgSQRuBoPF-7HGHhcHn0EajnWg@mail.gmail.com> <54EBCC38.7000702@imgtec.com> <54EBD023.8090706@imgtec.com>
 <alpine.LFD.2.11.1502240224500.17311@eddie.linux-mips.org> <54ECE7CE.4040407@imgtec.com> <alpine.LFD.2.11.1502242140220.17311@eddie.linux-mips.org> <54ECF3E6.9080606@imgtec.com> <alpine.LFD.2.11.1502242235160.17311@eddie.linux-mips.org> <54ED01F5.8040409@gmail.com>
 <54ED06F4.8020607@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45945
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

> > SYNCI is only useful in non-SMP kernels.
> Yes, until MIPS R6. I pressed hard on Arch team to change vague words in SYNCI
> description and now (MIPS R6) it has words requiring execution on all cores:
> 
> > "SYNCI globalization:
> > Release 6: SYNCI globalization (as described below) is required: compliant
> > implementations must globalize SYNCI.
> > Portable software can rely on this behavior, and use SYNCI rather than
> > expensive “instruction cache shootdown”
> > using inter-processor interrupts."

 Good, thanks for enforcing sanity!

> > If a thread is migrated to a different CPU between the SYNCI, and the
> > attempt to execute the freshly generated code, the new CPU can still have a
> > dirty ICACHE.  So for Linux userspace, cacheflush(2) is your only option.

 Is it not a kernel bug then?  Shouldn't migration code enforce cache 
coherency manually if hardware does not?  User software is supposed to 
have a consistent view of the system and such details as being run on a 
multiprocessor should be completely hidden.

  Maciej
