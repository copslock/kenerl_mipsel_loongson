Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2002 13:21:53 +0200 (CEST)
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:42235
	"EHLO irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S1122958AbSIELVw>; Thu, 5 Sep 2002 13:21:52 +0200
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id g85BMi30006337;
	Thu, 5 Sep 2002 12:22:44 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id g85BMgCK006335;
	Thu, 5 Sep 2002 12:22:42 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: patch to kaweth.c to align IP header
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Quinn Jensen <jensenq@lineo.com>, linux-mips@linux-mips.org
In-Reply-To: <008d01c254b5$d7398500$10eca8c0@grendel>
References: <3D765072.60208@Lineo.COM>
	<1031182461.3017.137.camel@irongate.swansea.linux.org.uk> 
	<008d01c254b5$d7398500$10eca8c0@grendel>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 05 Sep 2002 12:22:42 +0100
Message-Id: <1031224962.6178.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 104
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, 2002-09-05 at 09:23, Kevin D. Kissell wrote:
> It is true that, due to the unfortunate lack of foresight in the
> design of IP, no pre-alignment of buffers will *guarantee*
> that the address or other fields of IP headers will be aligned.

It was not done for lack of foresight. It was carefully instrumented
measured and assessed.

> But I note that a design which assumes, for non x86 CPUs,
> that unaligned references will be handled by a kernel trap
> handler had darn well better assure itself that the misaligned
> case is extemely infrequent.  Otherwise, it would be a distinctly

It does

> then using the unaligned reference trap as a crutch is a win
> only if the fields are correctly aligned roughtly 94% of the time.

With properly set up network cards (and that can be a problem some can't
DMA to half word start points) the benched numbers I got for normal use
back when we decided to go this way were that no packet appeared
unaligned unless deeply weird stuff like IPX over 802.2 without SNAP was
being used. Nevertheless there are several way users can trigger such
alignment so your code must handle them. Another case it can occur is
PPP. 

Hitting 94% aligned is trivially the norm.
