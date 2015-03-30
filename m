Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2015 22:10:27 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:50261 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014780AbbC3UKZFL25j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Mar 2015 22:10:25 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t2UKAIXf013497;
        Mon, 30 Mar 2015 22:10:18 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t2UKAF3d013496;
        Mon, 30 Mar 2015 22:10:15 +0200
Date:   Mon, 30 Mar 2015 22:10:15 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     cee1 <fykcee1@gmail.com>
Cc:     linux-mips@linux-mips.org, Chen Jie <chenj@lemote.com>
Subject: Re: [v5] MIPS: lib: csum_partial: more instruction paral
Message-ID: <20150330201015.GA3757@linux-mips.org>
References: <1427389644-92793-1-git-send-email-fykcee1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427389644-92793-1-git-send-email-fykcee1@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Mar 27, 2015 at 01:07:24AM +0800, cee1 wrote:

> From: Chen Jie <chenj@lemote.com>
> 
> Computing sum introduces true data dependency. This patch removes some
> true data depdendencies, hence increases instruction level parallelism.
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
> In the original implementation, each ADDC(sum, ...) depends on the sum
> value updated by previous ADDC(as source operand).
> 
> With this patch applied, the first two ADDC operations are independent,
> hence can be executed simultaneously if possible.
> 
> Another example is in the "copy and sum calculating chunk":
> // ** original **    vs    ** patch applied **
>     STORE(t0, UNIT(0) ...   STORE(t0, UNIT(0) ...
>     ADDC(sum, t0)           ADDC(t0, t1)
>     STORE(t1, UNIT(1) ...   STORE(t1, UNIT(1) ...
>     ADDC(sum, t1)           ADDC(sum, t0)
>     STORE(t2, UNIT(2) ...   STORE(t2, UNIT(2) ...
>     ADDC(sum, t2)           ADDC(t2, t3)
>     STORE(t3, UNIT(3) ...   STORE(t3, UNIT(3) ...
>     ADDC(sum, t3)           ADDC(sum, t2)
> 
> With this patch applied, ADDC and the **next next** ADDC are independent.

This is interesting because even CPUs as old as the R2000 have a pipeline
bypass which allows an instruction to use a result written to a register
by an immediately preceeeding instruction.

Can you explain why this patch is so beneficial for Loongson 3A?

Thanks,

  Ralf
