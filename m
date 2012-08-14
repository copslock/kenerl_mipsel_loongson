Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Aug 2012 15:39:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:55436 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903798Ab2HNNjB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Aug 2012 15:39:01 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q7EDcxMp002305;
        Tue, 14 Aug 2012 15:38:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q7EDcwmp002303;
        Tue, 14 Aug 2012 15:38:58 +0200
Date:   Tue, 14 Aug 2012 15:38:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: Netlogic: define cpu_has_fpu macro
Message-ID: <20120814133858.GA30856@linux-mips.org>
References: <1344950773-29299-1-git-send-email-jchandra@broadcom.com>
 <1344950773-29299-2-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1344950773-29299-2-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34156
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Aug 14, 2012 at 06:56:12PM +0530, Jayachandran C wrote:

> The default implementation of 'cpu_has_fpu' macro calls
> smp_processor_id() which causes this warning when preemption is enabled:
> 
> [    4.664000] Algorithmics/MIPS FPU Emulator v1.5
> [    4.676000] BUG: using smp_processor_id() in preemptible [00000000] code: init/1
> [    4.700000] caller is fpu_emulator_cop1Handler+0x434/0x27b8
> 
> Work around this by defining cpu_has_fpu for XLR and XLP in
> mach-netlogic/cpu-feature-overrides.h

Where is cpu_has_fpu being invoked from?  For exactly the scenario you're
running into there is raw_cpu_has_fpu and I wonder if the caller should be
switched to that instead.

  Ralf
