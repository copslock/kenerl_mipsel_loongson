Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980327.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA2643036 for <linux-archive@neteng.engr.sgi.com>; Wed, 29 Apr 1998 15:48:22 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA17441764
	for linux-list;
	Wed, 29 Apr 1998 15:47:57 -0700 (PDT)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA17215129
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 29 Apr 1998 15:47:54 -0700 (PDT)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id PAA19097
	for <linux@cthulhu.engr.sgi.com>; Wed, 29 Apr 1998 15:47:53 -0700 (PDT)
	mail_from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id AAA11199;
	Thu, 30 Apr 1998 00:47:44 +0200 (MEST)
Received: by thoma (SMI-8.6/KO-2.0)
	id AAA03590; Thu, 30 Apr 1998 00:47:40 +0200
Message-ID: <19980430004740.61845@uni-koblenz.de>
Date: Thu, 30 Apr 1998 00:47:40 +0200
From: ralf@uni-koblenz.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.rutgers.edu, adevries@engsoc.carleton.ca,
        linux@cthulhu.engr.sgi.com
Subject: Re: Could mounting sdc instead of sdc1 have solved my panics?
References: <19980430002810.03127@uni-koblenz.de> <m0yUfJq-000aNhC@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <m0yUfJq-000aNhC@the-village.bc.nu>; from Alan Cox on Wed, Apr 29, 1998 at 11:27:13PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 29, 1998 at 11:27:13PM +0100, Alan Cox wrote:

> > I don't see any reason why the kernel should crash when using sdc instead of
> > a partition.  So I forward this to linux-kernel in the hope anybody knows.
> 
> My Indy has always been on /dev/sdb - anyone who has met the SGI command
> line disk partitioner can probably guess why. So far its worked ;)

Fact is that two kernels, the one Alex built from linux-cvs and the one
which I built yesterday for myself, both significantly different and both
2.1.91 derived, crashed.  Each time disassembling showed that somehow a NULL
pointer ended up in the SCSI scatter-gather lists which where passed to
dma_setup in the sgiwd93.  No idea why; I've never seen that bug myself.

  Ralf
