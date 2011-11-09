Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 15:54:58 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41539 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904255Ab1KIOyj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 15:54:39 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9EsbkO019993;
        Wed, 9 Nov 2011 14:54:37 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9EsbEw019992;
        Wed, 9 Nov 2011 14:54:37 GMT
Date:   Wed, 9 Nov 2011 14:54:37 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 14/18] MTD: nand: make au1550nd.c a platform_driver
Message-ID: <20111109145437.GN19187@linux-mips.org>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
 <1320174224-27305-15-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320174224-27305-15-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7778

On Tue, Nov 01, 2011 at 08:03:40PM +0100, Manuel Lauss wrote:

> Transform the au1550nd.c driver into a platform_driver and hook it
> up in the PB1550 board (gen_nand works fine on the DB1550, but since
> I don't have a PB1550 to test this driver stays for now).
> 
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> Tested on the DB1550 as well.
> I'd like for this to go in via the MIPS tree if at all possible.

No (n)acks or comments received, so queued for 3.3.  Thanks,

  Ralf
