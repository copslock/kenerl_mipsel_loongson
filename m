Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 13:52:38 +0200 (CEST)
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49055 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993891AbeHALwf0ppCR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2018 13:52:35 +0200
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (LNeuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0C62560010;
        Wed,  1 Aug 2018 11:51:25 +0000 (UTC)
Subject: Re: [PATCH v5 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To:     Luiz Capitulino <lcapitulino@redhat.com>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
References: <20180731060155.16915-1-alex@ghiti.fr>
 <20180731160640.11306628@doriath>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <1cee9f98-4cff-3e42-6cc8-088310e406d9@ghiti.fr>
Date:   Wed, 1 Aug 2018 13:50:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180731160640.11306628@doriath>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@ghiti.fr
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

On 07/31/2018 10:06 PM, Luiz Capitulino wrote:
> On Tue, 31 Jul 2018 06:01:44 +0000
> Alexandre Ghiti <alex@ghiti.fr> wrote:
>
>> [CC linux-mm for inclusion in -mm tree]
>>
>> In order to reduce copy/paste of functions across architectures and then
>> make riscv hugetlb port (and future ports) simpler and smaller, this
>> patchset intends to factorize the numerous hugetlb primitives that are
>> defined across all the architectures.
> [...]
>
>>   15 files changed, 139 insertions(+), 382 deletions(-)
> I imagine you're mostly interested in non-x86 review at this point, but
> as this series is looking amazing:
>
> Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>

It's always good to have another feedback :)
Thanks for your review Luiz,

Alex
