Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Oct 2002 15:07:11 +0200 (CEST)
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:43255 "EHLO
	irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S1123397AbSJDNHL>; Fri, 4 Oct 2002 15:07:11 +0200
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id g94DFWbg032146;
	Fri, 4 Oct 2002 14:15:32 +0100
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id g94DFUZL032144;
	Fri, 4 Oct 2002 14:15:30 +0100
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Promblem with PREF (prefetching) in memcpy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Carsten Langgaard <carstenl@mips.com>,
	Dominic Sweetman <dom@algor.co.uk>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <00fe01c26ba6$04943480$10eca8c0@grendel>
References: <3D9D484B.4C149BD8@mips.com><200210041153.MAA12052@mudchute.algor.co.uk> 
	<3D9D855B.12128FA2@mips.com>
	<1033734968.31839.5.camel@irongate.swansea.linux.org.uk> 
	<00fe01c26ba6$04943480$10eca8c0@grendel>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 14:15:30 +0100
Message-Id: <1033737330.31861.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Fri, 2002-10-04 at 14:00, Kevin D. Kissell wrote:
> The issue isn't that anyone would deliberately use memcpy() in I/O
> space.  Rather, it's that memcpy() prefetches quite a ways ahead,
> and if one has I/O space assigned just after the end of physical
> memory, Bad Things might happen on a perfectly legal memcpy()
> that references the last couple hundred bytes of memory in a 
> way that not even a clever and well-informed bus error handler 
> could undo.

Then your memcpy function is IMHO broken. Fix it to note prefetch beyond
the end of the area you actually will copy and life should be a lot
better
