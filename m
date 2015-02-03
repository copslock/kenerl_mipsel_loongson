Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 12:57:52 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:41044 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012598AbbBCL5vEDg0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 12:57:51 +0100
Date:   Tue, 3 Feb 2015 11:57:51 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH RFC v2 46/70] MIPS: kernel: branch: Prevent BGEZL emulation
 for MIPS R6
In-Reply-To: <1421405389-15512-47-git-send-email-markos.chandras@imgtec.com>
Message-ID: <alpine.LFD.2.11.1502031148160.22715@eddie.linux-mips.org>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-47-git-send-email-markos.chandras@imgtec.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Fri, 16 Jan 2015, Markos Chandras wrote:

> diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
> index 502bf2aeb834..b8cc0a2e20a4 100644
> --- a/arch/mips/kernel/branch.c
> +++ b/arch/mips/kernel/branch.c
> @@ -452,6 +452,11 @@ int __compute_return_epc_for_insn(struct pt_regs *regs,
>  
>  		case bgez_op:
>  		case bgezl_op:
> +			if (NO_R6EMU && (insn.i_format.rt == bgezl_op)) {

 There is no need for parentheses around `==' here, logical operators are 
well known to have a lower precedence.  The same applies throughout this 
series.

  Maciej
