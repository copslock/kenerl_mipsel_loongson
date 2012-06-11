Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jun 2012 15:12:54 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:41085 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903647Ab2FKNMq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jun 2012 15:12:46 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@realitydiluted.com>)
        id 1Se4QA-0004mj-2s; Mon, 11 Jun 2012 08:12:38 -0500
Message-ID: <4FD5EEBE.50203@realitydiluted.com>
Date:   Mon, 11 Jun 2012 08:12:30 -0500
From:   "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120312 Thunderbird/11.0
MIME-Version: 1.0
To:     Paul Bolle <pebolle@tiscali.nl>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Remove unused smvp.h
References: <1339407387.30984.87.camel@x61.thuisdomein>
In-Reply-To: <1339407387.30984.87.camel@x61.thuisdomein>
X-Enigmail-Version: 1.4.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 33606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I have confirmed that in our older kernels and in the latest 3.X kernels that
this file is indeed unused. I approve this patch.

- -Steve

Acked-by: Steven J. Hill <sjhill@mips.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/V7r4ACgkQgyK5H2Ic36dCNQCfYRj7YMNnMySN0LQI2qElTJv+
jMMAnj69FxKbakspch9toWtm5IlsDLFN
=GvrB
-----END PGP SIGNATURE-----
