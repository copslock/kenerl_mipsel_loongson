Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jun 2004 18:45:01 +0100 (BST)
Received: from dallas.texasconnect.net ([IPv6:::ffff:208.232.232.3]:3593 "EHLO
	dallas.texasconnect.net") by linux-mips.org with ESMTP
	id <S8225229AbUFGRo5>; Mon, 7 Jun 2004 18:44:57 +0100
Received: from dallas.texasconnect.net (dallas.texasconnect.net [208.232.232.3])
	by dallas.texasconnect.net (8.12.9/8.12.9) with ESMTP id i57HimXC031501;
	Mon, 7 Jun 2004 12:44:48 -0500
Date: Mon, 7 Jun 2004 12:44:48 -0500 (CDT)
From: Ed Okerson <eokerson@texasconnect.net>
To: Dmitriy Tochansky <toch@dfpost.ru>
cc: linux-mips@linux-mips.org
Subject: Re: bootloader
In-Reply-To: <40C4520B.2020400@dfpost.ru>
Message-ID: <Pine.LNX.4.44.0406071243340.15478-100000@dallas.texasconnect.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <eokerson@texasconnect.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eokerson@texasconnect.net
Precedence: bulk
X-list: linux-mips

On Mon, 7 Jun 2004, Dmitriy Tochansky wrote:

> Ed Okerson wrote:
>
> >I have the same board and I use U-Boot.
> >
> >>Hi!
> >>Does anybody can advice me some bootloader for my Zinfandel(Db1500) board?
> >>
> >>CU.
> >>
> >>
> Had you any problems in compile it?

It was somewhat difficult to get it working in little endian mode, but
once I did I submitted patches back to U-Boot and it should work fine now.

Ed Okerson
