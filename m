Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 May 2004 23:07:22 +0100 (BST)
Received: from the-village.bc.nu ([IPv6:::ffff:81.2.110.252]:4226 "EHLO
	localhost.localdomain") by linux-mips.org with ESMTP
	id <S8225779AbUERWHV>; Tue, 18 May 2004 23:07:21 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.12.11/8.12.11) with ESMTP id i4IIOoFt010581;
	Tue, 18 May 2004 19:24:56 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id i4IIOaRt010580;
	Tue, 18 May 2004 19:24:37 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: problems on D-cache alias in 2.4.22
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Peter Horton <pdh@colonel-panic.org>, Jun Sun <jsun@mvista.com>,
	Bob Breuer <bbreuer@righthandtech.com>,
	linux-mips@linux-mips.org
In-Reply-To: <20040518195055.GB2454@linux-mips.org>
References: <B482D8AA59BF244F99AFE7520D74BF9609D4B3@server1.RightHand.righthandtech.com>
	 <20040518114519.C5390@mvista.com> <20040518191019.GA11007@skeleton-jack>
	 <20040518195055.GB2454@linux-mips.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1084904673.10535.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 18 May 2004 19:24:34 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2004-05-18 at 20:50, Ralf Baechle wrote:
> Carelessly written PIO drivers on any architecture would suffer from this
> kind of problem.

It isnt a driver problem. (Ramdisk is a bit special as you get aliases
in funny ways). The block and page cache is responsible for sorting this
out.
