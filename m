Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 May 2015 06:26:13 +0200 (CEST)
Received: from helcar.hengli.com.au ([209.40.204.226]:60386 "EHLO
        helcar.hengli.com.au" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006151AbbERE0LDTnwJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 May 2015 06:26:11 +0200
Received: from gondolin.me.apana.org.au ([192.168.0.6])
        by norbury.hengli.com.au with esmtp (Exim 4.80 #3 (Debian))
        id 1YuCcr-0001Cb-KH; Mon, 18 May 2015 14:26:01 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1YuCck-0003S3-Ci; Mon, 18 May 2015 12:25:54 +0800
Date:   Mon, 18 May 2015 12:25:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     LABBE Corentin <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, ralf@linux-mips.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, aaro.koskinen@iki.fi,
        linux-crypto@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/6] crypto: md5: add MD5 initial vectors
Message-ID: <20150518042554.GB13238@gondor.apana.org.au>
References: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1431860057-5232-1-git-send-email-clabbe.montjoie@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <herbert@gondor.apana.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47454
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

On Sun, May 17, 2015 at 12:54:12PM +0200, LABBE Corentin wrote:
> This patch simply adds the MD5 IV in the md5 header.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
