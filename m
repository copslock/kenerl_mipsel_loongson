Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 19:56:35 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:32950 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012476AbbHLR4cA1IaU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 19:56:32 +0200
Received: by wijp15 with SMTP id p15so227857811wij.0
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 10:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HIMhkc5Cn8/yYBS7a8oKy6LoqLgVUI7HptxGWB9wQqk=;
        b=vAL3i9gUaLqFkl6Qm8A3d372C/2qsQ5N+spv08bRvBbE7dIMYcsBL1Usbln4p48vNn
         rzOYXmLLPom+QkNgeQqx7CkGZX1FgxRcWWnqCs1cjvdP73ZYIEcsQ6K1X9csDJ+mlyvC
         KEd+mHfBnsARSnXHBczh+mYDf7BlfyloUkFnKHeZA915mVUh0yM/uKSMsPiSqO5AD0eS
         /xtv3oFRVifEE5XZV3sYXoHFzu2q3JM+2+THw2XpDQ0SCWQ+8o8je9bqfxcvaXtca2Lh
         70NmfQMi5AfdhF4AIlskTYc8VN6zELyTI86D8QeOhxwKa7A9q3Va9SYWGJ5Jc76n4Bb9
         tz0A==
MIME-Version: 1.0
X-Received: by 10.180.78.166 with SMTP id c6mr28246637wix.8.1439402186691;
 Wed, 12 Aug 2015 10:56:26 -0700 (PDT)
Received: by 10.28.152.70 with HTTP; Wed, 12 Aug 2015 10:56:26 -0700 (PDT)
In-Reply-To: <1439398807.2825.51.camel@HansenPartnership.com>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
        <1439398807.2825.51.camel@HansenPartnership.com>
Date:   Wed, 12 Aug 2015 10:56:26 -0700
Message-ID: <CAP6odjhfTHzgEivDUxXyU=VBG4U85ETxv1gcogE9GVGoGQ37-w@mail.gmail.com>
Subject: Re: RFC: prepare for struct scatterlist entries without page backing
From:   Grant Grundler <grantgrundler@gmail.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        axboe@kernel.dk, dan.j.williams@intel.com, vgupta@synopsys.com,
        hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com,
        dhowells@redhat.com, monstr@monstr.eu, x86@kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        alex.williamson@redhat.com,
        Grant Grundler <grundler@parisc-linux.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-nvdimm@ml01.01.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <grantgrundler@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grantgrundler@gmail.com
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

On Wed, Aug 12, 2015 at 10:00 AM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Wed, 2015-08-12 at 09:05 +0200, Christoph Hellwig wrote:
...
>> However the ccio (parisc) and sba_iommu (parisc & ia64) IOMMUs seem
>> to be operate mostly on virtual addresses.  It's a fairly odd concept
>> that I don't fully grasp, so I'll need some help with those if we want
>> to bring this forward.

James explained the primary function of IOMMUs on parisc (DMA-Cache
coherency) much better than I ever could.

Three more observations:
1) the IOMMU can be bypassed by 64-bit DMA devices on IA64.

2) IOMMU enables 32-bit DMA devices to reach > 32-bit physical memory
and thus avoiding bounce buffers. parisc and older IA-64 have some
32-bit PCI devices - e.g. IDE boot HDD.

3) IOMMU acts as a proxy for IO devices by fetching cachelines of data
for PA-RISC systems whose memory controllers ONLY serve cacheline
sized transactions. ie. 32-bit DMA results in the IOMMU fetching the
cacheline and updating just the 32-bits in a DMA cache coherent
fashion.

Bonus thought:
4) IOMMU can improve DMA performance in some cases using "hints"
provided by the OS (e.g. prefetching DMA data or using READ_CURRENT
bus transactions instead of normal memory fetches.)

cheers,
grant
