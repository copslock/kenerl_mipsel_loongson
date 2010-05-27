Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 May 2010 18:37:52 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52096 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492153Ab0E0Qht (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 May 2010 18:37:49 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o4RGbje5010010;
        Thu, 27 May 2010 17:37:46 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o4RGbiJi010009;
        Thu, 27 May 2010 17:37:45 +0100
Date:   Thu, 27 May 2010 17:37:44 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangjin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Oprofile: Loongson: Fixup of loongson2_exit()
Message-ID: <20100527163744.GA5263@linux-mips.org>
References: <1273165429-29766-1-git-send-email-wuzhangjin@gmail.com>
 <1274759510.10746.3.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1274759510.10746.3.camel@localhost>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 25, 2010 at 11:51:50AM +0800, Wu Zhangjin wrote:

> Seems you have accepted this patch but forgot to apply it, could you
> please apply it, thanks ;)

Ah, sorry.  This one did conflict with the other patches resulting in
some fuzz when applying it so my patch-o-matic automatically dropped it.
It's in for real now.

  Ralf
