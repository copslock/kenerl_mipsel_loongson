Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Feb 2006 12:58:52 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:9736 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133394AbWBUM6o (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 21 Feb 2006 12:58:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1LD5eis018985;
	Tue, 21 Feb 2006 13:05:45 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1KLu9R3027909;
	Mon, 20 Feb 2006 21:56:09 GMT
Date:	Mon, 20 Feb 2006 21:56:09 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] jiffies_to_compat_timeval fix
Message-ID: <20060220215609.GB27383@linux-mips.org>
References: <20060221.012506.25910204.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221.012506.25910204.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10593
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 21, 2006 at 01:25:06AM +0900, Atsushi Nemoto wrote:

> The last argument of div_long_long_rem() must be long.

Applied,

  Ralf
