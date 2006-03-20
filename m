Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Mar 2006 13:18:48 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:26261 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133830AbWCTNSk (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Mar 2006 13:18:40 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k2KDSKUu011333;
	Mon, 20 Mar 2006 13:28:20 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k2KDSKYU011332;
	Mon, 20 Mar 2006 13:28:20 GMT
Date:	Mon, 20 Mar 2006 13:28:20 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Separate CPU entries in /proc/cpuinfo with a blank line
Message-ID: <20060320132820.GA11139@linux-mips.org>
References: <20060320025120.GA18414@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060320025120.GA18414@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 20, 2006 at 02:51:20AM +0000, Martin Michlmayr wrote:

> Put in a blank line between CPU entries in /proc/cpuinfo, just like
> most other architectures (i386, ia64, x86_64) do.

Thanks, applied.

In the past I frequently used to reply to the mailing lists when applying
a patch.  Since I resurrected the commits mailing lists I do no longer do
this.  Just so people know.

  Ralf
