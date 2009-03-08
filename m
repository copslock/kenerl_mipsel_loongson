Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Mar 2009 08:54:24 +0000 (GMT)
Received: from fnoeppeil36.netpark.at ([217.175.205.164]:64671 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S21102887AbZCHIyV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 8 Mar 2009 08:54:21 +0000
Received: (qmail 27732 invoked from network); 8 Mar 2009 09:54:20 +0100
Received: from scarran.roarinelk.net (192.168.0.242)
  by fnoeppeil36.netpark.at with SMTP; 8 Mar 2009 09:54:20 +0100
Date:	Sun, 8 Mar 2009 09:54:20 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Manuel Lauss <mano@roarinelk.homelinux.net>
Cc:	Kevin Hickey <khickey@rmicorp.com>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 08/10] Alchemy: DB1300 blink leds on timer tick
Message-ID: <20090308095420.220ebd3f@scarran.roarinelk.net>
In-Reply-To: <20090308093731.1e7a9067@scarran.roarinelk.net>
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
	<1236452697.9848.1.camel@kh-d820>
	<20090308093731.1e7a9067@scarran.roarinelk.net>
Organization: Private
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

> board_timer_set callback to blink some leds. (Note, I still don't feel
> this is "right", but ultimately it's not up you anyway).

should read "but ultimately it's up to you anyway"
