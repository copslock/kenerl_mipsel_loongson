Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Dec 2009 15:26:58 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44395 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492643AbZLAO0y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Dec 2009 15:26:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nB1ERBv4021322;
        Tue, 1 Dec 2009 14:27:11 GMT
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nB1ERAZu021320;
        Tue, 1 Dec 2009 14:27:10 GMT
Date:   Tue, 1 Dec 2009 14:27:10 +0000
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Wu Zhangin <wuzhangjin@gmail.com>
Cc:     linux-mips@linux-mips.org, zhangfx@lemote.com,
        lm-sensors@lm-sensors.org
Subject: Re: [PATCH v6 5/8] Loongson: YeeLoong: add hwmon driver
Message-ID: <20091201142710.GE14064@linux-mips.org>
References: <cover.1259664573.git.wuzhangjin@gmail.com>
 <3973cc1fdb6ff2b2e540ed93ae92dac8d7b2a38f.1259664573.git.wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3973cc1fdb6ff2b2e540ed93ae92dac8d7b2a38f.1259664573.git.wuzhangjin@gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25244
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Dec 01, 2009 at 07:09:59PM +0800, Wu Zhangin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> This patch adds hwmon driver for managing the temperature of battery,
> cpu and controlling the fan.

And this one should now go to drivers/hwmon and become a platform driver
as well.

  Ralf
