Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 18:25:54 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:5360 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S29560352AbYISRZw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 18:25:52 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8JHPn2R031857;
	Fri, 19 Sep 2008 19:25:49 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8JHPj5D031853;
	Fri, 19 Sep 2008 18:25:49 +0100
Date:	Fri, 19 Sep 2008 18:25:45 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Dinar Temirbulatov <dtemirbulatov@gmail.com>
cc:	linux-mips@linux-mips.org
Subject: Re: mmap is broken for MIPS64 n32 and o32 abis
In-Reply-To: <a664af430809190953k486e2012hf3a09caa50c9574a@mail.gmail.com>
Message-ID: <Pine.LNX.4.55.0809191803390.29711@cliff.in.clinika.pl>
References: <a664af430809182331i41c9e344w83ecb2830ac24@mail.gmail.com> 
 <Pine.LNX.4.55.0809191329080.29711@cliff.in.clinika.pl>
 <a664af430809190953k486e2012hf3a09caa50c9574a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2008, Dinar Temirbulatov wrote:

>          mmptr = (unsigned short *)mmap((void *)0, 0x1000,
>                              PROT_READ | PROT_WRITE, MAP_SHARED,
>                              mmh, 0xb6000000);

 Ah, so it is the file offset you are concerned about.  Fair enough then.  
Obviously the non-LFS 32-bit variation has to sign-extend the offset as
this is how the off_t type has been defined in this case, though it is
interesting to note that the kernel treats this argument as unsigned while
the C library API defines it as signed and there is no range checking in
between.  Hmm...

  Maciej
