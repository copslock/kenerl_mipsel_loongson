Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6UNGwRw006854
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 30 Jul 2002 16:16:58 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6UNGwpX006853
	for linux-mips-outgoing; Tue, 30 Jul 2002 16:16:58 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sgi.com (sgi-too.SGI.COM [204.94.211.39])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6UNGqRw006843
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 16:16:53 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05282
	for <linux-mips@oss.sgi.com>; Tue, 30 Jul 2002 16:18:54 -0700 (PDT)
	mail_from (ica2_ts@csv.ica.uni-stuttgart.de)
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 17Zg2g-001VVM-00; Wed, 31 Jul 2002 01:04:38 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 17Zg65-0000aq-00; Wed, 31 Jul 2002 01:08:09 +0200
Date: Wed, 31 Jul 2002 01:08:09 +0200
To: "Zajerko-McKee, Nick" <nmckee@telogy.com>
Cc: "Linux-Mips (E-mail)" <linux-mips@oss.sgi.com>
Subject: Re: GAS 4kc question...
Message-ID: <20020730230809.GE7883@rembrandt.csv.ica.uni-stuttgart.de>
References: <37A3C2F21006D611995100B0D0F9B73CBFE213@tnint11.telogy.design.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37A3C2F21006D611995100B0D0F9B73CBFE213@tnint11.telogy.design.ti.com>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Zajerko-McKee, Nick wrote:
> Hi,
> 
> I'm trying to write some inline assembler code that needs the madd and mulu
> op codes found on the 4KC processor.  I've tried setting the cpu to 4650,
> but it failed to recognize the mulu instruction.  Can someone give me the
> magic incantation?  I'm running right now GCC 2.95.3 from Montavista.  I
> guess one way I can attack it for now is to build the op code by hand, but
> that is quite dirty, IMHO...

At least the assembler in current binutils does not know about "mulu" at all.
I don't know if Montavista has added such a feature to their derivative.


Thiemo
