Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 09:50:47 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:46617 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133461AbWBMJuj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 09:50:39 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1D9v0XE005665;
	Mon, 13 Feb 2006 09:57:00 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1D9uwb7005663;
	Mon, 13 Feb 2006 09:56:58 GMT
Date:	Mon, 13 Feb 2006 09:56:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.X] Early console for Cobalt
Message-ID: <20060213095658.GA3720@linux-mips.org>
References: <20060212171025.GB1562@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212171025.GB1562@colonel-panic.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Feb 12, 2006 at 05:10:25PM +0000, Peter Horton wrote:

> Adds early console support for Cobalts.
> 
> Signed-off-by: Peter Horton <pdh@colonel-panic.org>

Queued for 2.6.17.

Please never include pathnames using the asm symlink like
linux.git/include/asm/mach-cobalt/cobalt.h in patches.  They do cause
rejects and are generally a PITA.  I also sent the #if 0'ed code in
console.c to /dev/hell.

  Ralf
