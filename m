Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f73LGCc26977
	for linux-mips-outgoing; Fri, 3 Aug 2001 14:16:12 -0700
Received: from myth1.Stanford.EDU (myth1.Stanford.EDU [171.64.15.14])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f73LGCV26974
	for <linux-mips@oss.sgi.com>; Fri, 3 Aug 2001 14:16:12 -0700
Received: (from johnd@localhost)
	by myth1.Stanford.EDU (8.11.1/8.11.1) id f73LFsG02037;
	Fri, 3 Aug 2001 14:15:54 -0700 (PDT)
Date: Fri, 3 Aug 2001 14:15:54 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>
Subject: printk
Message-ID: <Pine.GSO.4.31.0108031412450.675-100000@myth1.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Does anyone know off hand, the earlies point that I can use printk?  I
added some printk statements to driver/char/console.c and the resulting
kernel hangs with only the logo showing and no text.  Is prom_printf
something that I should use instead. I put some printk statements in
tty_io.c and kernel/printk.c and those compiled kernels work.

thanks,
john davis
