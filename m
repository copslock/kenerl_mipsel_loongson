Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2014 23:19:34 +0200 (CEST)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:65279 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008338AbaILVTdCQo1U (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Sep 2014 23:19:33 +0200
Received: by mail-lb0-f181.google.com with SMTP id z11so1613463lbi.26
        for <linux-mips@linux-mips.org>; Fri, 12 Sep 2014 14:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EqhqjRug8UbBHpLK5ON3OXYF8egoQTE4kiJJPLcMCj4=;
        b=QA6t05Hac6abfEr46Dz6pt1ezLRO+VZ/ETuYyZc2/JJBxRrHVD+IWzQGF53GDH6ILf
         p3V/JAs4L9SXBfaqzjSRxYaTsrlCKWlQRmy3giMdDLuMYgb2Y0GAefDwqmB0V0uqnAFb
         on7mIAczcHxqRva5JnZ8ZnjtFZbDM4t10zgGtgrf5kgqKdtO2VGff//USU2o15EB63/+
         I12rRPg8JH4TCPF767cEpuczfxOS/2oBI+TtAV3MLdJ8ms7uXAkDyM7XQBCyij32qV8B
         7R7C/pgiRqBS2HTuR1rbWwC3b7W5LR9P4Fdj1etzsKNTZZ4oM2jXv/uUQqLrCbKOoNVD
         C/Gg==
X-Gm-Message-State: ALoCoQkYJb5Ps2ptKZ2om0triDqsUhM2tk6KifETEJD4u9+FaQWnjNXJZBpy25fTCK0Qpm8UShql
MIME-Version: 1.0
X-Received: by 10.152.44.230 with SMTP id h6mr11650633lam.51.1410556767456;
 Fri, 12 Sep 2014 14:19:27 -0700 (PDT)
Received: by 10.112.84.67 with HTTP; Fri, 12 Sep 2014 14:19:27 -0700 (PDT)
In-Reply-To: <20140912141429.17d570d1a7e1cb99ec73f0f7@linux-foundation.org>
References: <1410553043-575-1-git-send-email-ard.biesheuvel@linaro.org>
        <20140912141429.17d570d1a7e1cb99ec73f0f7@linux-foundation.org>
Date:   Fri, 12 Sep 2014 23:19:27 +0200
Message-ID: <CAKv+Gu8=9tVmKtp5s_SyXF7mGjZ7r9x4iBYnyYfNpBogA9ShVg@mail.gmail.com>
Subject: Re: [PATCH] mm: export symbol dependencies of is_zero_pfn()
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com,
        Christoffer Dall <christoffer.dall@linaro.org>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <ard.biesheuvel@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ard.biesheuvel@linaro.org
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

On 12 September 2014 23:14, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Fri, 12 Sep 2014 22:17:23 +0200 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> In order to make the static inline function is_zero_pfn() callable by
>> modules, export its symbol dependencies 'zero_pfn' and (for s390 and
>> mips) 'zero_page_mask'.
>
> So hexagon and score get the export if/when needed.
>

Exactly.

>> We need this for KVM, as CONFIG_KVM is a tristate for all supported
>> architectures except ARM and arm64, and testing a pfn whether it refers
>> to the zero page is required to correctly distinguish the zero page
>> from other special RAM ranges that may also have the PG_reserved bit
>> set, but need to be treated as MMIO memory.
>>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/mips/mm/init.c | 1 +
>>  arch/s390/mm/init.c | 1 +
>>  mm/memory.c         | 2 ++
>
> Looks OK to me.  Please include the patch in whichever tree is is that
> needs it, and merge it up via that tree.
>

Thanks.

@Paolo: could you please take this (with Andrew's ack), and put it
before the patch you took earlier today?

Thanks,
Ard.
