Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 17:09:11 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:36624 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8224859AbUJRQJF>;
	Mon, 18 Oct 2004 17:09:05 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1CJaD6-0000R6-00; Mon, 18 Oct 2004 17:18:12 +0100
Received: from perivale.mips.com ([192.168.192.200])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1CJa3y-0008SF-00; Mon, 18 Oct 2004 17:08:46 +0100
Received: from macro (helo=localhost)
	by perivale.mips.com with local-esmtp (Exim 3.36 #1 (Debian))
	id 1CJa3x-0003NH-00; Mon, 18 Oct 2004 17:08:45 +0100
Date: Mon, 18 Oct 2004 17:08:45 +0100 (BST)
From: "Maciej W. Rozycki" <macro@mips.com>
To: Andreas Jaeger <aj@suse.de>
cc: linux-mips@linux-mips.org, libc-alpha@sources.redhat.com,
	Dominic Sweetman <dom@mips.com>,
	Nigel Stephens <nigel@mips.com>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [patch] glibc 2.3: Memory clobber missing from syscalls
In-Reply-To: <m31xfwmwpn.fsf@gromit.moeb>
Message-ID: <Pine.LNX.4.61.0410181706560.12426@perivale.mips.com>
References: <Pine.LNX.4.61.0410151318550.8084@perivale.mips.com>
 <m31xfwmwpn.fsf@gromit.moeb>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.9, required 4, BAYES_00)
Return-Path: <macro@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
Precedence: bulk
X-list: linux-mips

On Mon, 18 Oct 2004, Andreas Jaeger wrote:

> Sorry, it took me longer to react than normal - but there is interest,
> just not always time to do anything properly.

 OK, understood.  I was just a bit surprised about such an obvious fix 
taking so long.

> I've committed your patch after adjusting the copyright years also.

 Thanks.  More fixes to come.

  Maciej
