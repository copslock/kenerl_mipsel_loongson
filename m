Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8QLumd32032
	for linux-mips-outgoing; Wed, 26 Sep 2001 14:56:48 -0700
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8QLujD32029
	for <linux-mips@oss.sgi.com>; Wed, 26 Sep 2001 14:56:46 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id OAA35443;
	Wed, 26 Sep 2001 14:56:23 -0700 (PDT)
Date: Wed, 26 Sep 2001 14:56:23 -0700
From: Geoffrey Espin <espin@idiom.com>
To: Jun Sun <jsun@mvista.com>
Cc: Marc Karasek <marc_karasek@ivivity.com>,
   "'Karsten Merker'" <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: busybox does not like 2.4.8, or the other way around?
Message-ID: <20010926145623.A15305@idiom.com>
References: <25369470B6F0D41194820002B328BDD2195AA2@ATLOPS> <3BB20FA9.79D167BA@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <3BB20FA9.79D167BA@mvista.com>; from Jun Sun on Wed, Sep 26, 2001 at 10:26:01AM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Jun,

> I'd appreciate if someone has already updated my little busybox ramdisk at
> http://linux.junsun.net and send me a copy ...

I couldn't get yours to work either.

I've put my ramdisk.o (ext2 fs) (you know where it goes :-)) with
busybox 60.1 tested on 2.4.9+SF on Markham/Korva:

    http://www.idiom.com/~espin/linux

I'll put my whole userland & ramdisk build scheme up soon...
mostly "souped up" VRLinux scheme with Lineo stuff.

Made with my own "gcc version 3.0 20010422 (prerelease)" as
ftp.mvista.com still down, eh.

BTW, your nec_candy.c driver didn't work for me (MII/PHY probs?)...
my old 2.4.0 candy.c version works.  Also, put up for you
consideration are small korva/{prom.c,setup.c} tweaks.

Geoff
-- 
Geoffrey Espin espin@idiom.com
