Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jan 2017 09:35:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:33392 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993881AbdAKIfC5nXlG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jan 2017 09:35:02 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v0B8Z1nb031367;
        Wed, 11 Jan 2017 09:35:01 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v0B8YwMV031366;
        Wed, 11 Jan 2017 09:34:58 +0100
Date:   Wed, 11 Jan 2017 09:34:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     jiang.biao2@zte.com.cn
Cc:     james.hogan@imgtec.com, linux-mips@linux-mips.org,
        pbonzini@redhat.com, rkrcmar@redhat.com, kvm@vger.kernel.org
Subject: Re: [PATCH 20/30] KVM: MIPS/MMU: Invalidate GVA PTs on ASID changes
Message-ID: <20170111083458.GF31072@linux-mips.org>
References: <201701111154365057441@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <201701111154365057441@zte.com.cn>
User-Agent: Mutt/1.7.1 (2016-10-04)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56259
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

On Wed, Jan 11, 2017 at 11:54:36AM +0800, jiang.biao2@zte.com.cn wrote:
> Date:   Wed, 11 Jan 2017 11:54:36 +0800 (CST)
> From: jiang.biao2@zte.com.cn
> To: james.hogan@imgtec.com
> Cc: linux-mips@linux-mips.org, james.hogan@imgtec.com, pbonzini@redhat.com,
>  rkrcmar@redhat.com, ralf@linux-mips.org, kvm@vger.kernel.org
> Subject: Re: [PATCH 20/30] KVM: MIPS/MMU: Invalidate GVA PTs on ASID changes
> Content-Type: multipart/mixed;        boundary="=====_001_next====="
> 
> Hi，
> 
> 
> ＞ +void kvm_mips_flush_gva_pt(pgd_t *pgd, enum kvm_mips_flush flags)
> 
> ＞ +{
> 
> ＞ +    if (flags & KMF_GPA) {
> 
> ＞ +        /* all of guest virtual address space could be affected */
> ＞ +        if (flags & KMF_KERN)
> ＞ +            /* useg, kseg0, seg2/3 */
> ＞ +            kvm_mips_flush_gva_pgd(pgd, 0, 0x7fffffff);
> ＞ +        else
> ＞ +            /* useg */
> ＞ +            kvm_mips_flush_gva_pgd(pgd, 0, 0x3fffffff);
> ＞ +    } else {
> ＞ +        /* useg */
> ＞ +        kvm_mips_flush_gva_pgd(pgd, 0, 0x3fffffff);
> ＞ +
> ＞ +        /* kseg2/3 */
> ＞ +        if (flags & KMF_KERN)
> ＞ +            kvm_mips_flush_gva_pgd(pgd, 0x60000000, 0x7fffffff);
> ＞ +    }
> 
> ＞ +}
> 
> 
> Is it maybe better to replace the hard code *0x7fffffff*, *0x60000000*,
> *0x3fffffff* with marco?

I think to anybody familiar with the architecture the raw numbers are
easier to understand than weird defines.

  Ralf
