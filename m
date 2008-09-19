Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Sep 2008 13:16:05 +0100 (BST)
Received: from kirk.serum.com.pl ([213.77.9.205]:35574 "EHLO serum.com.pl")
	by ftp.linux-mips.org with ESMTP id S20318266AbYISMQB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 Sep 2008 13:16:01 +0100
Received: from serum.com.pl (IDENT:macro@localhost [127.0.0.1])
	by serum.com.pl (8.12.11/8.12.11) with ESMTP id m8JCFpRr030498;
	Fri, 19 Sep 2008 14:15:51 +0200
Received: from localhost (macro@localhost)
	by serum.com.pl (8.12.11/8.12.11/Submit) with ESMTP id m8JCFcKx030494;
	Fri, 19 Sep 2008 13:15:39 +0100
Date:	Fri, 19 Sep 2008 13:15:38 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, u1@terran.org,
	linux-mips@linux-mips.org, netdev@vger.kernel.org
Subject: Re: [PATCH] MIPS checksum fix
In-Reply-To: <20080919120752.GA19877@linux-mips.org>
Message-ID: <Pine.LNX.4.55.0809191311130.29711@cliff.in.clinika.pl>
References: <Pine.LNX.4.55.0809171104290.17103@cliff.in.clinika.pl>
 <20080917.222350.41199051.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0809171501450.17103@cliff.in.clinika.pl>
 <20080918.002705.78730226.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.55.0809171917580.17103@cliff.in.clinika.pl>
 <20080918220734.GA19222@linux-mips.org> <Pine.LNX.4.55.0809190112090.22686@cliff.in.clinika.pl>
 <20080919112304.GB13440@linux-mips.org> <20080919114743.GA19359@linux-mips.org>
 <20080919120752.GA19877@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20554
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 19 Sep 2008, Ralf Baechle wrote:

> +	beqz	t7, 1f			/* odd buffer alignment? */
> +	 lui	v1, 0x00ff

 Well, .set reorder to move something from before the branch would have 
been a little bit better for the common aligned case. ;)  There is nothing 
special about branch delay slots in the whole epilogue, so one from just 
before the return might simply be relocated here.

  Maciej
