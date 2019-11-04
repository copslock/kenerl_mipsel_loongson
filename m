Return-Path: <SRS0=n3Oa=Y4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82321CA9EB5
	for <linux-mips@archiver.kernel.org>; Mon,  4 Nov 2019 18:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C38920B7C
	for <linux-mips@archiver.kernel.org>; Mon,  4 Nov 2019 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572893275;
	bh=THSchQwCqh5CSld25jEYgvJW4XoVKFqlo26SITCOteE=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=V+LjJh1LT3nhAZjFNtCgHzBdMp670cMzxBZbe21Ej0PqL2e7cd2T6mY5hRvNXdb3A
	 5iV40JmLSOkDSx3g7alFOJgqj0wuZLBvTuBN43OIa1GTxZBX9ZtonY5WQWJ7t5d17X
	 DI9VunnhcWa50obNeDLjd9xUFPUxLHhweq7dD1qQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfKDSrz (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:47:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37432 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfKDSry (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 4 Nov 2019 13:47:54 -0500
Received: by mail-pl1-f193.google.com with SMTP id p13so8011075pll.4
        for <linux-mips@vger.kernel.org>; Mon, 04 Nov 2019 10:47:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=UHuFjpI0KEeOc2U650+9PRUfkNCjcdtU8/U3DUHczFo=;
        b=ZO5Pn0K8jJ9QnA7Vus7O2VFd5WfuH7/W6G4DyJCnmFi/p27roY4me6/yGDnXVBuAQh
         SF3wfqTC/3nSwT48NiZVmnPjOM1OpD+dqqSiNKTP8oFth9ekGtWCwqKIXbOMuOLI0PDk
         tBCtDvnEcCuUeFDxfcfvK97OvdRZctNYvO8HbIwJC6Sf8LxA7SU8orQxsxFeOknp0cuL
         Vup1nq+3ihBQwHO9/uZLZZN7l7qfOQ5dkx98a+Ttq5kVVFgHSBcuavXw4WCEvPYDcIru
         RKBzi8Zb6H3EEyvm7YSf71aBG2ca8MwpT+Rd7+FNDQuDHH6/hCh5UKnCwTAqtYUSdK9A
         j1Yg==
X-Gm-Message-State: APjAAAWXhupYVcY7clhqPNUTAop1IaW43xxTBBVu8hSWeUINiazEZHWM
        dWyFh5Ex85MDKW32o5PVUn8=
X-Google-Smtp-Source: APXvYqz+b6NJJPZMbk4itJjgVPJBuT0NP8ea027FqR8MweTRNPiZ/lbT2/9A22yQD+SKVWv0bcgaOA==
X-Received: by 2002:a17:902:8bc2:: with SMTP id r2mr29215626plo.36.1572893273673;
        Mon, 04 Nov 2019 10:47:53 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id y4sm789222pgy.27.2019.11.04.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:47:52 -0800 (PST)
Message-ID: <5dc07258.1c69fb81.d6eef.303c@mx.google.com>
Date:   Mon, 04 Nov 2019 10:47:52 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     linux-mips@linux-mips.org
CC:     bcm-kernel-feedback-list@broadcom.com, cernekee@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove Kevin as maintainer of BMIPS generic  platforms
References:  <20191018171651.12582-1-f.fainelli@gmail.com>
In-Reply-To:  <20191018171651.12582-1-f.fainelli@gmail.com>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hello,

Florian Fainelli wrote:
> The last time Kevin did a review was sometime around 2014,
> since then, he has not been active for the BMIPS generic platform
> changes.
> 
> Following the position of other maintainers and Harald Welte's position
> here:
> 
> [1] http://laforge.gnumonks.org/blog/20180307-mchardy-gpl/
> 
> remove him from the list of maintainers.

Applied to mips-fixes.

> commit f6929c92e283
> https://git.kernel.org/mips/c/f6929c92e283
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> [paulburton@kernel.org:
>   Drop the non-technical commit message content; Kevin's absence from
>   the role is ample reasoning for this change.]
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
