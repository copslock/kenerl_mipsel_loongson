Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Apr 2010 18:36:01 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:57552 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492757Ab0D2Qf6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Apr 2010 18:35:58 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o3TGZvWC027550;
        Thu, 29 Apr 2010 17:35:57 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o3TGZv4g027548;
        Thu, 29 Apr 2010 17:35:57 +0100
Date:   Thu, 29 Apr 2010 17:35:57 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Arnaud Patard <apatard@mandriva.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] arch/mips/loongson/common/mem.c: fix
 phys_mem_access_prot() check
Message-ID: <20100429163557.GD25765@linux-mips.org>
References: <m3vdbawpeu.fsf@anduin.mandriva.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3vdbawpeu.fsf@anduin.mandriva.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 29, 2010 at 11:58:49AM +0200, Arnaud Patard wrote:

> The check used to determine if uncached accelerated should be used or
> not is wrong. The parenthesis are misplaced and making the test fail.
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

Thanks, applied.

  Ralf
