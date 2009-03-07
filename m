Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 Mar 2009 19:05:07 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:33036 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21366784AbZCGTFF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 7 Mar 2009 19:05:05 +0000
Received: from 10.8.0.23 ([10.8.0.23]) by hq-ex-mb01.razamicroelectronics.com ([10.1.1.40]) via Exchange Front-End Server webmail.razamicroelectronics.com ([10.1.1.41]) with Microsoft Exchange Server HTTP-DAV ;
 Sat,  7 Mar 2009 19:04:57 +0000
Received: from kh-d820 by webmail.razamicroelectronics.com; 07 Mar 2009 13:04:58 -0600
Subject: Re: [PATCH 08/10] Alchemy: DB1300 blink leds on timer tick
From:	Kevin Hickey <khickey@rmicorp.com>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	ralf@linux-mips.org, linux-mips@linux-mips.org
In-Reply-To: <20090307103731.4660e57f@scarran.roarinelk.net>
References: <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
	 <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
	 <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
	 <7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
	 <0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
	 <394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
	 <7e632686ab9b29a94eefeb2e5dca8b091a956b95.1236354153.git.khickey@rmicorp.com>
	 <df58b8408730cf0eee532a93f0b6234ac709663c.1236354153.git.khickey@rmicorp.com>
	 <be27dee4c591cdb1ea1b9517bee2b825657024f5.1236354153.git.khickey@rmicorp.com>
	 <20090307103731.4660e57f@scarran.roarinelk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Sat, 07 Mar 2009 13:04:57 -0600
Message-Id: <1236452697.9848.1.camel@kh-d820>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.3.1 
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

On Sat, 2009-03-07 at 10:37 +0100, Manuel Lauss wrote:
> On Fri,  6 Mar 2009 10:20:07 -0600
> Kevin Hickey <khickey@rmicorp.com> wrote:
> 
> > Blinks the dots on the hex display on the DB1300 board every 1000 timer ticks.
> > This can help tell the difference between a soft and hard hung board.

> Please don't do that.  I'd still like to get all devboard hackery out
> of code in common/ (at least for mainline kernels; what you do to the
> RMI-sources I don't care about).

Can you suggest an alternative?  Or are you saying that this
functionality does not belong in the mainline kernel at all?

-- 
Kevin Hickey
Alchemy Solutions
RMI Corporation
khickey@rmicorp.com
P:  512.691.8044
