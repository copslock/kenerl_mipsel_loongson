Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8DKm6D13581
	for linux-mips-outgoing; Thu, 13 Sep 2001 13:48:06 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8DKm3e13578
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 13:48:03 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id NAA16147
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 13:47:54 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id NAA00546
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 13:47:54 -0700 (PDT)
Received: from kjelde (coppckbe [172.17.85.2])
	by copfs01.mips.com (8.11.4/8.9.0) with SMTP id f8DKlsa27633
	for <linux-mips@oss.sgi.com>; Thu, 13 Sep 2001 22:47:55 +0200 (MEST)
From: "Kjeld Borch Egevang" <kjelde@mips.com>
To: <linux-mips@oss.sgi.com>
Subject: RE: Error in gcc version 2.96 20000731
Date: Thu, 13 Sep 2001 22:47:25 +0200
Message-ID: <NFBBKGGKGLLGNBGCEPKIAEHDCAAA.kjelde@mips.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <Pine.GSO.3.96.1010913171138.4511A-100000@delta.ds2.pg.gda.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks for your reply.

I was trying to port SPEC CPU 2000 (benchmarks), and one of the tests
failed. I boiled it down to the attached program. For performance reasons it
could be perfectly valid not to use memset(), but I agree that the code
looks a bit odd.


/Kjeld

-----Original Message-----
From: Maciej W. Rozycki [mailto:macro@ds2.pg.gda.pl]
Sent: 13. september 2001 17:15
To: Kjeld Borch Egevang
Cc: linux-mips@oss.sgi.com
Subject: Re: Error in gcc version 2.96 20000731


On Thu, 13 Sep 2001, Kjeld Borch Egevang wrote:

> I discovered an optimization error in the current gcc for MIPS.

 Is 2.96 20000731 current?  I thought 3.0.1 is.

> When I compile the code below with -O2 it clears the code-field just
> after setting it. The instructions are mixed up. It works fine with -O1
> and -O0.

 Use "-fno-strict-aliasing"?

> If the "//" is removed in front of the first printf, it works too.

 Why don't you use memset() to clear the struct in the first place?

--
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
