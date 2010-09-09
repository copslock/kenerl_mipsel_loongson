Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Sep 2010 20:35:22 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:45556 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491085Ab0IISfT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Sep 2010 20:35:19 +0200
Received: by vws11 with SMTP id 11so1770886vws.36
        for <multiple recipients>; Thu, 09 Sep 2010 11:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=9prrGczyq+hxuazqWX0xVbLVJcrXgVvnjO4mjef1lU8=;
        b=A0ylXPQl48iKyKfR9L0dyoueiOnqX8od4GtqG8LK4pSWdsqHlpxGWLxhNjz1DWVzm/
         T4EoHI61fcWIfWcXkLyDijYlAz513h+v8PcqDUC55mYUl/WCzQ+MGd5wCb87Tix5/WcN
         Xd9lwsiqDZM3VCdHiZBbxl0ECbEoGNZXcKw+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ZX+T85pV0V2A4qDPVndjlV4qmY8yjK9AjQb83nExhhdE1WyyzFI8rZy8oI/kNNF6CH
         TenCgAQrUNlM1jbsgNYvkB2DtnvSM5+2+wqDAuSGI+xu4UhCmjzf172Rd08kPIaqDavf
         7zcYtz9u072am5hzeUuKZlL4X/osaVEANA/6g=
MIME-Version: 1.0
Received: by 10.220.127.93 with SMTP id f29mr24056vcs.127.1284057308333; Thu,
 09 Sep 2010 11:35:08 -0700 (PDT)
Received: by 10.220.114.141 with HTTP; Thu, 9 Sep 2010 11:35:08 -0700 (PDT)
In-Reply-To: <20100909173426.GA14371@alpha.franken.de>
References: <064bb0722da5d8c271c2bd9fe0a521cc@localhost>
        <99a0868bdbcfa8785a92b4af4f6d9b99@localhost>
        <4C8914E8.5030002@caviumnetworks.com>
        <20100909173426.GA14371@alpha.franken.de>
Date:   Thu, 9 Sep 2010 11:35:08 -0700
Message-ID: <AANLkTikXd9Hf6nX2X0CSi__t5nm60XFcWLAgFtJ+sZZh@mail.gmail.com>
Subject: Re: [PATCH 3/3] MIPS: DMA: Add plat_extra_sync_for_cpu()
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 27741
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 7468

On Thu, Sep 9, 2010 at 10:34 AM, Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
> looks like this is doing what the non_coherent_r10000 case does. So IMHO

My code is not currently in the tree, but I have 3 different hooks for
3 different processor types.  The generic __dma_sync() workaround used
on R10K is not sufficient.

> either which make non_coheren check more generic or could use the new
> plat_sync thingie for IP28 and other non coherent r10k boxes.

That is a good idea.  One thing I'd like to do is continue sharing the
same R10K code for IP27 / IP28 / IP32 / SNI_RM, and move all of it out
of dma-default.c .  Do you have any suggestions on how to define the
plat_* handlers on a per-cpu-type basis instead of making 4 identical
copies of the R10K workaround?
