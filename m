Received:  by oss.sgi.com id <S305162AbQAaJ00>;
	Mon, 31 Jan 2000 01:26:26 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:18302 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305160AbQAaJ0G>;
	Mon, 31 Jan 2000 01:26:06 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA01595; Mon, 31 Jan 2000 01:28:56 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id BAA92611
	for linux-list;
	Mon, 31 Jan 2000 01:16:01 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id BAA59253
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 31 Jan 2000 01:15:57 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id BAA09336
	for <linux@cthulhu.engr.sgi.com>; Mon, 31 Jan 2000 01:15:55 -0800 (PST)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id CBE787D9; Mon, 31 Jan 2000 10:15:53 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 1C3848FC4; Mon, 31 Jan 2000 09:42:57 +0100 (CET)
Date:   Mon, 31 Jan 2000 09:42:57 +0100
From:   Florian Lohoff <flo@rfc822.org>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: WCHAN on R3000
Message-ID: <20000131094256.A3806@paradigm.rfc822.org>
References: <20000128212909.A11816@uni-koblenz.de> <20000129233325.I1329@paradigm.rfc822.org> <20000131053326.A12102@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000131053326.A12102@uni-koblenz.de>; from Ralf Baechle on Mon, Jan 31, 2000 at 05:33:26AM +0100
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Jan 31, 2000 at 05:33:26AM +0100, Ralf Baechle wrote:
> On Sat, Jan 29, 2000 at 11:33:25PM +0100, Florian Lohoff wrote:
> 
> > (root@repeat)~# cat /proc/cpuinfo 
> [...]
> > VCED exceptions         : 750604
> > VCEI exceptions         : 4523546
> [...]
> 
> > I dont know if you call this "sane" ...
> 
> The large number of VCEI exceptions smells.  How long has this machine
> been up?

Around ~26 days (I dont know what this would be with corrected 100Hz bug)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5241-470566
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
