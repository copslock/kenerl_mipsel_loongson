Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GG2BF14183
	for linux-mips-outgoing; Mon, 16 Jul 2001 09:02:11 -0700
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GG1tV14160;
	Mon, 16 Jul 2001 09:01:55 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA08202; Mon, 16 Jul 2001 09:01:36 -0700 (PDT)
	mail_from (macro@ds2.pg.gda.pl)
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA14187;
	Mon, 16 Jul 2001 14:46:50 +0200 (MET DST)
Date: Mon, 16 Jul 2001 14:46:49 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>, linux-mips@oss.sgi.com
Subject: Re: sti() does not work.
In-Reply-To: <20010714130448.C6713@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1010716140547.12988D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, 14 Jul 2001, Ralf Baechle wrote:

> Real wild pig hackers on R3000 were writing code which knows that in the
> load delay slot they still have the old register value available.  So you
> can implement var1++; var2++ as:

 That's crazy...

> Of course only safe with interrupts disabled.  So in a sense introducing
> the load interlock broke semantics of MIPS machine code ;-)

 That broke the MIPS' virtue as well, as MIPS stands for "Microprocessor
without Interlocked Pipeline Stages" (actually mfhi/mflo broke that in the
first place, but it was less significant due to the multiplier being a
separate unit). 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
