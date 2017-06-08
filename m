Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Jun 2017 15:11:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38510 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993865AbdFHNLvTlZpQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Jun 2017 15:11:51 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v58DBgsi008053;
        Thu, 8 Jun 2017 15:11:42 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v58DBfO0008052;
        Thu, 8 Jun 2017 15:11:41 +0200
Date:   Thu, 8 Jun 2017 15:11:41 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     James Hogan <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4/9] MIPS: Send SIGILL for BPOSGE32 in
 `__compute_return_epc_for_insn'
Message-ID: <20170608131141.GB8108@linux-mips.org>
References: <alpine.DEB.2.00.1706040314270.10864@tp.orcam.me.uk>
 <alpine.DEB.2.00.1706050258410.10864@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1706050258410.10864@tp.orcam.me.uk>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58307
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

On Tue, Jun 06, 2017 at 12:17:05AM +0100, Maciej W. Rozycki wrote:

> Fix commit e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP ASE.") and 
> send SIGILL rather than SIGBUS whenever an unimplemented BPOSGE32 DSP 
> ASE instruction has been encountered in `__compute_return_epc_for_insn' 
> as our Reserved Instruction exception handler would in response to an 
> attempt to actually execute the instruction.  Sending SIGBUS only makes 
> sense for the unaligned PC case, since moved to `__compute_return_epc'.  
> Adjust function documentation accordingly, correct formatting and use
> `pr_info' rather than `printk' as the other exit path already does.
> 
> Cc: stable@vger.kernel.org # 2.6.14+
> Fixes: e50c0a8fa60d ("Support the MIPS32 / MIPS64 DSP ASE.")
> Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> ---
>  I hope folding the formatting fix and `pr_info' update with the base 
> change is fine given that they all apply to the same code line.

Ok, but ...

>  sigill_dsp:
> -	printk("%s: DSP branch but not DSP ASE - sending SIGBUS.\n", current->comm);
> -	force_sig(SIGBUS, current);
> +	pr_info("%s: DSP branch but not DSP ASE - sending SIGILL.\n",
> +		current->comm);

Shouldn't this then maybe be a pr_debug then?  With pr_info the right
kind of program can produce lots of useless clutter.

  Ralf
