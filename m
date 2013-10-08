Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Oct 2013 14:43:34 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:29832 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827313Ab3JHMn2XWhqv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 Oct 2013 14:43:28 +0200
Message-ID: <5253FDFC.80007@imgtec.com>
Date:   Tue, 8 Oct 2013 13:43:40 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH] MIPS: Print correct PC in trace dump after NMI exception
References: <1381232371-25017-1-git-send-email-markos.chandras@imgtec.com> <20131008121546.GI1615@linux-mips.org> <5253FB20.7050909@imgtec.com> <20131008123859.GK1615@linux-mips.org>
In-Reply-To: <20131008123859.GK1615@linux-mips.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.31]
X-SEF-Processed: 7_3_0_01192__2013_10_08_13_43_23
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38270
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



markos

On 10/08/13 13:38, Ralf Baechle wrote:
> On Tue, Oct 08, 2013 at 01:31:28PM +0100, Markos Chandras wrote:
>
>>> If you were afraid gas might use $1 expanding this macro instruction - no,
>>> it won't.  A belt & suspenders approach might be to drop in a ".set noat";
>>> it would make the assembler throw an error if should ever see the need to
>>> use $1.
>>>
>> yeah i don't think the assembler would pick $1 in this case but we
>> could add ".set noat" just to be safe i suppose.
>>
>> Thanks for the review. Could you fix these problems for me or should
>> i submit a new patch?
>
> It's trivial enough so I'm going to do it.
>
> The NMI handler btw. was already wrapped with .set push; .set noat; ...
> .set pop.
>
>    Ralf
>
yeah i just noticed. Thank you!
