Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 19:59:43 +0100 (BST)
Received: from wf1.mips-uk.com ([194.74.144.154]:38567 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20027104AbXFFS7l (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 6 Jun 2007 19:59:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l56Isoqm010756
	for <linux-mips@linux-mips.org>; Wed, 6 Jun 2007 19:54:50 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l56Iso9m010755
	for linux-mips@linux-mips.org; Wed, 6 Jun 2007 19:54:50 +0100
Date:	Wed, 6 Jun 2007 19:54:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Tickless/dyntick kernel, highres timer and general time crapectomy
Message-ID: <20070606185450.GA10511@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Time to send bring this to a larger audience.

I'm working on getting dyntick and highres timer support working for MIPS.
This unavoidably implies dumping most of the MIPS-private time
infrastructure we've piled up over the past decade.  Which really is a
major crapectomy.  A first cut of the patches which are tested to run
well on uniprocessor and VSMP Malta kernels is at:

  ftp://ftp.linux-mips.org/pub/linux/mips/people/ralf/dyntick-quilt

It will also likely work on various other simple systems.  A more recent
version of these patches which I haven't yet gotten around to test on
silicon is available at:

  ftp://ftp.linux-mips.org/pub/linux/mips/people/ralf/linux-time.patches

The patchset is both large and intrusive.  One of the things that are still
missing is support for additional clocksources and clockevent_devices.
Particularly Alchemy (and any other system supporting clock scaling) will
need some work there since the cp0 count/compare timer are not useful on
such systems.  Help with those would be greatly appreciated.

  Ralf
