Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 02:47:32 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011960AbbAVBr3hYQPF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Jan 2015 02:47:29 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 4C9EF2035B;
        Thu, 22 Jan 2015 01:47:28 +0000 (UTC)
Received: from mail.kernel.org (unknown [46.165.208.107])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 312CC2034F;
        Thu, 22 Jan 2015 01:47:26 +0000 (UTC)
Date:   Thu, 22 Jan 2015 02:47:18 +0100
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
Subject: Re: [PATCH 3/9] power/reset: brcmstb: Add support for old 65nm chips
Message-ID: <20150122014718.GO13715@earth.universe>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
 <1416962994-27095-4-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B3NBd8mrXZtPJEYR"
Content-Disposition: inline
In-Reply-To: <1416962994-27095-4-git-send-email-cernekee@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sre@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45425
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


--B3NBd8mrXZtPJEYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Nov 25, 2014 at 04:49:48PM -0800, Kevin Cernekee wrote:
> The register bit fields are a little different, so add an entry and a
> compatible string to accommodate them.

Thanks, applied.

-- Sebastian

--B3NBd8mrXZtPJEYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUwFamAAoJENju1/PIO/qabr8P/1ea3h4M0xKnteM9XGvGal8q
BHAQBk7O083ZW/D4qhdxJyy+X0Wq/9/CiYVNsJb4xqDMDW6lpVp2V7EI0XeljjhU
Q171ZNF0jr+l3PiTyAL03yacpWzJ/QPZReJFwJCovN+/JUnVrz1mMzWFP4U5RyMY
TwtXIc5DiAxuwVv7cfc4sst+zGzSZpsRNToNQILUf9MIFozjiNUtXP83Wcn+Oj0I
lJ3YVtazMKwvpfN5ZAJ7+llZ2ye0rtr8pY6Pi/Okb0O8Lco6N9m3RCdti9nq3nxw
YuJVgXxj9bj3xzjAXMINx1HV/yMdL3Z02qSzYaEWZJq/5h7Kk8ZadmUcXEi9keZV
u3j6HJBcF4Mbh7Dbx227btBRmJUXTui57ssze4QTUxJ1gCilX+lsZEuiBeDC/XwB
G/UxxYVq+2tpwlco97wZrW6DlljmrLyiMIlgSqfwb602ulunuWdJRvr8BzadFraU
FG+jgYEEfz/w7sSzCuaPoGLlhc9C08CPowzDbn4PK6ubAptem29Uz2mulknEpUbs
pa7qGDRTyXsoaLnquJJReDc5VkqVerV1aqmQ0rSlhXeMpzJDuhm+/4lrpR1jVRL0
RwyqVbYUPQddAWU9rtWL7SBBmWqaSqAGbi8rmKSmqDuUsqyeSS+oJpCOkUP5sNGP
UxmSuEUsuDskeTxzKPYO
=Ix8s
-----END PGP SIGNATURE-----

--B3NBd8mrXZtPJEYR--
