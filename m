Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Feb 2006 13:13:10 +0000 (GMT)
Received: from mipsfw.mips-uk.com ([194.74.144.146]:19727 "EHLO
	bacchus.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8133531AbWBMNNC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Feb 2006 13:13:02 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.4/8.13.4) with ESMTP id k1DDJOKE010698;
	Mon, 13 Feb 2006 13:19:24 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.4/8.13.4/Submit) id k1DDJLn1010697;
	Mon, 13 Feb 2006 13:19:21 GMT
Date:	Mon, 13 Feb 2006 13:19:21 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	pdh@colonel-panic.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6.X] Early console for Cobalt
Message-ID: <20060213131921.GB3720@linux-mips.org>
References: <20060212171025.GB1562@colonel-panic.org> <20060213.114359.07641583.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213.114359.07641583.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 13, 2006 at 11:43:59AM +0900, Atsushi Nemoto wrote:

> >>>>> On Sun, 12 Feb 2006 17:10:25 +0000, Peter Horton <pdh@colonel-panic.org> said:
> pdh> Adds early console support for Cobalts.
> 
> We already have EARLY_PRINTK.  How about using it?  (like dec does)

Indeed, done.

  Ralf
