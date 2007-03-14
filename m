Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2007 13:47:15 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:11447 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021465AbXCNNrO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Mar 2007 13:47:14 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2EDjDxe025104;
	Wed, 14 Mar 2007 13:45:13 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2EDjCHM025103;
	Wed, 14 Mar 2007 13:45:12 GMT
Date:	Wed, 14 Mar 2007 13:45:12 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
Cc:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] merge GT64111 PCI routines and GT64120 PCI_0 routines
Message-ID: <20070314134511.GA24290@linux-mips.org>
References: <20070314215126.72d21e96.yoichi_yuasa@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070314215126.72d21e96.yoichi_yuasa@tripeaks.co.jp>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14466
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 14, 2007 at 09:51:26PM +0900, Yoichi Yuasa wrote:

> This patch has merged GT64111 PCI routines and GT64120 PCI_0 routines.
> GT64111 PCI is almost the same as GT64120's PCI_0.
> This patch don't change GT64120 PCI routines.
> 
> This patch tested on Cobalt Qube2.
> 
> Please queue for 2.6.22.

Will do.

This sort of cleanup is something I meant to do for a long time.  We have
other fairly similar chips such as the GT-64240 used in the Ocelot G and
the GT-64340 used in the Ocelot 3 which both are supported by
arch/mips/pci/ops-marvell.c.  There are many other PCI busses which are
virtually identical.

Thanks,

  Ralf
