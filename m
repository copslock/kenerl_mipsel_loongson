Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Sep 2002 23:51:58 +0200 (CEST)
Received: from mail.esstech.com ([64.152.86.3]:2720 "HELO [64.152.86.3]")
	by linux-mips.org with SMTP id <S1123913AbSI0Vvw>;
	Fri, 27 Sep 2002 23:51:52 +0200
Received: from mail.esstech.com by [64.152.86.3]
          via smtpd (for mail.linux-mips.org [80.63.7.146]) with SMTP; Fri, 27 Sep 2002 14:51:51 -0700
Received: from venus (venus.esstech.com [193.5.205.5])
	by mail.esstech.com (8.12.2/8.12.2) with SMTP id g8RLqa0A020533;
	Fri, 27 Sep 2002 14:52:36 -0700 (PDT)
Received: from bud.austin.esstech.com by venus (SMI-8.6/SMI-SVR4)
	id OAA02950; Fri, 27 Sep 2002 14:50:49 -0700
Received: from [193.5.206.150] by bud.austin.esstech.com (SMI-8.6/SMI-SVR4)
	id QAA25279; Fri, 27 Sep 2002 16:42:13 -0500
Subject: Re: [PATCH] show register names in show_regs
From: Gerald Champagne <gerald.champagne@esstech.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Linux Mips Mailing List <linux-mips@linux-mips.org>
In-Reply-To: <Pine.GSO.3.96.1020927231028.16597B-100000@delta.ds2.pg.gda.pl>
References: <Pine.GSO.3.96.1020927231028.16597B-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 27 Sep 2002 16:42:06 -0500
Message-Id: <1033162931.2314.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Virus-Scanned: by AMaViS-perl11-milter (http://amavis.org/)
Return-Path: <gerald.champagne@esstech.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerald.champagne@esstech.com
Precedence: bulk
X-list: linux-mips

>  Note that the format is selected to optimize the space consumed as a
> serial console is not always available and it's better not to let some
> essential information scroll away from the virtual terminal. 

Ah, I only use a serial console and I forgot about people that can't
scroll back.

> Also
> ksymoops will probably be unhappy with format changes (though it tries to
> be flexible, so it might actually survive). 

I thought that the scripts only used the stack values.  Now I see that
it seems to read ra as well.  But it does still work, for what it's
worth...

> How about writing a small
> program or a script that would parse register dumps and output them in
> your favourite layout?

I just wanted something simple that I could use in real-time without
processing.

Thanks for the information.  Now I know why it's done the way it's done.

Gerald
