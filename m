Received:  by oss.sgi.com id <S305162AbQAaEpL>;
	Sun, 30 Jan 2000 20:45:11 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:27230 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305160AbQAaEpA>;
	Sun, 30 Jan 2000 20:45:00 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA25858; Sun, 30 Jan 2000 20:43:19 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA90473
	for linux-list;
	Sun, 30 Jan 2000 20:34:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA87647
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 30 Jan 2000 20:34:04 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA02433
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Jan 2000 20:34:03 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-17.uni-koblenz.de (cacc-17.uni-koblenz.de [141.26.131.17])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id FAA17762;
	Mon, 31 Jan 2000 05:33:57 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407893AbQAaEd0>;
	Mon, 31 Jan 2000 05:33:26 +0100
Date:   Mon, 31 Jan 2000 05:33:26 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: WCHAN on R3000
Message-ID: <20000131053326.A12102@uni-koblenz.de>
References: <20000128212909.A11816@uni-koblenz.de> <20000129233325.I1329@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20000129233325.I1329@paradigm.rfc822.org>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sat, Jan 29, 2000 at 11:33:25PM +0100, Florian Lohoff wrote:

> (root@repeat)~# cat /proc/cpuinfo 
[...]
> VCED exceptions         : 750604
> VCEI exceptions         : 4523546
[...]

> I dont know if you call this "sane" ...

The large number of VCEI exceptions smells.  How long has this machine
been up?

  Ralf
