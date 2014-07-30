Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 19:34:59 +0200 (CEST)
Received: from p54BA937B.dip0.t-ipconnect.de ([84.186.147.123]:56762 "EHLO
        linux-mips.org" rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org
        with ESMTP id S6860076AbaG3RevtaLir (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 19:34:51 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s6UHYmtb002643;
        Wed, 30 Jul 2014 19:34:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s6UHYlsK002642;
        Wed, 30 Jul 2014 19:34:47 +0200
Date:   Wed, 30 Jul 2014 19:34:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: prevent user from setting FCSR cause bits
Message-ID: <20140730173446.GB27790@linux-mips.org>
References: <1406035281-693-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1406035281-693-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41817
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

On Tue, Jul 22, 2014 at 02:21:21PM +0100, Paul Burton wrote:

> If one or more matching FCSR cause & enable bits are set in saved thread
> context then when that context is restored the kernel will take an FP
> exception. This is of course undesirable and considered an oops, leading
> to the kernel writing a backtrace to the console and potentially
> rebooting depending upon the configuration. Thus the kernel avoids this
> situation by clearing the cause bits of the FCSR register when handling
> FP exceptions and after emulating FP instructions.
> 
> However the kernel does not prevent userland from setting arbitrary FCSR
> cause & enable bits via ptrace, using either the PTRACE_POKEUSR or
> PTRACE_SETFPREGS requests. This means userland can trivially cause the
> kernel to oops on any system with an FPU. Prevent this from happening
> by clearing the cause bits when writing to the saved FCSR context via
> ptrace.
> 
> This problem appears to exist at least back to the beginning of the git
> era in the PTRACE_POKEUSR case.

Good catch - but I think something like UML on a more proper fix.  How
until then I'm going to apply this.

  Ralf
