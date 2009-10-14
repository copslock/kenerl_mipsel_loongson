Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 12:43:25 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:54024 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1492647AbZJNKnW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Oct 2009 12:43:22 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9EAieJR027542;
	Wed, 14 Oct 2009 12:44:41 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9EAiaVG027540;
	Wed, 14 Oct 2009 12:44:36 +0200
Date:	Wed, 14 Oct 2009 12:44:36 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	david-b@pacbell.net, linux-mips@linux-mips.org,
	spi-devel-general@lists.sourceforge.net
Subject: Re: [PATCH 2/2] spi_txx9: Fix bit rate calculation
Message-ID: <20091014104436.GA27483@linux-mips.org>
References: <1251986341-16938-2-git-send-email-anemo@mba.ocn.ne.jp> <20090904163227.GB6699@linux-mips.org> <20090925.021039.179960776.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090925.021039.179960776.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 25, 2009 at 02:10:39AM +0900, Atsushi Nemoto wrote:

> On Fri, 4 Sep 2009 17:32:27 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> > Atsushi's patches should probably be merged together.  I can take care of
> > that if the SPI bit is acked by a maintainer.
> 
> David, could you give us Ack ?
> 
> [PATCH 1/2] txx9: Fix spi-baseclk value
> [PATCH 2/2] spi_txx9: Fix bit rate calculation

Nothing heared so I've just merged these two fixes and will push them to
Linus asap.

  Ralf
