Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8T1oXq26190
	for linux-mips-outgoing; Fri, 28 Sep 2001 18:50:33 -0700
Received: from idiom.com (espin@idiom.com [216.240.32.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8T1oUD26187
	for <linux-mips@oss.sgi.com>; Fri, 28 Sep 2001 18:50:30 -0700
Received: (from espin@localhost)
	by idiom.com (8.9.3/8.9.3) id SAA93451;
	Fri, 28 Sep 2001 18:50:29 -0700 (PDT)
Date: Fri, 28 Sep 2001 18:50:29 -0700
From: Geoffrey Espin <espin@idiom.com>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: link error with ramdisk file
Message-ID: <20010928185029.A89942@idiom.com>
References: <3BB5237F.9080203@esstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <3BB5237F.9080203@esstech.com>; from Gerald Champagne on Fri, Sep 28, 2001 at 08:27:27PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Gerald,

> I'm getting the following error when creating a ramdisk on a big endian system:
> $ mips-linux-ld -T ld.script -b binary -o ramdisk.o ramdisk.gz
> mips-linux-ld: ramdisk.gz: compiled for a little endian system and target is big 
> endian
> File in wrong format: failed to merge target specific data of file ramdisk.gz

I recently had this mini-nightmare, too.  I don't recall exactly
what I did to eliminate it.  I'm now using:

    linux/arch/mips/philips/nino/ld.script

and my home-built linker:            :-)

    % mipsel-linux-ld -v
    GNU ld version 2.11.90 (with BFD 2.11.90)

I can't recall whether it was a bad linker, or wrong script, or something else.

What linker and script are you using?

At one stage I used:

    EXTRA_LDFLAGS = --no-warn-mismatch

as a work-around.  But now I've successfully disabled this.

Geoff
-- 
Geoffrey Espin espin@idiom.com
