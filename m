Received:  by oss.sgi.com id <S553770AbRCGUDi>;
	Wed, 7 Mar 2001 12:03:38 -0800
Received: from FORT-POINT-STATION.MIT.EDU ([18.72.0.53]:61847 "EHLO
        fort-point-station.mit.edu") by oss.sgi.com with ESMTP
	id <S553755AbRCGUDM>; Wed, 7 Mar 2001 12:03:12 -0800
Received: from grand-central-station.mit.edu (GRAND-CENTRAL-STATION.MIT.EDU [18.7.21.82])
	by fort-point-station.mit.edu (8.9.2/8.9.2) with ESMTP id PAA06855
	for <linux-mips@oss.sgi.com>; Wed, 7 Mar 2001 15:03:04 -0500 (EST)
Received: from melbourne-city-street.MIT.EDU (MELBOURNE-CITY-STREET.MIT.EDU [18.69.0.45])
	by grand-central-station.mit.edu (8.9.2/8.9.2) with ESMTP id PAA04770
	for <linux-mips@oss.sgi.com>; Wed, 7 Mar 2001 15:03:04 -0500 (EST)
Received: from scrubbing-bubbles.mit.edu (SCRUBBING-BUBBLES.MIT.EDU [18.184.0.32])
	by melbourne-city-street.MIT.EDU (8.9.3/8.9.2) with ESMTP id PAA19532
	for <linux-mips@oss.sgi.com>; Wed, 7 Mar 2001 15:03:04 -0500 (EST)
Received: from localhost (kbarr@localhost) by scrubbing-bubbles.mit.edu (8.9.3) with ESMTP
	id PAA06611; Wed, 7 Mar 2001 15:03:03 -0500 (EST)
Date:   Wed, 7 Mar 2001 15:03:03 -0500 (EST)
From:   Kenneth C Barr <kbarr@MIT.EDU>
To:     <linux-mips@oss.sgi.com>
Subject: oops on shutdown
Message-ID: <Pine.GSO.4.30L.0103071457170.9228-100000@scrubbing-bubbles.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

I receive this error any time I try to "reboot" or "shutdown" my Indy
running a snapshot of 2.4.1.

Is this normal or experienced by anyone else?

Easy solution would be never to turn off the machine, but I want to make
sure this isn't indicative of a larger problem.  (eg, broken paging?)


shutdown: couldn't unmount /dev/sda1

Unable to handle kernel paging request at virtual address 00000000, epc
== 00008
Oops in fault.c:do_page_fault, line 172:
regs:

...

epc     00000000
Status  1000fc03
Cause   00000008
Process reboot (pid:39, stackpage=8bc8e000)
Stack:

...

Call trace: [<88031a6c>]  [<88031a64>] [<8813f734>] [<880b9a5c>]
[<88058714>]
Code: (Bad address in epc)
