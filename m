Received:  by oss.sgi.com id <S305163AbQDQRFv>;
	Mon, 17 Apr 2000 10:05:51 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:10842 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQDQRFb>; Mon, 17 Apr 2000 10:05:31 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA03736; Mon, 17 Apr 2000 10:09:29 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA31141
	for linux-list;
	Mon, 17 Apr 2000 09:49:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA29060
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Apr 2000 09:49:45 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA06742
	for <linux@cthulhu.engr.sgi.com>; Mon, 17 Apr 2000 09:49:44 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C430F7D9; Mon, 17 Apr 2000 18:49:41 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 212D48FC4; Mon, 17 Apr 2000 18:42:27 +0200 (CEST)
Date:   Mon, 17 Apr 2000 18:42:27 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Wichert Akkerman <wichert@mors.wiggy.net>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: sys_chown vs. sys_lchown
Message-ID: <20000417184227.H5359@paradigm.rfc822.org>
References: <20000417131701.A4840@paradigm.rfc822.org> <20000417181225.A1832@mors.wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20000417181225.A1832@mors.wiggy.net>; from Wichert Akkerman on Mon, Apr 17, 2000 at 06:12:25PM +0200
Organization: rfc822 - pure communication
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Apr 17, 2000 at 06:12:25PM +0200, Wichert Akkerman wrote:
> Previously Florian Lohoff wrote:
> > I discovered a anomaly there when trying to compile current strace
> > which has sys_lchown which is sys_chown in current glibc and fails
> > to compile thereof.
> 
> strace got that from include/asm-mips/unistd.h from a 2.3.99pre5 kernel
> tree, which should be authoritive. Are you sure that your glibc is
> compiled correctly?

;) As this is made by Ralf Baechle the "Master himself" ill trust that :)

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-subject-2-change
"Technology is a constant battle between manufacturers producing bigger and
more idiot-proof systems and nature producing bigger and better idiots."
