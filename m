Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Apr 2006 23:12:08 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:37000 "EHLO
	goldrake.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S8133463AbWDEWMA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Apr 2006 23:12:00 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by goldrake.enneenne.com with esmtp (Exim 4.50)
	id 1FRGMt-0004LU-G4; Thu, 06 Apr 2006 00:20:51 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1FRGPU-00052t-Fo; Thu, 06 Apr 2006 00:23:32 +0200
Date:	Thu, 6 Apr 2006 00:23:32 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	Linux MIPS <linux-mips@linux-mips.org>
Cc:	ppopov@mvista.com
Message-ID: <20060405222332.GO7029@enneenne.com>
References: <20060405154711.GL7029@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060405154711.GL7029@enneenne.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: Power management for au1000_eth.c
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on goldrake.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11041
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

On Wed, Apr 05, 2006 at 05:47:11PM +0200, Rodolfo Giometti wrote:
> Hello,
> 
> I'm trying to add power management support to au1000_eth.c driver.

Solved! :)

Here a patch to implement power management functions for au1000_eth.

Note that this patch needs my previous one who implements new power
management's sysfs interface.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
