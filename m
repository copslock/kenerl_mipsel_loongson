Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f32CKDp10846
	for linux-mips-outgoing; Mon, 2 Apr 2001 05:20:13 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f32CKDM10843
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 05:20:13 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA19901
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 05:20:15 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA03753
	for <linux-mips@oss.sgi.com>; Mon, 2 Apr 2001 05:20:14 -0700 (PDT)
Message-ID: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "MIPS/Linux List \(SGI\)" <linux-mips@oss.sgi.com>
Subject: Dumb Question on Cross-Development
Date: Mon, 2 Apr 2001 14:24:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've historically done all of my MIPS/Linux development
native, on Indies, P-5064's, Atlas, and Malta.  But now
that we seem to be in a situation where the latest, 
greatest, and most correct compilers are x86 cross-dev
only, I've cut over to building kernels on my Athlon box.
I'd like to start building apps and benchmarks (not 
necessarily from srpm's).  Plainly, I need a set of
libraries (naive attempts at cross-compilation of
user code with the egcs 1.1.2 compiler results in
complaints about the missing crt1.o), and possibly
some variant include files.  Are these packaged
somewhere, and is there an FAQ/HowTo on how
to set them up?  This may have been handled in 
Ralf's HowTo, but that seems to have disappeared
from the web.

            Regards,

            Kevin K.
