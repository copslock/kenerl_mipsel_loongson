Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 19:51:40 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:39164 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993405AbcLGSvdgSl8I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2016 19:51:33 +0100
Received: from localhost (unknown [38.140.131.194])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id ACBF612D8EB53;
        Wed,  7 Dec 2016 09:52:06 -0800 (PST)
Date:   Wed, 07 Dec 2016 13:51:27 -0500 (EST)
Message-Id: <20161207.135127.789629809982860453.davem@davemloft.net>
To:     dave.taht@gmail.com
Cc:     Jason@zx2c4.com, netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, wireguard@lists.zx2c4.com
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAA93jw7hcmkcyD=t4VRrQFfHk+n+EkSVgY6KFDq0_-DGpMADYw@mail.gmail.com>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
        <CAA93jw7hcmkcyD=t4VRrQFfHk+n+EkSVgY6KFDq0_-DGpMADYw@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 07 Dec 2016 09:52:07 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55960
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

From: Dave Taht <dave.taht@gmail.com>
Date: Wed, 7 Dec 2016 10:47:16 -0800

> https://git.lede-project.org/?p=openwrt/source.git;a=blob;f=target/linux/ar71xx/patches-4.4/910-unaligned_access_hacks.patch;h=b4b749e4b9c02a74a9f712a2740d63e554de5c64;hb=ee53a240ac902dc83209008a2671e7fdcf55957a

It's so much better to analyze properly where the misalignment comes from
and address it at the source, as we have for various cases that trip up
Sparc too.

Marking structures "packed" is going to kill performance and is not
the answer.
