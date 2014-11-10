Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 15:22:39 +0100 (CET)
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:59672 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbaKJOWar4a6r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 15:22:30 +0100
Received: from resomta-po-10v.sys.comcast.net ([96.114.154.234])
        by resqmta-po-03v.sys.comcast.net with comcast
        id DqMf1p00653iAfU01qNQZC; Mon, 10 Nov 2014 14:22:24 +0000
Received: from [192.168.1.13] ([76.100.35.31])
        by resomta-po-10v.sys.comcast.net with comcast
        id DqNM1p00Z0gJalY01qNNuK; Mon, 10 Nov 2014 14:22:23 +0000
Message-ID: <5460CA1D.9060907@gentoo.org>
Date:   Mon, 10 Nov 2014 09:22:21 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com> <5458272A.7050309@gentoo.org> <54582A91.8040401@gmail.com> <20141105160945.GB13785@linux-mips.org> <545C9D4D.4090501@gentoo.org> <545D0FC4.7020205@gmail.com> <545EB09C.40006@gentoo.org> <5460636A.5090401@gentoo.org> <20141110105106.GA4302@linux-mips.org> <20141110112039.GA7294@alpha.franken.de>
In-Reply-To: <20141110112039.GA7294@alpha.franken.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415629344;
        bh=1VU3slWM0IGC2l4E+ZLf13cOs3oD6q9gdptKfmnNxu8=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=ejIdfrdXboMCYSKuobdY9YsgwPUrgeY9nd438VG2CSqwprC2Ks0AjO4t2S7esFj1r
         X28Fu4oFWjul5nWIbq6o3fJcr9oPEaV6NSUayicB8pPQ9+kuig/1MSHZtp2AfU2s6D
         JwsN2Bmp2l4kMS2+UZVQqXLEUH/SGRxTF23OYyeowGxzgtuEcS80NUi9xkcR7cjT22
         1O08G14dATzuFFKLTd4nTDrS/vQ8OBYD0OolpfxQxAaUVmFwaLOLMfycUCgJojKiiC
         KGsEmQGPDeuJA70bP5wypzjBOSvirGzn8JtA05Fo393HSMVMK7GAnZvlXqV5TkwWfV
         ECy+pXQYmKgXw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 11/10/2014 06:20, Thomas Bogendoerfer wrote:
> On Mon, Nov 10, 2014 at 11:51:06AM +0100, Ralf Baechle wrote:
>> Thomas,
>>
>> can you test CONFIG_TRANSPARENT_HUGEPAGE on an IP28?
>>
>> All in all the R10000's TLB is unproblematic; my gut feeling is that
>> rather something else specific to IP27 is spoiling the broth.
> 
> I'll give it a spin later today.
> 
> Thomas.

Try testing with and without CONFIG_HUGETLBFS in the kernel.  File systems ->
Pseudo filesystems -> HugeTLB file system support

So far, it seems adding that option in with CONFIG_TRANSPARENT_HUGEPAGE makes
both IP27 and IP30 behave.  Without, I get data bus errors or segfaults on IP27
running Gentoo's "emerge" program on PAGE_SIZE_4K.

IP30 seems to be fine on an R12000 with or without that option, but I only have
a dual R12K module to test against.  I've only had the R14K dual module for a
few days, and I could not reproduce the bus errors on that module, either.  So
I wonder if there is something funny with the hardware on the single R14K
module, which I did get IBE's on before.  And whether that will behave once
CONFIG_HUGETLBFS is in the kernel.

If so, maybe the fix is to make CONFIG_HUGETLBFS automatically selected if
CONFIG_TRANSPARENT_HUGEPAGE?

--J
