Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Feb 2006 14:18:27 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:30474 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133476AbWBWOSU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Feb 2006 14:18:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1NEPWW4030997;
	Thu, 23 Feb 2006 14:25:32 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1NEPVpQ030995;
	Thu, 23 Feb 2006 14:25:31 GMT
Date:	Thu, 23 Feb 2006 14:25:31 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] use generic compat routines for readdir, getdents
Message-ID: <20060223142530.GA16433@linux-mips.org>
References: <20060221.155900.45517504.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221.155900.45517504.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10615
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 21, 2006 at 03:59:00PM +0900, Atsushi Nemoto wrote:

> Not just cleanup but also fixes O32 readdir(2) emulation.

Applied.  Thanks,

  Ralf
