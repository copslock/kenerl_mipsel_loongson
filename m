Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 14:50:13 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:61168 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S28594489AbYHMNuC (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 14:50:02 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m7DDnnEg000540;
	Wed, 13 Aug 2008 15:49:49 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m7DDnefC000536;
	Wed, 13 Aug 2008 14:49:48 +0100
Date:	Wed, 13 Aug 2008 14:49:39 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Brian Foster <brian.foster@innova-card.com>
cc:	linux-mips@linux-mips.org,
	Martin Gebert <martin.gebert@alpha-bit.de>,
	TriKri <kristoferkrus@hotmail.com>
Subject: Re: Debugging the MIPS processor using GDB
In-Reply-To: <200808130905.53671.brian.foster@innova-card.com>
Message-ID: <Pine.LNX.4.55.0808131441160.390@cliff.in.clinika.pl>
References: <18944199.post@talk.nabble.com> <200808121637.42148.brian.foster@innova-card.com>
 <Pine.LNX.4.55.0808121720370.24222@cliff.in.clinika.pl>
 <200808130905.53671.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20201
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 13 Aug 2008, Brian Foster wrote:

>   Re the FS²:  When it works, my (somewhat limited)
>  experience to-date is it works Ok.  And the use of
>  TCL on the Host workstation side allows some neat
>  tricks.  However, at least one thing doesn't work
>  reliably for me, albeit I've never investigated:
>  Breakpoints in the Linux kernel.  They do detonate.
>  Then, sometimes, I can ‘c’(ontinue) or ‘s’(tep) Ok.
>  But other times, when I ‘c’ or ‘s’, the breakpoint
>  detonates again and I'm stuck.  I cannot proceed.
>  (The same breakpoint might even work once or twice
>  and then fail.)   Any ideas?   AFAICR, this can also
>  happen if I try to use the ‘sysnav’ console instead
>  of ‘gdb’.

 Hmm, odd.  It looks like a cache coherence issue.  It could be a bug in
your version of FS2 software -- did you raise the issue with them?  
Anyway, as a workaround try setting "coherent=on" (quoting from memory) in
fs2.ini (just an idea -- it may not work and you will lose some
performance though) or use hardware breakpoints.

  Maciej
