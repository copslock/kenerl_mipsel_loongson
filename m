Received:  by oss.sgi.com id <S305184AbPLIWq1>;
	Thu, 9 Dec 1999 14:46:27 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:32060 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305163AbPLIWp6>; Thu, 9 Dec 1999 14:45:58 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA00359; Thu, 9 Dec 1999 14:55:11 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA68922
	for linux-list;
	Thu, 9 Dec 1999 14:43:51 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA81844
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 9 Dec 1999 14:43:42 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from lilith.dpo.uab.edu (lilith.dpo.uab.edu [138.26.1.128]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00721
	for <linux@cthulhu.engr.sgi.com>; Thu, 9 Dec 1999 14:43:39 -0800 (PST)
	mail_from (andrewb@uab.edu)
Received: from mdk187.tucc.uab.edu (mdk187.tucc.uab.edu [138.26.15.201])
	by lilith.dpo.uab.edu (8.9.3/8.9.3) with SMTP id QAA29008;
	Thu, 9 Dec 1999 16:43:32 -0600
Date:   Thu, 9 Dec 1999 16:41:01 -0600 (CST)
From:   "Andrew R. Baker" <andrewb@uab.edu>
X-Sender: andrewb@mdk187.tucc.uab.edu
To:     Mike Hill <mikehill@hgeng.com>
cc:     "'Ralf Baechle'" <ralf@oss.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: RE: Snapshot
In-Reply-To: <E138DB347D10D3119C630008C79F5DEC11F79F@BART>
Message-ID: <Pine.LNX.3.96.991209163947.3336A-100000@mdk187.tucc.uab.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Serial console is not working in 2.3 yet.  I know how to fix it for when
it is included on the command line, but what I came up with for detecting
it from the PROM enviroment is a bit strange.

On Tue, 7 Dec 1999, Mike Hill wrote:
> Hi Ralf,
> 
> This compiles very well (i386 cross-compiled) unless I add serial console
> support, in which case it finishes like this:
