Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2MFSgB02031
	for linux-mips-outgoing; Thu, 22 Mar 2001 07:28:42 -0800
Received: from chmls20.mediaone.net (chmls20.mediaone.net [24.147.1.156])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2MFSfM02027
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 07:28:41 -0800
Received: from decoy (h00a0cc39f081.ne.mediaone.net [24.218.248.129])
	by chmls20.mediaone.net (8.11.1/8.11.1) with SMTP id f2MFSbk14939;
	Thu, 22 Mar 2001 10:28:37 -0500 (EST)
From: "Jay Carlson" <nop@nop.com>
To: "Kevin D. Kissell" <kevink@mips.com>, "Jay Carlson" <nop@place.org>,
   <linux-mips@oss.sgi.com>, <linuxce-devel@linuxce.org>
Subject: RE: snow, a statically linked shared library MIPS ABI
Date: Thu, 22 Mar 2001 10:28:41 -0500
Message-ID: <KEEOIBGCMINLAHMMNDJNMEHDCAAA.nop@nop.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <013a01c0b2db$749249a0$0deca8c0@Ulysses>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Kevin D. Kissell [mailto:kevink@mips.com] writes:

> > Instead, we can build shared library images located at fixed locations
> > in memory, with the location configured at library creation time.
> > Stub libraries are generated that hold the absolute addresses of
> > functions and data within the library image; programs (and other
> > libraries) link with the stubs.
>
> In fact, this is exactly how shared libraries worked under
> UNIX System V.  It is inelegant, but economical.

Yeah.  I bet there are precedents back in the mainframe world too.  But my
first encounter with it was Linux a.out libraries, so it's a sign that I'm
truly a Linux Weenie that I think of it that way :-)

Jay
