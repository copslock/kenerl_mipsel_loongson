Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2011 16:01:09 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:58922 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903980Ab1KKPBF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 11 Nov 2011 16:01:05 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pABF12bQ023347;
        Fri, 11 Nov 2011 15:01:03 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pABF12l9023346;
        Fri, 11 Nov 2011 15:01:02 GMT
Date:   Fri, 11 Nov 2011 15:01:02 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH V2] MIPS: Alchemy: pci: fix build: missing export.h
Message-ID: <20111111150101.GA22942@linux-mips.org>
References: <20111110180624.GA30108@linux-mips.org>
 <1320951179-25780-1-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320951179-25780-1-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31562
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 10342

On Thu, Nov 10, 2011 at 07:52:59PM +0100, Manuel Lauss wrote:

> fixes:
> pci-alchemy.c:487:12: error: 'THIS_MODULE' undeclared here [...]
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> V2: export.h instead of module.h

Already fixed by:

commit 91ffb85340c7994219ded8781376ae8d2d9d9c37
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Thu Nov 10 14:15:57 2011 +0000

    MIPS: Fix build errors due to missing inclusion of <linux/export.h>.
    
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>


Thanks anyway!

  Ralf
