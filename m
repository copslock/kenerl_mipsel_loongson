Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 19:24:18 +0100 (BST)
Received: from wx-out-0506.google.com ([66.249.82.227]:19856 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20039092AbWI1SYQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 19:24:16 +0100
Received: by wx-out-0506.google.com with SMTP id h30so705078wxd
        for <linux-mips@linux-mips.org>; Thu, 28 Sep 2006 11:24:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=b63PVEE4ICLGWsjm06zar4XISId54gP4/H4hv+K7VnKi2QWRX+IitSoNcmZAITaOk25ERSFnPMVzayjh2wRmNpJ0IC/jwa3NgX+FnkZye4Oyq6T4wmkCqMuq40ADKVvKaqOrohFXxLa6DsiUoIcRGAzNgS14K9L/h5GybhtlWH0=
Received: by 10.70.31.18 with SMTP id e18mr759044wxe;
        Thu, 28 Sep 2006 11:24:15 -0700 (PDT)
Received: from ?10.0.1.104? ( [71.243.124.123])
        by mx.gmail.com with ESMTP id i17sm2642763wxd.2006.09.28.11.24.13;
        Thu, 28 Sep 2006 11:24:14 -0700 (PDT)
Message-ID: <451C134C.6010806@gmail.com>
Date:	Thu, 28 Sep 2006 14:24:12 -0400
From:	Peter Watkins <treestem@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050831)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: SGI Origin 200 (ip27) with DEBUG_SPINLOCK
Content-Type: multipart/mixed;
 boundary="------------040906080002030504050605"
Return-Path: <treestem@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: treestem@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------040906080002030504050605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Greetings SGI Origin wizards,

I'm doing some SMP testing on an SGI Origin 200 (ip27).

I started with a 2.6.15 vintage kernel and added changes from here:
ftp://ftp.linux-mips.org/pub/linux/mips/people/ralf/ip27/

It boots both processors and runs OK.

Then I turn on CONFIG_DEBUG_SPINLOCK and CONFIG_DEBUG_SPINLOCK_SLEEP, 
and get lots of lockup messages. A typical one is below.

Anyone seen this? Some of the low-level lock code has R10000_LLSC_WAR 
versions, but I don't see anything wrong there.





--------------040906080002030504050605
Content-Type: text/plain;
 name="SGI-LOCKDEBUG.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="SGI-LOCKDEBUG.txt"


Sep 26 16:08:15 localhost BUG: spinlock lockup on CPU#0, sshd/1876, a8000000003c7868
Sep 26 16:08:15 localhost loops-per-jiffy 110592 hz 1000
Sep 26 16:08:15 localhost owner ffffffffffffffff cpu -1 locked 0
Sep 26 16:08:15 localhost Call Trace:
Sep 26 16:08:15 localhost [<a8000000001e5da0>] _raw_spin_lock+0x220/0x2c8
Sep 26 16:08:15 localhost [<a80000000032c63c>] _spin_lock_irqsave+0x24/0x38
Sep 26 16:08:15 localhost [<a8000000001f4d60>] tty_ldisc_try+0x38/0x80
Sep 26 16:08:15 localhost [<a8000000001f634c>] tty_ldisc_ref_wait+0x1c/0x100
Sep 26 16:08:15 localhost [<a80000000032c63c>] _spin_lock_irqsave+0x24/0x38
Sep 26 16:08:15 localhost [<a8000000001f64b8>] tty_poll+0x88/0xd8
Sep 26 16:08:15 localhost [<a8000000000df9d0>] do_select+0x298/0x4c0
Sep 26 16:08:15 localhost [<a8000000000dfbf8>] __pollwait+0x0/0x118
Sep 26 16:08:15 localhost [<a8000000000de9d8>] vfs_ioctl+0x80/0x400
Sep 26 16:08:15 localhost [<a800000000100e48>] compat_sys_select+0x318/0x710
Sep 26 16:08:15 localhost [<a8000000000396b4>] handle_sysn32+0x54/0xa4
Sep 26 16:08:15 localhost




--------------040906080002030504050605--
