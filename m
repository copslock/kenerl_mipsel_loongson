Return-Path: <SRS0=rurz=RB=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA26C43381
	for <linux-mips@archiver.kernel.org>; Tue, 26 Feb 2019 09:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE57213A2
	for <linux-mips@archiver.kernel.org>; Tue, 26 Feb 2019 09:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bofh-nu.20150623.gappssmtp.com header.i=@bofh-nu.20150623.gappssmtp.com header.b="Qd/810rI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfBZJqa (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:46:30 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39487 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727367AbfBZJqa (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 26 Feb 2019 04:46:30 -0500
Received: by mail-oi1-f195.google.com with SMTP id b4so9819274oif.6
        for <linux-mips@vger.kernel.org>; Tue, 26 Feb 2019 01:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bofh-nu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thpd36PDMXlf2G7WnhbmXGo66cBy7Bf++yJWkTn0nmw=;
        b=Qd/810rIbHZVnn/POX0r7Em7HLJy3zwba5Ohwnh53Y4rfT8lNrK39nxsEiPbwQ5z/I
         OAySi7W+31UstzKmlYrpgN9aQGi2Ff1sym79XC9ntc2Zn2reUe6pCOJGoJElcwAL68nU
         bvPwQta3TOcib/542rhHpxwloTVke418JGfEP6Vmyr472U7ir03NT0YlZnp3pCl6dW/R
         mYzIYcTRDO0TT5nXnNx9ARnLeHYSBaqCofGJnmm417D+mjsfVmf0fQlO/bFkJ0lTGcV7
         p2rJ7Qj00svxyjMr/5XQg7BwYqw+WbFumwhSP7lUiboJvd17OeVe26VEjMBLHrNAKG5i
         y7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thpd36PDMXlf2G7WnhbmXGo66cBy7Bf++yJWkTn0nmw=;
        b=Dv95mcMwYwtq1Gbv3c6073UTqe4Ror95Z7o0JngCI18RJ8BzvRkjUTUISbEFwe6gTK
         coryP+t3lF9LKAUL2JubpDiWnkHkH491+vtzMe/aFP7C7SxGs8C7IO2l/zRAcqTcV/4r
         MCgtbSVn4MY3gX0uOkcffDDWK6MbpuO+9nF4bd9pF0CYQzCI3lJGSZouE6mL6aWFunxZ
         j5und84o/1/eXeXfPgJHyhOVUxGCe+SKKIiORIOqpocF8mwyz1Y2VAowfsR6//rBE+tc
         me6lvCW9+xUXr6gOVXx3C2cyRtGY0uUu9MSemJdNsZlTN7A9WbyShtnj92v68DfoYcfV
         FVJQ==
X-Gm-Message-State: AHQUAuZoy65PSWC1HAH9dH5XFKjxKvZXP/glPSOjSGACIkuTYceZN6ho
        TME7silUQwmfPNuzfnGMP+s463RqNELTYo0DAxiatg==
X-Google-Smtp-Source: AHgI3IaMjF3tt02j/rMrAij/98lIAHBujBXjVnoKtLZvAXMu5xj1vob58lRLeDdRoVNjv2zPT6KCzj166JHhuKyuR70=
X-Received: by 2002:aca:3a0b:: with SMTP id h11mr1823500oia.97.1551174389008;
 Tue, 26 Feb 2019 01:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20190219123212.29838-1-larper@axis.com> <6d12d244-85be-52c4-c3bc-75d077a9c0ee@arm.com>
In-Reply-To: <6d12d244-85be-52c4-c3bc-75d077a9c0ee@arm.com>
From:   Lars Persson <lists@bofh.nu>
Date:   Tue, 26 Feb 2019 10:46:18 +0100
Message-ID: <CADnJP=tOJbFR2hq_P+PvR0dxsrr6HR6iE5BMybEx_3zWjV4+Ng@mail.gmail.com>
Subject: Re: [PATCH] mm: migrate: add missing flush_dcache_page for non-mapped
 page migrate
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Lars Persson <lars.persson@axis.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Lars Persson <larper@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, Feb 26, 2019 at 10:23 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
> On 02/19/2019 06:02 PM, Lars Persson wrote:
> > Our MIPS 1004Kc SoCs were seeing random userspace crashes with SIGILL
> > and SIGSEGV that could not be traced back to a userspace code
> > bug. They had all the magic signs of an I/D cache coherency issue.
> >
> > Now recently we noticed that the /proc/sys/vm/compact_memory interface
> > was quite efficient at provoking this class of userspace crashes.
> >
> > Studying the code in mm/migrate.c there is a distinction made between
> > migrating a page that is mapped at the instant of migration and one
> > that is not mapped. Our problem turned out to be the non-mapped pages.
> >
> > For the non-mapped page the code performs a copy of the page content
> > and all relevant meta-data of the page without doing the required
> > D-cache maintenance. This leaves dirty data in the D-cache of the CPU
> > and on the 1004K cores this data is not visible to the I-cache. A
> > subsequent page-fault that triggers a mapping of the page will happily
> > serve the process with potentially stale code.
>
> Just curious. Is not the code path which tries to map this page should
> do the invalidation just before setting it up in the page table via
> set_pte_at() or other similar variants ? How it maps without doing the
> necessary flush.

In fact this is what happens when the flush_dcache_page API was used
correctly, but it is an arch implementation detail. All kernel code
that writes to a page cage page must also call flush_dcache_page
before the page becomes eligible for mapping. The arch code has the
option to postpone the actual flush until set_pte_at maps the page.
