Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1FAnDX13176
	for linux-mips-outgoing; Fri, 15 Feb 2002 02:49:13 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1FAnA913170
	for <linux-mips@oss.sgi.com>; Fri, 15 Feb 2002 02:49:10 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id BAA09499;
	Fri, 15 Feb 2002 01:49:05 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA08013;
	Fri, 15 Feb 2002 01:48:52 -0800 (PST)
Message-ID: <006e01c1b606$27b1b060$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Atsushi Nemoto" <nemoto@toshiba-tops.co.jp>
Cc: <macro@ds2.pg.gda.pl>, <mdharm@momenco.com>, <ralf@uni-koblenz.de>,
   <linux-mips@fnet.fr>, <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020212123901.17858B-100000@delta.ds2.pg.gda.pl><010601c1b3bd$1da618e0$0deca8c0@Ulysses><20020213.102805.74755945.nemoto@toshiba-tops.co.jp> <20020215.123124.70226832.nemoto@toshiba-tops.co.jp>
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
Date: Fri, 15 Feb 2002 09:30:45 +0100
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

From: "Atsushi Nemoto" <nemoto@toshiba-tops.co.jp>:
> Note that SYNC on TX39/H and TX39/H2 does not flush a write buffer.
> Some operation (for example, bc0f loop) are required to flush a write
> buffer.

That is, I would say, a bug in the TX39 implementation of SYNC.
The specification is states that all stores prior to the SYNC must 
complete before any memory ops after the sync, and that the 
definition of a store completing is that all stored values be 
"visible to every other processor in the system", which pretty 
clearly implies that the write buffers must be flushed.

So I think that the Linux code was perfectly correct in considering
the TX39 to be without SYNC, just as a Vr4101 must be
consdered to be without LL/SC.  They decode the instructions,
but they don't actually implement them as specified.

            Kevin K. 
