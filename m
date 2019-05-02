Return-Path: <SRS0=hTb5=TC=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25439C43219
	for <linux-mips@archiver.kernel.org>; Thu,  2 May 2019 14:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E98206DF
	for <linux-mips@archiver.kernel.org>; Thu,  2 May 2019 14:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfEBOBf (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 2 May 2019 10:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBOBf (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Thu, 2 May 2019 10:01:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CC2A9307EA9F;
        Thu,  2 May 2019 14:01:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id DE7E57D3E6;
        Thu,  2 May 2019 14:01:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  2 May 2019 16:01:27 +0200 (CEST)
Date:   Thu, 2 May 2019 16:01:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: remove asm-generic/ptrace.h
Message-ID: <20190502140122.GC7323@redhat.com>
References: <20190501173943.5688-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501173943.5688-1-hch@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 02 May 2019 14:01:34 +0000 (UTC)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On 05/01, Christoph Hellwig wrote:
>
> Hi all,
>
> asm-generic/ptrace.h is a little weird in that it doesn't actually
> implement any functionality, but it provided multiple layers of macros
> that just implement trivial inline functions.  We implement those
> directly in the few architectures and be off with a much simpler
> design.

Oh, thanks, I was always confused by these macros ;)

Oleg.

