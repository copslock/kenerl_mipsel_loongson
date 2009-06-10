Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 13:37:57 +0100 (WEST)
Received: from wa-out-1112.google.com ([209.85.146.176]:39867 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20023016AbZFJMhu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Jun 2009 13:37:50 +0100
Received: by wa-out-1112.google.com with SMTP id n4so145149wag.0
        for <multiple recipients>; Wed, 10 Jun 2009 05:37:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=d4xbBwYDZNDuUhNOJRkFXGPeJFGnL2xq/teK4YXECAI=;
        b=AeetyCwvexaXEgckWgDmtaQPQhfwiwrXyTbjOXe7gkovINOJ87X9pKgtG4iblDqKZE
         o8jLemnv260Y4umYfCSv0G0FSTtfcj12WHIhL8K2EH6w/hl3k4pGBKL5qGo+LxLps/dS
         FNZw6vdQWW9uIhwnTw1pM2Bto6LI9Us8wegKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=O4SJXJj0TnuFeVX3nOamvHIHUKeYJl3jSa4h7bFaIbdgAzk8cCeLg0NnHs29scwy7o
         PzPgA7Y6ehc/2dFNNU3tAbadm3bqqeHZY74vWVEIvV1zj7pCsS7x02J/vv72nZjPHviP
         lmUmYmunvVXcstEUKfKwwf1YQ6rOjucXe4rm0=
Received: by 10.114.67.17 with SMTP id p17mr1957508waa.203.1244637465463;
        Wed, 10 Jun 2009 05:37:45 -0700 (PDT)
Received: from ?192.168.1.101? ([219.246.59.144])
        by mx.google.com with ESMTPS id l37sm8947687waf.5.2009.06.10.05.37.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Jun 2009 05:37:44 -0700 (PDT)
Subject: Re: [loongson-PATCH-v3 15/25] add basic yeeloong(2f) laptop support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Zhang Le <r0bertz@gentoo.org>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
In-Reply-To: <20090609172314.GB1287@adriano.hkcable.com.hk>
References: <cover.1244120575.git.wuzj@lemote.com>
	 <438a70c6864380344960719a0a2fe0f32de9ff45.1244120575.git.wuzj@lemote.com>
	 <20090609172314.GB1287@adriano.hkcable.com.hk>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Wed, 10 Jun 2009 20:37:26 +0800
Message-Id: <1244637446.28989.0.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, 2009-06-10 at 01:23 +0800, Zhang Le wrote:
> On 21:07 Thu 04 Jun     , wuzhangjin@gmail.com wrote:
> > diff --git a/arch/mips/loongson/common/cmdline.c b/arch/mips/loongson/common/cmdline.c
> > index 12bb606..c7b6eb1 100644
> > --- a/arch/mips/loongson/common/cmdline.c
> > +++ b/arch/mips/loongson/common/cmdline.c
> > @@ -19,6 +19,8 @@
> >   */
> >  
> >  #include <asm/bootinfo.h>
> > +#include <loongson.h>
> > +#include <cmdline.h>
> 
> duplicated #include's.

Acked.

thx!
Wu Zhangjin
> >  
> >  #include <loongson.h>
> >  #include <cmdline.h>
> 
> 
