Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3IFscb04181
	for linux-mips-outgoing; Wed, 18 Apr 2001 08:54:38 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3IFsbM04178
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 08:54:37 -0700
Received: from cotw.com (ptecdev3.inter.net [192.168.10.5])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id KAA01069;
	Wed, 18 Apr 2001 10:54:13 -0500
Message-ID: <3ADDC747.FC1DB391@cotw.com>
Date: Wed, 18 Apr 2001 09:56:40 -0700
From: Scott A McConnell <samcconn@cotw.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
CC: linux-mips@oss.sgi.com
Subject: Re: kernel/printk.c problem
References: <Pine.GSO.4.10.10104180852450.17832-100000@escobaria.sonytel.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Geert Uytterhoeven wrote:

> Current policy is not explicitly initializing variables to zero. If this causes
> problems, there's a bug in the routine that clears the BSS on kernel entry.

What a man! You can debug my code from 6000 + miles away without even seeing it
;-)
