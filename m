Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 23:32:00 +0100 (CET)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:48214 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903807Ab1KUWbv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 23:31:51 +0100
Received: by ghbg15 with SMTP id g15so3878626ghb.36
        for <linux-mips@linux-mips.org>; Mon, 21 Nov 2011 14:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=8PdB5rYWIslJ88xd13YVYkAw2r7mcpbzgzfggJv29YA=;
        b=XI4qTLRDuf6YIn+ZFyx27e3hBpzN+Ew4NlXIedU7VSWsNHoTit2EJHqk1lV0QZwJ/6
         ZYRrsOPh1/Ble9wJ+ApQ==
Received: by 10.236.73.166 with SMTP id v26mr23190809yhd.100.1321914704831;
        Mon, 21 Nov 2011 14:31:44 -0800 (PST)
Received: by 10.236.73.166 with SMTP id v26mr23190762yhd.100.1321914704404;
        Mon, 21 Nov 2011 14:31:44 -0800 (PST)
Received: from [2620:0:1008:1201:be30:5bff:fed8:5e64] ([2620:0:1008:1201:be30:5bff:fed8:5e64])
        by mx.google.com with ESMTPS id h20sm16286712yhj.18.2011.11.21.14.31.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 14:31:43 -0800 (PST)
Date:   Mon, 21 Nov 2011 14:31:41 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Hillf Danton <dhillf@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] mips, mm: avoid using HPAGE constants without
 CONFIG_HUGETLB_PAGE
In-Reply-To: <4ECAA5B8.3080908@gmail.com>
Message-ID: <alpine.DEB.2.00.1111211430480.5318@chino.kir.corp.google.com>
References: <alpine.DEB.2.00.1111191855410.5457@chino.kir.corp.google.com> <CAJd=RBBmODwpUi1_eObE47yCQVfEGLHyy45=aqUtxM-9Bpki6A@mail.gmail.com> <4ECAA5B8.3080908@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-archive-position: 31901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rientjes@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17951

On Mon, 21 Nov 2011, David Daney wrote:

> > --- a/arch/mips/include/asm/page.h	Sun Nov 20 13:08:44 2011
> > +++ b/arch/mips/include/asm/page.h	Sun Nov 20 13:17:43 2011
> > @@ -38,6 +38,11 @@
> >   #define HPAGE_SIZE	(_AC(1,UL)<<  HPAGE_SHIFT)
> >   #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
> >   #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
> > +#else
> > +#define HPAGE_SHIFT	({ BUG(); 0; })
> > +#define HPAGE_SIZE	({ BUG(); 0; })
> > +#define HPAGE_MASK	({ BUG(); 0; })
> 
> These three are taken care of in linux/hugetlb.h by the patches that Andrew
> Morton has in his tree, the full discussion starts at:
> 
> http://www.linux-mips.org/archives/linux-mips/2011-11/msg00412.html
> 

Those patches were removed since Linus picked up my patch instead, so I 
think you'll want the patch I'm proposing here.
