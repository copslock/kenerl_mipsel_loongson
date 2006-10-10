Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Oct 2006 00:52:39 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:28605 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20037436AbWJJXwh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 11 Oct 2006 00:52:37 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GXQOs-0000U9-CS; Wed, 11 Oct 2006 00:48:41 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>)
	id 1GXROi-00082v-NE; Wed, 11 Oct 2006 01:52:32 +0200
Date:	Wed, 11 Oct 2006 01:52:32 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	linux-mips@linux-mips.org
Message-ID: <20061010235232.GA25397@enneenne.com>
References: <20061010182747.GA14539@enneenne.com> <452BFC8D.8080903@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452BFC8D.8080903@ru.mvista.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: Problem on au1100 USB device support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12892
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

On Wed, Oct 11, 2006 at 12:03:25AM +0400, Sergei Shtylyov wrote:
> 
>    What tree are you testing against? Asking because with the recent 
>    deletion of the "old" driver (arch/mips/au1000/common/usbdev.c), the setup 
> code fiddling with SYS_PINFUNC and SYS_CLKSRC regs is gone...

Linux 2.6.18-rc1

>    Well, errata says you must use DMA for endpoint 0 on Au1100 revs before 
>    BE -- otherwise you'll be asking for trouble.

I enabled DMA for endpoint 0 but I still see no activities on the
bus... I'm quite sure I misconfigured the controller.

Any suggestions?

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
