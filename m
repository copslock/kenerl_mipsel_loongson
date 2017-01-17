Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 17:24:17 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35564 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993889AbdAQQYHit14w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jan 2017 17:24:07 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0HGO6Gg029358;
        Tue, 17 Jan 2017 17:24:06 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0HGO6DT029357;
        Tue, 17 Jan 2017 17:24:06 +0100
Date:   Tue, 17 Jan 2017 17:24:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     linux-mips@linux-mips.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org
Subject: Re: [PATCH 2/30] MIPS: Export pgd/pmd symbols for KVM
Message-ID: <20170117162406.GD24215@linux-mips.org>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
 <dd23ddfe6b616c2111a395e7b0351d7c2c3f8683.1483665879.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd23ddfe6b616c2111a395e7b0351d7c2c3f8683.1483665879.git-series.james.hogan@imgtec.com>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56360
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

On Fri, Jan 06, 2017 at 01:32:34AM +0000, James Hogan wrote:

> Export pgd_init(), pmd_init(), invalid_pmd_table and
> tlbmiss_handler_setup_pgd to GPL kernel modules so that MIPS KVM can use
> the inline page table management functions and switch between page
> tables:
> 
> - pgd_init() is used inline by pgd_alloc(), which KVM will use to
>   allocate page directory tables for GVA mappings.
> 
> - pmd_init() will be used directly by KVM to initialise newly allocated
>   pmd tables with invalid lower level table pointers.
> 
> - invalid_pmd_table is used by pud_present(), pud_none(), and
>   pud_clear(), which KVM will use to test and clear pud entries.
> 
> - tlbmiss_handler_setup_pgd() will be called by KVM entry code to switch
>   to the appropriate GVA page tables.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> Cc: linux-mips@linux-mips.org
> Cc: kvm@vger.kernel.org

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
