Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g54EarnC028061
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 4 Jun 2002 07:36:53 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g54EarTg028060
	for linux-mips-outgoing; Tue, 4 Jun 2002 07:36:53 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from delta.ds2.pg.gda.pl (macro@delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g54EalnC028055;
	Tue, 4 Jun 2002 07:36:47 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id QAA18336;
	Tue, 4 Jun 2002 16:39:08 +0200 (MET DST)
Date: Tue, 4 Jun 2002 16:39:07 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
   "Gleb O. Raiko" <raiko@niisi.msk.ru>, Jun Sun <jsun@mvista.com>,
   Alexandr Andreev <andreev@niisi.msk.ru>, linux-mips@oss.sgi.com
Subject: Re: 3 questions about linux-2.4.18 and R3000
In-Reply-To: <20020603160425.A28859@dea.linux-mips.net>
Message-ID: <Pine.GSO.3.96.1020604163730.17556D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, 3 Jun 2002, Ralf Baechle wrote:

> Wonderful.  Due to the hackish way we're using to build 64-bit kernels
> for the currently supported targets we don't run into this problems,
> there are no R_MIPS_HIGHEST relocs ever.

 I've already cleaned up the crap in my tree and I'll make the changes
available as soon as I have a version of binutils that actually works. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
