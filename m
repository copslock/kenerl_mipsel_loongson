Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 Dec 2002 11:59:36 +0000 (GMT)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:45290 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225424AbSLSL7g>; Thu, 19 Dec 2002 11:59:36 +0000
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA00504;
	Thu, 19 Dec 2002 12:59:44 +0100 (MET)
Date: Thu, 19 Dec 2002 12:59:43 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Juan Quintela <quintela@mandrakesoft.com>
cc: linux mips mailing list <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH]: make highmem only things enclosed in the right #ifdef
In-Reply-To: <m2znr2mieg.fsf@demo.mitica>
Message-ID: <Pine.GSO.3.96.1021219125246.27339I-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On 19 Dec 2002, Juan Quintela wrote:

> What do you think of this new one?

 Well, you could remove the line below:

>  	         sizeof(pgd_t ) * USER_PTRS_PER_PGD);
>  
> -	pgd_base = swapper_pg_dir;
>  
>  #ifdef CONFIG_HIGHMEM

but that's nitpicking (and I may fix it up if Ralf applies the patch as
is) -- I've pointed you out the problem of spacing more to bring your
attention to such details than to object this particular change.  The
patch looks semantically OK. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
