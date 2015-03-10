Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Mar 2015 10:58:20 +0100 (CET)
Received: from ringil.hengli.com.au ([178.18.16.133]:49133 "EHLO
        ringil.hengli.com.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006587AbbCJJ6Tc5994 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 10 Mar 2015 10:58:19 +0100
Received: from gondolin.me.apana.org.au ([192.168.0.6])
        by norbury.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
        id 1YVGvX-0001tD-5e; Tue, 10 Mar 2015 20:58:15 +1100
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1YVGvP-0004gc-Tr; Tue, 10 Mar 2015 20:58:07 +1100
Date:   Tue, 10 Mar 2015 20:58:07 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] crypto: OCTEON MD5 bugfix + SHA modules
Message-ID: <20150310095807.GA17913@gondor.apana.org.au>
References: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1425845267-14413-1-git-send-email-aaro.koskinen@iki.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46305
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

On Sun, Mar 08, 2015 at 10:07:40PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> The first patch is a bug fix for OCTEON MD5 aimed for 4.0-rc cycle.

Please send such bug fixes in a separate series in future.
For this one in particular it does not appear to be critical
enough to go in straight away so I have pushed it into cryptodev
along with the rest.

> The remaining patches add SHA1/SHA256/SHA512 modules. I have tested
> these on the following OCTEON boards and CPUs with 4.0-rc2:
> 
> 	D-Link DSR-1000N:	CN5010p1.1-500-SCP
> 	EdgeRouter Lite:	CN5020p1.1-500-SCP
> 	EdgeRouter Pro:		CN6120p1.1-1000-NSP
> 
> All selftests are passing. With tcrypt, I get the following numbers
> on speed compared to the generic modules:

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
