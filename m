Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2008 15:57:37 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:65157 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21221711AbYJKO5f (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2008 15:57:35 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9BEvT1v006674;
	Sat, 11 Oct 2008 15:57:29 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9BEvSpU006672;
	Sat, 11 Oct 2008 15:57:28 +0100
Date:	Sat, 11 Oct 2008 15:57:28 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Add missing include in
	arch/mips/include/asm/ptrace.h.
Message-ID: <20081011145728.GA6570@linux-mips.org>
References: <48EFAF9E.9010806@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48EFAF9E.9010806@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 10, 2008 at 12:40:14PM -0700, David Daney wrote:

> Add missing include in arch/mips/include/asm/ptrace.h.
>
> Recent reorganization seems to have lost this include.  You cannot
> build without it.
>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> ---
> arch/mips/include/asm/ptrace.h |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> index 7fe9812..36872b8 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -120,6 +120,8 @@ struct pt_watch_regs {
>
> #include <linux/compiler.h>
> #include <linux/linkage.h>
> +#include <linux/sched.h>

Sched.h is one of those include files that drag in way to many other
header files.  So I went for a forward declaration of struct task_struct
instead.

Thanks,

  Ralf
