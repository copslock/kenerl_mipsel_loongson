Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Dec 2002 23:00:42 +0000 (GMT)
Received: from nixon.xkey.com ([IPv6:::ffff:209.245.148.124]:47749 "HELO
	nixon.xkey.com") by linux-mips.org with SMTP id <S8225308AbSLQXAm>;
	Tue, 17 Dec 2002 23:00:42 +0000
Received: (qmail 11578 invoked from network); 17 Dec 2002 23:00:40 -0000
Received: from localhost (HELO localhost.conservativecomputer.com) (127.0.0.1)
  by localhost with SMTP; 17 Dec 2002 23:00:40 -0000
Received: (from lindahl@localhost)
	by localhost.conservativecomputer.com (8.11.6/8.11.0) id gBHMxb802285
	for linux-mips@linux-mips.org; Tue, 17 Dec 2002 14:59:37 -0800
X-Authentication-Warning: localhost.localdomain: lindahl set sender to lindahl@keyresearch.com using -f
Date: Tue, 17 Dec 2002 14:59:37 -0800
From: Greg Lindahl <lindahl@keyresearch.com>
To: linux-mips <linux-mips@linux-mips.org>
Subject: Re: PATCH
Message-ID: <20021217145937.B1921@wumpus.internal.keyresearch.com>
Mail-Followup-To: linux-mips <linux-mips@linux-mips.org>
References: <1039841567.25391.13.camel@adsl.pacbell.net> <20021217142913.A1921@wumpus.internal.keyresearch.com> <1040164850.16501.18.camel@zeus.mvista.com> <1040167450.20804.30.camel@irongate.swansea.linux.org.uk> <1040165474.16482.22.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1040165474.16482.22.camel@zeus.mvista.com>; from ppopov@mvista.com on Tue, Dec 17, 2002 at 02:51:14PM -0800
Return-Path: <lindahl@keyresearch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lindahl@keyresearch.com
Precedence: bulk
X-list: linux-mips

On Tue, Dec 17, 2002 at 02:51:14PM -0800, Pete Popov wrote:

> One of the problems with these graphics cards is that they are end of
> life before you finish writing the driver. I still have a few RageXL
> cards in the office, but you can't even buy them in the store anymore.

Yeah, that's why emulation might turn out to be easier in the long run.

This emulator:

http://www.scitechsoft.com/products/developer/x86_emulator.html

claims to be the one in XFree86 these days. Another emulation project
is bochs. It doesn't really matter if the performance isn't great
since the BIOS doesn't run for very long. But I think I'll have to dig
around a bit to figure out how well this works in practice.

-- greg
