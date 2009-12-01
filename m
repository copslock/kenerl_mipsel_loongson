Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 15:20:18 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46600 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492486AbZLAOUP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 15:20:15 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1EKS95021096;
        Tue, 1 Dec 2009 14:20:28 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1EKSbP021093;
        Tue, 1 Dec 2009 14:20:28 GMT
Date:   Tue, 1 Dec 2009 14:20:28 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Stephen Rothwell <sfr@linuxcare.com>
Subject: Re: [PATCH v6 4/8] Loongson: YeeLoong: add battery driver
Message-ID: <20091201142028.GD14064@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
 <6a81bc182b684f94ebcffc562ee98fa7db759826.1259664573.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a81bc182b684f94ebcffc562ee98fa7db759826.1259664573.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 07:09:19PM +0800, Wu Zhangin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds APM_EMULATION based Battery Driver, which provides
> standard interface for user-space applications to manage the battery.

This one as well is a candidate to become a platform driver.

  Ralf
