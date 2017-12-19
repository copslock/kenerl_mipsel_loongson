Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2017 17:07:50 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:41722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994634AbdLSQHi5dbtY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2017 17:07:38 +0100
Received: from localhost (unknown [38.140.131.194])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CFD3A13EB8E26;
        Tue, 19 Dec 2017 08:07:32 -0800 (PST)
Date:   Tue, 19 Dec 2017 11:07:31 -0500 (EST)
Message-Id: <20171219.110731.419425553753960805.davem@davemloft.net>
To:     jonas.gorski@gmail.com
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        ralf@linux-mips.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 0/4] bcm63xx_enet: remove mac_id usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20171217160255.30342-1-jonas.gorski@gmail.com>
References: <20171217160255.30342-1-jonas.gorski@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 19 Dec 2017 08:07:33 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61518
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

From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 17 Dec 2017 17:02:51 +0100

> This patchset aims at reducing the platform device id number usage with
> the target of making it eventually possible to probe the driver through OF.
> 
> Runtested on BCM6358.
> 
> Since the patches touch mostly net/, they should go through net-next.

Series applied, thank you.
