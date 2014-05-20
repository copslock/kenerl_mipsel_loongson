Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 May 2014 14:06:07 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:59926 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817165AbaETMGFLNO6C (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 May 2014 14:06:05 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 94EE59832FD32;
        Tue, 20 May 2014 13:05:55 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 20 May
 2014 13:05:58 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 20 May 2014 13:05:58 +0100
Received: from [192.168.154.137] (192.168.154.137) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 20 May
 2014 13:05:57 +0100
Message-ID: <537B4525.3080903@imgtec.com>
Date:   Tue, 20 May 2014 13:05:57 +0100
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     chenj <chenj@lemote.com>, <james.hogan@imgtec.com>
CC:     <linux-mips@linux-mips.org>, <chenhc@lemote.com>
Subject: Re: [PATCH, v3] MIPS: lib: csum_partial: more instruction paral
References: <1400587638-17791-1-git-send-email-chenj@lemote.com> <1400587772-6130-1-git-send-email-chenj@lemote.com>
In-Reply-To: <1400587772-6130-1-git-send-email-chenj@lemote.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.137]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40171
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

On 05/20/2014 01:09 PM, chenj wrote:
> Computing sum introduces true data dependency. This patch removes some
> true data depdendencies, hence instruction level parallelism is
> improved.
> 
> This patch brings at most 50% csum performance gain on Loongson 3a
> processor in our test.
> 
> One example about how this patch works is in CSUM_BIGCHUNK1:
> // ** original **    vs    ** patch applied **
>     ADDC(sum, t0)           ADDC(t0, t1)
>     ADDC(sum, t1)           ADDC(t2, t3)
>     ADDC(sum, t2)           ADDC(sum, t0)
>     ADDC(sum, t3)           ADDC(sum, t2)
> 
> In the original implementation, each ADDC(sum, ...) references the sum
> value updated by previous ADDC.
> 
> With patch applied, the first two ADDC operations are independent,
> hence can be executed simultaneously if possible.
> 
> Another example is in the "copy and sum calculating" chunk:
> // ** original **    vs    ** patch applied **
>     STORE(t0, UNIT(0)...    STORE(t0, UNIT(0)...
>     ADDC(sum, t0)           ADDC(t0, t1)
>     STORE(t1, UNIT(1)...    STORE(t1, UNIT(1)...
>     ADDC(sum, t1)           ADDC(sum, t0)
>     STORE(t2, UNIT(2)...    STORE(t2, UNIT(2)...
>     ADDC(sum, t2)           ADDC(t2, t3)
>     STORE(t3, UNIT(3)...    STORE(t3, UNIT(3)...
>     ADDC(sum, t3)           ADDC(sum, t2)
> 
> With patch applied, the second and third ADDC are independent.

Hi chenj,

You forgot to sign-off your patch

-- 
markos
