Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA21562; Tue, 11 Jun 1996 18:11:20 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA24805 for linux-list; Wed, 12 Jun 1996 01:11:12 GMT
Received: from ares.esd.sgi.com (fddi-ares.engr.sgi.com [192.26.80.60]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA24799 for <linux@cthulhu.engr.sgi.com>; Tue, 11 Jun 1996 18:11:10 -0700
Received: from fir.esd.sgi.com by ares.esd.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/950213.SGI.AUTOCF)
	 id SAA09358; Tue, 11 Jun 1996 18:11:09 -0700
Received: by fir.esd.sgi.com (940816.SGI.8.6.9/920502.SGI.AUTO)
	 id SAA08986; Tue, 11 Jun 1996 18:11:05 -0700
Date: Tue, 11 Jun 1996 18:11:05 -0700
From: wje@fir.esd.sgi.com (William J. Earl)
Message-Id: <199606120111.SAA08986@fir.esd.sgi.com>
To: "David S. Miller" <dm@neteng.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: I fixed the r4ktimer code...
In-Reply-To: <199606120004.RAA17283@neteng.engr.sgi.com>
References: <199606120004.RAA17283@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller writes:
 > 
 > Calibrating delay loop.. ok - 138.04 BogoMIPS
 > 
 > Much better ;-)

     Yes, except that it should really be 133.33 on the 133 MHZ R4600SC.
I don't have any idea where the 4% error would be coming from, unless there
is something wrong with the external timer.  One way of checking the timer
might be to measure a tick of the Dallas clock/calendar chip.  I believe
the one we use in Indy counts 0.01 second units, so noticing the 
$count change over, say, a 0.5 second interval, as measured by the
Dallas part, would be a way of validating the timer configuration.
