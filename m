Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0U23kJ08478
	for linux-mips-outgoing; Tue, 29 Jan 2002 18:03:46 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0U23id08474
	for <linux-mips@oss.sgi.com>; Tue, 29 Jan 2002 18:03:44 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g0U13gX29139
	for <linux-mips@oss.sgi.com>; Tue, 29 Jan 2002 17:03:42 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: Does Linux invalidate TLB entries?
Date: Tue, 29 Jan 2002 17:03:42 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAIGECBCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm still trying to track down the cause of all my problems, so I'm
going over the RM7000 errata.

I see one here that I'm not sure if it's a problem or not.  It only
applies to OSes which invalidate TLB entries and thus will cause TLB
Invalid exceptions (as opposed to a TLB refill exception, I think).

So, does Linux invalidate TLBs?  I've been looking at the code, and I
think the answer is 'no', but I'm not really sure.

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com
