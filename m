Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Oct 2002 17:47:33 +0200 (CEST)
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:55293 "EHLO
	irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S1123897AbSJEPrc>; Sat, 5 Oct 2002 17:47:32 +0200
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id g95FuJbg004134;
	Sat, 5 Oct 2002 16:56:20 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id g95FuHJZ004132;
	Sat, 5 Oct 2002 16:56:17 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Promblem with PREF (prefetching) in memcpy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hartvig Ekner <hartvige@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	"Kevin D. Kissell" <kevink@mips.com>,
	Dominic Sweetman <dom@algor.co.uk>,
	Carsten Langgaard <carstenl@mips.com>,
	linux-mips@linux-mips.org
In-Reply-To: <200210051512.g95FCmI11618@copfs01.mips.com>
References: <200210051512.g95FCmI11618@copfs01.mips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 16:56:16 +0100
Message-Id: <1033833377.4103.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 381
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Sat, 2002-10-05 at 16:12, Hartvig Ekner wrote:
> Whether the last page of physical memory needs to be thrown away or not seems
> like a separate issue. Is this also done in x86 world? What are the issues
> you're thinking about Ralf? Are there devices which will read/write beyond 
> what they have been asked to?

For x86 it isnt done. There are no real wins for prefetching off the end
of memory on x86. Also its important on x86 we don't prefetch into other
memory as we may pull stuff out of the cache of other processors on an
SMP box, and that is expensive
