Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Dec 2002 17:54:45 +0100 (CET)
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:49320 "EHLO
	irongate.swansea.linux.org.uk") by linux-mips.org with ESMTP
	id <S8225295AbSLEQyo>; Thu, 5 Dec 2002 17:54:44 +0100
Received: from irongate.swansea.linux.org.uk (localhost [127.0.0.1])
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5) with ESMTP id gB5HTZlQ019729;
	Thu, 5 Dec 2002 17:29:36 GMT
Received: (from alan@localhost)
	by irongate.swansea.linux.org.uk (8.12.5/8.12.5/Submit) id gB5HTYPi019727;
	Thu, 5 Dec 2002 17:29:34 GMT
X-Authentication-Warning: irongate.swansea.linux.org.uk: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Compiler problems with zero-length array in the middle of a
	struct
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carsten Langgaard <carstenl@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
In-Reply-To: <3DEF5606.E34BD27A@mips.com>
References: <3DEF2EBE.F273B44A@mips.com>
	<20021205141018.A6106@linux-mips.org>  <3DEF5606.E34BD27A@mips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Dec 2002 17:29:33 +0000
Message-Id: <1039109373.19681.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Thu, 2002-12-05 at 13:35, Carsten Langgaard wrote:
> > Hmm...  What compiler version is that?  The gcc documentation explicitly
> > permits empty arrays.

There was some discussion about this and what to do with zero sized
objects. In the C++ universe it seems to be horribly complicated with
rules about two objects not having the same address.
