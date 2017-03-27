Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Mar 2017 15:10:32 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34000 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993868AbdC0NKYvMkwp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Mar 2017 15:10:24 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2RDAOvG023197;
        Mon, 27 Mar 2017 15:10:24 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2RDAOcm023196;
        Mon, 27 Mar 2017 15:10:24 +0200
Date:   Mon, 27 Mar 2017 15:10:24 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Mathias Kresin <dev@kresin.me>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v3] MIPS: PCI: add controllers before the specified head
Message-ID: <20170327131024.GB5734@linux-mips.org>
References: <1490547936-21871-1-git-send-email-dev@kresin.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490547936-21871-1-git-send-email-dev@kresin.me>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57452
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On Sun, Mar 26, 2017 at 07:05:36PM +0200, Mathias Kresin wrote:

> 
> With commit 23dac14d058f ("MIPS: PCI: Use struct list_head lists") new
> controllers are added after the specified head where they where added
> before the specified head previously.
> 
> Use list_add_tail to restore the former order.
> 
> This patches fixes the following PCI error on lantiq:
> 
>   pci 0000:01:00.0: BAR 0: error updating (0x1c000004 != 0x000000)
> 
> Fixes: 23dac14d058f ("MIPS: PCI: Use struct list_head lists")
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Thanks Mathias, will apply.

Had I replied earlier, I would have requested the change you did yourself
in v3.  It seems to me the more logic solution and also closer to the
code before Paul's 23dac14d058f changed it.

I'm going to take care of Sergei's nit also, no need to resend.

  Ralf
