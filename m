Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 19:56:02 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44055 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904273Ab1KISz6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 19:55:58 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9Itv1s012377;
        Wed, 9 Nov 2011 18:55:57 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9Ituq4012376;
        Wed, 9 Nov 2011 18:55:56 GMT
Date:   Wed, 9 Nov 2011 18:55:56 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Alchemy: db1100: fix build: missing module.h
Message-ID: <20111109185556.GC4816@linux-mips.org>
References: <20111109145325.GL19187@linux-mips.org>
 <1320863955-14609-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320863955-14609-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8052

On Wed, Nov 09, 2011 at 07:39:15PM +0100, Manuel Lauss wrote:

> fix build against 3.2-rc1, add a missing module.h (symbol_get/symbol_put).
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> Please fold into "[PATCH 12/18] MIPS: Alchemy: MMC for DB1100".

Done, but:

patching file arch/mips/alchemy/devboards/db1000.c
Hunk #1 succeeded at 25 with fuzz 1.

As with every use of symbol_get I wonder if this is not a case of doing
something the very wrong way.

  Ralf
