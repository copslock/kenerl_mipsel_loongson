Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OEaoRw019755
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 07:36:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OEaos3019754
	for linux-mips-outgoing; Wed, 24 Jul 2002 07:36:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OEaiRw019745
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 07:36:45 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA29214;
	Wed, 24 Jul 2002 16:38:03 +0200 (MET DST)
Date: Wed, 24 Jul 2002 16:38:03 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Nick Zajerko-McKee <nmckee@telogy.com>
cc: linux-mips@oss.sgi.com
Subject: Re: Question about generic\time.c 2.4.17
In-Reply-To: <1027461913.4699.26.camel@gtlinuxserver1.telogy.design.ti.com>
Message-ID: <Pine.GSO.3.96.1020724162924.27732C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

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
