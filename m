Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id UAA92769 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Apr 1999 20:10:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA73611
	for linux-list;
	Wed, 14 Apr 1999 20:09:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi.waldorf-gmbh.de ([150.166.40.201])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA07366;
	Wed, 14 Apr 1999 20:09:17 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id UAA01128;
	Wed, 14 Apr 1999 20:09:04 -0700
Message-ID: <19990414200859.A1088@uni-koblenz.de>
Date: Wed, 14 Apr 1999 20:08:59 -0700
From: ralf@uni-koblenz.de
To: Alex deVries <adevries@engsoc.carleton.ca>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Errors building...
References: <19990414231550.A3227@alpha.franken.de> <Pine.LNX.3.96.990414213624.29768B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <Pine.LNX.3.96.990414213624.29768B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Apr 14, 1999 at 09:37:50PM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 14, 1999 at 09:37:50PM -0400, Alex deVries wrote:

> Somehow my egcs was corrupt, so I reinstalled it and life is much better.

Not corrupt.  The problem is that the compiler options -msplit-addresses
results in code that cannot be assembled when the compiler is being built
with HAIFA enabled.  Newer releases fixed that.

  Ralf
