Return-Path: <SRS0=Ffnl=UN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF42C31E44
	for <linux-mips@archiver.kernel.org>; Fri, 14 Jun 2019 07:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2F32084E
	for <linux-mips@archiver.kernel.org>; Fri, 14 Jun 2019 07:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFNHt6 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Fri, 14 Jun 2019 03:49:58 -0400
Received: from verein.lst.de ([213.95.11.211]:44900 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfFNHt6 (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Fri, 14 Jun 2019 03:49:58 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 9112068B02; Fri, 14 Jun 2019 09:49:28 +0200 (CEST)
Date:   Fri, 14 Jun 2019 09:49:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: remove asm-generic/ptrace.h v2
Message-ID: <20190614074928.GA9631@lst.de>
References: <20190520060018.25569-1-hch@lst.de> <20190604070205.GA15438@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604070205.GA15438@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, Jun 04, 2019 at 09:02:05AM +0200, Christoph Hellwig wrote:
> Is anyone going to pick this series up?

ping?  Arnd, this might be asm-generic tree material?
