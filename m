Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f36CK2B25817
	for linux-mips-outgoing; Fri, 6 Apr 2001 05:20:02 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f36CK2M25814
	for <linux-mips@oss.sgi.com>; Fri, 6 Apr 2001 05:20:02 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA10074;
	Fri, 6 Apr 2001 05:20:04 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA04413;
	Fri, 6 Apr 2001 05:20:02 -0700 (PDT)
Message-ID: <00cb01c0be94$7744aac0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Florian Lohoff" <flo@rfc822.org>
Cc: <debian-mips@lists.debian.org>, <linux-mips@oss.sgi.com>
References: <20010406130958.A14083@paradigm.rfc822.org> <20010406132214.D14083@paradigm.rfc822.org> <00a401c0be8e$cfc065a0$0deca8c0@Ulysses> <20010406135849.E14083@paradigm.rfc822.org>
Subject: Re: first packages for mipsel
Date: Fri, 6 Apr 2001 14:23:53 +0200
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

> If there is a working ll/sc emulation fine - Currently there is none
> so the only way to go TODAY is sysmips.

I'll work on one in the background.  It should be pretty straightforward
for the uniprocessor case, but an SMP version will be messier, and
possibly require a platform-dependent hook.  Of course, the same
is true of sysmips()...

            Kevin K.
