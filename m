Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Sep 2014 16:23:42 +0200 (CEST)
Received: from mail-we0-f176.google.com ([74.125.82.176]:52454 "EHLO
        mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008807AbaINOXkeJsa6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Sep 2014 16:23:40 +0200
Received: by mail-we0-f176.google.com with SMTP id q58so2831681wes.21
        for <multiple recipients>; Sun, 14 Sep 2014 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mL++IjCUSU16DLqFfg9Zvm5qiQGypNhCxr8jgPXRQfM=;
        b=pXSnV5Xge52PewPfxUf3W3sqGh+vOf1Gcu6G6tI1ulWHBP+9mmzCTcDWCWiEo/nfCX
         HVnlymMMtnHNYwg5D1DeLqAesheH2TeBH2aekcPo3NCZHL2kbik/gCVkFCrBKKeoF+jc
         b5sk041EPS21ATRfGmt2yvjkr32ImqCB2AZ3mpHR+K7efjeY1O392P9TyPTMD/qUo1az
         YSvdE/IXtjrf7lyO7xln+YDo8POhdbofq3kOuIRiNaCNL8xMyDQAx1OHp5LhaEpELHP/
         VkvzjbiFwnOpiiWVm35zUb+ixIdOKxTf7Pt0JV0EWvJGjqvdr79bIPlYgc3RA5sUOdoA
         ADBQ==
X-Received: by 10.194.186.178 with SMTP id fl18mr26335386wjc.8.1410704615309;
        Sun, 14 Sep 2014 07:23:35 -0700 (PDT)
Received: from yakj.usersys.redhat.com (net-37-116-212-135.cust.vodafonedsl.it. [37.116.212.135])
        by mx.google.com with ESMTPSA id mv14sm8320604wic.20.2014.09.14.07.23.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2014 07:23:33 -0700 (PDT)
Message-ID: <5415A4DF.90706@redhat.com>
Date:   Sun, 14 Sep 2014 16:23:27 +0200
From:   Paolo Bonzini <pbonzini@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
MIME-Version: 1.0
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     kvm@vger.kernel.org,
        Christoffer Dall <christoffer.dall@linaro.org>,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH] mm: export symbol dependencies of is_zero_pfn()
References: <1410553043-575-1-git-send-email-ard.biesheuvel@linaro.org> <20140912141429.17d570d1a7e1cb99ec73f0f7@linux-foundation.org> <CAKv+Gu8=9tVmKtp5s_SyXF7mGjZ7r9x4iBYnyYfNpBogA9ShVg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8=9tVmKtp5s_SyXF7mGjZ7r9x4iBYnyYfNpBogA9ShVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <paolo.bonzini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pbonzini@redhat.com
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

Il 12/09/2014 23:19, Ard Biesheuvel ha scritto:
> On 12 September 2014 23:14, Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Fri, 12 Sep 2014 22:17:23 +0200 Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>
>>> In order to make the static inline function is_zero_pfn() callable by
>>> modules, export its symbol dependencies 'zero_pfn' and (for s390 and
>>> mips) 'zero_page_mask'.
>>
>> So hexagon and score get the export if/when needed.
>>
> 
> Exactly.
> 
>>> We need this for KVM, as CONFIG_KVM is a tristate for all supported
>>> architectures except ARM and arm64, and testing a pfn whether it refers
>>> to the zero page is required to correctly distinguish the zero page
>>> from other special RAM ranges that may also have the PG_reserved bit
>>> set, but need to be treated as MMIO memory.
>>>
>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>> ---
>>>  arch/mips/mm/init.c | 1 +
>>>  arch/s390/mm/init.c | 1 +
>>>  mm/memory.c         | 2 ++
>>
>> Looks OK to me.  Please include the patch in whichever tree is is that
>> needs it, and merge it up via that tree.
>>
> 
> Thanks.
> 
> @Paolo: could you please take this (with Andrew's ack), and put it
> before the patch you took earlier today?

Yes, will do.

Paolo
