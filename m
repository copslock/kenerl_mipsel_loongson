Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Feb 2018 16:31:29 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:48030 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992828AbeBRPbWFBBtl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Feb 2018 16:31:22 +0100
Received: from localhost (pool-173-77-163-229.nycmny.fios.verizon.net [173.77.163.229])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 252F0101AF694;
        Sun, 18 Feb 2018 07:31:17 -0800 (PST)
Date:   Sun, 18 Feb 2018 10:31:12 -0500 (EST)
Message-Id: <20180218.103112.1461192916516173265.davem@davemloft.net>
To:     paul.burton@mips.com
Cc:     netdev@vger.kernel.org, hassan.naveed@mips.com,
        matt.redfearn@mips.com, linux-mips@linux-mips.org
Subject: Re: [PATCH v5 00/14] net: pch_gbe: Fixes & MIPS support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180217201037.3006-1-paul.burton@mips.com>
References: <20180217201037.3006-1-paul.burton@mips.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 18 Feb 2018 07:31:17 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62610
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


Nobody is going to see and apply these patches if you don't CC: the
Linux networking development list, netdev@vger.kernel.org

Thank you.
