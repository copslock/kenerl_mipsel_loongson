Received:  by oss.sgi.com id <S42289AbQGTC3i>;
	Wed, 19 Jul 2000 19:29:38 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:41011 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42280AbQGTC26>;
	Wed, 19 Jul 2000 19:28:58 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id TAA16926
	for <linux-mips@oss.sgi.com>; Wed, 19 Jul 2000 19:21:05 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id WAA07550; Wed, 19 Jul 2000 22:19:51 -0300
Date:   Wed, 19 Jul 2000 22:19:51 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Keith M Wesolowski <wesolows@chem.unr.edu>
cc:     linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000719183901.A24731@chem.unr.edu>
Message-ID: <Pine.SGI.4.10.10007192202020.7510-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Great.  I'll get in sync with that and see where it takes me.

I did try recompiling our own C++ code on one of the other Indy boxes to
check out the possibility of a hardware problem.  That one was also
running Simple 0.1.  It exhibeted the same bus error.  This alone is not
conclusive one way or another.  That code was developed on x86 and I don't
know if that group ever tested it on Sparc or other risc for
endian/alignment issues in the data structures.  Thus any combination of
the code, compiler, machine could be broken.  Further analysis will tell.

My company seems comitted to using mips, as opposed to moving to any other
arch as I was told to "make it work regardless" this afternoon, even if it
meant changeing their time line a little.  They seem interested in
throwing some people at this if it comes down to fixing the tools to get
the job done.  For arguments sake, if that were the case, what should we
be working with and what people on the mailing lists should I start
getting in touch with?

Thanks again for your input Keith!
