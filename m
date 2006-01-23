Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 23:35:30 +0000 (GMT)
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:58295 "EHLO
	lxorguk.ukuu.org.uk") by ftp.linux-mips.org with ESMTP
	id S3458400AbWAWXfM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 23:35:12 +0000
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.13.4/8.13.4) with ESMTP id k0NNdpEu007033;
	Mon, 23 Jan 2006 23:39:52 GMT
Received: (from alan@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id k0NNdpDR007029;
	Mon, 23 Jan 2006 23:39:51 GMT
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: [PATCH 2.6.x] Cobalt IDE fix, take 2
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20060123223354.GA2698@colonel-panic.org>
References: <20060123223354.GA2698@colonel-panic.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Mon, 23 Jan 2006 23:39:45 +0000
Message-Id: <1138059585.24808.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Llu, 2006-01-23 at 22:33 +0000, Peter Horton wrote:
> Fix long boot delay on Cobalt scanning non-existent IDE interfaces.

NAK again, please just fix this properly. If you just copy the logic
from the x86 platform it will all work without #defines and other hacks
on the already wrong core code.

Alan
