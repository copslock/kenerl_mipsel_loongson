Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g62256nC023023
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 1 Jul 2002 19:05:06 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g62256aM023022
	for linux-mips-outgoing; Mon, 1 Jul 2002 19:05:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from potter.sfbay.redhat.com (IDENT:root@potter.sfbay.redhat.com [205.180.83.107])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g62250nC022995
	for <linux-mips@oss.sgi.com>; Mon, 1 Jul 2002 19:05:00 -0700
Received: from localhost.localdomain (remus.sfbay.redhat.com [172.16.27.252])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g622A1Q14168;
	Mon, 1 Jul 2002 19:10:02 -0700
Subject: Re: MIPS GOT overflow in gcc 3.2.
From: Eric Christopher <echristo@redhat.com>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-mips@oss.sgi.com, GNU C Library <libc-alpha@sources.redhat.com>,
   binutils@sources.redhat.com
In-Reply-To: <20020701184640.A2043@lucon.org>
References: <20020701184640.A2043@lucon.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 01 Jul 2002 19:07:11 -0700
Message-Id: <1025575632.30577.64.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> For gcc 3.1.1, I got
> 
>   [17] .got              PROGBITS        0068b8a0 64b8a0 00ff90 04 WAp  0   0
>   16
> 
> 0x00ff90 is very close to 64K. I thought it would only happen to KDE.

AFAIK it happens to mozilla as well.

Guh.

-eric

-- 
I will not carve gods
