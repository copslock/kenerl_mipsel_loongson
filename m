Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3PHmG110383
	for linux-mips-outgoing; Wed, 25 Apr 2001 10:48:16 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3PHmFM10380
	for <linux-mips@oss.sgi.com>; Wed, 25 Apr 2001 10:48:15 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id MAA13506;
	Wed, 25 Apr 2001 12:47:49 -0500
Message-ID: <3AE72A90.6CDEFAFE@cotw.com>
Date: Wed, 25 Apr 2001 12:50:40 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@mvista.com>
CC: Wayne Gowcher <wgowcher@yahoo.com>, linux-mips@oss.sgi.com
Subject: Re: serial console, have linefeed but no command prompt
References: <20010425150258.11719.qmail@web11901.mail.yahoo.com> <3AE70886.AEEC48D3@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Pete Popov wrote:

> Wayne Gowcher wrote:
>
> What does your /etc/inittab look like?

Wayne,

As Pete was wondering most likely you are missing a line in your inittab

# Run gettys in standard runlevels
t0:123:respawn:/sbin/getty ttyS0 DT115200          <------------
1:2345:respawn:/sbin/getty tty1
2:2345:respawn:/sbin/getty tty2
3:2345:respawn:/sbin/getty tty3
4:2345:respawn:/sbin/getty tty4
5:2345:respawn:/sbin/getty tty5
6:2345:respawn:/sbin/getty tty6
