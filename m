Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Mar 2015 15:54:50 +0100 (CET)
Received: from sauhun.de ([89.238.76.85]:44355 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008051AbbCLOysING4j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Mar 2015 15:54:48 +0100
Received: from p4fe24c69.dip0.t-ipconnect.de ([79.226.76.105]:57857 helo=katana)
        by pokefinder.org with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <wsa@the-dreams.de>)
        id 1YW4VY-0001gu-PR; Thu, 12 Mar 2015 15:54:45 +0100
Date:   Thu, 12 Mar 2015 15:55:03 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-i2c@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC V2 04/12] i2c: opal: make use of the new infrastructure for
 quirks
Message-ID: <20150312145503.GB9572@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-5-git-send-email-wsa@the-dreams.de>
 <54FF2631.9050006@linux.vnet.ibm.com>
 <1426029133.17565.9.camel@kernel.crashing.org>
 <54FFC3EC.7020708@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <54FFC3EC.7020708@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <wsa@the-dreams.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wsa@the-dreams.de
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


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think we can't land up here by-passing the check for quirks so above
> checks are duplicated here..

True.

So, as Ben seems OK with write-then-anything, can you send me your
changes as an incremental patch to mine with your Signed-off, please?

Thanks,

   Wolfram


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAajHAAoJEBQN5MwUoCm254UP/1g93L0on97oPHJ3A4JfX6ti
+6xQ/c0c+c1kIwpK8dt5LMPNXwNS8+DIk06y2rOwhI9liqVTruWZv+hrKalTGWBK
m63fS0IdwKgSay+G2zd956UH0Do4qsYjdYzxZ5TO2kw37k1Wa9iU4nQ8zHtnwN9I
g6Ri2QZQZdPqfPEu9nsTkxqDmZDr+mB+GwcwZZv1x4nvIST7wA/jmTD7KsKbTxLp
T0ak/qIzL8VwKAswlatxjR69FW4Gi8HVjJY5U8B5+vMZtOtoNL6pVdQIoa2Fhmp+
c7d+D9brYhWp2cps0z7Wz1g7LdBkVpcsrZU+KBn7bAHAYJXpSz4xg13sBvlupsd/
H0cYRpSYBICedY3zyAPu+Ih04RfqP6S+de+DHh7QeUm6VvWqdZ81Uq1iQqUahgE+
yj8kyiJUpTiBwuIkO0KevzncuvSIdYXy98PxgsQYbEkV1/+kRAN4zWHoT1UHPVT/
s1RkcwpWUmm3a1CPYS3M/zzMXr8twdYn5/0AF0g9kfmsLHGW9wZ06Q8IqaV9TFGR
DKYLsA3SVqWEcmbpUCAvwbrL+xcLoxH06QbsBaFFOnmUEFZOVwTUrqsSAkd0+clM
gw5wb9fIswAN8LairYDd8Xe63wA46DZPT/ykkcIe9+xTw0oC2ouDxZzYKvxvuyM/
XLL/alJLDxQzbOayFPjI
=Kxsv
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
