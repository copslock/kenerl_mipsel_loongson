Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Sep 2009 00:19:42 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:38931 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493301AbZIWWTf (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Sep 2009 00:19:35 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n8NMKKDH024742;
	Wed, 23 Sep 2009 23:20:20 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n8NMK3be024719;
	Wed, 23 Sep 2009 23:20:03 +0100
Date:	Wed, 23 Sep 2009 23:20:03 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Kevin Cernekee <cernekee@gmail.com>
Cc:	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Avoid destructive invalidation on partial L2
	cachelines
Message-ID: <20090923221937.GC22516@linux-mips.org>
References: <de70b67245e012ab0c11b520a721989b@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de70b67245e012ab0c11b520a721989b@localhost>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 18, 2009 at 07:12:45PM -0700, Kevin Cernekee wrote:

> This extends commit a8ca8b64e3fdfec17679cba0ca5ce6e3ffed092d to cover
> the board cache code.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Thanks Kevin, applied.

  Ralf
