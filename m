Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 May 2016 00:33:32 +0200 (CEST)
Received: from gate.crashing.org ([63.228.1.57]:33282 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27028490AbcEIWdazpZh9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 10 May 2016 00:33:30 +0200
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u49MX5vG002942;
        Mon, 9 May 2016 17:33:08 -0500
Message-ID: <1462833187.20290.123.camel@kernel.crashing.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org
Cc:     a.seppala@gmail.com, johnyoun@synopsys.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Lamparter <chunkeey@googlemail.com>
Date:   Tue, 10 May 2016 08:33:07 +1000
In-Reply-To: <8737prikg9.fsf@intel.com>
References: <4231696.iL6nGs74X8@debian64> <1908894.Nkk1LXQkFm@debian64>
         <1462753402.20290.95.camel@au1.ibm.com> <4162108.qmr2GZCaDN@wuerfel>
         <8737prikg9.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2 (3.18.5.2-1.fc23) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <benh@kernel.crashing.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: benh@kernel.crashing.org
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

On Mon, 2016-05-09 at 13:39 +0300, Felipe Balbi wrote:
> and patch all drivers similarly? Shouldn't arch/mips itself deal with
> it and hide it from drivers ?

Not sure what you mean, but we never had "endian neutral" accessors. It
would be a bit of an endeavour and we already have so many accessors
that adding more need a very strong justification.

Most IP blocks have a fixed endian...

Ben.
