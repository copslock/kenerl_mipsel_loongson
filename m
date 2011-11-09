Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2011 15:56:03 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41547 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1904251Ab1KIOz5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Nov 2011 15:55:57 +0100
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id pA9EtuMP020138;
        Wed, 9 Nov 2011 14:55:56 GMT
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id pA9Ettr2020136;
        Wed, 9 Nov 2011 14:55:55 GMT
Date:   Wed, 9 Nov 2011 14:55:55 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Samuel Ortiz <samuel@sortiz.org>, netdev@vger.kernel.org
Subject: Re: [PATCH 16/18] net/irda: convert au1k_ir to platform driver.
Message-ID: <20111109145555.GP19187@linux-mips.org>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
 <1320174224-27305-17-git-send-email-manuel.lauss@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1320174224-27305-17-git-send-email-manuel.lauss@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 31471
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 7781

On Tue, Nov 01, 2011 at 08:03:42PM +0100, Manuel Lauss wrote:

> Moderate driver cleanup:
> convert to platform driver, get rid of board-specific code.
> 
> Driver loads and runs on a DB1100 board.  But since I have no other
> IrDA hardware to exchange data with I can't say whether it really sends
> and receives.
> 
> Cc: Samuel Ortiz <samuel@sortiz.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> I'd like for this to go in via the MIPS tree since other mips patches depend
> on it.

No (n)acks or comments received so queued for 3.3.  Thanks,

  Ralf
