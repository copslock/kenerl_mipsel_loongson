Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Nov 2002 18:04:18 +0100 (CET)
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:28053 "EHLO
	irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S1122121AbSKERER>; Tue, 5 Nov 2002 18:04:17 +0100
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id gA5HQDbc006315;
	Tue, 5 Nov 2002 17:26:14 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id gA5HQBB2006313;
	Tue, 5 Nov 2002 17:26:11 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Prefetches in memcpy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: Ralf Baechle <ralf@uni-koblenz.de>,
	Carsten Langgaard <carstenl@mips.com>,
	linux-mips@linux-mips.org
In-Reply-To: <00fb01c284e6$5b7bf4f0$10eca8c0@grendel>
References: <3DC7CB8B.E2C1D4E5@mips.com>
	<20021105163806.A24996@bacchus.dhis.org> 
	<00fb01c284e6$5b7bf4f0$10eca8c0@grendel>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 17:26:11 +0000
Message-Id: <1036517171.5012.100.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Tue, 2002-11-05 at 16:13, Kevin D. Kissell wrote:
> Assuming we had a version that prefetched exactly to the end
> of the source memory block and no further, why would we need
> the second variant?

memcpy_to/from_io needs to do strictly ordered fetches on some devices
which fake a memory range with a fifo for performance (pci bursting
dirty tricks)
