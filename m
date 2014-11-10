Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 17:55:22 +0100 (CET)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40523 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011908AbaKJQzUfopRV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 17:55:20 +0100
Received: by mail-ie0-f173.google.com with SMTP id tr6so9529988ieb.4
        for <multiple recipients>; Mon, 10 Nov 2014 08:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NX3whFFWLmnxsMVrpGY3r+Nqibl9A42QP3oTxl+pZAI=;
        b=w486Znwb1FOLh85KoOwYEadCNG/5dpUggccGBihfTVS4irEvTvUBy3F0ZhmXr8GnNw
         3CXWqlzLQLeY3YVzc2Nh6untGDMBrdhzi9sIDCTFsP9H7Snh/+1qMEUUYCBmLgJgAcfr
         pAkRv6tg9hD55majyIHttsaPDYvfuH9fiz7PxcIZNR5vO0N+d3mBjglE5SP2vuPIqM70
         IN61mxfP2EWpPxF0v9Pm0cPwWaZ6gaW2nHXXW1cr12PA9kOJNgIRM6KcgCTOdlWLs+ZG
         A39WdfTH4Ack3+7eyufpHjvBiMg+FCxm3o5Ye6ynwXXZEDolRF0ylh1O4f9tA7TFb3zZ
         Y7QQ==
X-Received: by 10.42.16.74 with SMTP id o10mr8725659ica.61.1415638511369;
        Mon, 10 Nov 2014 08:55:11 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id oq6sm4988049igb.2.2014.11.10.08.55.10
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Nov 2014 08:55:10 -0800 (PST)
Message-ID: <5460EDED.3030600@gmail.com>
Date:   Mon, 10 Nov 2014 08:55:09 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Joshua Kinard <kumba@gentoo.org>
CC:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com> <5458272A.7050309@gentoo.org> <54582A91.8040401@gmail.com> <20141105160945.GB13785@linux-mips.org> <545C9D4D.4090501@gentoo.org> <545D0FC4.7020205@gmail.com> <545EB09C.40006@gentoo.org> <5460636A.5090401@gentoo.org> <20141110105106.GA4302@linux-mips.org> <20141110112039.GA7294@alpha.franken.de> <5460CA1D.9060907@gentoo.org>
In-Reply-To: <5460CA1D.9060907@gentoo.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43961
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

On 11/10/2014 06:22 AM, Joshua Kinard wrote:
> On 11/10/2014 06:20, Thomas Bogendoerfer wrote:
>> On Mon, Nov 10, 2014 at 11:51:06AM +0100, Ralf Baechle wrote:
>>> Thomas,
>>>
>>> can you test CONFIG_TRANSPARENT_HUGEPAGE on an IP28?
>>>
>>> All in all the R10000's TLB is unproblematic; my gut feeling is that
>>> rather something else specific to IP27 is spoiling the broth.
>>
>> I'll give it a spin later today.
>>
>> Thomas.
>
> Try testing with and without CONFIG_HUGETLBFS in the kernel.  File systems ->
> Pseudo filesystems -> HugeTLB file system support
>
> So far, it seems adding that option in with CONFIG_TRANSPARENT_HUGEPAGE makes
> both IP27 and IP30 behave.  Without, I get data bus errors or segfaults on IP27
> running Gentoo's "emerge" program on PAGE_SIZE_4K.
>
> IP30 seems to be fine on an R12000 with or without that option, but I only have
> a dual R12K module to test against.  I've only had the R14K dual module for a
> few days, and I could not reproduce the bus errors on that module, either.  So
> I wonder if there is something funny with the hardware on the single R14K
> module, which I did get IBE's on before.  And whether that will behave once
> CONFIG_HUGETLBFS is in the kernel.
>
> If so, maybe the fix is to make CONFIG_HUGETLBFS automatically selected if
> CONFIG_TRANSPARENT_HUGEPAGE?
>

Yes, you may be on to something here.  Certianly basic huge TLB support 
must be in place for TRANSPARENT_HUGEPAGE to work.

It could be that the Kconfig symbols for the various portions of huge 
page support are missing the required dependencies.

FWIW, I always build with a huge page Kconfig options set.

I have:
$ grep HUGE .config
CONFIG_SYS_SUPPORTS_HUGETLBFS=y
CONFIG_MIPS_HUGE_TLB_SUPPORT=y
CONFIG_CPU_SUPPORTS_HUGEPAGES=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y

I suspect that you may not need CONFIG_HUGETLBFS, but 
CONFIG_HUGETLB_PAGE is probably essential.



David Daney


> --J
>
