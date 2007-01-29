Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2007 00:02:12 +0000 (GMT)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:11959 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20037530AbXA3ACI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Jan 2007 00:02:08 +0000
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1HBgOQ-00011i-Dj; Tue, 30 Jan 2007 00:58:37 +0100
Received: from giometti by zaigor.enneenne.com with local (Exim 4.63)
	(envelope-from <giometti@enneenne.com>)
	id 1HBgOs-0002Ll-DP; Tue, 30 Jan 2007 00:59:02 +0100
Date:	Tue, 30 Jan 2007 00:59:02 +0100
From:	Rodolfo Giometti <giometti@enneenne.com>
To:	Richard Purdie <rpurdie@rpsys.net>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-arm-kernel@lists.arm.linux.org.uk
Message-ID: <20070129235902.GB8882@enneenne.com>
References: <20070129230755.GA8705@enneenne.com> <1170114826.5833.139.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1170114826.5833.139.camel@localhost.localdomain>
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: Re: Advice on APM-EMU reunion
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@enneenne.com
Precedence: bulk
X-list: linux-mips

On Mon, Jan 29, 2007 at 11:53:46PM +0000, Richard Purdie wrote:

> I'm not sure this is a good idea. As you're creating a new interface,
> why not create something new/improved without the problems that
> confining yourself to APM emulation brings?

Because several applications (and expecially in embedded systems) use
that interface. However adding a sysfs support I try to define a new
(and most versatile) interface.

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
