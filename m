Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2MEIAg32472
	for linux-mips-outgoing; Thu, 22 Mar 2001 06:18:10 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2MEIAM32469
	for <linux-mips@oss.sgi.com>; Thu, 22 Mar 2001 06:18:10 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA11734;
	Thu, 22 Mar 2001 06:18:00 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id GAA02264;
	Thu, 22 Mar 2001 06:17:58 -0800 (PST)
Message-ID: <013a01c0b2db$749249a0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Jay Carlson" <nop@nop.com>, <linux-mips@oss.sgi.com>,
   <linuxce-devel@linuxce.org>
References: <KEEOIBGCMINLAHMMNDJNAEHDCAAA.nop@nop.com>
Subject: Re: snow, a statically linked shared library MIPS ABI
Date: Thu, 22 Mar 2001 15:21:48 +0100
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

> Instead, we can build shared library images located at fixed locations
> in memory, with the location configured at library creation time.
> Stub libraries are generated that hold the absolute addresses of
> functions and data within the library image; programs (and other
> libraries) link with the stubs.

In fact, this is exactly how shared libraries worked under
UNIX System V.  It is inelegant, but economical.

            Kevin K.
