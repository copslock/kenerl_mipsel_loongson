Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 16:45:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41462 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012313AbbA3Pp23glWi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 16:45:28 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 35D8A351D66D1;
        Fri, 30 Jan 2015 15:45:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 15:45:22 +0000
Received: from [192.168.154.96] (192.168.154.96) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 15:45:20 +0000
Message-ID: <54CBA710.3040504@imgtec.com>
Date:   Fri, 30 Jan 2015 15:45:20 +0000
From:   Markos Chandras <Markos.Chandras@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] MIPS: Fix build errors with binutils 2.24.51+
References: <1422632420-4973-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1422632420-4973-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45580
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

On 01/30/2015 03:40 PM, James Hogan wrote:
> Fix the following build error with binutils 2.24.51+ since v3.18-rc4:
> 
> {standard input}: Assembler messages:
> {standard input}:2913: Error: opcode not supported on this processor: mips32r2 (mips32r2) `ctc1 $2,$31'
> scripts/Makefile.build:257: recipe for target 'arch/mips/kernel/traps.o' failed
> 
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: David Daney <david.daney@cavium.com>
> Cc: linux-mips@linux-mips.org
> 
> James Hogan (2):
>   MIPS: mipsregs.h: Add write_32bit_cp1_register()
>   MIPS: traps: Fix inline asm ctc1 missing .set hardfloat
> 
>  arch/mips/include/asm/mipsregs.h | 15 +++++++++++++++
>  arch/mips/kernel/traps.c         |  3 ++-
>  2 files changed, 17 insertions(+), 1 deletion(-)
> 

both look good to me. Thanks!

Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>

-- 
markos
