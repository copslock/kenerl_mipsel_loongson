Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HGMinC025295
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 09:22:44 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HGMi6x025294
	for linux-mips-outgoing; Mon, 17 Jun 2002 09:22:44 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from localhost.localdomain (ip68-6-25-170.hu.sd.cox.net [68.6.25.170])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HGMfnC025291
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 09:22:41 -0700
Received: (from justin@localhost)
	by localhost.localdomain (8.11.6/8.11.6) id g5HGOxT01910;
	Mon, 17 Jun 2002 09:24:59 -0700
X-Authentication-Warning: localhost.localdomain: justin set sender to justin@cs.cmu.edu using -f
Subject: Re: __access_ok
From: Justin Carlson <justin@cs.cmu.edu>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3D0DCDCB.252F5565@mips.com>
References: <3D0DCDCB.252F5565@mips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 17 Jun 2002 09:24:58 -0700
Message-Id: <1024331098.1463.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 2002-06-17 at 04:53, Carsten Langgaard wrote:

>   * Address valid if:
> - *  - "addr" doesn't have any high-bits set
> - *  - AND "size" doesn't have any high-bits set
> - *  - AND "addr+size" doesn't have any high-bits set
> - *  - OR we are in kernel mode.
> + *  - In user mode and "addr" and "addr+size" in USEG (or XUSEG).
> + *  - OR we are in kernel mode and "addr" and "addr+size" isn't in the
> + *    area between USEG (XUSEG) and KSEG0.

You also need to test for high bit set in size.  Otherwise, for example,
if a process was ok to access range 0x40000000-0x40003fff, 
access_ok(0x40001000, 0xfffff100) would return 1.  The addition will
wrap around, leading to all sorts of fun havoc.

-Justin
