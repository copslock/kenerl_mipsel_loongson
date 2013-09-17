Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 18:13:30 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46996 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824764Ab3IQQN2TksFd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 18:13:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8HGDR2t001575;
        Tue, 17 Sep 2013 18:13:27 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8HGDR5i001574;
        Tue, 17 Sep 2013 18:13:27 +0200
Date:   Tue, 17 Sep 2013 18:13:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] MIPS: DECstation I/O ASIC DMA interrupt handling fix
Message-ID: <20130917161327.GG22468@linux-mips.org>
References: <alpine.LFD.2.03.1309171613160.5967@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309171613160.5967@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37835
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

On Tue, Sep 17, 2013 at 04:40:39PM +0100, Maciej W. Rozycki wrote:

>  I see you have applied the original change after all; I'd prefer it to be 
> dropped to avoid cluttering the history, but please let me know if you 
> need an incremental change instead.

The first patch is already upstream in 3.12-rc1, so I will need an
incremental patch.

Thanks,

  Ralf
