Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA21879; Tue, 11 Jun 1996 18:22:26 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA26908 for linux-list; Wed, 12 Jun 1996 01:22:21 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id SAA26898 for <linux@cthulhu.engr.sgi.com>; Tue, 11 Jun 1996 18:22:20 -0700
Received: (from dm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAB21833; Tue, 11 Jun 1996 18:19:45 -0700
Date: Tue, 11 Jun 1996 18:19:45 -0700
Message-Id: <199606120119.SAB21833@neteng.engr.sgi.com>
From: "David S. Miller" <dm@neteng.engr.sgi.com>
To: wje@fir.esd.sgi.com
CC: linux@cthulhu.engr.sgi.com
In-reply-to: <199606120111.SAA08986@fir.esd.sgi.com> (wje@fir.esd.sgi.com)
Subject: Re: I fixed the r4ktimer code...
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

   Date: Tue, 11 Jun 1996 18:11:05 -0700
   From: wje@fir.esd.sgi.com (William J. Earl)

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

Peculiar... but I believe if you look at the calibrate_delay()
function I sent you earlier you will see that the way it performs the
calculation implies a certain error fuzz all in the name of efficiency
(some time back calibrate_delay() was much more accurate but took 3 or
4 seconds to run at boot time, ugh, the lesser of two evils)

The new way I calculate the r4k compare register offset is that I set
the rate generation of the Intel counter at 1HZ.  I then make 4
samples of how far the r4k counter goes every time the Intel counter
makes a full 1 HZ iteration.  I then average these 4 samples and
multiply by HZ (which == 100 for the Mips port of Linux) to find the
final r4k offset value that I use.

Anyways, BogoMIPS is by definition "bogus" ;-) It is only used by
the kernel to do quick microsecond delays in various places of the
kernel.

Later,
David S. Miller
dm@sgi.com
