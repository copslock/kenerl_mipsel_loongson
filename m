Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2003 01:36:21 +0100 (BST)
Received: from p508B6FF8.dip.t-dialin.net ([IPv6:::ffff:80.139.111.248]:45527
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225243AbTGBAgS>; Wed, 2 Jul 2003 01:36:18 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h620aHDB003821;
	Wed, 2 Jul 2003 02:36:17 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h620aCXE003820;
	Wed, 2 Jul 2003 02:36:12 +0200
Date: Wed, 2 Jul 2003 02:36:12 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Brian Murphy <brian@murphy.dk>
Cc: linux-mips@linux-mips.org
Subject: Re: My god! 2.5 is big
Message-ID: <20030702003612.GD3210@linux-mips.org>
References: <3F01FEB6.5010407@murphy.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F01FEB6.5010407@murphy.dk>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jul 01, 2003 at 11:35:50PM +0200, Brian Murphy wrote:

> My gzip'ped 2.4 kernel is 250k smaller than 2.5 and it works.
> Perhaps I just need to remove some code... ;-)

Old saying - "software is like gas, it fills all available space" ;-)

The MIPS 2.5 is still in it's quite early stages; I suspect we can still
regain part of the extra size.  More important than the pure kernel size
(users booting from flash throw your rotten vegies now ;-) is the in
memory size.  The greatly reduced size of struct page for example will
result in a net gain of memory available for applications for systems of
more than about 48MB.

  Ralf
