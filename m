Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4QIT5nC021905
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 26 May 2002 11:29:05 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4QIT5Pe021904
	for linux-mips-outgoing; Sun, 26 May 2002 11:29:05 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4QIT0nC021901
	for <linux-mips@oss.sgi.com>; Sun, 26 May 2002 11:29:01 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17C2lV-0007ya-00; Sun, 26 May 2002 20:29:13 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17C2mF-00041o-00; Sun, 26 May 2002 20:29:59 +0200
Date: Sun, 26 May 2002 20:29:59 +0200
To: Eric Christopher <echristo@redhat.com>
Cc: "H . J . Lu" <hjl@lucon.org>, cgd@broadcom.com, linux-mips@oss.sgi.com
Subject: Re: linux.h patch for mips
Message-ID: <20020526182959.GA15299@rembrandt.csv.ica.uni-stuttgart.de>
References: <1022278283.25829.46.camel@ghostwheel.cygnus.com> <20020524190322.C10735@lucon.org> <20020525181404.GI21557@rembrandt.csv.ica.uni-stuttgart.de> <1022436056.29700.3.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1022436056.29700.3.camel@ghostwheel.cygnus.com>
User-Agent: Mutt/1.3.28i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Eric Christopher wrote:
> 
> > 
> > At least for completeness there should be also _MIPS_ISA_MIPS5
> > (the -mips5 swich would cause _MIPS_ISA_MIPS1 otherwise).
> 
> Rather irrelevent since mips5 really isn't supported in gcc, but ok. I
> was more concerned with the kernel issues and how checks for processor
> features was being done. Requiring -mipsX for anything isn't a good idea
> (what if you want to compile for something that is not a particular
> architecture, e.g. -march=r4600). 

That's why my private patch for mips64-linux has:

  %{mips1:-D_MIPS_ISA=_MIPS_ISA_MIPS1} \
  %{mips2:-D_MIPS_ISA=_MIPS_ISA_MIPS2} \
  %{mips32:-D_MIPS_ISA=_MIPS_ISA_MIPS32} \
  %{mips3:-D_MIPS_ISA=_MIPS_ISA_MIPS3} \
  %{mips4:-D_MIPS_ISA=_MIPS_ISA_MIPS4} \
  %{mips5:-D_MIPS_ISA=_MIPS_ISA_MIPS5} \
  %{mips64:-D_MIPS_ISA=_MIPS_ISA_MIPS64} \
  %{!mips*: \
    %{mabi=32|mabi=o32|!mabi*:-D_MIPS_ISA=_MIPS_ISA_MIPS1} \
    %{mabi=n32|mabi=64|mabi=n64:-D_MIPS_ISA=_MIPS_ISA_MIPS3}} \


Thiemo
