Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Sep 2014 02:53:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52456 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007843AbaI2AxIkGvei (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Sep 2014 02:53:08 +0200
Date:   Mon, 29 Sep 2014 01:53:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Isamu Mogi <isamu@leafytree.jp>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: R3000: Fix debug output for Virtual page number
In-Reply-To: <1410278429-8541-1-git-send-email-isamu@leafytree.jp>
Message-ID: <alpine.LFD.2.11.1409290145370.21156@eddie.linux-mips.org>
References: <1410278429-8541-1-git-send-email-isamu@leafytree.jp>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 10 Sep 2014, Isamu Mogi wrote:

> Virtual page number of R3000 in entryhi is 20 bit from MSB. But in
> dump_tlb(), the bit mask to read it from entryhi is 19 bit (0xffffe000).
> The patch fixes that to 0xfffff000.
> 
> Signed-off-by: Isamu Mogi <isamu@leafytree.jp>

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

 It would be good to add appropriate macros to <asm/mipsregs.h> too, to 
avoid magic numbers and decrease the likelihood of issues like this.  As a 
separate change, that is, of course, and not a prerequisite.

  Maciej
