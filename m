Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 15:35:47 +0200 (CEST)
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:36856 "EHLO
	irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S1123397AbSJDNfr>; Fri, 4 Oct 2002 15:35:47 +0200
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id g94Di8bg032222;
	Fri, 4 Oct 2002 14:44:09 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id g94Di7GQ032220;
	Fri, 4 Oct 2002 14:44:07 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Promblem with PREF (prefetching) in memcpy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Carsten Langgaard <carstenl@mips.com>,
	Dominic Sweetman <dom@algor.co.uk>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <010e01c26ba8$2c9400d0$10eca8c0@grendel>
References: <3D9D484B.4C149BD8@mips.com><200210041153.MAA12052@mudchute.algor.co.uk>
	<3D9D855B.12128FA2@mips.com><1033734968.31839.5.camel@irongate.swansea.linux
	 .org.uk> <00fe01c26ba6$04943480$10eca8c0@grendel>
	<1033737330.31861.30.camel@irongate.swansea.linux.org.uk> 
	<010e01c26ba8$2c9400d0$10eca8c0@grendel>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 14:44:06 +0100
Message-Id: <1033739046.31861.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, 2002-10-04 at 14:15, Kevin D. Kissell wrote:
> Which is excatly the point that Carsten was raising when he started this thread!
> 
> The question is how, i.e. throttle memcpy or thow away a "guard band" of RAM?


The x86 code basically says

	while(over 320 bytes left)
	{
		prefetch ahead
		copy bits
	}
	while(bytes left)
		copy bits

You also have to watch the prefetching in the tcp checksum code. We hit
an x86 bug there also very recently. That one is new but shows up with
the zero copy tcp nfs
