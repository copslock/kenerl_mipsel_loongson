Received:  by oss.sgi.com id <S305162AbQAaEgB>;
	Sun, 30 Jan 2000 20:36:01 -0800
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:6233 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305160AbQAaEfm>; Sun, 30 Jan 2000 20:35:42 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id UAA08845; Sun, 30 Jan 2000 20:41:05 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA74600
	for linux-list;
	Sun, 30 Jan 2000 20:16:43 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA94065
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 30 Jan 2000 20:16:25 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA07162
	for <linux@cthulhu.engr.sgi.com>; Sun, 30 Jan 2000 20:16:19 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-17.uni-koblenz.de (cacc-17.uni-koblenz.de [141.26.131.17])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id FAA16916;
	Mon, 31 Jan 2000 05:16:12 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407893AbQAaEPK>;
	Mon, 31 Jan 2000 05:15:10 +0100
Date:   Mon, 31 Jan 2000 05:15:10 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     "Kevin D. Kissell" <kevink@mips.com>,
        Ralf Baechle <ralf@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: WCHAN on R3000
Message-ID: <20000131051510.D11780@uni-koblenz.de>
References: <000801bf6b14$51b2e620$0ceca8c0@satanas.mips.com> <20000130120542.C1514@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20000130120542.C1514@paradigm.rfc822.org>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Jan 30, 2000 at 12:05:42PM +0100, Florian Lohoff wrote:

> (root@repeat)~# ps -V
> Unknown HZ value! (0) Assume 100.
> procps version 2.0.3
> (root@repeat)~#

Can you track down why this one happens?  It doesn't happen with the
stock Redhat procps thing which I'm using, whatever version that is.

  Ralf
