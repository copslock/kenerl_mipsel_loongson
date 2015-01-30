Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 10:25:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:48633 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011107AbbA3JZOfeZuf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 10:25:14 +0100
Date:   Fri, 30 Jan 2015 09:25:14 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] MIPS: fix kernel lockup or crash after CPU
 offline/online
In-Reply-To: <1421355719-17576-2-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <alpine.LFD.2.11.1501300347170.28301@eddie.linux-mips.org>
References: <1421355719-17576-1-git-send-email-aaro.koskinen@iki.fi> <1421355719-17576-2-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45556
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

On Thu, 15 Jan 2015, Aaro Koskinen wrote:

> As printk() invocation can cause e.g. a TLB miss, printk() cannot be
> called before the exception handlers have been properly initialized.
> This can happen e.g. when netconsole has been loaded as a kernel module
> and the TLB table has been cleared when a CPU was offline.

 Hmm, why can a call to `printk' cause a TLB miss, what's so special about 
this function?  Does it use kernel mapped addresses for any purpose such 
as `vmalloc'?

  Maciej
