Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 12:15:35 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:17178 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133503AbWA3MOa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 12:14:30 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0UCJWW6004233;
	Mon, 30 Jan 2006 12:19:32 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0UCJW7V004232;
	Mon, 30 Jan 2006 12:19:32 GMT
Date:	Mon, 30 Jan 2006 12:19:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: help ... Galileo PCI bridge
Message-ID: <20060130121932.GA3816@linux-mips.org>
References: <20060129094409.GA1495@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129094409.GA1495@colonel-panic.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10228
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 29, 2006 at 09:44:09AM +0000, Peter Horton wrote:

> I'm currently struggling with a hard hang on the Cobalt hardware which
> uses the Galileo GT64111 PCI bridge.
> 
> I've got the rev 11 data sheet for the bridge, I was wondering if anyone
> knows whether there is an errata sheet for this chip, and if so whether
> anyone has a copy ?

I recall PCI device 31 on bus 0 was magic on all Galileo.  Touching it
results in a system hang.  Could that be what is hitting you?

  Ralf
