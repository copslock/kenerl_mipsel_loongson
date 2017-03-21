Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Mar 2017 20:55:08 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38712 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993890AbdCUTzBUo3Ea (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Mar 2017 20:55:01 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2LJt02U009958;
        Tue, 21 Mar 2017 20:55:00 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2LJt0ks009957;
        Tue, 21 Mar 2017 20:55:00 +0100
Date:   Tue, 21 Mar 2017 20:55:00 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: MIPS/Emulate: Properly implement TLBR for T&E
Message-ID: <20170321195500.GB9697@linux-mips.org>
References: <cover.57583f73c169e83d499329fbda19909b816c0024.1489510483.git-series.james.hogan@imgtec.com>
 <3688052f24c8ffb26c87c7376de44732f25bcdd6.1489510483.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3688052f24c8ffb26c87c7376de44732f25bcdd6.1489510483.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57407
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

On Tue, Mar 14, 2017 at 05:00:08PM +0000, James Hogan wrote:

> Properly implement emulation of the TLBR instruction for Trap & Emulate.
> This instruction reads the TLB entry pointed at by the CP0_Index
> register into the other TLB registers, which may have the side effect of
> changing the current ASID. Therefore abstract the CP0_EntryHi and ASID
> changing code into a common function in the process.
> 
> A comment indicated that Linux doesn't use TLBR, which is true during
> normal use, however dumping of the TLB does use it (for example with the
> relatively recent 'x' magic sysrq key), as does a wired TLB entries test
> case in my KVM tests.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
