Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 16:02:54 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:33019 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S29058567AbYISPCp (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 16:02:45 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8JF2hhR031273;
	Fri, 19 Sep 2008 17:02:43 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8JF2d7N031259;
	Fri, 19 Sep 2008 16:02:39 +0100
Date:	Fri, 19 Sep 2008 16:02:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	ralf@linux-mips.org, u1@terran.org, linux-mips@linux-mips.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] MIPS checksum fix
In-Reply-To: <20080919.230952.128619158.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.55.0809191543230.29711@cliff.in.clinika.pl>
References: <20080919112304.GB13440@linux-mips.org> <20080919114743.GA19359@linux-mips.org>
 <20080919120752.GA19877@linux-mips.org> <20080919.230952.128619158.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20560
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2008, Atsushi Nemoto wrote:

> I think it would be better splitting bugfix and optimization.  This
> code is too complex to do many things at a time, isn't it?

 It's probably easier for people to test a single patch now and it can
then be split at the commitment time.  Of course if something actually
breaks, then keeping changes combined won't help tracking down the cause.  
;)

  Maciej
