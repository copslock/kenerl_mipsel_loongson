Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Aug 2011 20:11:10 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58612 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491200Ab1HBSLH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Aug 2011 20:11:07 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p72IB4DJ003598;
        Tue, 2 Aug 2011 19:11:04 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p72IB4tL003597;
        Tue, 2 Aug 2011 19:11:04 +0100
Date:   Tue, 2 Aug 2011 19:11:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 03/15] MIPS: Alchemy: include Au1100 in PM code.
Message-ID: <20110802181104.GA2842@linux-mips.org>
References: <1312307470-6841-1-git-send-email-manuel.lauss@googlemail.com>
 <1312307470-6841-4-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1312307470-6841-4-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 30813
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 1642

On Tue, Aug 02, 2011 at 07:50:58PM +0200, Manuel Lauss wrote:

> The current code forgets the Au1100 when looking for the
> correct method to suspend the chip.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>

Applied.  Thanks!

  Ralf
