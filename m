Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Aug 2011 14:06:33 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46797 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491046Ab1HCMG3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Aug 2011 14:06:29 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p73C6R18003223;
        Wed, 3 Aug 2011 13:06:28 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p73C6RhS003222;
        Wed, 3 Aug 2011 13:06:27 +0100
Date:   Wed, 3 Aug 2011 13:06:27 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 12/15] MMC: au1xmmc: remove Alchemy CPU subtype
 dependencies
Message-ID: <20110803120627.GA856@linux-mips.org>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
 <1312307470-6841-13-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1312307470-6841-13-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2278

On Tue, Aug 02, 2011 at 07:51:07PM +0200, Manuel Lauss wrote:

> Replace all occurrences of CONFIG_SOC_AU1??? with runtime feature
> detection.
> 
> Cc: <linux-mmc@vger.kernel.org>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> I'd like for this patch to go in via the mips tree since a few more depend
> on it.

Patch is looking ok.  Since MMC is orphaned I've just queued it and it
will go to linux-next after -rc1.

  Ralf
