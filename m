Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Sep 2014 18:02:44 +0200 (CEST)
Received: from shards.monkeyblade.net ([149.20.54.216]:49401 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009620AbaIWQCmXNE4m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Sep 2014 18:02:42 +0200
Received: from localhost (cpe-67-247-12-89.nyc.res.rr.com [67.247.12.89])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2047558402D;
        Tue, 23 Sep 2014 09:02:39 -0700 (PDT)
Date:   Tue, 23 Sep 2014 12:02:37 -0400 (EDT)
Message-Id: <20140923.120237.1788295912902036193.davem@davemloft.net>
To:     mmarek@suse.cz
Cc:     sfr@canb.auug.org.au, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/5] mips: Set CONFIG_NET=y in defconfigs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1411487044-14071-1-git-send-email-mmarek@suse.cz>
References: <54218AEF.5090200@suse.cz>
        <1411487044-14071-1-git-send-email-mmarek@suse.cz>
X-Mailer: Mew version 6.6 on Emacs 24.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.7 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Sep 2014 09:02:39 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: Michal Marek <mmarek@suse.cz>
Date: Tue, 23 Sep 2014 17:44:00 +0200

> Commit 5d6be6a5 ("scsi_netlink : Make SCSI_NETLINK dependent on NET
> instead of selecting NET") removed what happened to be the only instance
> of 'select NET'. Defconfigs that were relying on the select now lack
> networking support.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Michal Marek <mmarek@suse.cz>

On the contrary, since NET was being selected for them indirectly
previously, weren't they depending instead upon NET being enabled?

Likewise for SCSI_NETLINK, SCSI_FC_ATTRS, and whatever was triggering
the select upon them?

I'll remember this as yet another why 'select' is to be avoided at
just about all costs.
