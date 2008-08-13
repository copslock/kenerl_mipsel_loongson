Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2008 16:16:57 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:50418 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20023228AbYHMPQw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2008 16:16:52 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m7DFGkeB001127;
	Wed, 13 Aug 2008 17:16:46 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m7DFGfhL001121;
	Wed, 13 Aug 2008 16:16:46 +0100
Date:	Wed, 13 Aug 2008 16:16:41 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Brian Foster <brian.foster@innova-card.com>
cc:	linux-mips@linux-mips.org,
	Martin Gebert <martin.gebert@alpha-bit.de>,
	TriKri <kristoferkrus@hotmail.com>
Subject: Re: Debugging the MIPS processor using GDB
In-Reply-To: <200808131707.30570.brian.foster@innova-card.com>
Message-ID: <Pine.LNX.4.55.0808131611580.390@cliff.in.clinika.pl>
References: <18944199.post@talk.nabble.com> <200808130905.53671.brian.foster@innova-card.com>
 <Pine.LNX.4.55.0808131441160.390@cliff.in.clinika.pl>
 <200808131707.30570.brian.foster@innova-card.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 13 Aug 2008, Brian Foster wrote:

>   What _might_ be an issue/cause is we're using our own
>  home-grown ‘gdb’ scripts (to init the memory, load the
>  kernel, etc.).  I didn't write them, but I have looked
>  them over, and they _look_ Ok to me.

 That should not matter.  For example you could boot your system in the
usual way provided by the firmware and attach to an already running
kernel.  The probe does not know or care about that.

>   I tried some “mdi cacheflush” at some plausible-seeming
>  points, all to no effect.  I also tried deleting the
>  breakpoint (after step 8), which was a disaster:  (From
>  memory) when I then ‘c’(ontinued), ‘gdb’ hung, and the
>  ‘sysnav’ went into an infinite loop of reporting a
>  breakpoint.  ;-(
> 
>  ( I seem to recall also having an issue with hardware
>   breakpoints, but cannot recall for certain ATM; tests
>   will have to wait until later ....  ;-\  )
> 
>   All ideas and suggestions are very welcome!

 Your situation looks pretty miserable -- you should definitely pester 
FS2.

  Maciej
