Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2TIMeD08271
	for linux-mips-outgoing; Thu, 29 Mar 2001 10:22:40 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2TIMAM08253
	for <linux-mips@oss.sgi.com>; Thu, 29 Mar 2001 10:22:11 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id UAA16956;
	Thu, 29 Mar 2001 20:10:16 +0200 (MET DST)
Date: Thu, 29 Mar 2001 20:10:15 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: vhouten@kpn.com
cc: linux-mips@oss.sgi.com
Subject: Re: Recommended toolchain
In-Reply-To: <200103291739.TAA01695@sparta.research.kpn.com>
Message-ID: <Pine.GSO.3.96.1010329195202.16049B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 29 Mar 2001, Karel van Houten wrote:

> Oh, and the resulting (ELF) kernel doesn't boot at all:
> >>boot 3/rz0 1/new
> delo V0.7 Copyright 2000 Florian Lohoff <flo@rfc822.org>
> Loading /etc/delo.conf .. ok
> Loading /boot/vmlinux.new ....... ok
> 
> KN05 V2.1k    (PC: 0xa002cab8, SP: 0x8043fef0)
> >>                            

 Well, this might be related to R4k you are using.  I have been able to
run kernels up to 2.4.0-test12 fine on my /240.  I tried the final 2.4.0
(or was it 2.4.1? -- I don't rememeber) on my machine and it booted but it
was very unstable -- I got a shell prompt but any moderate fs activity
killed it immediately.

 As it was the time I was building binutils 2.10.91 package I checked if
the version of binutils matters.  It didn't.  The 2.4.0-test12 version was
stable and the other one was not regardless of the binutils version used. 

 So I guess there may be something wrong with the R4k code generation in
gcc 2.95.2(3) (or possibly binutils, but the latter is quite unlikely).  I
can't run-time test R4k code but I may see if I can review the generated
binary of startup code up to the first line output for any
inconsistencies.  Don't hold your breath, though... 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
