Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2008 08:41:37 +0100 (BST)
Received: from wilson.telenet-ops.be ([195.130.132.42]:59780 "EHLO
	wilson.telenet-ops.be") by ftp.linux-mips.org with ESMTP
	id S21197111AbYJKHlf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 11 Oct 2008 08:41:35 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by wilson.telenet-ops.be (Postfix) with SMTP id 6038334031;
	Sat, 11 Oct 2008 09:41:34 +0200 (CEST)
Received: from anakin.of.borg (d54C15368.access.telenet.be [84.193.83.104])
	by wilson.telenet-ops.be (Postfix) with ESMTP id 2CC593402B;
	Sat, 11 Oct 2008 09:41:33 +0200 (CEST)
Received: from anakin.of.borg (localhost [127.0.0.1])
	by anakin.of.borg (8.14.3/8.14.3/Debian-5) with ESMTP id m9B7fWEf023092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 11 Oct 2008 09:41:33 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.14.3/8.14.3/Submit) with ESMTP id m9B7fVbl023089;
	Sat, 11 Oct 2008 09:41:32 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Date:	Sat, 11 Oct 2008 09:41:31 +0200 (CEST)
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	David Daney <ddaney@caviumnetworks.com>
cc:	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Add missing include in arch/mips/include/asm/ptrace.h.
In-Reply-To: <48EFAF9E.9010806@caviumnetworks.com>
Message-ID: <Pine.LNX.4.64.0810110941020.8063@anakin>
References: <48EFAF9E.9010806@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <geert@linux-m68k.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Fri, 10 Oct 2008, David Daney wrote:
> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> index 7fe9812..36872b8 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -120,6 +120,8 @@ struct pt_watch_regs {
> 
> #include <linux/compiler.h>
  ^
> #include <linux/linkage.h>
  ^
> +#include <linux/sched.h>
> +
> #include <asm/isadep.h>
  ^
> 
  ^
> extern int ptrace_getregs(struct task_struct *child, __s64 __user *data);
  ^

Oops, you mailer removed some spaces again...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
