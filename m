Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1CD1Ms30509
	for linux-mips-outgoing; Tue, 12 Feb 2002 05:01:22 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1CD1J930506
	for <linux-mips@oss.sgi.com>; Tue, 12 Feb 2002 05:01:20 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id EAA18097;
	Tue, 12 Feb 2002 04:01:13 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA28977;
	Tue, 12 Feb 2002 04:01:09 -0800 (PST)
Message-ID: <010601c1b3bd$1da618e0$0deca8c0@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Matthew Dharm" <mdharm@momenco.com>
Cc: "Ralf Baechle" <ralf@uni-koblenz.de>, <linux-mips@fnet.fr>,
   <linux-mips@oss.sgi.com>
References: <Pine.GSO.3.96.1020212123901.17858B-100000@delta.ds2.pg.gda.pl>
Subject: Re: [patch] linux 2.4.17: The second mb() rework (final)
Date: Tue, 12 Feb 2002 13:02:13 +0100
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

From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>:
> On Mon, 11 Feb 2002, Matthew Dharm wrote:
> 
> > Aren't there more processors that have sync?  I thought the RM7000
> > (PMC-Sierra) did too...
> 
>  Obviously there are as "sync" is standard for MIPS II and above.  That's
> why only CONFIG_CPU_R3000 and CONFIG_CPU_TX39XX disable "sync".

According to the (rather old) Tx39xx specs at my disposal,
those parts should also support the SYNC instruction.  Does
anyone know for a fact that some of them do not?

            Kevin K.
