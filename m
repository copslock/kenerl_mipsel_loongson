Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OEqDRw020131
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 07:52:13 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OEqDHx020130
	for linux-mips-outgoing; Wed, 24 Jul 2002 07:52:13 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (shaft17-f182.dialo.tiscali.de [62.246.17.182])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OEq7Rw020120
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 07:52:08 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g6OEqdm28375;
	Wed, 24 Jul 2002 16:52:39 +0200
Date: Wed, 24 Jul 2002 16:52:39 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
   "Kevin D. Kissell" <kevink@mips.com>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: cpu_probe(): remove 32-bit CPU bits for MIPS64
Message-ID: <20020724165239.F28010@dea.linux-mips.net>
References: <Pine.GSO.3.96.1020723164235.29699A-100000@delta.ds2.pg.gda.pl> <3D3DC6E6.AFF9CBFD@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D3DC6E6.AFF9CBFD@mips.com>; from kevink@mips.com on Tue, Jul 23, 2002 at 02:13:10PM -0700
X-Accept-Language: de,en,fr
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej,

>  I don't think it's possible to be fully achieved.  Some differences will
> have to exist, at least in the headers, but likely within the arch tree as
> well.  The reason is binary code size or perfomance -- having R3000
> support code in mips64 binaries is simply ridiculous as is using 32-bit
> operations with 64-bit data on a 64-bit CPU.  However, it is worth trying
> to minimize visible differences where possible, e.g. by convincing the
> compiler to optimize irrelevant bits away.

In this particular case all the bloat is just in __init code, could that
convince you?

  Ralf
