Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id LAA367537 for <linux-archive@neteng.engr.sgi.com>; Sun, 21 Dec 1997 11:13:25 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA13682 for linux-list; Sun, 21 Dec 1997 11:12:36 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA13678 for <linux@cthulhu.engr.sgi.com>; Sun, 21 Dec 1997 11:12:35 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id LAA15759
	for <linux@cthulhu.engr.sgi.com>; Sun, 21 Dec 1997 11:12:33 -0800
	env-from (ralf@mailhost.uni-koblenz.de)
Received: from thoma (ralf@thoma.uni-koblenz.de [141.26.4.61])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with SMTP id UAA13055;
	Sun, 21 Dec 1997 20:12:08 +0100 (MET)
Received: by thoma (SMI-8.6/KO-2.0)
	id UAA12770; Sun, 21 Dec 1997 20:12:07 +0100
Message-ID: <19971221201207.54857@thoma.uni-koblenz.de>
Date: Sun, 21 Dec 1997 20:12:07 +0100
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
Subject: Re: Polishing the cache routines ...
References: <19971220224036.52320@uni-koblenz.de> <199712211900.NAA18285@athena.nuclecu.unam.mx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.84e
In-Reply-To: <199712211900.NAA18285@athena.nuclecu.unam.mx>; from Miguel de Icaza on Sun, Dec 21, 1997 at 01:00:51PM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Dec 21, 1997 at 01:00:51PM -0600, Miguel de Icaza wrote:
> 
> > minor side effects of polishing the cache routines ...
> > 
> >   Ralf
> 
> What exactly did the polishing do?  I saw that we are down in a couple
> of tests.

Most of these values where we went down aren't stable across several
runs.  The improoved values for the exec & sh test however were pretty
stable.  The optimization was getting rid of flushing the second level
cache in r4k_flush_page_to_ram_d32i32().

  Ralf
