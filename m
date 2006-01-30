Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 12:56:30 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:38686 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133539AbWA3Mz0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 12:55:26 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0UD0QT4005207;
	Mon, 30 Jan 2006 13:00:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0UAM8dl003432;
	Mon, 30 Jan 2006 10:22:08 GMT
Date:	Mon, 30 Jan 2006 10:22:08 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Peter Horton <pdh@colonel-panic.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.X] Fix SWARM IDE detection
Message-ID: <20060130102208.GB3383@linux-mips.org>
References: <20060125221302.GA2968@colonel-panic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060125221302.GA2968@colonel-panic.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jan 25, 2006 at 10:13:02PM +0000, Peter Horton wrote:

> Make sure we scan SWARM IDE interface for devices.

IDE driver stuff please to:

IDE DRIVER [GENERAL]
P:      Bartlomiej Zolnierkiewicz
M:      B.Zolnierkiewicz@elka.pw.edu.pl
L:      linux-kernel@vger.kernel.org
L:      linux-ide@vger.kernel.org
T:      git kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git
S:      Maintained

  Ralf
