Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2006 13:05:19 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:27660 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133508AbWBONFL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 15 Feb 2006 13:05:11 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1FDBhH2025960;
	Wed, 15 Feb 2006 13:11:43 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1FDBgAE025959;
	Wed, 15 Feb 2006 13:11:42 GMT
Date:	Wed, 15 Feb 2006 13:11:42 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] sc-rm7k.c cleanup
Message-ID: <20060215131142.GA24149@linux-mips.org>
References: <20060215.182548.118975142.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060215.182548.118975142.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10468
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 15, 2006 at 06:25:48PM +0900, Atsushi Nemoto wrote:

> Use blast_scache_range, blast_inv_scache_range for rm7k scache routine.
> Output code should be logically same.

Ok, queued for 2.6.17.

  Ralf
