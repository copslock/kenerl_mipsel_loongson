Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 12:54:56 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:39652 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026627AbXLNMxo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Dec 2007 12:53:44 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lBECrX3s029660;
	Fri, 14 Dec 2007 12:53:35 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lBE1728D024600;
	Fri, 14 Dec 2007 01:07:02 GMT
Date:	Fri, 14 Dec 2007 01:07:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][1/2][MIPS] remove unneeded button check for reset
Message-ID: <20071214010702.GB20999@linux-mips.org>
References: <20071212222019.9ab7b2ed.yoichi_yuasa@tripeaks.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071212222019.9ab7b2ed.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17816
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 12, 2007 at 10:20:19PM +0900, Yoichi Yuasa wrote:

> Removed unneeded button check for reset.
> Because, the Cobalt has power switch.

Queued for 2.6.25 with the printk removed.  If anywhere such notifications
should go to userspace.

Thanks,

  Ralf.
