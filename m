Received:  by oss.sgi.com id <S305160AbQDTVob>;
	Thu, 20 Apr 2000 14:44:31 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:37971 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305159AbQDTVoR>; Thu, 20 Apr 2000 14:44:17 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA03536; Thu, 20 Apr 2000 14:48:19 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA63852; Thu, 20 Apr 2000 14:43:46 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA22978
	for linux-list;
	Thu, 20 Apr 2000 14:30:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA53858
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Apr 2000 14:30:13 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA01762
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Apr 2000 14:30:09 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id B8F3280D; Thu, 20 Apr 2000 23:30:10 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id CE9E98FC4; Thu, 20 Apr 2000 23:03:45 +0200 (CEST)
Date:   Thu, 20 Apr 2000 23:03:45 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Should send SIGFPE to .*
Message-ID: <20000420230345.A272@paradigm.rfc822.org>
References: <012b01bfaaeb$27911800$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <012b01bfaaeb$27911800$0ceca8c0@satanas.mips.com>; from Kevin D. Kissell on Thu, Apr 20, 2000 at 07:09:07PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Apr 20, 2000 at 07:09:07PM +0200, Kevin D. Kissell wrote:
> >> if it was actually a problem), and as such the force_sig() should
> >> use the value returned by compute_return_epc() as the signal
> >
> >I dont think compute_return_epc returns a signal value.
> 
> Oops.  You're right.  It returns -EFAULT.  And it handles
> the signal propagation all by its lonesome, so nothing
> further needs to be done if it failed.

This is what i assumed :)

> >How much is the full emulator as binary ?
> 
> About 47Kbytes, I'm afraid.

Hmmm - With a 2MB Kernel Image total and 64-128MB machines this is 
ok :)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
