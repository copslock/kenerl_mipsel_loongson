Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2009 11:10:27 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60928 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021984AbZEOKKU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 May 2009 11:10:20 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4FA9xEK004791;
	Fri, 15 May 2009 11:10:07 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4FA9qR4004773;
	Fri, 15 May 2009 11:09:52 +0100
Date:	Fri, 15 May 2009 11:09:51 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] TXx9: Add ACLC support
Message-ID: <20090515100951.GB2821@linux-mips.org>
References: <1242312605-2160-2-git-send-email-anemo@mba.ocn.ne.jp> <20090515090118.GA7706@linux-mips.org> <20090515091741.GA4449@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090515091741.GA4449@sirena.org.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22728
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 15, 2009 at 10:17:43AM +0100, Mark Brown wrote:

> On Fri, May 15, 2009 at 10:01:19AM +0100, Ralf Baechle wrote:
> > On Thu, May 14, 2009 at 11:50:05PM +0900, Atsushi Nemoto wrote:
> 
> > > Add platform support for ACLC of TXx9 SoCs.
> 
> > Thanks, queued up for 2.6.31 / linux-next.
> 
> These will need revision after fixing my review comments for the audio
> drivers - the way the platform devices are set up needs to be changed so
> that the resources are associated with devices for the CPU rather than
> the machine driver that says how a given board is connected up.

Ok; I re-queued the patch into my -mm tree until we declare it ripe.

  Ralf
