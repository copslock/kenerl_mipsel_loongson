Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9VCIiD11604
	for linux-mips-outgoing; Wed, 31 Oct 2001 04:18:44 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9VCIZ011599
	for <linux-mips@oss.sgi.com>; Wed, 31 Oct 2001 04:18:35 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id NAA12094;
	Wed, 31 Oct 2001 13:16:51 +0100 (MET)
Date: Wed, 31 Oct 2001 13:16:50 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Airlie <airlied@csn.ul.ie>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com,
   linux-vax@mithra.physics.montana.edu
Subject: Re: [LV] FYI: Mopd ELF support
In-Reply-To: <Pine.LNX.4.32.0110302144340.14320-100000@skynet>
Message-ID: <Pine.GSO.3.96.1011031131020.10781C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 30 Oct 2001, Dave Airlie wrote:

> Okay it didn't go so well.. my VAX couldn't boot the file I normally use
> with this mopd (I had to rebuild it for a static libelf)...
> 
> I've put a tgz up at
> 
> http://www.skynet.ie/~airlied/vax/mopd_on_the_vax.tgz
> 
> it contains the file I was trying to boot and the tcpdumps of this mopd
> and the one I normally use ...

 Thanks for the report.  This is what mopchk says about the image:

Checking: vmlinux.SYS
RSX Image
Header Block Count: 0
Image Size:         00000000
Load Address:       00000000
Transfer Address:   00000000

No wonder it cannot be booted -- the header states the file's size is
zero.

> if you need any more info give me a shout ..

 That's enough, thanks.  It seems I was a bit too optimistic in the
assumption a traditional MOP image header contains a correct image size --
I'll implement a fallback to the file's size if the header contains null
size.

 Since I'll be away till Tuesday, expect an update in the middle of the
next week.  I'm assuming ELF loading works, right?

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
