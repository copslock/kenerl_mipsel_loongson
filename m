Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OF3RRw020566
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 08:03:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OF3Rnd020565
	for linux-mips-outgoing; Wed, 24 Jul 2002 08:03:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from tnint11.telogy.design.ti.com ([209.116.120.7])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OF3KRw020529
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 08:03:21 -0700
Received: by tnint11.telogy.design.ti.com with Internet Mail Service (5.5.2653.19)
	id <NYM51PH8>; Wed, 24 Jul 2002 11:02:54 -0400
Message-ID: <37A3C2F21006D611995100B0D0F9B73CBFE202@tnint11.telogy.design.ti.com>
From: "Zajerko-McKee, Nick" <nmckee@telogy.com>
To: "'Maciej W. Rozycki'" <macro@ds2.pg.gda.pl>,
   "Zajerko-McKee, Nick"
	 <nmckee@telogy.com>
Cc: linux-mips@oss.sgi.com
Subject: RE: Question about generic\time.c 2.4.17
Date: Wed, 24 Jul 2002 11:02:53 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for the reply.   No, the code wasn't too obvious.  I went through the
gas info page to try to understand the inline assembler options + see mips
run.  I believe the code is used in the MIPS32 condition, which is what mode
I'm building for...  

so the result is res = (high |low)/ base ?

What had me confused was high and low are also modified as part of the
function.

-----Original Message-----
From: Maciej W. Rozycki [mailto:macro@ds2.pg.gda.pl]
Sent: Wednesday, July 24, 2002 10:38 AM
To: Nick Zajerko-McKee
Cc: linux-mips@oss.sgi.com
Subject: Re: Question about generic\time.c 2.4.17


On 23 Jul 2002, Nick Zajerko-McKee wrote:

> I'm working on a new 4Kc platform and was looking at the
> arch\mips\mips-boards\generic\time.c sources.  Can someone explain to me
> the function of do_fast_gettimeoffset(), especially the do_div64_32()
> assembler routine?  One of the requirements I have will be not modify
> the timer resolution for my platform to something in the msec range w/o
> disturbing the underlying jiffie setup found in linux.

 That's a traditional double-precision division, i.e. in this case it's a
64-bit dividend by a 32-bit divisor with a 32-bit quotient and a 32-bit
remainder (hmm, the code should be obvious).  It isn't used in the file,
though. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
