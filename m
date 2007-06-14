Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2007 16:52:08 +0100 (BST)
Received: from qb-out-0506.google.com ([72.14.204.233]:49284 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20023452AbXFNPwG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 14 Jun 2007 16:52:06 +0100
Received: by qb-out-0506.google.com with SMTP id q17so242328qba
        for <linux-mips@linux-mips.org>; Thu, 14 Jun 2007 08:52:05 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lAn+AnDz8OUQg4CLvCRxpWWAu3WBuwNZywCnIBhvacc2wcqs+fzBxm0YOoal+4wHCcwdIADvHXwlXWl7zMJdYpr6UTN4Vyb6SZ0rqzVtxGbMUrbcWp5xGf1ei355fL5xC5CA+5/OLKrt96LTO5NFIxTRhQMhM4lUjfCgz3PSISY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RnOHfIpgfg90z5BzCVAv7vBTy8TmEjVNH096ygIeiI1QgXKm6R8ESKeHT/Xw4Chrgg3VxvR7jSlb95uIpmh2qe/9zURnfLiWWnKuhknH3/ley3ITk9XbhSJq5nVQyOKM8nPxlxYvTcpiL0oUnZVNjDOfl4iggHDQo7j8c+l6+L0=
Received: by 10.65.231.12 with SMTP id i12mr3762382qbr.1181836324903;
        Thu, 14 Jun 2007 08:52:04 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Thu, 14 Jun 2007 08:52:04 -0700 (PDT)
Message-ID: <cda58cb80706140852k12dafadbjbffbe470608f540c@mail.gmail.com>
Date:	Thu, 14 Jun 2007 17:52:04 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
In-Reply-To: <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <11818164023940-git-send-email-fbuihuu@gmail.com>
	 <20070614111748.GA8223@alpha.franken.de>
	 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
>  I'll have a look at your patches, but I hope you have got about the most
> interesting configuration right, which is the DEC platform

hmm, I looked at arch/mips/dec/time.c, and I'm not sure to understand it.
Could you give me more info ?

To be sure we're taking about the same thing, I'm calling "hpt" the timer
in CP0 _only_. If you have others timers let's call them "timer".

> where you can have one of these:
>
> 1. No HPT at all.
>

What's generating the tick interrupt in this case ?

> 2. HPT in the chipset.
>

What do you mean by chipset ? the DS1287 ?

> 3. HPT in CP0.
>

Reading the dec code, it seems that whatever the case, you don't use
the hpt cp0 as tick interrupt source. It's only use as a clock source.
If so, why ?

-- 
               Franck
