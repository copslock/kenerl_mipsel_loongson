Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Apr 2005 17:04:09 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:55770
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225793AbVD1QDy>; Thu, 28 Apr 2005 17:03:54 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j3SG3jJd007062;
	Thu, 28 Apr 2005 09:03:45 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with SMTP id j3SG3hQf014926;
	Thu, 28 Apr 2005 09:03:44 -0700 (PDT)
Message-ID: <004e01c54c0c$4c9f3d30$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Cc:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>, <linux-mips@linux-mips.org>
References: <20050427.143622.77402407.nemoto@toshiba-tops.co.jp> <20050428134118.GC1276@linux-mips.org> <002d01c54bfa$5b913f80$0deca8c0@Ulysses> <20050428152123.GH1276@linux-mips.org>
Subject: Re: preempt safe fpu-emulator
Date:	Thu, 28 Apr 2005 18:06:53 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7821
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

> On Thu, Apr 28, 2005 at 06:58:28AM -0700, Kevin D. Kissell wrote:
> 
> > When I first integrated the Algorithmics emulator with the Linux kernel
> > several years back, I tried doing something like this but ran into some
> > problem that I cannot recall exactly - there may have been some case
> > where the system expected threads to "inherit" FCSR changes.  I agree
> > that this is an obviously cleaner approach, but be careful.
> 
> The global variables definately won't fly anymore in preemptable and SMP
> kernels.  Or rather any attempt to get that to work would only make things
> worse, so they had to go.

The global variable thing was clearly not SMP safe - but then again, the
32-bit MIPS kernel we were working with wasn't SMP safe either, in
those days.  ;o)  But *if* - and it may not really (or no longer) be the case - 
there is an implicit assumption that some FCSR state is preserved on a
context switch, it would be more correct to map the ieee754_csr symbol
to a per-CPU variable than a per-thread variable.

            Regards,

            Kevin K.
