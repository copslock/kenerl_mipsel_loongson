Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Feb 2010 15:58:38 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49024 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492387Ab0BQO6e (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 17 Feb 2010 15:58:34 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o1HEwSv9031069;
        Wed, 17 Feb 2010 15:58:28 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o1HEwA5N031058;
        Wed, 17 Feb 2010 15:58:10 +0100
Date:   Wed, 17 Feb 2010 15:58:09 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH -queue] MIPS/net: fix au1000_eth.c build and warnings
Message-ID: <20100217145809.GK1561@linux-mips.org>
References: <1266263017-6874-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1266263017-6874-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 15, 2010 at 08:43:37PM +0100, Manuel Lauss wrote:

> - buildfix: DECLARE_MAC_BUF was removed recently.
> - remove various warnings spit out during build
> 
> Only compile-tested.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Hi Ralf!  Please fold this into the patch titled
> "NET: au1000-eth: convert to platform_driver model"
> in mips-queue, thank you!

Done - but as this is a net patch it should have been cc'ed to netdev /
DaveM as well ...

  Ralf
