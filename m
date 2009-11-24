Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Nov 2009 02:20:01 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:59125 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
	id S1493500AbZKXBT5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Nov 2009 02:19:57 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAO1K1wx003860;
	Tue, 24 Nov 2009 01:20:01 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAO1Jw7v003858;
	Tue, 24 Nov 2009 01:19:58 GMT
Date:	Tue, 24 Nov 2009 01:19:58 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stephen Rothwell <sfr@canb.auug.org.au>
Cc:	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Beregalov <a.beregalov@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Fainelli <florian@openwrt.org>,
	linux-mips@linux-mips.org,
	Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: linux-next: manual merge of the mips tree with the net-current
	tree
Message-ID: <20091124011958.GA8105@linux-mips.org>
References: <20091124113717.c5d86d41.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091124113717.c5d86d41.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 24, 2009 at 11:37:17AM +1100, Stephen Rothwell wrote:

> Hi Ralf,
> 
> Today's linux-next merge of the mips tree got a conflict in
> drivers/net/au1000_eth.c between commit
> 63edaf647607795a065e6956a79c47f500dc8447 ("Au1x00: fix crash when trying
> register_netdev()") from the net-current tree and commit
> 6cdbc95856e7f4ab4e7b2f2bdab5c3844537ad83 ("NET: au1000-eth: convert to
> platform_driver model") from the mips tree.
> 
> It looks to me that the mips tree change supercedes the net-current one
> (since it moves the register_netdev() call much later), so I just used
> this file from the mips tree.

I agree.  David, can you just drop the net-current patch then?  This fix
is still needed for -stable however.

  Ralf
