Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2M9eGa24881
	for linux-mips-outgoing; Thu, 22 Mar 2001 01:40:16 -0800
Received: from exchange1.cam.pace.co.uk (host-131-80.pace.co.uk [136.170.131.80])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2M9eEM24878
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 01:40:14 -0800
Received: by exchange1 with Internet Mail Service (5.5.2448.0)
	id <GNGHZVH9>; Thu, 22 Mar 2001 09:39:12 -0000
Message-ID: <1402C4C025C4D311B50D00508B8B74E281B152@exchange1>
From: Phil Thompson <Phil.Thompson@pace.co.uk>
To: "'Geert Uytterhoeven'" <Geert.Uytterhoeven@sonycom.com>
Cc: linux-mips@oss.sgi.com
Subject: RE: Recommended toolchain
Date: Thu, 22 Mar 2001 09:39:11 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Correct - I am using the standard 2.4.2 sources. I had (obviously
incorrectly) assumed that the standard sources would be up to date and not
"some months" out of date.

How are the differences in the two trees managed? At what point are the
latest non-MIPS changes applied to the MIPS tree? At what point are the MIPS
specific changes applied to the standard tree?

Thanks,
Phil

-----Original Message-----
From: Geert Uytterhoeven [mailto:Geert.Uytterhoeven@sonycom.com]
Sent: 22 March 2001 07:50
To: Phil Thompson
Cc: 'Erik Mullinix'; linux-mips@oss.sgi.com
Subject: RE: Recommended toolchain


On Wed, 21 Mar 2001, Phil Thompson wrote:
> I had to patch va-mips.h to #include <asm/sgidefs.h> rather than
> <sgidefs.h>.
> 
> The current errors are:
> 
> - warnings about struct flock64 not being declared (it's defined in
> asm-mips64/fcntl.h but not asm-mips/fcntl.h)
> 
> - compilation stops because loops_per_sec is undeclared as far as
> asm-mips/delay.h is concerned (although it seems fine in
> asm-mips64/delay.h).
> 
> This seems to imply that the mips architecture (as opposed to mips64)
isn't
> being maintained. Is this the case? Should I be using mips64 - but what
> would be the point on an embedded CPU?

You're definitely not using the Linux/MIPS CVS tree, since these things were
fixed there some months ago.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven ------------- Sony Software Development Center Europe
(SDCE)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat
55
Voice +32-2-7248626 Fax +32-2-7262686 ---------------- B-1130 Brussels,
Belgium
