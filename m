Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jun 2009 13:22:58 +0100 (WEST)
Received: from mail-pz0-f202.google.com ([209.85.222.202]:38089 "EHLO
	mail-pz0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022539AbZFDMWw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 4 Jun 2009 13:22:52 +0100
Received: by pzk40 with SMTP id 40so720987pzk.22
        for <multiple recipients>; Thu, 04 Jun 2009 05:22:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=523EWA0viAsZK0AzIKbpvhbO0vJgWnkt6YQYcTsA5As=;
        b=t0nTRq3LrazpRKZS7uK1qyae/ctJAAiK0Pbo2gcadh5WnxwpzYPv5TfPJDfjEDHT8C
         u1n4G29CuxENwGbol1GULd/bAUXwzgwJf+ISQiMSqPEXJhi3lukQv3t6bCXQ8s7Qgerp
         2Slc+qdVUZuYSvl+HsgkgLze2TqXsTd/iO/VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=IWkAH1Phw50Xn9c889/PJYqKfnmZJLO9tUta68KuF8m5+7ch4wa3rDBWYM6vSlsrtQ
         LWmEQ4rlg+Q534WcA14DOub0+MvV25GA3JDXTBrTMuCzwDJ89RVoaBaE60ytN15f1vLq
         hDS0xsgv8FFdliwDPpRLLQ7uIfxufrMJ9urlA=
Received: by 10.115.60.2 with SMTP id n2mr3386056wak.36.1244118165421;
        Thu, 04 Jun 2009 05:22:45 -0700 (PDT)
Received: from ?192.168.2.239? ([202.201.14.140])
        by mx.google.com with ESMTPS id l27sm10862576waf.20.2009.06.04.05.22.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 05:22:44 -0700 (PDT)
Subject: Re: [PATCH-v1] Hibernation Support in mips system
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Pavel Machek <pavel@ucw.cz>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Yan Hua <yanh@lemote.com>, Zhang Fuxin <zhangfx@lemote.com>,
	Hu Hongbing <huhb@lemote.com>
In-Reply-To: <20090604120549.GD22897@elf.ucw.cz>
References: <6b7278ff10d7c4f9d819792de8742f65147c6855.1244038584.git.wuzj@lemote.com>
	 <20090604120549.GD22897@elf.ucw.cz>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 04 Jun 2009 20:22:31 +0800
Message-Id: <1244118151.32116.0.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23240
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-06-04 at 14:05 +0200, Pavel Machek wrote:
> Hi!
> 
> > @@ -0,0 +1,41 @@
> > +/*
> > + * Suspend support specific for mips.
> > + *
> > + * Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
> > + * Author: Hu Hongbing <huhb@lemote.com>
> > + *         Wu Zhangjin <wuzj@lemote.com>
> > + */
> 
> I guess GPL notice there would be nice...
> 

sorry, forget it, will add later :-)

thanks!
Wu Zhangjin
