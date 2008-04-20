Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2008 19:38:32 +0100 (BST)
Received: from courier.cs.helsinki.fi ([128.214.9.1]:12437 "EHLO
	mail.cs.helsinki.fi") by ftp.linux-mips.org with ESMTP
	id S20035928AbYDTSia (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 20 Apr 2008 19:38:30 +0100
Received: from wrl-59.cs.helsinki.fi (wrl-59.cs.helsinki.fi [128.214.166.179])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Sun, 20 Apr 2008 21:38:28 +0300
  id 00068138.480B8DA4.00005025
Received: by wrl-59.cs.helsinki.fi (Postfix, from userid 50795)
	id 89DC1A0092; Sun, 20 Apr 2008 21:38:28 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by wrl-59.cs.helsinki.fi (Postfix) with ESMTP id 786C1A006C;
	Sun, 20 Apr 2008 21:38:28 +0300 (EEST)
Date:	Sun, 20 Apr 2008 21:38:28 +0300 (EEST)
From:	"=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
X-X-Sender: ijjarvin@wrl-59.cs.helsinki.fi
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Fix order of BRK_BUG in case
In-Reply-To: <20080420112417.GA21078@linux-mips.org>
Message-ID: <Pine.LNX.4.64.0804202132010.4083@wrl-59.cs.helsinki.fi>
References: <Pine.LNX.4.64.0804192310460.20623@wrl-59.cs.helsinki.fi>
 <20080420112417.GA21078@linux-mips.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696208474-2054475427-1208716708=:4083"
Return-Path: <ilpo.jarvinen@helsinki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18968
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilpo.jarvinen@helsinki.fi
Precedence: bulk
X-list: linux-mips

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-2054475427-1208716708=:4083
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sun, 20 Apr 2008, Ralf Baechle wrote:

> On Sat, Apr 19, 2008 at 11:16:36PM +0300, Ilpo Järvinen wrote:
> 
> > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > index 984c0d0..4dfcd61 100644
> > --- a/arch/mips/kernel/traps.c
> > +++ b/arch/mips/kernel/traps.c
> > @@ -694,7 +694,7 @@ asmlinkage void do_bp(struct pt_regs *regs)
> >  		info.si_addr = (void __user *) regs->cp0_epc;
> >  		force_sig_info(SIGFPE, &info, current);
> >  		break;
> > -	case BRK_BUG:
> > +	case BRK_BUG << 10:
> >  		die("Kernel bug detected", regs);
>                 ^^^
> 
> Now what will be happening if with your patch applied a "break BRK_BUG"
> instruction is executed in userspace?

I suppose you know better, I can only guess :-). Like I said, I have no 
idea about mips code, maybe one would want die_if_kernel() kernel 
instead...? My main point was that the conversion made by commit 63dc68a8 
here seems questionable (resulted in dead code and would that not have 
been dead code the question you asked would apply to that code fragment), 
what is the right thing to do, you sure know better than I do :-).

-- 
 i.
---696208474-2054475427-1208716708=:4083--
