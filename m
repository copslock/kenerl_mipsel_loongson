Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2016 00:27:56 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:41269 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992168AbcIVW1tlYQfo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Sep 2016 00:27:49 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 60CB44ADA50AC;
        Thu, 22 Sep 2016 23:27:39 +0100 (IST)
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 22 Sep
 2016 23:27:43 +0100
Received: from [10.20.2.61] (10.20.2.61) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.266.1; Thu, 22 Sep
 2016 15:27:41 -0700
Message-ID: <57E45ADD.6000202@imgtec.com>
Date:   Thu, 22 Sep 2016 15:27:41 -0700
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 7/9] MIPS: uprobes: Flush icache via kernel address
References: <cover.d93e43428f3c573bdd18d7c874830705b39c3a8a.1472747205.git-series.james.hogan@imgtec.com> <0d915756776de050b8a92b5bb5d4e7ffbe784d66.1472747205.git-series.james.hogan@imgtec.com> <20160921132656.GF14137@linux-mips.org> <57E2CE5B.8020406@imgtec.com> <20160922211527.GB7352@jhogan-linux.le.imgtec.org> <57E44F59.5050600@imgtec.com> <7C466D41-C786-48E0-9BFB-1024D6F9AFFC@imgtec.com>
In-Reply-To: <7C466D41-C786-48E0-9BFB-1024D6F9AFFC@imgtec.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.2.61]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55245
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

On 09/22/2016 03:13 PM, James Hogan wrote:
> well it'll do a protected dcache flush (i.e. using CACHEE with EVA). Would kmap/kunmap or variants (fixed to work with aliasing dcache) be able to take care of colouring / further flushing?

We should flush kernel D-cache and user I-cache in any cache aliasing 
system. I was wrong - a fixed HIGHMEM doesn't do any difference 
actually, because page may be located in directly addressed memory (all 
HIGHMEM stuff is irrelevant in this case, kmap returns a lowmem address).

>
> In any case, simply changing to the user_ one is a no-op compared to leaving as is where patch 9 would probably break it on EVA by making it operate only on kernel addresses.

EVA or not has no difference here - kernel address can still be a 
different color to user address.

And keeping kernel I-cache flush does break it really, not EVA.

- Leonid.
