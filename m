Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 04:43:40 +0100 (CET)
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44169
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by eddie.linux-mips.org with ESMTP id S1491782AbZKXDng (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 24 Nov 2009 04:43:36 +0100
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 00BC93647F1;
	Mon, 23 Nov 2009 19:43:43 -0800 (PST)
Date:	Mon, 23 Nov 2009 19:43:43 -0800 (PST)
Message-Id: <20091123.194343.232255103.davem@davemloft.net>
To:	ralf@linux-mips.org
Cc:	sfr@canb.auug.org.au, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org, a.beregalov@gmail.com,
	florian@openwrt.org, linux-mips@linux-mips.org,
	manuel.lauss@googlemail.com
Subject: Re: linux-next: manual merge of the mips tree with the net-current
 tree
From:	David Miller <davem@davemloft.net>
In-Reply-To: <20091124011958.GA8105@linux-mips.org>
References: <20091124113717.c5d86d41.sfr@canb.auug.org.au>
	<20091124011958.GA8105@linux-mips.org>
X-Mailer: Mew version 6.2.51 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25086
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
Precedence: bulk
X-list: linux-mips

From: Ralf Baechle <ralf@linux-mips.org>
Date: Tue, 24 Nov 2009 01:19:58 +0000

> On Tue, Nov 24, 2009 at 11:37:17AM +1100, Stephen Rothwell wrote:
> 
>> Hi Ralf,
>> 
>> Today's linux-next merge of the mips tree got a conflict in
>> drivers/net/au1000_eth.c between commit
>> 63edaf647607795a065e6956a79c47f500dc8447 ("Au1x00: fix crash when trying
>> register_netdev()") from the net-current tree and commit
>> 6cdbc95856e7f4ab4e7b2f2bdab5c3844537ad83 ("NET: au1000-eth: convert to
>> platform_driver model") from the mips tree.
>> 
>> It looks to me that the mips tree change supercedes the net-current one
>> (since it moves the register_netdev() call much later), so I just used
>> this file from the mips tree.
> 
> I agree.  David, can you just drop the net-current patch then?  This fix
> is still needed for -stable however.

Why would I do that?  The bug fix is necessary for 2.6.32 too.

You're not going to merge a platform_driver conversion this late
in the -rc series are you?
