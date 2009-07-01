Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Jul 2009 08:36:55 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:36222 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491965AbZGAGgr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Jul 2009 08:36:47 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n616VHTw007491;
	Wed, 1 Jul 2009 07:31:17 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n616VGe6007489;
	Wed, 1 Jul 2009 07:31:17 +0100
Date:	Wed, 1 Jul 2009 07:31:16 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] [MIPS] Malta: Remove unneeded function protos from
	malta-reset.c
Message-ID: <20090701063116.GA6101@linux-mips.org>
References: <1246035565-24015-1-git-send-email-dmitri.vorobiev@movial.com> <20090628181702.GB20084@linux-mips.org> <alpine.LFD.2.00.0907010108380.23134@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0907010108380.23134@eddie.linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jul 01, 2009 at 01:17:22AM +0100, Maciej W. Rozycki wrote:

> > There should be a tax on useless prototypes and also excessive parentheses ;-)
> 
>  And insufficient parentheses causing the average reader to refer to the 
> language spec for the operator priority list. ;)

Code written to require intimate knowledge of all operator priorities is
probably as bad as overuse.  Here a few examples:

	return (1);
#define FOO	(42)
	a = (b + c);
	a = (b + c) + d;
	a = (b * c) + (d * e);
	if ((a > b) && (a < c))

  Ralf
