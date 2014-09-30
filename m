Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Sep 2014 18:28:11 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:34128 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006150AbaI3Q2IIsknj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Sep 2014 18:28:08 +0200
Date:   Tue, 30 Sep 2014 17:28:08 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Thibaut Robert <thibaut.robert@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tc: fix warning and coding style
In-Reply-To: <1412079396-26005-1-git-send-email-thibaut.robert@gmail.com>
Message-ID: <alpine.LFD.2.11.1409301720050.21156@eddie.linux-mips.org>
References: <1412079396-26005-1-git-send-email-thibaut.robert@gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42902
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

On Tue, 30 Sep 2014, Thibaut Robert wrote:

> Fix checkpatch warnings:
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> WARNING: Possible unnecessary 'out of memory' message
> WARNING: quoted string split across lines
> WARNING: Use #include <linux/io.h> instead of <asm/io.h>
> 
> Fix gcc warning:
> warning: format ¡%d¢ expects argument of type ¡int¢, but argument 4 has type ¡resource_size_t¢ [-Wformat=]
> 
> As resource_size_t can be 32 or 64 bits (depending on CONFIG_RESOURCES_64BIT), this patch uses "%lld" format along with a cast to u64 for printing resource_size_t values
> 
> Signed-off-by: Thibaut Robert <thibaut.robert@gmail.com>
> ---

 NAK.  These issues have already been taken care of via the LMO tree; the
original change has been archived here:

http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=alpine.LFD.2.11.1404062030280.15266%40eddie.linux-mips.org

and is on the way to Linus's tree (IIUC; Ralf, please acknowledge).

 If you think there's anything wrong still left afterwards, except from 
the message wrapping (as I'm not going to approve any modification to go 
beyond 79 columns; this is nonsense), then please send an incremental 
change on top of that.

 Thanks for your contribution anyway.

  Maciej
