Return-Path: <SRS0=e5Bu=VN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64817C7618F
	for <linux-mips@archiver.kernel.org>; Tue, 16 Jul 2019 18:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF3920665
	for <linux-mips@archiver.kernel.org>; Tue, 16 Jul 2019 18:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fLx81Axc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfGPS4E (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:56:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43761 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbfGPS4A (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 16 Jul 2019 14:56:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so22065603wru.10
        for <linux-mips@vger.kernel.org>; Tue, 16 Jul 2019 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HII1jGmOqJ+ZHDKFI1WGLRVkv6rLuJXcbXOQGuTO2qs=;
        b=fLx81Axc7fZXcKYyn4FdWmT0VEDGlHROQXan6kCDS1lBwXYOSOZICuwNpupEPxZ1KA
         wYSXFaoVOjGfUCkS+d8cHlAhu3M2pxovWkqnQFOwALA9QBVmnRkxZxo8H9luuiBMYElW
         teY5CswjSiHPAphop6UNge3b8FVvFOdl6ZPhV/lGeX4EdVgwNRrnGQgmpMB8qwN4h6Vz
         CUQTMLSjShRSEkdrxPF+i2v0KnEMWmD2NuZDGJaVq93w9O/93sXEJ13J+BUqFv+mqIR0
         a2nSPFa0W7ZgTdiFK5BAgfXI4EwftEfi8ScyprvmIm71SEiMx2Gq30N3zYyTNzblFVBj
         IDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HII1jGmOqJ+ZHDKFI1WGLRVkv6rLuJXcbXOQGuTO2qs=;
        b=K9O8k3+PNG1rXW0msQEtbVkY5cw6lSXvNaywYT3lT2MCI+2Ae8MjBa4pSapmpjrqi9
         hc9mCOx4TSI164OixtLfYlpZJVJurxmabtSPaExRJaG54Lsv9VeJfqSq3ndS0mNKNKG9
         KZvRzsWQcTYPM/TUzyUucfnlsZ6dDVjznVBhN3+0Tq5PZFp+aPK5Fw9P9aU2Lo5Yn2Oz
         Rk/kc7olb3giW4CFPUs0Pw7wIrlJjYx+zIG+PuUCYiNCr0o5MufWl7jKeiGSb0Alg5od
         6NRpUuoe4QwZbg9t2LbJvlB+FFYQwsMFV9D6GcVbMRvER9W9X39NQ4jeL2yFPZfk5eY/
         al7g==
X-Gm-Message-State: APjAAAVvWf0KbdQLWeqxf0W+l6lxC+gMGcYOqIfKtkr6Iq1633rGnfvU
        xsqu1/boNnHJw35If+veBAk=
X-Google-Smtp-Source: APXvYqxjOiZ+/ZmqnAl0iYfzzo4MAVdDizISydYdFT08PVtYYgV0sowV+fqLU0s1PX6fcTCrkIj0Fw==
X-Received: by 2002:adf:f8cf:: with SMTP id f15mr36779432wrq.333.1563303357931;
        Tue, 16 Jul 2019 11:55:57 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id j33sm48044545wre.42.2019.07.16.11.55.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:55:57 -0700 (PDT)
Date:   Tue, 16 Jul 2019 20:55:55 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>, mpe@ellerman.id.au
Subject: Re: [PATCH 1/2] arch: mark syscall number 435 reserved for clone3
Message-ID: <20190716185554.gwpppirvmxgvnkgb@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
 <20190714192205.27190-2-christian@brauner.io>
 <e14eb2f9-43cb-0b9d-dec4-b7e7dcd62091@de.ibm.com>
 <20190716130631.tohj4ub54md25dys@brauner.io>
 <20190716185310.GA12537@t470p.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190716185310.GA12537@t470p.stackframe.org>
User-Agent: NeoMutt/20180716
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, Jul 16, 2019 at 08:53:10PM +0200, Sven Schnelle wrote:
> Hi,
> 
> [Adding Helge to CC list]
> 
> On Tue, Jul 16, 2019 at 03:06:33PM +0200, Christian Brauner wrote:
> > On Mon, Jul 15, 2019 at 03:56:04PM +0200, Christian Borntraeger wrote:
> > > I think Vasily already has a clone3 patch for s390x with 435. 
> > 
> > A quick follow-up on this. Helge and Michael have asked whether there
> > are any tests for clone3. Yes, there will be and I try to have them
> > ready by the end of the this or next week for review. In the meantime I
> > hope the following minimalistic test program that just verifies very
> > very basic functionality (It's not pretty.) will help you test:
> > [..]
> 
> On PA-RISC this seems to work fine with Helge's patch to wire up the
> clone3 syscall.

I think I already responded to Helge before and yes, I think that parisc
doesn't do anything special for fork, vfork, clone, and by extension
also probably doesn't need to for clone3.
It should only be a problem for arches that require mucking explicitly
with arguments of clone-like syscalls.
In any case, I saw Helge's patch and I think I might've missed to add an
Acked-by but feel free to add it.

Thanks for testing it and sorry that I couldn't test!
Christian
