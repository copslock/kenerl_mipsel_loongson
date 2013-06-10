Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 17:54:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:45064 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835080Ab3FJPyBVfOks (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 17:54:01 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5AFrxG6011650;
        Mon, 10 Jun 2013 17:53:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5AFrxVG011649;
        Mon, 10 Jun 2013 17:53:59 +0200
Date:   Mon, 10 Jun 2013 17:53:59 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH v3] MIPS: Alchemy: fix wait function
Message-ID: <20130610155359.GC5303@linux-mips.org>
References: <1370722541-25407-1-git-send-email-manuel.lauss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370722541-25407-1-git-send-email-manuel.lauss@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36806
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

On Sat, Jun 08, 2013 at 10:15:41PM +0200, Manuel Lauss wrote:

> Only an interrupt can wake the core from 'wait', enable interrupts
> locally before executing 'wait'.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> v3: add constraint for additional register used, as per Maciej's feedback
> v2: enable interrupts immediately before executing 'wait', to minimize chance
>     of interrupts occurring.

Applied, primarily because time is running away and it's more important to
get Alchemy back to at least limping along happily ...

  Ralf
