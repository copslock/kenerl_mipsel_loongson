Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4R6uEnC026880
	for <linux-mips-outgoing@oss.sgi.com>; Sun, 26 May 2002 23:56:14 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4R6uElV026879
	for linux-mips-outgoing; Sun, 26 May 2002 23:56:14 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from potter.sfbay.redhat.com (IDENT:root@potter.sfbay.redhat.com [205.180.83.107])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4R6uAnC026875
	for <linux-mips@oss.sgi.com>; Sun, 26 May 2002 23:56:10 -0700
Received: from localhost.localdomain (remus.sfbay.redhat.com [172.16.27.252])
	by potter.sfbay.redhat.com (8.11.6/8.11.6) with ESMTP id g4R6tQv08125;
	Sun, 26 May 2002 23:55:26 -0700
Subject: Re: linux.h patch for mips
From: Eric Christopher <echristo@redhat.com>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: "H . J . Lu" <hjl@lucon.org>, cgd@broadcom.com, linux-mips@oss.sgi.com
In-Reply-To: <20020526182959.GA15299@rembrandt.csv.ica.uni-stuttgart.de>
References: <1022278283.25829.46.camel@ghostwheel.cygnus.com>
	<20020524190322.C10735@lucon.org>
	<20020525181404.GI21557@rembrandt.csv.ica.uni-stuttgart.de>
	<1022436056.29700.3.camel@ghostwheel.cygnus.com> 
	<20020526182959.GA15299@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 26 May 2002 23:55:18 -0700
Message-Id: <1022482520.29700.8.camel@ghostwheel.cygnus.com>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> That's why my private patch for mips64-linux has:
> 
>   %{mips1:-D_MIPS_ISA=_MIPS_ISA_MIPS1} \
>   %{mips2:-D_MIPS_ISA=_MIPS_ISA_MIPS2} \
>   %{mips32:-D_MIPS_ISA=_MIPS_ISA_MIPS32} \
>   %{mips3:-D_MIPS_ISA=_MIPS_ISA_MIPS3} \
>   %{mips4:-D_MIPS_ISA=_MIPS_ISA_MIPS4} \
>   %{mips5:-D_MIPS_ISA=_MIPS_ISA_MIPS5} \
>   %{mips64:-D_MIPS_ISA=_MIPS_ISA_MIPS64} \
>   %{!mips*: \
>     %{mabi=32|mabi=o32|!mabi*:-D_MIPS_ISA=_MIPS_ISA_MIPS1} \
>     %{mabi=n32|mabi=64|mabi=n64:-D_MIPS_ISA=_MIPS_ISA_MIPS3}} \

Not a bad start. There's more that needs to be done, I may end up having
to submit kernel patches to make everything agree. Do people use a cvs
server or ...

-eric

-- 
I will not carve gods
