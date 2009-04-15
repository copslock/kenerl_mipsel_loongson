Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Apr 2009 21:23:17 +0100 (BST)
Received: from mail.codesourcery.com ([65.74.133.4]:13038 "EHLO
	mail.codesourcery.com") by ftp.linux-mips.org with ESMTP
	id S20023587AbZDOUXI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Apr 2009 21:23:08 +0100
Received: (qmail 15123 invoked from network); 15 Apr 2009 20:23:00 -0000
Received: from unknown (HELO digraph.polyomino.org.uk) (joseph@127.0.0.2)
  by mail.codesourcery.com with ESMTPA; 15 Apr 2009 20:23:00 -0000
Received: from jsm28 (helo=localhost)
	by digraph.polyomino.org.uk with local-esmtp (Exim 4.69)
	(envelope-from <joseph@codesourcery.com>)
	id 1LuBdF-0001I8-Gd; Wed, 15 Apr 2009 20:22:53 +0000
Date:	Wed, 15 Apr 2009 20:22:53 +0000 (UTC)
From:	"Joseph S. Myers" <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:	"Maciej W. Rozycki" <macro@codesourcery.com>
cc:	libc-ports@sourceware.org, linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: Cooked FP register for new ABIs
In-Reply-To: <alpine.DEB.1.10.0903010013320.4064@tp.orcam.me.uk>
Message-ID: <Pine.LNX.4.64.0904152022380.3560@digraph.polyomino.org.uk>
References: <alpine.DEB.1.10.0903010013320.4064@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <joseph@codesourcery.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joseph@codesourcery.com
Precedence: bulk
X-list: linux-mips

On Sun, 1 Mar 2009, Maciej W. Rozycki wrote:

> Hello,
> 
>  Here is a change to <sys/fpregdef.h> to provide correct cooked FP 
> register names for the MIPS n64 and n32 ABIs according to "MIPSpro 
> Assembly Language Programmer's Guide" (Silicon Graphic's document number 
> 007-2418-004).
> 
> 2009-03-01  Maciej W. Rozycki  <macro@codesourcery.com>
> 
> 	* sysdeps/mips/sys/fpregdef.h: Update for new ABIs.
> 
>  Please apply.

I have committed this patch.

-- 
Joseph S. Myers
joseph@codesourcery.com
