Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Mar 2010 11:18:22 +0100 (CET)
Received: from mail-pz0-f185.google.com ([209.85.222.185]:40775 "EHLO
        mail-pz0-f185.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491778Ab0CLKSS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Mar 2010 11:18:18 +0100
Received: by pzk15 with SMTP id 15so606336pzk.21
        for <multiple recipients>; Fri, 12 Mar 2010 02:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=mZbQYMLk+4voatF7uYgQaESzSIAXzmsGpjZV3V0Z8Is=;
        b=iDfjp/hJxWH+uxwWh6GMSPCC0XfJPh1Kl3O9T5P4VCnAR52YGtUpKHH+wWkqs/4QuM
         l/z4hrCekVRzJptDjhO4JpteNaGxF68snsC9XG6ACs4On6MlEy19Si2GZTN0NsAs+6ew
         Rhzd8cuK0MgxhNK1P/jSmV3bTwZ+gCb0NUHTA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=B7sJ2AyJ1Da2YPGqia2vHt2JcolkzzUMN5iLzhVSHpKNpvtPnDu8oLL8wlOb14BJtk
         ZmpbymzaIyU/0YoT3Ze0czfbP1kCNytuI6vVqGXlJoX4mVmYNk3BdTme03JGb7m2yVZy
         QQeIcBySq94Lh5ZDEVeEReHuoG4UJSgGeTXeU=
Received: by 10.142.61.19 with SMTP id j19mr2358529wfa.69.1268389090936;
        Fri, 12 Mar 2010 02:18:10 -0800 (PST)
Received: from [202.201.12.142] ([202.201.12.142])
        by mx.google.com with ESMTPS id 21sm1096206pzk.12.2010.03.12.02.18.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 02:18:10 -0800 (PST)
Subject: Re: [PATCH] MIPS: tracing: Optimize the implementation
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <srostedt@redhat.com>,
        linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <20100312085053.GB6364@alpha.franken.de>
References: <8b93c417fefa4d446f801abfd718ba94fdcb1821.1268330348.git.wuzhangjin@gmail.com>
         <20100312085053.GB6364@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Fri, 12 Mar 2010 18:11:35 +0800
Message-ID: <1268388695.6447.3.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, 2010-03-12 at 09:50 +0100, Thomas Bogendoerfer wrote:
> On Fri, Mar 12, 2010 at 02:07:37AM +0800, Wu Zhangjin wrote:
> > +/*
> > + * If the Instruction Pointer is in module space (0xc0000000), return ture;
> > + * otherwise, it is in kernel space (0x80000000), return false.
> > + */
> > +#define in_module(ip) (unlikely((ip) & 0x40000000))
> > +
> 
> looks broken for 64bit, but maybe this is a 32bit only feature...

Actually, this works well on my 64bit YeeLoong laptop ;)

But we should find another better solution.

Regards,
	Wu Zhangjin
