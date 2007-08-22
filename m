Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2007 13:31:03 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:62149 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023785AbXHWM2T (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Aug 2007 13:28:19 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7NCSE8m012232;
	Thu, 23 Aug 2007 13:28:18 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7MMZ7hg007276;
	Wed, 22 Aug 2007 23:35:07 +0100
Date:	Wed, 22 Aug 2007 23:35:07 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Andy Whitcroft <apw@shadowen.org>
Cc:	linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>,
	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/6] mips: irix_getcontext will always fail EFAULT
Message-ID: <20070822223507.GD4473@linux-mips.org>
References: <exportbomb.1187270320@pinky> <0b4bc89aa61d97708ca0f79ba02f6e60@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b4bc89aa61d97708ca0f79ba02f6e60@pinky>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16258
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Aug 16, 2007 at 02:18:45PM +0100, Andy Whitcroft wrote:

> Seems that a trailing ';' has slipped onto the end of the access_ok
> check here, such that we will always return -EFAULT.

Ilpo Järvinen has sent an identical patch earlier which I have already
applied.  Thanks anyway,

  Ralf
