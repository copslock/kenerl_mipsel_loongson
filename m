Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 23:11:57 +0000 (GMT)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:4533 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20037471AbXA2XLx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jan 2007 23:11:53 +0000
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1HBfaz-0000ma-Es; Tue, 30 Jan 2007 00:07:32 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>)
	id 1HBfbQ-0002IS-Dr; Tue, 30 Jan 2007 00:07:56 +0100
Date:	Tue, 30 Jan 2007 00:07:56 +0100
From:	Rodolfo Giometti <giometti@enneenne.com>
To:	linux-kernel@vger.kernel.org
Cc:	linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org
Message-ID: <20070129230755.GA8705@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Advice on APM-EMU reunion
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@enneenne.com
Precedence: bulk
X-list: linux-mips

Hello,

some months ago I sent to the MIPS and ARM mail lists a patch to unify
the several APM emulation codes adding a new dedicated directory so it
can be used to put there the per board specific code avoiding code
duplications (see files ./arch/arm/kernel/apm.c,
./arch/mips/kernel/apm.c and ./arch/sh/kernel/apm.c that are almost
the same).

The patch is here
"http://www.linux-mips.org/archives/linux-mips/2006-07/msg00144.html"
and it has been lost in the deep space...

The target is to remove the files ./arch/{arm,mips,sh}/kernel/apm.c
and to add files drivers/apm-emu/{Kconfig,Makefile,apm-emu.c}.

Now I try on this list in order to have some advice if this could be a
good idea and what about if I add a new class "apm_emu" on the sysfs
support with proper registrations functions.

Thanks in advance,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
