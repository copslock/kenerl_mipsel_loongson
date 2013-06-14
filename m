Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Jun 2013 13:12:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:60681 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827506Ab3FNLMc2cd7Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Jun 2013 13:12:32 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5EBCQvv019368;
        Fri, 14 Jun 2013 13:12:26 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5EBCNHk019367;
        Fri, 14 Jun 2013 13:12:23 +0200
Date:   Fri, 14 Jun 2013 13:12:23 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via
 the MIPS-VZ extensions.
Message-ID: <20130614111223.GB15775@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36877
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

On Fri, Jun 07, 2013 at 04:03:04PM -0700, David Daney wrote:

> Subject: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via the
>  MIPS-VZ extensions.
> 
> From: David Daney <david.daney@cavium.com>
> 
> These patches take a somewhat different approach to MIPS
> virtualization via the MIPS-VZ extensions than the patches previously
> sent by Sanjay Lal.
> 
> Several facts about the code:
> 
> o Existing exception handlers are modified to hook in to KVM instead
>   of intercepting all exceptions via the EBase register, and then
>   chaining to real exception handlers.
> 
> o Able to boot 64-bit SMP guests that use the FPU (I have booted 4-way
>   SMP 64-bit MIPS/Linux).
> 
> o Additional overhead on every exception even when *no* vCPU is running.
> 
> o Lower interrupt overhead, than the EBase interception method, when
>   vCPU *is* running.
> 
> o This code is somewhat smaller than the existing trap/emulate
>   implementation (about 2100 lines vs. about 5300 lines)
> 
> o Currently probably only usable on the OCTEON III CPU model, as some
>   MIPS-VZ implementation-defined behaviors were assumed to have the
>   OCTEON III behavior.
> 
> Note: I think Ralf already has the 17/31 (MIPS: Quit exposing Kconfig
> symbols in uapi headers.) queued, but I also include it here.

Yes; as the references to CONFIG_* symbols in UAPI were a bug, I've
already merged this patch for 3.10 as 8f657933a3c2086d4731350c98f91a990783c0d3
[MIPS: Quit exposing Kconfig symbols in uapi headers.]

  Ralf
