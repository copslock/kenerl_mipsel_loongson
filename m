Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 20:47:10 +0100 (CET)
Received: from ms.lwn.net ([45.79.88.28]:38698 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994838AbeBATrEZ2HrC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 20:47:04 +0100
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 83B8F133D;
        Thu,  1 Feb 2018 19:46:58 +0000 (UTC)
Date:   Thu, 1 Feb 2018 12:46:57 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     ralf@linux-mips.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Documentation: mips: Update AU1xxx_IDE Kconfig
 dependencies
Message-ID: <20180201124657.5f9b3090@lwn.net>
In-Reply-To: <1517228467-1444-1-git-send-email-clabbe@baylibre.com>
References: <1517228467-1444-1-git-send-email-clabbe@baylibre.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-Path: <corbet@lwn.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62405
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: corbet@lwn.net
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

On Mon, 29 Jan 2018 12:21:07 +0000
Corentin Labbe <clabbe@baylibre.com> wrote:

> IDEDMA_AUTO IDEDMA_PCI_AUTO was removed in commit 120b9cfddff2 ("ide: remove CONFIG_IDEDMA_{ICS,PCI}_AUTO config")
> BLK_DEV_IDEDISK was removed in commit 806f80a6fc20 ("ide: add generic ATA/ATAPI disk driver")
> BLK_DEV_IDE_AU1XXX_BURSTABLE_ON was removed in commit 8f29e650bffc ("ide: AU1200 IDE update")
> Remove them from documentation

Applied to the docs tree, thanks.

jon
