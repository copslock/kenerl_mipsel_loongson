Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9J1DRd10693
	for linux-mips-outgoing; Thu, 18 Oct 2001 18:13:27 -0700
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9J1DPD10689
	for <linux-mips@oss.sgi.com>; Thu, 18 Oct 2001 18:13:25 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id SAA64191;
	Thu, 18 Oct 2001 18:13:22 -0700 (PDT)
Date: Thu, 18 Oct 2001 18:13:22 -0700
From: Geoffrey Espin <espin@idiom.com>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Moving kernel_entry to LOADADDR
Message-ID: <20011018181322.B56244@idiom.com>
References: <3BCF7AD2.2000000@esstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <3BCF7AD2.2000000@esstech.com>; from Gerald Champagne on Thu, Oct 18, 2001 at 07:58:58PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Gerald,

> to hard-code a jump to kernel_entry in my boot loader.  I got tired
> of having kernel_entry moving around, so I just moved it to the top
> of head.S, just afte the ".fill 0x280".  That places kernel_entry at
> the same place every time.  It's always at LOADADDR+0x280.

Don't know about all .fill & exception vecs... the trick I use in
my (vr)boot loader...

KERNEL_ENTRY=$(shell awk '/kernel_entry/{print "0x" $$1}' $(LINUX_SRC)/System.map)
CFLAGS+=-DKERNEL_ENTRY=$(KERNEL_ENTRY)

And compile boot.S or whatever your bootloader is.

But a fixed, well-known offset can't be a bad thing either.

Geoff
-- 
Geoffrey Espin espin@idiom.com
