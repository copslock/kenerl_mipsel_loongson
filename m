Return-Path: <SRS0=VxEc=R4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B38CC43381
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 17:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20C120823
	for <linux-mips@archiver.kernel.org>; Mon, 25 Mar 2019 17:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mcakECUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfCYRvx (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:51:53 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:40627 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfCYRvx (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 25 Mar 2019 13:51:53 -0400
Received: by mail-qk1-f179.google.com with SMTP id w20so5876868qka.7
        for <linux-mips@vger.kernel.org>; Mon, 25 Mar 2019 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=00Ms6NJY8XZVY3PTifw/DWKACkhTufevyM9oDDMnZ98=;
        b=mcakECUMzfnWJTjHKTgjHkQ3p5HiWz1AVOeK/ghfgih69htVJO9HDrS54A121ygzVY
         gWLEZMejpsvVFhPFvHwICPJEGrqNyF2/qZcA0NNQdr9DSe7lhxSeAsy3AlI8/ilXz0Wy
         iMjTD05URcYKbnMgowRxCxL/DBUygVp3Sma1XI81k+r9M7o2AAzJzmYJzZpoi21aczm0
         eJeHxiLWuI7hbyS8S+/ZQ0NvTbpWGm3bLAR63L4Lfuo8GetXjU127prX/mYb1aNddl8p
         PasZzEsnYa7YcrBr5PZX7TvDDfzStRfR4EBtHmAXdccRPyo5CD2MDBXpy7Y6pvzdL9FQ
         Mskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=00Ms6NJY8XZVY3PTifw/DWKACkhTufevyM9oDDMnZ98=;
        b=H5P4MrR1aT0g91lFoTPrpVVWRgqtk+0Q/8jd1t5QVggGZPhvpF4lMg3s2sTXqP2TBB
         tciAGHQ2v4rsgiDmpt+ysV4sDHc/9B8fe7Vcp7plTJWVaaGIC0nPJi4W24euNCM45r6L
         r5vAe8lmo7p8+MiOQ3vNvs9xetV9A/Cx1sWcP4RjnajhW5aZ/BBPzZtERYLTho7uzrjv
         jWMWd3qNyc8OcW9o1PL/1q5Jc6KsxzhBXRvpHx58njZknIBZuBT4qVznjxcuadD607mu
         2E8yXj1cMQ1KlLtB+DRDaCrBM/9g2+3JUPRWAAn4IF/E2P6Pf/RE20/ET2pJcTwgsnyb
         dJpg==
X-Gm-Message-State: APjAAAWCsmvYAhddncImdpVHsoI5pVUeYGun9lW92K2COVfHaHaSJSAh
        7041+LqDapOFe4wtgg+hkMsvqg==
X-Google-Smtp-Source: APXvYqyPXE4H1Qt/wLb7MTNtAAHDbeoOG7ue4zLWhXEM5KYve0v2wSXPQ09LZ4L0EFTQCEmHdQgrlA==
X-Received: by 2002:a37:7d86:: with SMTP id y128mr20700103qkc.36.1553536312325;
        Mon, 25 Mar 2019 10:51:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id 56sm5277027qto.57.2019.03.25.10.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 10:51:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h8TlG-0005vR-FG; Mon, 25 Mar 2019 14:51:50 -0300
Date:   Mon, 25 Mar 2019 14:51:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
Message-ID: <20190325175150.GA21008@ziepe.ca>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-5-ira.weiny@intel.com>
 <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
 <20190325084225.GC16366@iweiny-DESK2.sc.intel.com>
 <20190325164713.GC9949@ziepe.ca>
 <20190325092314.GF16366@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325092314.GF16366@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Mon, Mar 25, 2019 at 02:23:15AM -0700, Ira Weiny wrote:
> > > Unfortunately holding the lock is required to support FOLL_LONGTERM (to check
> > > the VMAs) but we don't want to hold the lock to be optimal (specifically allow
> > > FAULT_FOLL_ALLOW_RETRY).  So I'm maintaining the optimization for *_fast users
> > > who do not specify FOLL_LONGTERM.
> > > 
> > > Another way to do this would have been to define __gup_longterm_unlocked with
> > > the above logic, but that seemed overkill at this point.
> > 
> > get_user_pages_unlocked() is an exported symbol, shouldn't it work
> > with the FOLL_LONGTERM flag?
> > 
> > I think it should even though we have no user..
> > 
> > Otherwise the GUP API just gets more confusing.
> 
> I agree WRT to the API.  But I think callers of get_user_pages_unlocked() are
> not going to get the behavior they want if they specify FOLL_LONGTERM.

Oh? Isn't the only thing FOLL_LONGTERM does is block the call on DAX?
Why does the locking mode matter to this test?

> What I could do is BUG_ON (or just WARN_ON) if unlocked is called with
> FOLL_LONGTERM similar to the code in get_user_pages_locked() which does not
> allow locked and vmas to be passed together:

The GUP call should fail if you are doing something like this. But I'd
rather not see confusing specialc cases in code without a clear
comment explaining why it has to be there.

Jason
