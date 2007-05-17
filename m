Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 May 2007 16:16:59 +0100 (BST)
Received: from sorrow.cyrius.com ([65.19.161.204]:38160 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S20023474AbXEQPQ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 17 May 2007 16:16:57 +0100
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 0B824D8E1; Thu, 17 May 2007 15:16:50 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 1BDED543E0; Thu, 17 May 2007 17:16:37 +0200 (CEST)
Date:	Thu, 17 May 2007 17:16:37 +0200
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Subject: SGI O2 meth: missing sysfs device symlink
Message-ID: <20070517151636.GJ3586@deprecation.cyrius.com>
References: <1178743456.15447.41.camel@scarafaggio> <20070516151939.GH19816@deprecation.cyrius.com> <20070516160313.GA3409@bongo.bofh.it> <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50621.192.168.2.50.1179383217.squirrel@eppesuigoccas.homedns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

Apparently udev fails to rename the SGI O2 interface because it
doesn't have a sysfs device symlink.  Does someone here know how to
fix this?

* Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org> [2007-05-17 08:26]:
> [...]
> > Interfaces must have a device symlink (in /sys/class/net/$IFACE/, which
> > some broken drivers lack) and unique MAC addresses.
> 
> Hi Marco,
> this "device" link is missing for this driver. So probably this is a
> kernel bug.
> 
> giuseppe@sgi:~$ ls -ld /sys/class/net/*{,/device}
> drwxr-xr-x 3 root root 0 2007-05-17 08:22 /sys/class/net/eth0
> drwxr-xr-x 3 root root 0 2007-05-17 08:22 /sys/class/net/eth100
> lrwxrwxrwx 1 root root 0 2007-05-17 08:22 /sys/class/net/eth100/device ->
> ../../../devices/pci0000:00/0000:00:03.0
> drwxr-xr-x 3 root root 0 2007-05-12 23:35 /sys/class/net/lo
> drwxr-xr-x 3 root root 0 2007-05-12 15:10 /sys/class/net/ppp0
> drwxr-xr-x 3 root root 0 2007-05-12 21:35 /sys/class/net/sit0
> 
> Thanks,
> Giuseppe

-- 
Martin Michlmayr
http://www.cyrius.com/
