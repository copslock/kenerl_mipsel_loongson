Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6E9lvRw004284
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 14 Jul 2002 02:47:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6E9lu2W004283
	for linux-mips-outgoing; Sun, 14 Jul 2002 02:47:56 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6E9lqRw004274
	for <linux-mips@oss.sgi.com>; Sun, 14 Jul 2002 02:47:53 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6E9qUXb020314
	for <linux-mips@oss.sgi.com>; Sun, 14 Jul 2002 02:52:30 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id CAA03294;
	Sun, 14 Jul 2002 02:52:30 -0700 (PDT)
Message-ID: <00a801c22b1c$446a6fe0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Kevin D. Kissell" <kevink@mips.com>, <linux-mips@oss.sgi.com>
References: <023e01c22a5e$c013f120$10eca8c0@grendel>
Subject: Re: Gcc v2.96 versus Trolltech QtEmbedded Window System
Date: Sun, 14 Jul 2002 11:53:10 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Many thanks to all of you who replied with suggestions.
I was able to repeat the experiment on a system with
essentially the same configuration as my own, except
with 256MB of memory instead of 32M.  The compilation
that took 20 hours to get to 90MB if virtual size completed
in something like 5 minutes, with the last sampled virtual
footprint being 94MB.  Now all I've gotta do is to squeeze
the resulting build tree across an ISDN line back to my
own system to install, but even if that comes out to 
hundreds of megabytes, it'll be faster than a local build.  ;-)

            Regards,

            Kevin K.
