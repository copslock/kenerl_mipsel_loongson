Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Jan 2016 20:25:37 +0100 (CET)
Received: from smtp.codeaurora.org ([198.145.29.96]:58477 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011253AbcASTZe1nIrb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Jan 2016 20:25:34 +0100
Received: from smtp.codeaurora.org (localhost [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 959FE60630;
        Tue, 19 Jan 2016 19:25:32 +0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 820CA60266; Tue, 19 Jan 2016 19:25:32 +0000 (UTC)
Received: from potku.adurom.net (a88-115-185-251.elisa-laajakaista.fi [88.115.185.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D387660266;
        Tue, 19 Jan 2016 19:25:29 +0000 (UTC)
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: ssb: Set linux-wireless as MAINTAINERS list
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20160118175303.19164539@wiggum>
To:     =?utf-8?q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips\@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Message-Id: <20160119192532.820CA60266@smtp.codeaurora.org>
Date:   Tue, 19 Jan 2016 19:25:32 +0000 (UTC)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <kvalo@codeaurora.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kvalo@codeaurora.org
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


> ssb patches go through the linux-wireless tree.
> Set the list to linux-wireless, so linux-wireless patchwork can catch the patches.
> 
> Signed-off-by: Michael Buesch <m@bues.ch>

Thanks, applied to wireless-drivers.git.

Kalle Valo
