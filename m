Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Mar 2017 13:19:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:65343 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991786AbdCaLTBlwH5d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Mar 2017 13:19:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9D4ACB11C86EC;
        Fri, 31 Mar 2017 12:18:52 +0100 (IST)
Received: from [10.20.78.20] (10.20.78.20) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 31 Mar 2017
 12:18:54 +0100
Date:   Fri, 31 Mar 2017 12:18:40 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: Avoid warnings from use of dla in 32 bit
 kernels
In-Reply-To: <20170330214838.5828-1-paul.burton@imgtec.com>
Message-ID: <alpine.DEB.2.00.1703310441420.5644@tp.orcam.me.uk>
References: <20170330214838.5828-1-paul.burton@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.20]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57507
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

On Thu, 30 Mar 2017, Paul Burton wrote:

> One seemingly straightforward fix would be to make use of the PTR_LA
> macro to emit the appropriate pseudo-instruction, however this would
> involve including asm.h which is intended solely for inclusion in
> assembly code. When included by C code its definition of various generic
> & non-namespaced macros such as LONG, PTR, CAT etc cause numerous build
> failures.

 This is however exactly what we do in several places, and I would 
recommend here as well.  Can you point me at the earlier review of your 
proposal?

> Instead fix this by adding a ".set gp=64" directive to inform the
> assembler that general purpose registers are 64 bit for the dla
> instruction. This is a lie, but no more so than using the dla
> instruction to begin with.

 I agree using DLA unconditionally is wrong, so if using <asm/asm.h> and 
its PTR_LA turns out infeasible indeed, then please define a local macro 
that expands to LA or DLA as appropriate and does not cause a namespace 
issue, and use it in `instruction_hazard' (all instances) rather than this 
horrible hack.

  Maciej
