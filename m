Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA93043 for <linux-archive@neteng.engr.sgi.com>; Tue, 30 Mar 1999 18:35:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA15949
	for linux-list;
	Tue, 30 Mar 1999 18:33:14 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id SAA86499;
	Tue, 30 Mar 1999 18:33:11 -0800 (PST)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id SAA17826; Tue, 30 Mar 1999 18:33:10 -0800
Date: Tue, 30 Mar 1999 18:33:10 -0800
Message-Id: <199903310233.SAA17826@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: "Mark A. Zottola" <asnmaz01@asc.edu>
Cc: Alan Hoyt <neuroinc@unidial.com>,
        Ariel Faigon <ariel@cthulhu.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: Port to R3000 Indigo
In-Reply-To: <37017BA5.160B97BD@asc.edu>
References: <37016B61.5AC93288@unidial.com>
	<37017BA5.160B97BD@asc.edu>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mark A. Zottola writes:
 > 
 > I would like to second Alan's request. Our port of LINUX to the Indigo2 has
 > ground to an unceremonious halt for a lack of hardware documentation. I
 > understand that there are legal considerations. Would it not be possible to
 > release the documentation under some sort of non-disclosure agreement? As
 > we are writing code, if we do not :
 > 
 > 1) include specific citations of the documentation within the comments, or
 > 2) discuss those hardware matters deemed as proprietary within the comments
 > 
 > then it seems we could be able to satisfy any non-disclosure agreement SGI
 > would have while working under the disclosure constraint of the LINUX's
 > GPL. It seems there is an eminently workable way around this if reasonable
 > people can come together to discuss this reasonably.
...

     For serious developers, we can definitely provide the Indy documentation,
which covers quite a bit of Indigo R4000 and Indigo2, although there are 
differences in some places, notably due to those machines using an earlier
revision of the I/O controller (HPC).  We are still working on getting a 
more general policy on release of documentation, including selected bits
of low-level IRIX code (at least where license issues do not arise).  The
Indy situation was a special case, done some time ago.
