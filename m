Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5LL2onC014417
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 21 Jun 2002 14:02:50 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5LL2oHU014416
	for linux-mips-outgoing; Fri, 21 Jun 2002 14:02:50 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5LL2knC014407
	for <linux-mips@oss.sgi.com>; Fri, 21 Jun 2002 14:02:47 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id XAA04577;
	Fri, 21 Jun 2002 23:06:19 +0200 (MET DST)
Date: Fri, 21 Jun 2002 23:06:19 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Smith, Todd" <Todd.Smith@camc.org>
cc: "''linux-mips@oss.sgi.com' '" <linux-mips@oss.sgi.com>
Subject: Re: DECstation
In-Reply-To: <490E0430C3C72046ACF7F18B7CD76A2A568B98@KES.camcare.com>
Message-ID: <Pine.GSO.3.96.1020621225833.2531B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, 21 Jun 2002, Smith, Todd wrote:

> I was curious about the DECstation 5000/133 and a graphical console.

 The system should be fine -- basically all I/O ASIC based systems should
work, though not all devices have been supplied with drivers yet. 

 You should be able to use X11 with an XF86_FBDev Xserver on a PMAG-B (CX) 
or a PMAGB-B (HX) display adapter (I wasn't able to try myself so far
though).  For other display adapters, the answer is either "not yet" or
"no way". 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
