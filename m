Received:  by oss.sgi.com id <S42310AbQFTL0z>;
	Tue, 20 Jun 2000 04:26:55 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:41290 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42229AbQFTL0g>; Tue, 20 Jun 2000 04:26:36 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id EAA02844
	for <linux-mips@oss.sgi.com>; Tue, 20 Jun 2000 04:31:46 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: from calypso.engr.sgi.com (calypso.engr.sgi.com [163.154.5.113])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA11544
	for <linux-mips@oss.sgi.com>;
	Tue, 20 Jun 2000 04:26:08 -0700 (PDT)
	mail_from (ulfc@calypso.engr.sgi.com)
Received: by calypso.engr.sgi.com (Postfix, from userid 37984)
	id 15253A7875; Tue, 20 Jun 2000 04:25:25 -0700 (PDT)
From:   Ulf Carlsson <ulfc@calypso.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14671.21669.3126.181895@calypso.engr.sgi.com>
Date:   Tue, 20 Jun 2000 04:25:25 -0700 (PDT)
To:     linux-mips@oss.sgi.com
Subject: MIPS symbol versioning patches
X-Mailer: VM 6.75 under Emacs 20.5.1
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi Guys,

I have synced the binutils CVS with symbol versioning patches.  The
current CVS tree at http://sourceware.cygnus.com/binutils should work
now.  I have only tested compile and tests from glibc 2.1.90 so things
will probably break badly.  I will be away from my office the next
five days, and I will unfortunately not have any machine to work on.

I have verified with glibc CVS from today, glibc 2.96 CVS from today
and binutils CVS from today.

Ulf
