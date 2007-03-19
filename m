Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 01:56:30 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15821 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022938AbXCSB43 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 01:56:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2J1sSxB006284;
	Mon, 19 Mar 2007 01:54:28 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2J1sO6r006274;
	Mon, 19 Mar 2007 01:54:24 GMT
Date:	Mon, 19 Mar 2007 01:54:24 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] More liberal check for mips-board console
Message-ID: <20070319015411.GB5658@linux-mips.org>
References: <20070319000506.GA7744@networkno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070319000506.GA7744@networkno.de>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Mar 19, 2007 at 12:05:06AM +0000, Thiemo Seufer wrote:

> the appended patch allows to override the MALTA/ATLAS/etc. default
> console setting with non-serial console devices.

Okay, applied also.  I take it you've done some more Qemu VGA fixing.  I
hope it means that I can soon delete all the VGA initialization rubbish
in q-vga.c - as it currently exists, it is not mergable.

  Ralf
