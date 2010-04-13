Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Apr 2010 00:02:09 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:60721 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492753Ab0DMWCG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Apr 2010 00:02:06 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3DM22te024650;
        Tue, 13 Apr 2010 23:02:02 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3DM21bs024649;
        Tue, 13 Apr 2010 23:02:01 +0100
Date:   Tue, 13 Apr 2010 23:02:00 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Loongson: update cpu-feature-overrides.h
Message-ID: <20100413220200.GA24077@linux-mips.org>
References: <1271135794-19762-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1271135794-19762-1-git-send-email-wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 13, 2010 at 01:16:34PM +0800, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Loongson doesn't support MIPSR2, therefore, MIPSR2 vectored interrupts
> (cpu_has_vint) and MIPSR2 external interrupt controller mode
> (cpu_has_veic) are 0.
> 
> Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>

Thanks Wu, queued for 2.6.35!

  Ralf
