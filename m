Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jul 2006 23:47:00 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:26319 "EHLO bacchus.dhis.org")
	by ftp.linux-mips.org with ESMTP id S8133495AbWGIWqw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 9 Jul 2006 23:46:52 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by bacchus.dhis.org (8.13.6/8.13.4) with ESMTP id k69MkvgW020630;
	Sun, 9 Jul 2006 23:46:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.6/8.13.6/Submit) id k69MksxT020625;
	Sun, 9 Jul 2006 23:46:54 +0100
Date:	Sun, 9 Jul 2006 23:46:53 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] sparsemem fix
Message-ID: <20060709224653.GA20598@linux-mips.org>
References: <20060705.012244.96686002.anemo@mba.ocn.ne.jp> <44AB79D0.90002@innova-card.com> <20060705.192054.128618288.nemoto@toshiba-tops.co.jp> <20060706173235.GA4739@linux-mips.org> <cda58cb80607080747g66ac4357ya1f2cef89b4d868@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80607080747g66ac4357ya1f2cef89b4d868@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jul 08, 2006 at 04:47:39PM +0200, Franck Bui-Huu wrote:

> but the code seems to be in arch/mips/sgi-ip27, no ?
> 
> BTW, Ralf, are there any needs for MIPS to support platforms whose
> memory start is not 0 ? I have made a patch for that, and wondering if
> it's worth to post it on the list...

Yes, while it's relativly rare such platforms do exist and they currently
pay the price of wasting some memory for the allocation of unused entries
in mem_map[].

  Ralf
