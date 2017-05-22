Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 May 2017 18:43:54 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58768 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993972AbdEVQnrODj3z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 22 May 2017 18:43:47 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id BD0101A4632;
        Mon, 22 May 2017 18:43:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkn153 (rtrkn153.domain.local [192.168.236.145])
        by mail.rt-rk.com (Postfix) with ESMTPSA id A71571A22CD;
        Mon, 22 May 2017 18:43:39 +0200 (CEST)
From:   "Petar Jovanovic" <petar.jovanovic@rt-rk.com>
To:     "'David Daney'" <ddaney@caviumnetworks.com>,
        "'Maciej W. Rozycki'" <macro@imgtec.com>,
        "'Petar Jovanovic'" <Petar.Jovanovic@imgtec.com>
Cc:     <linux-mips@linux-mips.org>, <ralf@linux-mips.org>,
        <david.daney@cavium.com>
References: <1489600751-82884-1-git-send-email-petar.jovanovic@rt-rk.com> <001b01d2ae25$d7554b80$85ffe280$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D036343@BADAG02.ba.imgtec.org> <002c01d2c80f$52e66060$f8b32120$@rt-rk.com> <56EA75BA695AE044ACFB41322F6D2BF4013D048E49@BADAG02.ba.imgtec.org> <alpine.DEB.2.00.1705210223180.2590@tp.orcam.me.uk> <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com>
In-Reply-To: <22c5e59d-fb87-9dbf-1285-2a5ff3b62497@caviumnetworks.com>
Subject: RE: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and mips64r1
Date:   Mon, 22 May 2017 18:43:39 +0200
Message-ID: <003601d2d31a$90c22a20$b2467e60$@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFk0u1L5Xxe++MwOaWf1NpDgdbVAQD+Q8JBAi8P7/cBht+ufgJrlzj2AtLLO/IBy5iamKJ+nVxQ
Content-Language: en-us
Return-Path: <petar.jovanovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: petar.jovanovic@rt-rk.com
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

-----Original Message-----
From: David Daney [mailto:ddaney@caviumnetworks.com] 
Sent: Monday, May 22, 2017 6:26 PM
To: Maciej W. Rozycki <macro@imgtec.com>; Petar Jovanovic <Petar.Jovanovic@imgtec.com>
Cc: Petar Jovanovic <petar.jovanovic@rt-rk.com>; linux-mips@linux-mips.org; ralf@linux-mips.org; david.daney@cavium.com
Subject: Re: [PATCH] MIPS: Octeon: Expose support for mips32r1, mips32r2 and mips64r1

On 05/20/2017 06:37 PM, Maciej W. Rozycki wrote:
>>   I suspect it will affect more than just `show_cpuinfo', e.g. some inline
>> asm, and you could have included a justification as to why this patch is
>> correct, such as by referring to how `set_isa' sets flags in `isa_level'.

> That is correct, and exactly what I said in my reply to the patch when 
> it was posted.  When the OCTEON code was merged, different code paths 
> were taken in the kernel, and there was a deliberate decision to 
> structure mach-cavium-octeon/cpu-feature-overrides.h the way we did it.

In the current ToT, I have not seen where this change would affect apart
from show_cpuinfo(). I understood from your words it was different at the
time when the original patch was added.

Petar
