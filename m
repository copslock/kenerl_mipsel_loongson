Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Nov 2006 16:34:19 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:52451 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038721AbWKSQeS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Nov 2006 16:34:18 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id kAJGYFtY012350;
	Sun, 19 Nov 2006 16:34:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id kAJGYD5A012349;
	Sun, 19 Nov 2006 17:34:13 +0100
Date:	Sun, 19 Nov 2006 17:34:13 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org, ths@networkno.de
Subject: Re: Add -mfix7000 to CONFIG_SGI_IP22
Message-ID: <20061119163413.GB6240@linux-mips.org>
References: <20061119145843.GA5387@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061119145843.GA5387@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Nov 19, 2006 at 02:58:43PM +0000, Martin Michlmayr wrote:

> What was the rationale to add that to CONFIG_SGI_IP22?  Shouldn't it
> be added to CONFIG_SGI_IP32, i.e. O2?

Indeed.

And a workaround for what CPU bug is that supposed to be anyway?  My errata
don't document anything that looks like what -mfix7000 claims to fix.

  Ralf
