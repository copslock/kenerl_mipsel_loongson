Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4TH4BnC023930
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 29 May 2002 10:04:11 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4TH4BND023929
	for linux-mips-outgoing; Wed, 29 May 2002 10:04:11 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4TH47nC023926
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 10:04:08 -0700
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.2/8.12.2/Debian -5) with ESMTP id g4TH5UtS019566
	for <linux-mips@oss.sgi.com>; Wed, 29 May 2002 19:05:30 +0200
Message-ID: <3CF50A5A.9020807@murphy.dk>
Date: Wed, 29 May 2002 19:05:30 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-mips <linux-mips@oss.sgi.com>
Subject: Re: ioremap?
References: <3CF4CA8C.9040802@murphy.dk> <009701c2072b$2b1e2820$4c00a8c0@prefect>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Bradley D. LaRonde wrote:

>Looks like those are for io (inb, outb, etc.) not mem (readb, writeb, etc.).
>io addresses shouldn't be ioremapped.
>
O.K.  I have now used set_io_port_base to set the base address to KSEG1.
What should be ioremapped then?

/Brian
