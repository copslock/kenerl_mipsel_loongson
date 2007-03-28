Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Mar 2007 21:55:43 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42195 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023157AbXC1Uzl (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Mar 2007 21:55:41 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l2SKtSZ1013565;
	Wed, 28 Mar 2007 21:55:28 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l2SKtPZO013564;
	Wed, 28 Mar 2007 21:55:25 +0100
Date:	Wed, 28 Mar 2007 21:55:25 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Attila Kinali <attila@kinali.ch>
Cc:	linux-mips@linux-mips.org
Subject: Re: Power loss and system time when not having a battery backed RTC
Message-ID: <20070328205524.GC12955@linux-mips.org>
References: <20070328163914.b7187fcb.attila@kinali.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070328163914.b7187fcb.attila@kinali.ch>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 28, 2007 at 04:39:14PM +0200, Attila Kinali wrote:

> Now, this system does not contain a battery backed RTC
> (not enough space) and thus does not know what date/time
> it is after boot. At a later time the device will
> be able to get a time quote from a time server using
> a wireless connection. But as the wireless connection
> is triggered by a user action, it can happen hours after
> boot. This means that there is a quite long period whithin
> which the device does not know what time it is and hence
> assumes it's 1970.
> 
> My problem lies now in the back jumps that the device
> makes, when unplugged and replugged. On the filesystem
> there will be files from 2007, while the system still
> thinks it's 1970.
> 
> How do you handle this issue with the back jumps, if you
> cannot stick in a batter backed RTC?

Forward jumps are usually much less of a problem.  Since your fs is based
on flash you will probably want to avoid writing timestamps all the time
but maybe a quick fs scan for the file with the latest date might provide
a reasonable value for the startup time.  At this time you know the actual
time should be newer than this date, so time will only jump forward.

Some standard also defines that time must increase strictly monotonically,
that is of two subsequent calls the second must return the higher time.
So my suggestion would also avoid triggering bugs in code that relies on
this sort of behaviour.

  Ralf
