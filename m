Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 17:06:41 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:53527 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491165Ab0E0PGg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 May 2010 17:06:36 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4RF6WlZ005180;
        Thu, 27 May 2010 16:06:32 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4RF6VrK005179;
        Thu, 27 May 2010 16:06:31 +0100
Date:   Thu, 27 May 2010 16:06:30 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH RESEND] MIPS: Alchemy: sleepcode without compile-time
 cputype dependencies
Message-ID: <20100527150630.GA4027@linux-mips.org>
References: <1274722972-19123-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1274722972-19123-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, May 24, 2010 at 07:42:52PM +0200, Manuel Lauss wrote:

> Split the low-level sleepcode into per-cpu functions instead of
> relying on compile-time-defined cpu type.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> This patch didn't make it to 2.6.35 so I'm resending it.

Sorry, seems I or my patch-o-matic scripts somehow dropped
http://patchwork.linux-mips.org/patch/1038/ on the ground.  That patch
was supposed to be applied.  Anyway, I marked the old patch as superseeded
and I'm applying this one now.

  Ralf
