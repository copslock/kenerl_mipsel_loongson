Return-Path: <SRS0=Rn8T=QP=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE33C169C4
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 22:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A3321841
	for <linux-mips@archiver.kernel.org>; Fri,  8 Feb 2019 22:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfBHW5u (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:57:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBHW5u (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Fri, 8 Feb 2019 17:57:50 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4CC28C9E1;
        Fri,  8 Feb 2019 22:57:49 +0000 (UTC)
Date:   Fri, 8 Feb 2019 14:57:48 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "dbueso@suse.de" <dbueso@suse.de>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: + mips-c-r4k-do-no-use-mmap_sem-for-gup_fast.patch added to -mm
 tree
Message-Id: <20190208145748.5c701cd01095f1cdf3a6cbb6@linux-foundation.org>
In-Reply-To: <20190208055708.sxlvcfyjayiwrozc@pburton-laptop>
References: <20190208054407.gjyKBBYUS%akpm@linux-foundation.org>
        <20190208055708.sxlvcfyjayiwrozc@pburton-laptop>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Fri, 8 Feb 2019 05:57:10 +0000 Paul Burton <paul.burton@mips.com> wrote:

> Whilst I don't object to you merging this too strongly, I thought I'd
> point out again that as I already replied to Davidlohr [1] the code
> being changed here is unused in mainline & all affected stable branches.
> In mips-next it's entirely removed. As such this patch will have no
> effect on the kernel's behaviour & cause a minor conflict with
> mips-next.

Is OK, I'll discover such things when mips-next updates with linux-next
and I'll quietly drop the offending patch.

