Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5JACxnC014378
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 19 Jun 2002 03:12:59 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5JACx7H014377
	for linux-mips-outgoing; Wed, 19 Jun 2002 03:12:59 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (mx2.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5JACunC014374
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 03:12:56 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.9.3/8.9.0) with ESMTP id DAA20054
	for <linux-mips@oss.sgi.com>; Wed, 19 Jun 2002 03:15:46 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id DAA28487;
	Wed, 19 Jun 2002 03:15:44 -0700 (PDT)
Message-ID: <005501c2177a$4a1ba590$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Hartvig Ekner" <hartvige@mips.com>
Cc: "user alias" <linux-mips@oss.sgi.com>
References: <200206190951.g5J9pt620966@copfs01.mips.com>
Subject: Re: Linux and the Sony Playstation
Date: Wed, 19 Jun 2002 12:15:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

> > You didn't disassemble the code.  The Sony gcc distribution
> > is hard-wired to generate soft-float code, even if you 
> > specify -mhard-float on the command line.
> 
> I did disassemble the code. It generates true FPU code for floats, and
> soft-float for double. See the example below:

I tested both double and single variants last night, 
and I *thought* that I had seen soft-float code
generated for both cases.  By the light of day,
I can see that that the single case disassembly
does indeed use the FPU - I must have gotten
the disassembly files confused last night.  In any
case, as I said, even if you specify "hard-float",
you'll get soft doubles from the Sony gcc.

While various users have complained about
both the speed and the accuracy of the Sony
soft float implementation, it does pass paranoia
with flying colors.

            Kevin K.
