Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0N9cQN25250
	for linux-mips-outgoing; Wed, 23 Jan 2002 01:38:26 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0N9cLP25221;
	Wed, 23 Jan 2002 01:38:21 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id AAA15915;
	Wed, 23 Jan 2002 00:38:10 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id AAA22805;
	Wed, 23 Jan 2002 00:38:02 -0800 (PST)
Message-ID: <000c01c1a3e9$6a8086c0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Machida Hiroyuki" <machida@sm.sony.co.jp>
Cc: <aj@suse.de>, <hjl@lucon.org>, <ralf@oss.sgi.com>,
   <linux-mips@oss.sgi.com>
References: <20020122232529V.machida@sm.sony.co.jp><005301c1a368$87d27ed0$10eca8c0@grendel> <20020123145634M.machida@sm.sony.co.jp>
Subject: Re: patches for test-and-set without ll/sc (Re: thread-ready ABIs)
Date: Wed, 23 Jan 2002 09:38:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > It should in principle be SMP safe.
> 
> I don't think so.

You are quite right.  It was an offhand remark
that should have been better qualified.   The basic
mechanism requires no global memory resource
and will detect discontinuitues in scheduling on
several CPUs at once, but but it is certainly not
SMP safe in the sense of the code sample
providing atomic increment on a classical SMP
hardware platform.  

            Regards,

            Kevin K.
