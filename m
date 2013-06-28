Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Jun 2013 23:31:10 +0200 (CEST)
Received: from multi.imgtec.com ([194.200.65.239]:34173 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823114Ab3F1VbJLqe6R (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 28 Jun 2013 23:31:09 +0200
Message-ID: <51CE003A.5040902@imgtec.com>
Date:   Fri, 28 Jun 2013 16:29:30 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
MIME-Version: 1.0
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W . Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: Reduce kernel binary size.
References: <1372454107-7784-1-git-send-email-Steven.Hill@imgtec.com>
In-Reply-To: <1372454107-7784-1-git-send-email-Steven.Hill@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.159.67]
X-SEF-Processed: 7_3_0_01192__2013_06_28_22_31_03
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37213
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

Ralf,

Take note of the addition of '#ifdef CONFIG_SYS_HAS_CPU_R10000' around 
the 'cpu_is_noncoherent_r10000' and empty inline function if we're not 
one of the SGI platforms. Without the the empty inline function, I get 
an internal compiler compiler error. It results from the new 
'current_cpu_type()' function you added. Essentially two functions are 
going to get optimized out. The compiler does not seem to complete that 
successfully. Here is the message:

   CC      arch/mips/mm/dma-default.o
arch/mips/mm/dma-default.c: In function 'mips_dma_sync_sg_for_cpu':
arch/mips/mm/dma-default.c:320:1: internal compiler error: in 
add_insn_before, at emit-rtl.c:3852

Maciej, what are we dealing with here? Thanks.

-Steve
