Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBLH4rw10954
	for linux-mips-outgoing; Fri, 21 Dec 2001 09:04:53 -0800
Received: from the-village.bc.nu (lightning.swansea.linux.org.uk [194.168.151.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBLH4oX10951
	for <linux-mips@oss.sgi.com>; Fri, 21 Dec 2001 09:04:50 -0800
Received: from alan by the-village.bc.nu with local (Exim 3.22 #1)
	id 16HSHp-0000ay-00; Fri, 21 Dec 2001 16:12:41 +0000
Subject: Re: ISA
To: Geert.Uytterhoeven@sonycom.com (Geert Uytterhoeven)
Date: Fri, 21 Dec 2001 16:12:40 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
   macro@ds2.pg.gda.pl (Maciej W. Rozycki), jsun@mvista.com (Jun Sun),
   jim@jtan.com, linux-mips@oss.sgi.com (Linux/MIPS Development)
In-Reply-To: <Pine.GSO.4.21.0112191456410.28777-100000@vervain.sonytel.be> from "Geert Uytterhoeven" at Dec 19, 2001 03:06:32 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HSHp-0000ay-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> But what about request_mem_region() and friends? How can I distinguish between
> ISA memory and the first 16 MB of RAM (or ROM, or whatever my board has there)?
> 
> Or am I not supposed to let those things show up in /proc/iomem?

Interesting - I'd not considered that. Is ISA and non ISA space seperate on
MIPS or is it all rather ambiguous ?
