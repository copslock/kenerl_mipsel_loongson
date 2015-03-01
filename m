Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Mar 2015 11:05:18 +0100 (CET)
Received: from helcar.apana.org.au ([209.40.204.226]:49132 "EHLO
        helcar.apana.org.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006703AbbCAKFQVgBa6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Mar 2015 11:05:16 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6])
        by norbury.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
        id 1YS0k7-0001mY-Ul; Sun, 01 Mar 2015 21:05:00 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1YS0j7-0004HU-Ch; Sun, 01 Mar 2015 23:03:57 +1300
Date:   Sun, 1 Mar 2015 23:03:57 +1300
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpm@selenic.com, wsa@the-dreams.de,
        cernekee@gmail.com
Subject: Re: [PATCH 0/4] hw_random: bcm63xx-rng: misc cleanups and reorg
Message-ID: <20150301100357.GA16444@gondor.apana.org.au>
References: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424138956-11563-1-git-send-email-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46060
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: herbert@gondor.apana.org.au
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

On Mon, Feb 16, 2015 at 06:09:12PM -0800, Florian Fainelli wrote:
> Hi,
> 
> This patchset prepares the driver to be built on non-MIPS bcm63xx architectures
> such as the ARM bcm63xx variants, thanks!
> 
> Although patch 3 touches a MIPS header file, there should be little to no
> conflicts there if all patches went through the hw_random tree (is there one?)

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
