Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6OGev324410
	for linux-mips-outgoing; Tue, 24 Jul 2001 09:40:57 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6OGesO24407;
	Tue, 24 Jul 2001 09:40:54 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id JAA17932;
	Tue, 24 Jul 2001 09:40:47 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id JAA13093;
	Tue, 24 Jul 2001 09:40:45 -0700 (PDT)
Message-ID: <01ce01c11460$07f50a80$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>,
   "Andrew Thornton" <andrew.thornton@insignia.com>
Cc: "James Simmons" <jsimmons@transvirtual.com>,
   "Linux-MIPS" <linux-mips@oss.sgi.com>
References: <00b201c11443$f02eae40$d11110ac@snow.isltd.insignia.com> <20010724182312.E27225@bacchus.dhis.org>
Subject: Re: ATI Victoria on Malta
Date: Tue, 24 Jul 2001 18:45:08 +0200
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

>
> > OK. I'm afraid I haven't got that much time to spare on this, which is
why I
> > asked if anyone else had managed this!
> >
> > What I've got is linux-2.4.3.mips-src-01.00.tar.gz (from ftp.mips.com)
> > patched to make the FPU emulator work reliably (taken from the mail
list),
>
> Sorry to destroy your illusions but we've got still a bunch of rather
> tricky bugs in the fp emulation code.

Note, however, that all known bugs have to deal with catching
and handling signals during certain emulation sequences - if
you're doing "straight-line" FP computation, you're probably OK.  ;-)

            Kevin K.
