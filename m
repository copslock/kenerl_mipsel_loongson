Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 19:48:57 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44024 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904273Ab1KISsx (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 19:48:53 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9Imo5p011236;
        Wed, 9 Nov 2011 18:48:50 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9Imntm011228;
        Wed, 9 Nov 2011 18:48:49 GMT
Date:   Wed, 9 Nov 2011 18:48:49 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Alchemy: db1300: fix build: missing module.h
Message-ID: <20111109184849.GB4816@linux-mips.org>
References: <20111109145015.GE19187@linux-mips.org>
 <1320863926-6168-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320863926-6168-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 8045

On Wed, Nov 09, 2011 at 07:38:46PM +0100, Manuel Lauss wrote:

> add module.h to fix build (symbol_get/symbol_put) against 3.2-rc1
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> Please fold into "[PATCH 05/18] Basic support for the DB1300 board."

Done.

  Ralf
