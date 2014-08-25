Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 15:20:58 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:52428 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006724AbaHYNU5B4sOm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 15:20:57 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PDKrTD029925;
        Mon, 25 Aug 2014 15:20:53 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PDKpQR029919;
        Mon, 25 Aug 2014 15:20:51 +0200
Date:   Mon, 25 Aug 2014 15:20:50 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jayachandran C <jchandra@broadcom.com>
Cc:     linux-mips@linux-mips.org, chenhc@lemote.com,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/2] MIPS: Netlogic: Use MIPS topology.h
Message-ID: <20140825132050.GH27724@linux-mips.org>
References: <CAAhV-H7x3FDAXYcH6J8mDeBnrgV1CZZtizerjHRa4cj_oZ1PuQ@mail.gmail.com>
 <1408681112-26744-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408681112-26744-1-git-send-email-jchandra@broadcom.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42221
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

On Fri, Aug 22, 2014 at 09:48:31AM +0530, Jayachandran C wrote:

> commit bda4584cd943 ("MIPS: Support CPU topology files in sysfs")
> added topology related macros for all MIPS platforms. This causes
> compile failure for Netlogic platforms with errors like:
> 
> arch/mips/include/asm/mach-netlogic/topology.h:14:0: error: "topology_physical_package_id" redefined [-Werror]
> 
> Fix this by dropping Netlogic specific topology.h and setting up package
> field in cpu data.

I've already applied Guenter Roeck's patch
https://patchwork.linux-mips.org/patch/7513/ as commit
bbbf6d8768f5cac3523c408917083a111b1f3ffe [MIPS: Netlogic: Use MIPS
topology.h] and the pull request for that one is out to Linus.

So if you think your solution is nicer, please send a followup patch,

> Signed-off-by: Jayachandran C <jchandra@broadcom.com>
> ---
> [Resending this, looks like linux-mips.org is down]

Ironically the announcement of the new system also got affected by the
email woes and only went out after resending it ...  By now things should
be all back to normal and I can't believe how much faster some operations
such as git push have become!

  Ralf
