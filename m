Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 09:38:19 +0200 (CEST)
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38941 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993941AbeHTHiQhwXeJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 09:38:16 +0200
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (LNeuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 386B21BF207;
        Mon, 20 Aug 2018 07:37:50 +0000 (UTC)
Subject: Re: [PATCH v6 00/11] hugetlb: Factorize hugetlb architecture
 primitives
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, ysato@users.sourceforge.jp,
        dalias@libc.org, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180806175711.24438-1-alex@ghiti.fr>
 <81078a7f-09cf-7f19-f6bb-8a1f4968d6fb@ghiti.fr>
 <20180820071730.GC29735@dhcp22.suse.cz>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <00b8c047-3ab5-f86b-41e5-d87950f10c21@ghiti.fr>
Date:   Mon, 20 Aug 2018 09:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180820071730.GC29735@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <alex@ghiti.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65652
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

Ok, my bad, sorry about that, I have just added Andrew as CC then.

Thank you,

Alex


On 08/20/2018 09:17 AM, Michal Hocko wrote:
> On Mon 20-08-18 08:45:10, Alexandre Ghiti wrote:
>> Hi Michal,
>>
>> This patchset got acked, tested and reviewed by quite a few people, and it
>> has been suggested
>> that it should be included in -mm tree: could you tell me if something else
>> needs to be done for
>> its inclusion ?
>>
>> Thanks for your time,
> I didn't really get to look at the series but seeing an Ack from Mike
> and arch maintainers should be good enough for it to go. This email
> doesn't have Andrew Morton in the CC list so you should add him if you
> want the series to land into the mm tree.
