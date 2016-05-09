Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 May 2016 15:23:24 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57790 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028417AbcEINXUrhTy7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 May 2016 15:23:20 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u49DNI2M029250;
        Mon, 9 May 2016 15:23:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u49DNGPq029249;
        Mon, 9 May 2016 15:23:16 +0200
Date:   Mon, 9 May 2016 15:23:16 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        "Jayachandran C." <jchandra@broadcom.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-mips@linux-mips.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/7] MIPS: Add extended ASID support
Message-ID: <20160509132315.GA28818@linux-mips.org>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, May 06, 2016 at 02:36:17PM +0100, James Hogan wrote:

> This patchset is based on v4.6-rc4 and adds support for the optional
> extended ASIDs present since revision 3.5 of the MIPS32/MIPS64
> architecture, which extends the TLB ASIDs from 8 bits to 10 bits. These
> are known to be implemented in XLP and I6400 cores.
> 
> Along the way a few cleanups are made, particularly for KVM which
> manipulates ASIDs from assembly code.
> 
> Patch 6 lays most of the groundwork by abstracting asid masks so they
> can be variable, and patch 7 adds the actual support for extended ASIDs.
> 
> Patches 1-5 do some preliminary clean up around ASID handling, and in
> KVM's locore.S to allow patch 7 to support extended ASIDs.
> 
> The use of extended ASIDs can be observed by using the 'x' sysrq to dump
> TLB values, e.g. by repeatedly running this command:
> $(echo x > /proc/sysrq-trigger); dmesg -c | grep asid

Oh beloved ASIDs ...

Already PMC-Sierra's RM9000 / E9000 core had an extended ASID field, of
12 bits for 4096 ASID contexts.  Afaics this was an extension derived
in-house back in the wild days before everything had to be sanctioned by
the architecture folks, so there is nothing in a config register to test
for it.

PMCS simply extended the ASID field to 12 bits; no of the EntryHi bits
which today would conflict doing so did exist back then.

Afair there was yet another core with such a non-standard extension of the
ASID field.  R6000 and R8000 were weird, too.

Until commit f67e4ffc79905482c3b9b8c8dd65197bac7eb508 ("My proposal for
non-generic kernels:") we used to runtime patch the kernel (That's the
cowboy patch the commit message is refering to) to allow for variable
size of the ASID field and position of the ASID field in the EntryHi
register.

  Ralf
