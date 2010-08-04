Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Aug 2010 17:24:33 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41513 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492874Ab0HDPY1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Aug 2010 17:24:27 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o74FNjOd019110;
        Wed, 4 Aug 2010 16:23:46 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o74FNhGf019108;
        Wed, 4 Aug 2010 16:23:43 +0100
Date:   Wed, 4 Aug 2010 16:23:42 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Mundt <lethal@linux-sh.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Shilimkar, Santosh" <santosh.shilimkar@ti.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-mips@linux-mips.org
Subject: Re: Additional fix : (was [v2]printk: fix delayed messages from CPU
 hotplug events)
Message-ID: <20100804152342.GC21004@linux-mips.org>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C5DB6D1F@dbde02.ent.ti.com>
 <20100802154434.5615bcf9.akpm@linux-foundation.org>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C641D8EC@dbde02.ent.ti.com>
 <20100803165926.2e37d355.akpm@linux-foundation.org>
 <20100804033034.GA15098@linux-sh.org>
 <20100804135145.GA21004@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100804135145.GA21004@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Santosh's patch was lacking akpm's cleanup patch.  So I created the
following from all contributions.

  Ralf
