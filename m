Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g07JsAx22676
	for linux-mips-outgoing; Mon, 7 Jan 2002 11:54:10 -0800
Received: from river-bank.demon.co.uk (river-bank.demon.co.uk [193.237.18.135])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g07Js5g22643
	for <linux-mips@oss.sgi.com>; Mon, 7 Jan 2002 11:54:06 -0800
Received: from river-bank.demon.co.uk(ratty.river-bank.demon.co.uk[192.168.0.4]) (1654 bytes) by river-bank.demon.co.uk
	via smtpd with P:smtp/R:bind_hosts/T:inet_zone_bind_smtp
	(sender: <phil@river-bank.demon.co.uk>) 
	id <m16Neuw-000SfBC@river-bank.demon.co.uk>
	for <linux-mips@oss.sgi.com>; Mon, 7 Jan 2002 18:54:42 +0000 (GMT)
	(Smail-3.2.0.111 2000-Feb-17 #1 built 2001-Jan-12)
Message-ID: <3C39EE20.57513318@river-bank.demon.co.uk>
Date: Mon, 07 Jan 2002 18:51:12 +0000
From: Phil Thompson <phil@river-bank.demon.co.uk>
Organization: At Home
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: How to Handle PCI Bridge Buffers?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am working with some hardware that has a "feature" that I'd like some
advice on how to handle. The PCI bridge has a read-ahead buffer between
the PCI bus and system memory - used by PCI bus masters. The buffer can
only be invalidated from software.

An example of the problem it causes is an ethernet device is kicked off
to go through its ring buffers. The first one has a flag saying there is
no data, so it stops. The kernel then puts data in the buffer, toggles
the flag, and kicks off the ethernet device again. The old value of the
flag is still in the read-ahead buffer so the device stops again. The
fix is obviously to invalidate the read-ahead buffer before kicking off
the device. The question is, how to do this in a generic way?

I don't want to modify the driver for every PCI device that might be
used. The only other way seems to be to add the buffer invalidation code
to outb() etc. (and hope that no driver wants to use memory mapped
registers).

Is this "feature" common? Is there existing code I can look at?

Suggestions very welcome.

Thanks,
Phil
