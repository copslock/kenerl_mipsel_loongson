Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7GCVdk26720
	for linux-mips-outgoing; Thu, 16 Aug 2001 05:31:39 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7GCVcj26717
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 05:31:38 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id FAA00421;
	Thu, 16 Aug 2001 05:31:28 -0700 (PDT)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id FAA17200;
	Thu, 16 Aug 2001 05:31:29 -0700 (PDT)
Message-ID: <009401c12650$021bcca0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: <dan@debian.org>, "Atsushi Nemoto" <nemoto@toshiba-tops.co.jp>
Cc: <carstenl@mips.com>, <linux-mips@oss.sgi.com>
References: <3B7A70B8.ED92FE4@mips.com><20010815110634.A19305@nevyn.them.org> <20010816132042T.nemoto@toshiba-tops.co.jp>
Subject: Re: FP emulator patch
Date: Thu, 16 Aug 2001 14:35:46 +0200
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

> I also am trying to fix this problem.  How about my patch?
> 
> restore_sigcontext() can be more optimized, but I think this is a
> smallest patch to fix the problem.

I beleive that your patch might fix a symptom of the bugs
that I talked about in my mail last night, but it doesn't solve
the underlying problem.  With the signal setup/restore 
changes I posted last night, your patch should not be
necessary.

            Kevin K.
