Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Dec 2005 14:21:35 +0000 (GMT)
Received: from smtp107.biz.mail.re2.yahoo.com ([206.190.52.176]:15694 "HELO
	smtp107.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133528AbVL1OVR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Dec 2005 14:21:17 +0000
Received: (qmail 52647 invoked from network); 28 Dec 2005 14:22:57 -0000
Received: from unknown (HELO ?192.168.2.27?) (dan@embeddedalley.com@69.21.252.132 with plain)
  by smtp107.biz.mail.re2.yahoo.com with SMTP; 28 Dec 2005 14:22:57 -0000
In-Reply-To: <82e4189c0512272336xed0fe2ax9fee6119ea2d6b00@mail.gmail.com>
References: <82e4189c0512272336xed0fe2ax9fee6119ea2d6b00@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <06af7c9f9f82dd2b306e02997869e709@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: Fixed kernel entry point suggestion
Date:	Wed, 28 Dec 2005 09:22:55 -0500
To:	Adil Hafeez <adilhafeez80@gmail.com>
X-Mailer: Apple Mail (2.623)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Dec 28, 2005, at 2:36 AM, Adil Hafeez wrote:

> Everytime we add/remove a feature from kernel location of entry_point 
> symbol changes.

If you "wrap" the kernel image with a simple header and have a boot 
loader
that understands this, or even understands the ELF header, or download
S-records (yuk) as most systems do, I guess it isn't necessary to fix 
this.
I've been providing the compressed zImage patches for a long time that 
solves
this, as well as the u-boot uImage patches.  The process of building 
these
images not only locates the proper entry point, but it provides 
advantages
for embedded systems by creating smaller images and faster boot times.

>  .....   Adding a simply jump instruction to kernel_entry point in 
> head.S can solve this problem. Why dont we make this change permanent 
> in kernel.

:-)  It seems MIPS likes to be different from other architectures that 
have
solved these irritating little details years ago :-)  Submit a patch 
and see
what happens, as just complaining on the list isn't likely to make it
happen.

Thanks.

	-- Dan
