Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4QI1qnC021687
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 26 May 2002 11:01:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4QI1pe8021686
	for linux-mips-outgoing; Sun, 26 May 2002 11:01:51 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from potter.sfbay.redhat.com (IDENT:root@potter.sfbay.redhat.com [205.180.83.107])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4QI1mnC021683
	for <linux-mips@oss.sgi.com>; Sun, 26 May 2002 11:01:49 -0700
Received: from localhost.localdomain (remus.sfbay.redhat.com [172.16.27.252])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g4QI12v06380;
	Sun, 26 May 2002 11:01:02 -0700
Subject: Re: linux.h patch for mips
From: Eric Christopher <echristo@redhat.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "H . J . Lu" <hjl@lucon.org>, cgd@broadcom.com, linux-mips@oss.sgi.com
In-Reply-To: <20020525181404.GI21557@rembrandt.csv.ica.uni-stuttgart.de>
References: <1022278283.25829.46.camel@ghostwheel.cygnus.com>
	<20020524190322.C10735@lucon.org> 
	<20020525181404.GI21557@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 26 May 2002 11:00:54 -0700
Message-Id: <1022436056.29700.3.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> 
> At least for completeness there should be also _MIPS_ISA_MIPS5
> (the -mips5 swich would cause _MIPS_ISA_MIPS1 otherwise).

Rather irrelevent since mips5 really isn't supported in gcc, but ok. I
was more concerned with the kernel issues and how checks for processor
features was being done. Requiring -mipsX for anything isn't a good idea
(what if you want to compile for something that is not a particular
architecture, e.g. -march=r4600). 

-eric

-- 
I will not carve gods
