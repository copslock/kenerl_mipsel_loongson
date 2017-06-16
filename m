Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jun 2017 04:56:55 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56545 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993859AbdFPCznPpmgY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jun 2017 04:55:43 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5DAD141BF4EF5;
        Fri, 16 Jun 2017 03:55:35 +0100 (IST)
Received: from [10.20.78.215] (10.20.78.215) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 16 Jun 2017
 03:55:35 +0100
Date:   Fri, 16 Jun 2017 03:55:26 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 0/5] MIPS: FP cleanup & no-FP support
In-Reply-To: <20170605182131.16853-1-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.00.1706160348450.23046@tp.orcam.me.uk>
References: <20170605182131.16853-1-paul.burton@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.215]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58506
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Mon, 5 Jun 2017, Paul Burton wrote:

> This series tidies up support for floating point a little, then
> introduces support for disabling it via Kconfig. The end result is that
> it becomes possible to compile a kernel which does not include any
> support for userland which makes use of floating point instructions -
> meaning that it never enables an FPU & does not include the FPU
> emulator. The benefit of this is that if you know your userland code
> will not use FP instructions then you can shrink the kernel by around
> 65KiB.
> 
> Applies atop v4.12-rc4.
> 
> Paul Burton (5):
>   MIPS: Remove unused R6000 support
>   MIPS: Move r4k FP code from r4k_switch.S to r4k_fpu.S
>   MIPS: Move r2300 FP code from r2300_switch.S to r2300_fpu.S
>   MIPS: Remove unused ST_OFF from r2300_switch.S
>   MIPS: Allow floating point support to be disabled

 Doesn't ptrace(2) require suitable updates for requests that deal with 
the FP context?  Preferably along with the last change (or maybe ahead of 
it) so that we don't have a kernel revision that presents rubbish to the 
userland (of course tools like GDB will have to be updated accordingly to 
cope, but that's out of scope for Linux itself).

 Also how about those prctl(2) calls that also operate on FP state?

  Maciej
