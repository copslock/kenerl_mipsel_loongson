Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 16:46:21 +0200 (CEST)
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:50937 "EHLO
	irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S1123397AbSJDOqV>; Fri, 4 Oct 2002 16:46:21 +0200
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id g94Esnbg032394;
	Fri, 4 Oct 2002 15:54:50 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id g94EsgKN032392;
	Fri, 4 Oct 2002 15:54:42 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Promblem with PREF (prefetching) in memcpy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <016201c26bb0$b8609a30$10eca8c0@grendel>
References: <3D9D484B.4C149BD8@mips.com><200210041153.MAA12052@mudchute.algor.co.uk><3D9
	 D855B.12128FA2@mips.com><1033734968.31839.5.camel@irongate.swansea.linux
	.org.uk>
	<00fe01c26ba6$04943480$10eca8c0@grendel><1033737330.31861.30.camel@irongate.
	 swansea.linux.org.uk> <010e01c26ba8$2c9400d0$10eca8c0@grendel>
	<1033739046.31861.35.camel@irongate.swansea.linux.org.uk> 
	<016201c26bb0$b8609a30$10eca8c0@grendel>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 15:54:42 +0100
Message-Id: <1033743282.32384.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 376
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, 2002-10-04 at 15:17, Kevin D. Kissell wrote:
> Which is safe, simple, and efficient, but does seem to have the property
> that there's a "cursed" page in the system that can be randomly allocated
> and which will be curiously slow on memcopy().  That might or might not
> be a problem in the embedded application space.

Im curious why you think that. Its the same speed for all pages and all
copies. If anything it is more efficient because we don't drag 320 bytes
of crap across the bus that we dont actually want anyway.
