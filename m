Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 14:27:56 +0200 (CEST)
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:9719 "EHLO
	irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S1123253AbSJDM1z>; Fri, 4 Oct 2002 14:27:55 +0200
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id g94CaBbg031901;
	Fri, 4 Oct 2002 13:36:11 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id g94Ca9JW031899;
	Fri, 4 Oct 2002 13:36:09 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Promblem with PREF (prefetching) in memcpy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Dominic Sweetman <dom@algor.co.uk>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <3D9D855B.12128FA2@mips.com>
References: <3D9D484B.4C149BD8@mips.com>
	<200210041153.MAA12052@mudchute.algor.co.uk>  <3D9D855B.12128FA2@mips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 13:36:08 +0100
Message-Id: <1033734968.31839.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, 2002-10-04 at 13:11, Carsten Langgaard wrote:
> Is a bus error exception an address related exception ?
> I'm afraid some implementation think it's not.
> 

So you need an option for broken systems, no new news 8)

> What about an UART RX register, we might loose a character ?
> You can also configure you system, so you get a external interrupt from you
> system controller in case of a bus error, there is no way the CPU can
> relate this interrupt to the prefetching.

The use of memcpy for I/O space isnt permitted in Linux, thats why we
have memcpy_*_io stuff. Thus prefetches should never touch 'special'
spaces. (On x86 the older Athlons corrupt their cache if you do this so
its not a mips specific matter)
