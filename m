Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Mar 2007 22:55:32 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:15242 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021354AbXC2Vza (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Mar 2007 22:55:30 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2TLtNZH026565;
	Thu, 29 Mar 2007 22:55:23 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2TLtMxt026564;
	Thu, 29 Mar 2007 22:55:22 +0100
Date:	Thu, 29 Mar 2007 22:55:22 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark Mason <mmason@upwardaccess.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] add bcm1480 ZBus trace support, fix wait related bugs
Message-ID: <20070329215522.GA24093@linux-mips.org>
References: <20070329183956.GA10855@upwardaccess.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070329183956.GA10855@upwardaccess.com>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Mar 29, 2007 at 11:39:56AM -0700, Mark Mason wrote:

> Make ZBus tracing generic - moving it to a common direcotry under
> arch/mips/sibyte, add bcm1480 support and fix some wait related
> bugs (thanks to Ralf for assistance on that).
> 
> Signed-off-by: Mark Mason <mason@broadcom.com>

Queued for 2.6.22.

  Ralf
