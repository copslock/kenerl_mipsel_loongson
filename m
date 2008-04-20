Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2008 12:24:31 +0100 (BST)
Received: from oss.sgi.com ([192.48.170.157]:485 "EHLO oss.sgi.com")
	by ftp.linux-mips.org with ESMTP id S20033966AbYDTLY2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 20 Apr 2008 12:24:28 +0100
Received: from dl5rb.ham-radio-op.net (localhost [127.0.0.1])
	by oss.sgi.com (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id m3KBNh8s019340
	for <linux-mips@linux-mips.org>; Sun, 20 Apr 2008 04:23:43 -0700
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m3KBOInW021118;
	Sun, 20 Apr 2008 12:24:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m3KBOHWI021117;
	Sun, 20 Apr 2008 12:24:17 +0100
Date:	Sun, 20 Apr 2008 12:24:17 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@helsinki.fi>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fix order of BRK_BUG in case
Message-ID: <20080420112417.GA21078@linux-mips.org>
References: <Pine.LNX.4.64.0804192310460.20623@wrl-59.cs.helsinki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0804192310460.20623@wrl-59.cs.helsinki.fi>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: ClamAV 0.91.2/6021/Wed Feb 27 15:55:48 2008 on oss.sgi.com
X-Virus-Status:	Clean
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Apr 19, 2008 at 11:16:36PM +0300, Ilpo Järvinen wrote:

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 984c0d0..4dfcd61 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -694,7 +694,7 @@ asmlinkage void do_bp(struct pt_regs *regs)
>  		info.si_addr = (void __user *) regs->cp0_epc;
>  		force_sig_info(SIGFPE, &info, current);
>  		break;
> -	case BRK_BUG:
> +	case BRK_BUG << 10:
>  		die("Kernel bug detected", regs);
                ^^^

Now what will be happening if with your patch applied a "break BRK_BUG"
instruction is executed in userspace?

  Ralf
