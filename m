Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Sep 2018 07:09:19 +0200 (CEST)
Received: from shards.monkeyblade.net ([IPv6:2620:137:e000::1:9]:48194 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993030AbeIDFJOrMzEN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Sep 2018 07:09:14 +0200
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0917312139FE8;
        Mon,  3 Sep 2018 22:09:10 -0700 (PDT)
Date:   Mon, 03 Sep 2018 22:09:10 -0700 (PDT)
Message-Id: <20180903.220910.899357653888940454.davem@davemloft.net>
To:     alexandre.belloni@bootlin.com
Cc:     andrew@lunn.ch, quentin.schulz@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kishon@ti.com, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v2 00/11] mscc: ocelot: add support for SerDes muxing
 configuration
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180903134522.GC13888@piout.net>
References: <20180903093308.24366-1-quentin.schulz@bootlin.com>
        <20180903133415.GF4445@lunn.ch>
        <20180903134522.GC13888@piout.net>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Sep 2018 22:09:11 -0700 (PDT)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65921
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

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Mon, 3 Sep 2018 15:45:22 +0200

> On 03/09/2018 15:34:15+0200, Andrew Lunn wrote:
>> > I suggest patches 1 and 8 go through MIPS tree, 2 to 5 and 11 go through
>> > net while the others (6, 7, 9 and 10) go through the generic PHY subsystem.
>> 
>> Hi Quentin
>> 
>> Are you expecting merge conflicts? If not, it might be simpler to gets
>> ACKs from each maintainer, and then merge it though one tree.
>> 
> 
> There are some other DT changes for this cycle so those should probably
> go through MIPS.

No objection for this going through the MIPS tree, and from me:

Acked-by: David S. Miller <davem@davemloft.net>
