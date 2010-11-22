Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2010 04:41:48 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:47949 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490962Ab0KVDlp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Nov 2010 04:41:45 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id oAM3fgOj026642;
        Mon, 22 Nov 2010 03:41:42 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id oAM3ff08026640;
        Mon, 22 Nov 2010 03:41:41 GMT
Date:   Mon, 22 Nov 2010 03:41:41 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Maksim Rayskiy <maksim.rayskiy@gmail.com>,
        "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ASID conflict after CPU hotplug
Message-ID: <20101122034141.GA13138@linux-mips.org>
References: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28442
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 17, 2010 at 10:49:09AM -0800, Maksim Rayskiy wrote:

> This is a repost of my original message which somehow did not reach
> the mailing list (filtered out?).

Yes indeed.  In particular the previous posting was HTML which the list
robot is configured to exterminate.

> I am running SMP Linux 2.6.37-rc1 on BMIPS5000 (single core dual
> thread) and observe some abnormalities when doing system
> suspend/resume which I narrowed down to cpu hotplugging. The suspend
> brings the second thread processor down and then restarts it, after
> which I see memory corruption in userspace. I started digging and
> found out that problem occurs because while doing execve() the child
> process is getting the same ASID as the parent, which obviously
> corrupts parent's address space.
> 
> Further digging showed that:
> activate_mm() calls get_new_mmu_context() to get a new ASID, but at
> this time ASID field in entryHi is 1, and asid_cache(cpu) is 0x100 (it
> was just reset to ASID_FIRST_VERSION when the secondary TP was
> booting).
> So, get_new_mmu_context() increments the asid_cache(cpu) value to
> 0x101, and thus puts 0x01 into entryHi. The result - ASID field does
> not get changed as it was supposed to.
> 
> My solution was very simple - do not reset asid_cache(cpu) on TP warm
> restart. But I would welcome any comments because my understanding of
> the code is somewhat fuzzy.

Unfortunately I haven't yet found a BMIPS board or manual in my mailbox
so I can't really give a definitate answer.  But let me describe how
the MIPS34K handles it.

The 34K supports two TLB modes, shared and split TLB.  The VSMP kernel
uses the TLB in split mode in which half of the TLB entries is available
to each of the two threads aka VPEs.  So with a 64 entry TLB that's 32
entries per VPE then.  Each VPE (or rather TC but see further down) has
it's own c0_entryhi register, thus it's own ASID.  So no ASID collisions
possible, ever.  This is the same as on a conventional SMP system where
TLB and ASID number space are also per CPU.

The SMTC kernel model (usually) uses the shared model, that is all the 64
entries are now available to all threads and the ASID space is shared.
This means allocation of the same ASID to multiple TCs needs to be avoided.

It seems BMIPS falls into the latter class?

Need to think a little about potencial consequences of your suggested
patch.  It seems ok.  Kevin, what do you think?

  Ralf
