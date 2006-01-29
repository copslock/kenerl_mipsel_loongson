Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jan 2006 13:00:11 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:25119 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133552AbWA3Mzc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Jan 2006 12:55:32 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.4) with ESMTP id k0UD0QTM005207;
	Mon, 30 Jan 2006 13:00:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k0TEAMCL027295;
	Sun, 29 Jan 2006 14:10:22 GMT
Date:	Sun, 29 Jan 2006 14:10:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] add __user tag to __get_user_check
Message-ID: <20060129141021.GB3420@linux-mips.org>
References: <20060129.022724.126574864.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060129.022724.126574864.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, Jan 29, 2006 at 02:27:24AM +0900, Atsushi Nemoto wrote:

> Revert __user tag lost by recent get_user rework.

Applied,

  Ralf
