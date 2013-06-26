Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 17:35:17 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:18370 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823098Ab3FZPfMgZZMn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 17:35:12 +0200
Message-ID: <51CB0A20.30803@imgtec.com>
Date:   Wed, 26 Jun 2013 10:34:56 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Florian Fainelli <florian@openwrt.org>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account
 for PHYS_OFFSET"
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com> <20130626145234.GB7171@linux-mips.org>
In-Reply-To: <20130626145234.GB7171@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.60]
X-SEF-Processed: 7_3_0_01192__2013_06_26_16_35_07
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

On 06/26/2013 09:52 AM, Ralf Baechle wrote:
> On Thu, Jun 20, 2013 at 10:36:30AM -0500, Steven J. Hill wrote:
>
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> This reverts commit 3f4579252aa166641861a64f1c2883365ca126c2. It is
>> invalid because the macros CAC_ADDR and UNCAC_ADDR have a kernel
>> virtual address as an argument and also returns a kernel virtual
>> address. Using and physical address PHYS_OFFSET is blatantly wrong
>> for a macro common to multiple platforms.
>
> While the patch itself is looking sane at a glance, I'm wondering if this
> is fixing any actual bug or is just the result of a code review?
>
The new Aptiv cores are no longer bound by KSEGxxx address spaces. This 
means that the values for KUSEG, KSEG0, KSEG1, KSEG2 cannot be assumed 
to be static anymore, and some macros need to be changed accordingly.

-Steve
