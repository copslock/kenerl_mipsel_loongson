Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DNInq23299
	for linux-mips-outgoing; Mon, 13 Aug 2001 16:18:49 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DNImj23296
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 16:18:48 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f7DNIbTc026617;
	Mon, 13 Aug 2001 16:18:37 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f7DNIbeZ026613;
	Mon, 13 Aug 2001 16:18:37 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Mon, 13 Aug 2001 16:18:36 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "John D. Davis" <johnd@Stanford.EDU>
cc: Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Re: Tracing the Console
In-Reply-To: <Pine.GSO.4.31.0108131556230.21357-100000@myth1.Stanford.EDU>
Message-ID: <Pine.LNX.4.10.10108131616110.29602-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I am currently trying to trace the console on and R4400 Indy. It seems
> that everything goes through console.c using either con_write or
> con_put_char. It would be great if I could communicate with someone that
> has a thorough understanding of this code and its interaction with
> newport_con.c.  

Okay. I could explain this code if you want.

> I have put some prtink statements in and it seems that
> newport_putcs is called several more times than it should. 

Don't do that. Printk calls newport_putcs so if you have printk in
newport_putcs it will going into a endless loop. You could redirect the
console to a different tty device, say a serial console. 
