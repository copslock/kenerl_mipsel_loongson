Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 14:33:28 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:12215 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20042340AbWHINbp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 14:31:45 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GAnAU-0000Af-DJ
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 14:28:14 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GAoAq-0002i1-T7
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 15:32:40 +0200
Date:	Wed, 9 Aug 2006 15:32:40 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060809133240.GA9690@enneenne.com>
References: <20060809102950.GA2531@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060809102950.GA2531@enneenne.com>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: au1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12247
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips

On Wed, Aug 09, 2006 at 12:29:50PM +0200, Rodolfo Giometti wrote:
> 
>    mmc0: starting CMD2 arg 00000000 flags 00000067
>    mmc0: req done (CMD2): 0/0/0: 1d41444d 494e4953 10310001 9a005500

Ok. This the CID number.

>    mmc0: starting CMD3 arg 00000000 flags 00000065
>    mmc0: req done (CMD3): 0/0/0: 019a0055 00000000 00000000 00000000

And this is the RCA.

>    mmc0: host does not support reading read-only switch. assuming write-enable.
>    mmc0: starting CMD2 arg 00000000 flags 00000067
>    mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
>    mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
>    mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
>    mmc0: req done (CMD2): 1/0/0: 00000000 00000000 00000000 00000000
>    mmc0: clock 450000Hz busmode 2 powermode 2 cs 0 Vdd 15 width 0
>    mmc0: starting CMD9 arg 019a0000 flags 00000007
>    mmc0: req done (CMD9): 1/0/0: 00000000 00000000 00000000 00000000
>    mmc0: req done (CMD9): 1/0/0: 00000000 00000000 00000000 00000000
>    mmc0: req done (CMD9): 1/0/0: 00000000 00000000 00000000 00000000
>    mmc0: req done (CMD9): 1/0/0: 00000000 00000000 00000000 00000000

Here is the problem! I get no answer to CMD9 (CSD request) due a
timeout (sd0_status=0x3028080).

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
