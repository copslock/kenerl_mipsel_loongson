Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OJG7Rw006004
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 12:16:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OJG7aX006003
	for linux-mips-outgoing; Wed, 24 Jul 2002 12:16:07 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sentinel.sanera.net (ns1.sanera.net [208.253.254.10])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OJG0Rw005993;
	Wed, 24 Jul 2002 12:16:00 -0700
Received: from icarus.sanera.net (icarus [192.168.254.11])
	by sentinel.sanera.net (8.11.2/8.11.2) with ESMTP id g6OJGv510192;
	Wed, 24 Jul 2002 12:16:57 -0700
Received: from exceed2.sanera.net (exceed2.sanera.net [172.16.2.39])
	by icarus.sanera.net (8.11.6/8.11.6) with SMTP id g6OJGpi30005;
	Wed, 24 Jul 2002 12:16:51 -0700
Message-Id: <200207241916.g6OJGpi30005@icarus.sanera.net>
Date: Wed, 24 Jul 2002 12:16:51 -0700 (PDT)
From: Krishna Kondaka <krishna@Sanera.net>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
Subject: Re: kernel BUG at slab.c:1073!
To: ralf@oss.sgi.com
Cc: jsun@mvista.com, linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: cTOGTkP5GpnSCXgiEXAwIA==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.2 SunOS 5.8 sun4u sparc 
X-Spam-Status: No, hits=0.5 required=5.0 tests=PLING version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I just checked my .config file and there is no CONFIG_PREEMPT.

Krishna

>Date: Wed, 24 Jul 2002 21:14:14 +0200
>From: Ralf Baechle <ralf@oss.sgi.com>
>To: Krishna Kondaka <krishna@Sanera.net>
>Cc: jsun@mvista.com, linux-mips@oss.sgi.com
>Subject: Re: kernel BUG at slab.c:1073!
>Mime-Version: 1.0
>Content-Disposition: inline
>User-Agent: Mutt/1.2.5.1i
>X-Accept-Language: de,en,fr
>
>On Wed, Jul 24, 2002 at 12:08:34PM -0700, Krishna Kondaka wrote:
>
>> I don't think I am running preemptible kernel. Is there /proc file that shows
>> if I am running preemptible kernel or not?
>
>If the kernel you're running is from Broadcom it doesn't contain the
>preemption patches.  Just check your kernel .config file for
>CONFIG_PREEMPT.
>
>  Ralf
