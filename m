Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2007 23:56:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:58770 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20039019AbXBTX43 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 20 Feb 2007 23:56:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l1KNuTjG021486;
	Tue, 20 Feb 2007 23:56:29 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l1KNuRJD021485;
	Tue, 20 Feb 2007 23:56:27 GMT
Date:	Tue, 20 Feb 2007 23:56:27 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Martin Michlmayr <tbm@cyrius.com>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] add MTD device support for Cobalt
Message-ID: <20070220235627.GA21412@linux-mips.org>
References: <20070220141157.06bf44bd.yoichi_yuasa@tripeaks.co.jp> <20070220191539.GB21082@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070220191539.GB21082@deprecation.cyrius.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 20, 2007 at 07:15:39PM +0000, Martin Michlmayr wrote:

> * Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2007-02-20 14:11]:
> > +		.name	= "Colo",
> 
> Should this really be called 'Colo'?

It's probably the gentle hint with a redwood trunk to replace the
original Cobalt firmware with something less crappy ;-)

How about calling it just "firmware"?

  Ralf
