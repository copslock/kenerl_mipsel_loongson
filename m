Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 10:45:28 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:19211 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008889AbbGNIp0ZGaqx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 10:45:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A63F8A675CCAA;
        Tue, 14 Jul 2015 09:45:18 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 14 Jul 2015 09:45:20 +0100
Received: from [192.168.154.48] (192.168.154.48) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 14 Jul
 2015 09:45:20 +0100
Subject: Re: [PATCH v2 10/19] MIPS: asm: mips-cm: Extend CM accessors for
 64-bit CPUs
To:     Paul Burton <paul.burton@imgtec.com>
References: <1436434853-30001-11-git-send-email-markos.chandras@imgtec.com>
 <1436861652-2063-1-git-send-email-markos.chandras@imgtec.com>
 <20150714083019.GD2519@NP-P-BURTON> <20150714083539.GF2519@NP-P-BURTON>
CC:     <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        Andrew Bresticker <abrestic@chromium.org>
From:   Markos Chandras <Markos.Chandras@imgtec.com>
Message-ID: <55A4CC20.7040902@imgtec.com>
Date:   Tue, 14 Jul 2015 09:45:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
MIME-Version: 1.0
In-Reply-To: <20150714083539.GF2519@NP-P-BURTON>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.48]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Markos.Chandras@imgtec.com
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

On 07/14/2015 09:35 AM, Paul Burton wrote:
> On Tue, Jul 14, 2015 at 09:30:19AM +0100, Paul Burton wrote:
>> On Tue, Jul 14, 2015 at 09:14:12AM +0100, Markos Chandras wrote:
>>> Previously, the CM accessors were only accessing CM registers as u32
>>> types instead of using the native CM register with. However, newer CMs
>>> may actually be 64-bit on MIPS64 cores. Fortunately, current 64-bit CMs
>>> (CM3) hold all the useful configuration bits in the lower half of the
>>> 64-bit registers (at least most of them) so they can still be accessed
>>> using the current 32-bit accessors.
>>>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Andrew Bresticker <abrestic@chromium.org>
>>> Cc: Paul Burton <paul.burton@imgtec.com>
>>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>>> ---
>>> Changes since v1
>>> - Use 32-bit CM I/O on 32-bit kernels
>>
>> A concern I have, but haven't yet drank enough coffee to think through
>> fully, is whether this will work on big endian systems. These are 64b
>> addresses and you're writing 32b to their addresses which I suspect may
>> go horribly wrong.
> 
> Should be:
> 
> "These are 64b registers and you're writing 32b to their addresses"
> 
> Apparently I haven't drunk enouugh coffee to formulate sentences yet
> either ;)
> 
> Thanks,
>     Paul
> 

The HW team told me that the CM regs can be accessed in LE-pair format
even on big-endian cores in the sense that bit0 of a 64-bit CM reg will
always be on the lower address. I have never tested that really.

-- 
markos
