Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 May 2016 14:18:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:34938 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27040881AbcEaMSeZNJ-i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 31 May 2016 14:18:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 75451679D1331;
        Tue, 31 May 2016 13:18:25 +0100 (IST)
Received: from [192.168.154.26] (192.168.154.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 31 May
 2016 13:18:28 +0100
Subject: Re: [PATCH] MIPS: lib: Mark intrinsics notrace
To:     Ralf Baechle <ralf@linux-mips.org>
References: <20160525100635.22541-1-harvey.hunt@imgtec.com>
 <20160529210340.GA25587@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        "# 4 . 2 . x-" <stable@vger.kernel.org>
From:   Harvey Hunt <harvey.hunt@imgtec.com>
Message-ID: <eab5a895-a174-9d2c-16ba-f660c04190ba@imgtec.com>
Date:   Tue, 31 May 2016 13:18:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160529210340.GA25587@linux-mips.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.26]
Return-Path: <Harvey.Hunt@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: harvey.hunt@imgtec.com
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

Hi Ralf,

On 29/05/16 22:03, Ralf Baechle wrote:
> On Wed, May 25, 2016 at 11:06:35AM +0100, Harvey Hunt wrote:
>
>> On certain MIPS32 devices, the ftrace tracer "function_graph" uses
>> __lshrdi3() during the capturing of trace data. ftrace then attempts to
>> trace __lshrdi3() which leads to infinite recursion and a stack overflow.
>> Fix this by marking __lshrdi3() as notrace. Mark the other compiler
>> intrinsics as notrace in case the compiler decides to use them in the
>> ftrace path.
>
> Makes perfect sense - but I'm wondering how you triggered it.  Was this
> a build with the GCC option -Os that is CONFIG_CC_OPTIMIZE_FOR_SIZE?
> Usually people build with CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE that is -O2
> which results in intrinsics being inlined.

This is triggered by building with CONFIG_CC_OPTIMIZE_FOR_SIZE. This 
explains why I only saw it on certain MIPS32 devices - Malta's 
defconfigs don't have CONFIG_CC_OPTIMIZE_FOR_SIZE enabled, but the 
pistachio and Ci20 defconfigs do.

>
>   Ralf
>

Thanks,

Harvey
