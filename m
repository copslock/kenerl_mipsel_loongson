Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f39CaMZ04711
	for linux-mips-outgoing; Mon, 9 Apr 2001 05:36:22 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f39CaLM04708
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 05:36:21 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id HAA16606
	for <linux-mips@oss.sgi.com>; Mon, 9 Apr 2001 07:36:15 -0500
Message-ID: <3AD1BB55.224407E1@cotw.com>
Date: Mon, 09 Apr 2001 06:38:29 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: mips_memory_upper
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Used to be defined in ./arch/mips/kernel/setup.c

It is no longer defined. I also noticed that badget is now using
vac_memory_upper.

Can anyone fill me in on the details.

Thanks,
Scott
