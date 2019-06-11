Return-Path: <SRS0=t3CX=UK=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB449C31E45
	for <linux-mips@archiver.kernel.org>; Tue, 11 Jun 2019 21:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2C302086A
	for <linux-mips@archiver.kernel.org>; Tue, 11 Jun 2019 21:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560287358;
	bh=qmpEoNXO99XPF9xd/5iv2nDwyZYxG+9HqzTYNPT4KTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xdolk+RNifQ08ocBf5TruJKj9j0qcCoPkjOjBUxS36V6HlEPVLf5NVjO8qygGEwLj
	 fZ4ZGTO2+l/Zb4dpc8NhPR033AXcX2viblxEFHPys7etrBy7nF2MZmNPDGgHf+gPJ7
	 yi7kkMfonNzC5tR9FjJB2eILCSh1CSjdOmRhYioA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407520AbfFKVJK (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 11 Jun 2019 17:09:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406960AbfFKVJK (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Tue, 11 Jun 2019 17:09:10 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 542412080A;
        Tue, 11 Jun 2019 21:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560287348;
        bh=qmpEoNXO99XPF9xd/5iv2nDwyZYxG+9HqzTYNPT4KTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EzYSNQ5VopjCkhJxjwzVG+3NUfKcn1X9cU/Ns4PV5yZIsnow5MRHYB73/Tl3T81K/
         SbRRApw7C7MWKpiNZqE5wCHVmQlPPOHtSxjsrM3RebqPsIl/mcOR/W6a0jpkC0UwOz
         rSPkBbLzTQO7F5VSs5bcQHmoWK/bst5kRMcBgC7c=
Date:   Tue, 11 Jun 2019 14:09:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Shyam Saini <shyam.saini@amarulasolutions.com>,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        keescook@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        netdev@vger.kernel.org, linux-ext4 <linux-ext4@vger.kernel.org>,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-sctp@vger.kernel.org, bpf@vger.kernel.org,
        kvm@vger.kernel.org, mayhs11saini@gmail.com,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH V2] include: linux: Regularise the use of FIELD_SIZEOF
 macro
Message-Id: <20190611140907.899bebb12a3d731da24a9ad1@linux-foundation.org>
In-Reply-To: <6DCAE4F8-3BEC-45F2-A733-F4D15850B7F3@dilger.ca>
References: <20190611193836.2772-1-shyam.saini@amarulasolutions.com>
        <20190611134831.a60c11f4b691d14d04a87e29@linux-foundation.org>
        <6DCAE4F8-3BEC-45F2-A733-F4D15850B7F3@dilger.ca>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, 11 Jun 2019 15:00:10 -0600 Andreas Dilger <adilger@dilger.ca> wrote:

> >> to FIELD_SIZEOF
> > 
> > As Alexey has pointed out, C structs and unions don't have fields -
> > they have members.  So this is an opportunity to switch everything to
> > a new member_sizeof().
> > 
> > What do people think of that and how does this impact the patch footprint?
> 
> I did a check, and FIELD_SIZEOF() is used about 350x, while sizeof_field()
> is about 30x, and SIZEOF_FIELD() is only about 5x.

Erk.  Sorry, I should have grepped.

> That said, I'm much more in favour of "sizeof_field()" or "sizeof_member()"
> than FIELD_SIZEOF().  Not only does that better match "offsetof()", with
> which it is closely related, but is also closer to the original "sizeof()".
> 
> Since this is a rather trivial change, it can be split into a number of
> patches to get approval/landing via subsystem maintainers, and there is no
> huge urgency to remove the original macros until the users are gone.  It
> would make sense to remove SIZEOF_FIELD() and sizeof_field() quickly so
> they don't gain more users, and the remaining FIELD_SIZEOF() users can be
> whittled away as the patches come through the maintainer trees.

In that case I'd say let's live with FIELD_SIZEOF() and remove
sizeof_field() and SIZEOF_FIELD().

I'm a bit surprised that the FIELD_SIZEOF() definition ends up in
stddef.h rather than in kernel.h where such things are normally
defined.  Why is that?

