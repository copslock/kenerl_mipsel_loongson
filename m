Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 10:17:26 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:29873 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823119Ab3JHIRYQsbqx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 10:17:24 +0200
Message-ID: <5253BF5B.40405@imgtec.com>
Date:   Tue, 8 Oct 2013 09:16:27 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Add printing of ES bit when cache error occurs.
References: <1381137952-18340-1-git-send-email-markos.chandras@imgtec.com> <20131008050633.GD1615@linux-mips.org>
In-Reply-To: <20131008050633.GD1615@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_08_09_17_18
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38257
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

On 10/08/13 06:06, Ralf Baechle wrote:
> On Mon, Oct 07, 2013 at 10:25:52AM +0100, Markos Chandras wrote:
>
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> Print out the source of request that caused the error (ES bit) when
>> a cache error exception occurs.
>
> The reason ES isn't being printed is that not all processors that support
> a cache error exception have an ES bit.  The R4000 has it, R5000 doesn't,
> R10000 CacheErr looks rather different - and in fact MIPS32/64 make the
> entire register optional and its details implementation specific.
>
> Don't even ask me anymore which processor the implementation in the
> kernel is trying to support - probably something R7000ish, at least
> that's what guess from the 1385617929e09545f9858785ea3dc1068fedfde1
> commit log.
>
> Short of some fancy engineering, I'd suggest throwing in a switch
> statement and per processor type printks just as in parity_protection_init.
>
>    Ralf
>
Hi Ralf,

hmm i see. ok i will do that instead.
