Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 18:29:30 +0100 (CET)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:54303 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013255AbaKJR332xdUB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 18:29:29 +0100
Received: by mail-ie0-f170.google.com with SMTP id tp5so9729362ieb.29
        for <multiple recipients>; Mon, 10 Nov 2014 09:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Dcf6XwuMB1LzLnAD2KKX5A8Xz/AqCsm16/8vpUzVjA0=;
        b=VXnaRPv+/EZhNGAgeIPwK2WAtvi9ntjIKvdXtza0V2nZzLsP4e+5D7ZbROFZr18iap
         Trh59OnTMaOQPu1CO7MyZWh+L73Sdp+c1xNd77vkTSk0Wg8fILDP+2UXyftgsb+4WZoM
         Di0sd9xNV+DHSQF8ltwfYIXafkZ3V2Kb4HuYkdsED63PUtoKB9UYL7RAupUNeQKhCLe1
         8z5pLvCBGyAuPik457+1wW9Awj8Bv/biXcd+dIMCQtnOL0CCJR4Ef00yNMFug/zSjB2M
         EuyUN6dvuYzdCoo5jDAi7V7VGX3lxwgOIDcHmg/gWI5+4aNesDPpG1rHrBrNrx/38BOO
         uI+w==
X-Received: by 10.50.77.7 with SMTP id o7mr26793617igw.18.1415640563159;
        Mon, 10 Nov 2014 09:29:23 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id m125sm8521335iom.6.2014.11.10.09.29.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Nov 2014 09:29:22 -0800 (PST)
Message-ID: <5460F5F1.3070203@gmail.com>
Date:   Mon, 10 Nov 2014 09:29:21 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Joshua Kinard <kumba@gentoo.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54582A91.8040401@gmail.com> <20141105160945.GB13785@linux-mips.org> <545C9D4D.4090501@gentoo.org> <545D0FC4.7020205@gmail.com> <545EB09C.40006@gentoo.org> <5460636A.5090401@gentoo.org> <20141110105106.GA4302@linux-mips.org> <20141110112039.GA7294@alpha.franken.de> <5460CA1D.9060907@gentoo.org> <5460EDED.3030600@gmail.com> <20141110170357.GB11091@linux-mips.org>
In-Reply-To: <20141110170357.GB11091@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 11/10/2014 09:03 AM, Ralf Baechle wrote:
> On Mon, Nov 10, 2014 at 08:55:09AM -0800, David Daney wrote:
>
>> Yes, you may be on to something here.  Certianly basic huge TLB support must
>> be in place for TRANSPARENT_HUGEPAGE to work.
>>
>> It could be that the Kconfig symbols for the various portions of huge page
>> support are missing the required dependencies.
>>
>> FWIW, I always build with a huge page Kconfig options set.
>>
>> I have:
>> $ grep HUGE .config
>> CONFIG_SYS_SUPPORTS_HUGETLBFS=y
>> CONFIG_MIPS_HUGE_TLB_SUPPORT=y
>> CONFIG_CPU_SUPPORTS_HUGEPAGES=y
>> CONFIG_TRANSPARENT_HUGEPAGE=y
>> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
>> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
>> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
>> CONFIG_HUGETLBFS=y
>> CONFIG_HUGETLB_PAGE=y
>>
>> I suspect that you may not need CONFIG_HUGETLBFS, but CONFIG_HUGETLB_PAGE is
>> probably essential.
>
> IP27 also has NUMA as the only in-tree MIPS system - and it's NUMA support
> is not in the best support state to say the least.  Just an observation -
> at this point in time there is no obvious connection between either
>
>    R10000 <-> transparent huge page
>
> or
>
>    NUMA <-> transparent huge page
>
>    Ralf
>

FYI, I am running with CONFIG_TRANSPARENT_HUGEPAGE on a 2-node NUMA 
system (48 CPUs per node) OCTEON III, and the huge pages have not been 
an issue.  So I don't think there are any inherent NUMA issues with 
HUGEPAGES.

David Daney
