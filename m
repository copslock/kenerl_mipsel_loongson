Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HKimnC030182
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 13:44:48 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HKimco030180
	for linux-mips-outgoing; Mon, 17 Jun 2002 13:44:48 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HKiinC030175;
	Mon, 17 Jun 2002 13:44:44 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA02332; Mon, 17 Jun 2002 13:47:22 -0700 (PDT)
	mail_from (ica2_ts@csv.ica.uni-stuttgart.de)
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17K2bz-000b8W-00; Mon, 17 Jun 2002 21:56:27 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17K2df-0005PH-00; Mon, 17 Jun 2002 21:58:11 +0200
Date: Mon, 17 Jun 2002 21:58:11 +0200
To: Daniel Jacobowitz <dan@debian.org>
Cc: Justin Carlson <justin@cs.cmu.edu>, linux-mips@oss.sgi.com,
   ralf@oss.sgi.com
Subject: Re: system.h asm fixes
Message-ID: <20020617195811.GA20335@rembrandt.csv.ica.uni-stuttgart.de>
References: <1024338042.1463.21.camel@localhost.localdomain> <20020617194312.GA14489@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020617194312.GA14489@nevyn.them.org>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Daniel Jacobowitz wrote:
> On Mon, Jun 17, 2002 at 11:20:42AM -0700, Justin Carlson wrote:
> > Looks to me like we're missing some proper asm clobber markers:
> 
> Not really, I think those actually caused a problem at some point but
> that might be my imagination.  They certainly aren't necessary.  The
> compiler can not use $1 for anything, because it doesn't know what the
> assembler might be doing with it.

But other assembler routines which run in the meantime may do.


Thiemo
