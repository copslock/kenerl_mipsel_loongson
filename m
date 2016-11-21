Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2016 18:35:13 +0100 (CET)
Received: from h1.direct-netware.de ([5.45.107.14]:53295 "EHLO
        h1.direct-netware.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993005AbcKURfGpO6MF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2016 18:35:06 +0100
Received: from odin.home.local (p54B048AB.dip0.t-ipconnect.de [84.176.72.171])
        by h1.direct-netware.de (Postfix) with ESMTPA id 5227FFF8BC;
        Mon, 21 Nov 2016 18:35:06 +0100 (CET)
Received: from loki.localnet (unknown [172.16.255.1])
        by odin.home.local (Postfix) with ESMTPSA id 6A42862CE8E;
        Mon, 21 Nov 2016 18:35:05 +0100 (CET)
From:   Tobias Wolf <dev-NTEO@vplace.de>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] of: Add check to of_scan_flat_dt() before accessing initial_boot_params
Date:   Mon, 21 Nov 2016 18:35:04 +0100
Message-ID: <3905333.BFAR4jakeZ@loki>
User-Agent: KMail/5.3.3 (Linux/4.8.8-2-ARCH; KDE/5.28.0; x86_64; ; )
In-Reply-To: <a13d095d-cdc9-8deb-82e2-f19b15748a4a@cogentembedded.com>
References: <3700342.djbc9u0nWG@loki> <2281020.GC1GkRyGht@loki> <a13d095d-cdc9-8deb-82e2-f19b15748a4a@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Return-Path: <dev-NTEO@vplace.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dev-NTEO@vplace.de
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

Am Montag, 21. November 2016, 20:21:03 CET schrieb Sergei Shtylyov:
> On 11/21/2016 07:23 PM, Tobias Wolf wrote:
>    CC      drivers/of/fdt.o
> drivers/of/fdt.c: In function ‘of_scan_flat_dt’:
> drivers/of/fdt.c:738:3: warning: ‘return’ with no value, in function
> returning non-void [-Wreturn-type]
> drivers/of/fdt.c:740:2: warning: ISO C90 forbids mixed declarations and code
> [-Wdeclaration-after-statement]
> 
> MBR, Sergei

Dear Sergei,

Thanks for that note. In fact it returns whatever it provides. Question is, 
what would be the right value.

int offset, rc = 0, depth = -1;

rc defaults to 0 but something like EINVAL would better reflect that something 
is wrong.

Best regards
Tobias
