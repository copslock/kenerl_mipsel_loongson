Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 02:46:59 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:36962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011960AbbAVBqrowW43 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Jan 2015 02:46:47 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 4B0D2202F8;
        Thu, 22 Jan 2015 01:46:45 +0000 (UTC)
Received: from mail.kernel.org (unknown [46.165.208.107])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257422035C;
        Thu, 22 Jan 2015 01:46:43 +0000 (UTC)
Date:   Thu, 22 Jan 2015 02:46:35 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     dbaryshkov@gmail.com, dwmw2@infradead.org, arnd@arndb.de,
        linux@prisktech.co.nz, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org, f.fainelli@gmail.com,
        grant.likely@linaro.org, robh+dt@kernel.org,
        computersforpeace@gmail.com, marc.ceeeee@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/9] power/reset: brcmstb: Make the driver buildable on
 MIPS
Message-ID: <20150122014635.GM13715@earth.universe>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
 <1416962994-27095-2-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hnsKUeImFCk/igEn"
Content-Disposition: inline
In-Reply-To: <1416962994-27095-2-git-send-email-cernekee@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sre@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45423
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sre@kernel.org
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


--hnsKUeImFCk/igEn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Nov 25, 2014 at 04:49:46PM -0800, Kevin Cernekee wrote:
> Now that the driver doesn't use any ARM-specific headers, it is safe
> to build on MIPS or with COMPILE_TEST.

Thanks, applied.

-- Sebastian

--hnsKUeImFCk/igEn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwFZ4AAoJENju1/PIO/qahrAP/344bCXsWDwe0W4PQHH0n1S6
xKRvwF2P76dxirhxsZmYBMyNmssgRaCOjDrRyg4lBj5POyW8yV1C5RS/qBDKiJEz
eHTIG0xml/TEk36Pxa8WsvZCT9gBHNbrf8wbXK95g5h6uotHq11Fu9B+wxivBzkL
w7dYlSo8q49HxB4HYGJPvAhqxN6n2zCiIzwMiJNrZJrybRdnSiKHFO3xFglE9Awy
uqrJHS7zpS2VIImANDVQ20tiJiiQDe9xaxoMoVn5fWc4MNBODAoZ8cPVmXZp/uDR
Q0qn1jfsYGJdlz5fR1kqHa2MsegOlnqDK3xQ6gLu5otg5fUZVYWHjiWYJTpp6Y5I
qErECSY40QoBqZhBHyQaEcK5eq72AFTC86xmHmr7/yAgyBzqLZQSYeu2Y8tBEHPK
wMaCBldfC7fxJXND42LGLKbH7lDOyaIisbcQGk583M10/xdPAYBYoQtnuVkMduAb
4zrUqV4ORUUdf+Ikkr48F/09eTk0oKHKMOg2p9GIDJmLBX8yRg3lSItWYjcWIS/h
cCJzzCrXirnh99g0tWO8KkKwzEVC7jnjEJ9WSpBBg7SkL9b+DuqHWUkUCkGfDRbB
XsakBmCHTQxSrAWWYByWmqy3zMLdeJ/PgBGDA8W7PgxKfSr8BZ7h6DLxpIiONRwh
DAkBpMuQ0NI7nFcYDkbt
=FhZs
-----END PGP SIGNATURE-----

--hnsKUeImFCk/igEn--
