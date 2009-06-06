Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 06 Jun 2009 17:58:18 +0100 (WEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:60152 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023409AbZFFQ6M (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 6 Jun 2009 17:58:12 +0100
Received: by pxi17 with SMTP id 17so243427pxi.22
        for <multiple recipients>; Sat, 06 Jun 2009 09:58:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=iqUtW4jsTerg296qneweV+ucJk+b84+gULn+2t+B+zs=;
        b=H79MEXIMyam06lEb0BSRiamxhUSBZyN/koDsaYhmcb9juWh3Tt/ZrhCJ1ak7diAfEj
         BSKIZJoLidpK+hlkX2lq623VwJ/3PqzYBw4Y4lFPdGr5lb/zUN5uHjUUahtpQ6UM96Di
         n3aSlatxaByxqh5Wg6h+vVHgi+LgnoqaCivxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=N5OE6qSk3KB9nWWWeRIOilvFpM0y0BWfRUqz18/1k+3BAlYPK0hw+vEbvdjDoNOi5h
         px06qaqH3/DREY4F5fKNv9ImaW6WNLoxxnWo0pkDT7S4XRSTTZPlcRURTb6P50xR6X8+
         7CiOAcZkiwXb3EPmNWyY8g9KuKQSR2k+nP2xg=
Received: by 10.114.201.2 with SMTP id y2mr6664453waf.184.1244307484571;
        Sat, 06 Jun 2009 09:58:04 -0700 (PDT)
Received: from ?192.168.1.104? ([219.246.59.144])
        by mx.google.com with ESMTPS id m28sm2025212waf.37.2009.06.06.09.58.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 09:58:03 -0700 (PDT)
Subject: Re: [PATCH-v2] Hibernation Support in mips system
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Yan Hua <yanh@lemote.com>, Zhang Fuxin <zhangfx@lemote.com>,
	Pavel Machek <pavel@ucw.cz>, Hu Hongbing <huhb@lemote.com>
In-Reply-To: <20090606152315.GA16785@adriano.hkcable.com.hk>
References: <9c9bc070f3c272c41254304537e9dec398245b94.1244118419.git.wuzj@lemote.com>
	 <20090606152315.GA16785@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sun, 07 Jun 2009 00:57:52 +0800
Message-Id: <1244307472.3864.1.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

Hi, 

Applied :-)

thanks!
Wu Zhangjin

On Sat, 2009-06-06 at 23:23 +0800, Zhang Le wrote:
> On 20:27 Thu 04 Jun     , wuzhangjin@gmail.com wrote:
> 
> [snip]
> 
> > +++ b/arch/mips/power/cpu.c
> > @@ -0,0 +1,43 @@
> > +/*
> > + * Suspend support specific for mips.
> 
> Sorry for nitpicking, but here "specific" could be omitted.
> 
> > + *
> > + * Distribute under GPLv2
> 
> Distributed
> 
> ...
> [snip]
> ...
> 
> > +++ b/arch/mips/power/hibernate.S
> > @@ -0,0 +1,70 @@
> > +/*
> > + * Hibernation support specific for mips - temporary page tables
> 
> Same here
> 
> > + *
> > + * Distribute under GPLv2
> 
> And here
> 
