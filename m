Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2003 13:13:47 +0000 (GMT)
Received: from p508B5E38.dip.t-dialin.net ([IPv6:::ffff:80.139.94.56]:27050
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225380AbTKRNNf>; Tue, 18 Nov 2003 13:13:35 +0000
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.12.8/8.12.8) with ESMTP id hAIDDXA0018708;
	Tue, 18 Nov 2003 14:13:34 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id hAIDDXaU018699;
	Tue, 18 Nov 2003 14:13:33 +0100
Date: Tue, 18 Nov 2003 14:13:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: ashish anand <ashish_ibm@rediffmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Assertion duration of edge interrupts can decrease spurious interrupts ..?
Message-ID: <20031118131333.GC17503@linux-mips.org>
References: <20031118065741.27152.qmail@webmail29.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118065741.27152.qmail@webmail29.rediffmail.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 18, 2003 at 06:57:41AM -0000, ashish  anand wrote:

> 1.If i have a compulsion to use egde triggering peripheral on MIPS CP0,
> would it be useful if i can increase the assertion duration of edge
> interupts (this I can do) ..I mean to say probablity of loosing edge
> interrupts will decrasse.

That would help but still not be a safe mechanism.  Not only the processor
may be missing the edge - Linux may also disable interrupts for quite a
long time.  You'd have to use a hard realtime variant of Linux or you will
loose interrupts ...

> 2.does CP0 interrupt logic samples interrupts after each instruction or
> at some multiplication(..or division.?) of system clock.

This is a very processor specific detail.  R4000 for example will sample
interrupts on pipe stage 3; something along that lines is probably done
in most in-order processors.

  Ralf
