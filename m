Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 16:40:38 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:40474 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492598AbZLAPkf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 16:40:35 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1Fepqc023955;
        Tue, 1 Dec 2009 15:40:51 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1FeovF023953;
        Tue, 1 Dec 2009 15:40:50 GMT
Date:   Tue, 1 Dec 2009 15:40:50 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 8/8] Loongson: YeeLoong: add hotkey driver
Message-ID: <20091201154050.GJ14064@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
 <939c1425f653e3bda05799345c53198dfd2c1dcc.1259664573.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <939c1425f653e3bda05799345c53198dfd2c1dcc.1259664573.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 07:12:37PM +0800, Wu Zhangin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds Hotkey Driver, which will do relative actions for The
> hotkey event and report the corresponding input keys to the user-space
> applications.

This one also should become a platform driver.  And is probably a
candidate for drivers/input/keyboard.

  Ralf
