Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 May 2014 10:17:44 +0200 (CEST)
Received: from mail.lemote.com ([222.92.8.138]:54963 "EHLO mail.lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816409AbaERIRk5izQe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 18 May 2014 10:17:40 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.lemote.com (Postfix) with ESMTP id 24B5F22DE5;
        Sun, 18 May 2014 16:17:32 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from mail.lemote.com ([127.0.0.1])
        by localhost (mail.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JtitkIikyf5v; Sun, 18 May 2014 16:17:18 +0800 (CST)
Received: from software.domain.org (unknown [222.92.8.142])
        (Authenticated sender: chenj@lemote.com)
        by mail.lemote.com (Postfix) with ESMTPA id 069BF22AA0;
        Sun, 18 May 2014 16:17:18 +0800 (CST)
From:   chenj <chenj@lemote.com>
To:     linux-mips@linux-mips.org, paul.burton@imgtec.com
Cc:     chenhc@lemote.com
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
Date:   Sun, 18 May 2014 16:23:29 +0800
Message-Id: <1400401410-32600-1-git-send-email-chenj@lemote.com>
X-Mailer: git-send-email 1.9.0
Return-Path: <chenj@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
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

[PATCH] MIPS: Loongson 3: Select CPU_MIPS64_R2

To chenhc: Please review this.
