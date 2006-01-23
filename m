Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 00:38:21 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45998 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S8133494AbWAWAh7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 00:37:59 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k0N0gKZt026103;
	Mon, 23 Jan 2006 00:42:20 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k0N0gJ0f026102;
	Mon, 23 Jan 2006 00:42:19 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: Cobalt IDE fix
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20060122235038.GA3501@colonel-panic.org>
References: <20060122235038.GA3501@colonel-panic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Mon, 23 Jan 2006 00:42:17 +0000
Message-Id: <1137976937.24808.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10043
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Sul, 2006-01-22 at 23:50 +0000, Peter Horton wrote:
> Fix long IDE detection delay by not scanning non-existent channels.

That just changes the number of interfaces that can be registered. The
right fix is to change the list of non-PCI addresses scanned for the
system in question and not blindly copy x86 I suspect.
