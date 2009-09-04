Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Sep 2009 18:31:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35999 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492750AbZIDQbk (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 4 Sep 2009 18:31:40 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n84GWT1h007643;
	Fri, 4 Sep 2009 17:32:30 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n84GWRmK007641;
	Fri, 4 Sep 2009 17:32:27 +0100
Date:	Fri, 4 Sep 2009 17:32:27 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, spi-devel-general@lists.sourceforge.net,
	david-b@pacbell.net
Subject: Re: [PATCH 2/2] spi_txx9: Fix bit rate calculation
Message-ID: <20090904163227.GB6699@linux-mips.org>
References: <1251986341-16938-2-git-send-email-anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1251986341-16938-2-git-send-email-anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 03, 2009 at 10:59:01PM +0900, Atsushi Nemoto wrote:

Atsushi's patches should probably be merged together.  I can take care of
that if the SPI bit is acked by a maintainer.

Thanks,

  Ralf
