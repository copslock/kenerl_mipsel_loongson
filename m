Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 May 2006 16:15:59 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:27270 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S3457184AbWEIOPh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 9 May 2006 16:15:37 +0200
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k49CWx7O004722;
	Tue, 9 May 2006 13:32:59 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k49CWwqB004721;
	Tue, 9 May 2006 13:32:58 +0100
Date:	Tue, 9 May 2006 13:32:58 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] fix kgdb exception handler from user mode
Message-ID: <20060509123258.GA3749@linux-mips.org>
References: <20060509.202349.80882976.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509.202349.80882976.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11368
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 09, 2006 at 08:23:49PM +0900, Atsushi Nemoto wrote:

> Fix a calculation of saved vector address in trap_low (damage done by
> f4c72cc737561aab0d9c7f877abbc0a853f1c465)

Applied to master and linux-2.6.16-stable.

  Ralf
