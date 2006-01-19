Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Jan 2006 10:28:05 +0000 (GMT)
Received: from [62.38.115.213] ([62.38.115.213]:24708 "EHLO pfn3.pefnos")
	by ftp.linux-mips.org with ESMTP id S8133793AbWASK1r (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 19 Jan 2006 10:27:47 +0000
Received: from xorhgos2.pefnos (xorhgos2.pefnos [192.168.0.3])
	by pfn3.pefnos (Postfix) with ESMTP id ED0A51F31C;
	Thu, 19 Jan 2006 12:31:13 +0200 (EET)
From:	"P. Christeas" <p_christ@hol.gr>
To:	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: gcc -3.4.4 and linux-2.4.32
Date:	Thu, 19 Jan 2006 12:30:57 +0200
User-Agent: KMail/1.9
Cc:	David Daney <ddaney@avtrex.com>,
	Kishore K <hellokishore@gmail.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
References: <f07e6e0601160423h5ce1c0d7lcb7e38f8509c4116@mail.gmail.com> <200601190035.19022.p_christ@hol.gr> <Pine.LNX.4.62.0601191100001.21230@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0601191100001.21230@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601191230.59347.p_christ@hol.gr>
Return-Path: <p_christ@hol.gr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9978
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p_christ@hol.gr
Precedence: bulk
X-list: linux-mips

On Thursday 19 January 2006 12:00 pm, Geert Uytterhoeven wrote:
> On Thu, 19 Jan 2006, P. Christeas wrote:
> > Just to let you know:
> > In a very interesting twist, gcc4.0.2 produces a faulty kernel with the
> > 2.4.31 kernel (as the latter is provided from the hardware's
> > manufacturer). I'm validating gcc and binutils at the moment.
>
> That's why 2 days ago this one went in in 2.4.x:
> | [PATCH] document that gcc 4 is not supported
> |
> | gcc 4 is not supported for compiling kernel 2.4, and I don't see any
> | compelling reason why kernel 2.4 should ever be adapted to gcc 4.

Which comes round to the main reason I'm doing this work (port the platform to 
2.6): if we are not using the *latest* kernel with the *latest* build/user 
tools, then we cannot share our work. Patches to an old kernel/gcc may 
probably get discarded when moving to the next version.

Nevertheless, I think my problem has been the binutils. After switching to 
version 2.16.1, the oops probability (per reset) dropped from 80% to <20% and 
the oops is less random. (that is, there is also one, real, bug)
