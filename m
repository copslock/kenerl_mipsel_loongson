Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5I0pWnC032761
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 17:51:32 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5I0pWXf032760
	for linux-mips-outgoing; Mon, 17 Jun 2002 17:51:32 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dea.linux-mips.net (c-180-196-76.ka.dial.de.ignite.net [62.180.196.76])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5I0pRnC032757
	for <linux-mips@oss.sgi.com>; Mon, 17 Jun 2002 17:51:28 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id g5I0q4228292;
	Tue, 18 Jun 2002 02:52:04 +0200
Date: Tue, 18 Jun 2002 02:52:04 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@oss.sgi.com
Subject: Re: system.h asm fixes
Message-ID: <20020618025204.A28165@dea.linux-mips.net>
References: <1024338042.1463.21.camel@localhost.localdomain> <20020617224452.C27009@dea.linux-mips.net> <20020617223650.GD20335@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020617223650.GD20335@rembrandt.csv.ica.uni-stuttgart.de>; from ica2_ts@csv.ica.uni-stuttgart.de on Tue, Jun 18, 2002 at 12:36:50AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, Jun 18, 2002 at 12:36:50AM +0200, Thiemo Seufer wrote:

> Ralf Baechle wrote:
> [snip]
> > > Looks to me like we're missing some proper asm clobber markers:
> > 
> > No, as per convention $1 is never used by the compiler per convention,
> > so clobbering not necessary.  I recently removed all "$1" clobbers to
> > make the code a bit easier to read.
> 
> How can this work? A grep shows many instances of $1 usage,

Uses by assembler code only, not gcc.  Therefoe we don't need to protect
C code against use of $at.

> I don't think all of this code is interrupt safe.

How this should relate to interrupts is beyond me.  Exception handlers do
their own register saving thing.

  Ralf
