Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5HMYAnC031402
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 17 Jun 2002 15:34:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5HMYAem031401
	for linux-mips-outgoing; Mon, 17 Jun 2002 15:34:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5HMY4nC031397;
	Mon, 17 Jun 2002 15:34:05 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17K55X-000axA-00; Tue, 18 Jun 2002 00:35:07 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17K57C-0005rW-00; Tue, 18 Jun 2002 00:36:50 +0200
Date: Tue, 18 Jun 2002 00:36:50 +0200
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: system.h asm fixes
Message-ID: <20020617223650.GD20335@rembrandt.csv.ica.uni-stuttgart.de>
References: <1024338042.1463.21.camel@localhost.localdomain> <20020617224452.C27009@dea.linux-mips.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020617224452.C27009@dea.linux-mips.net>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
[snip]
> > Looks to me like we're missing some proper asm clobber markers:
> 
> No, as per convention $1 is never used by the compiler per convention,
> so clobbering not necessary.  I recently removed all "$1" clobbers to
> make the code a bit easier to read.

How can this work? A grep shows many instances of $1 usage,
I don't think all of this code is interrupt safe.


Thiemo
