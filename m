Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LKq8m04778
	for linux-mips-outgoing; Sat, 21 Jul 2001 13:52:08 -0700
Received: from colo.asti-usa.com (IDENT:root@colo.asti-usa.com [205.252.89.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LKq7V04775
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 13:52:07 -0700
Received: from lineo.com (raven.lineo.com [64.50.107.47])
	by colo.asti-usa.com (8.9.3/8.9.3) with ESMTP id RAA05483
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 17:00:51 -0400
Message-ID: <3B59FC0D.6CAD443C@lineo.com>
Date: Sat, 21 Jul 2001 23:02:53 +0100
From: Steve Papacharalambous <stevep@lineo.com>
Organization: Lineo Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: Interrupts in modules
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All,

Are there any limitations or precautions needed with interrupt handlers
in loadable modules?

The reason for asking is that I have an interrupt handler which works
fine when compiled into the kernel, but causes the kernel to crash when
it is a loadable module,

Thanks,

Steve
