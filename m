Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NEawRw028159
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 07:36:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NEawmJ028158
	for linux-mips-outgoing; Tue, 23 Jul 2002 07:36:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mx2.mips.com (ftp.mips.com [206.31.31.227])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NEarRw028149
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 07:36:53 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id g6NEb0Xb024976;
	Tue, 23 Jul 2002 07:37:00 -0700 (PDT)
Received: from Ulysses (sfr-tgn-sfb-vty22.as.wcom.net [216.192.4.22])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id HAA05075;
	Tue, 23 Jul 2002 07:36:54 -0700 (PDT)
Message-ID: <003b01c23256$b262f080$1604c0d8@Ulysses>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, <linux-mips@fnet.fr>,
   <linux-mips@oss.sgi.com>, "Ralf Baechle" <ralf@uni-koblenz.de>
References: <Pine.GSO.3.96.1020722222909.2373P-100000@delta.ds2.pg.gda.pl>
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
Date: Tue, 23 Jul 2002 16:38:58 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>  There is no need to carry support for pure 32-bit CPUs around in
> cpu_probe() in arch/mips64/kernel/setup.c, since such CPUs are not
> supported by the port and likely won't ever reach that code due to a
> reserved instruction exception earlier.  The code is misleading and a
> possible cause of troubles, e.g. the 2.4 branch doesn't link now because
> of an unresolved reference to cpu_has_fpu() which is only needed for
> R2000/R3000. 
> 
>  The following patch removes the code for 2.4.  For the trunk
> cpu_has_fpu() would be removed as well.  Any objections?

I'm on the road and don't have ready access to the sources,
but if I understand you correctly, I object.  The MIPS 5Kc and 
the NEC Vr41xx are two examples of 64-bit CPUs which don't 
have FPUs, and I believe there is at least one other from
Toshiba. (Tx49-something-or-other).

My personal bleief is that the mips and mips64 trees 
should ultimately be merged, and that creating additional 
and gratuitous differences should be avoided.
