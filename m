Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 09:14:01 +0100 (BST)
Received: from fk-out-0910.google.com ([209.85.128.189]:63607 "EHLO
	fk-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20021894AbXI0INw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 09:13:52 +0100
Received: by fk-out-0910.google.com with SMTP id f40so2495734fka
        for <linux-mips@linux-mips.org>; Thu, 27 Sep 2007 01:13:52 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=xkCH4DOOmT2OI8ey0AU0M3Z0MhmFLzFCjHY/IgW6RJg=;
        b=RAzlJShk2K8T9ndkeo1sHDsBgf23WDVY3f/QkgSzgLLwvumOMnRmVdgCXBZiSSOvsHyg96e9WEhbufuITOx537UD9/VXnCNUuSvdxg/ODo7ZUCaMli15w8Jc8ta2v2Qn4Z/KiIwbiRJz3nPi8vxdJI1BEu+k1oJV2cuNJdMRyxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JbBef4674YKAAe1fMngrf9vE6hx18NlDReyxgIVLobhIFnKUxoB+LW1kt3RJ2ftwyJeGsrKWmVX5aQcySz2bs7wTlw724GT5jnGHBLxEJs8AOUder1f95/VTtDhnBjgnZZAGQOzSnWs8BDmjmU8u6B/N4K7giq+MuHkKwpZGl0k=
Received: by 10.82.111.8 with SMTP id j8mr3943808buc.1190880831575;
        Thu, 27 Sep 2007 01:13:51 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id c28sm3880691fka.2007.09.27.01.13.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Sep 2007 01:13:48 -0700 (PDT)
Message-ID: <46FB65C5.2000202@gmail.com>
Date:	Thu, 27 Sep 2007 10:11:49 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, tbm@cyrius.com,
	linux-mips@linux-mips.org
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
References: <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl> <46FA5FFA.1060704@gmail.com> <Pine.LNX.4.64N.0709261525510.30122@blysk.ds.pg.gda.pl> <20070927.003400.108121785.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0709261644500.30122@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0709261644500.30122@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Thu, 27 Sep 2007, Atsushi Nemoto wrote:
> 
>> Current linux-queue code adds -msym32 if the load address was CKSEG0,
>> so it can not be compiled with gcc 3.x.  I think this patch fixes the
>> problem:
>>
>> http://www.linux-mips.org/archives/linux-mips/2007-03/msg00404.html
> 
>  It looks like it should -- why hasn't it been pushed?
> 

I don't remember. I thought the last patchset had the fix.

Just to be sure I understand both of you correctly, could
you confirm that in case of '-msym32' switch isn't supported,
we should _silently_ drop this option ? That's what Atsushi
was suggesting. But reading what Maciej wrote, it seems that
we should notify the user...

		Franck
