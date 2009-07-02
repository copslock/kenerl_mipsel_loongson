Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jul 2009 12:52:51 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43008 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492119AbZGBKwp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Jul 2009 12:52:45 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n62AkoNm007636;
	Thu, 2 Jul 2009 11:46:50 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n62AknSa007634;
	Thu, 2 Jul 2009 11:46:49 +0100
Date:	Thu, 2 Jul 2009 11:46:49 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Jeff Chua <jeff.chua.linux@gmail.com>,
	Etienne Basset <etienne.basset@numericable.fr>,
	David Miller <davem@davemloft.net>, rjw@sisk.pl,
	linux-kernel@vger.kernel.org, kernel-testers@vger.kernel.org,
	linux-mips@linux-mips.org, linux-ide@vger.kernel.org
Subject: Re: [Bug #13663] suspend to ram regression (IDE related)
Message-ID: <20090702104649.GC14804@linux-mips.org>
References: <etTXaRqGgAC.A.SaE.6iASKB@chimera> <1246459661.9660.40.camel@falcon> <200907011821.26091.bzolnier@gmail.com> <200907011829.16850.bzolnier@gmail.com> <1246499203.9660.52.camel@falcon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1246499203.9660.52.camel@falcon>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 02, 2009 at 09:46:43AM +0800, Wu Zhangjin wrote:

> Sorry, I can not apply this patch directly, which original version did
> you use? I used the one in the master branch of linux-mips development
> git repository.

The master branch of linux-mips.org has no IDE changes over Linus' tree.

  Ralf
