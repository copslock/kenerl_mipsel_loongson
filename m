Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jul 2012 19:19:55 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:34446 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903480Ab2G0RTt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jul 2012 19:19:49 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@realitydiluted.com>)
        id 1SuoCS-0001FF-4p; Fri, 27 Jul 2012 12:19:40 -0500
Message-ID: <5012CDA4.5000008@realitydiluted.com>
Date:   Fri, 27 Jul 2012 12:19:32 -0500
From:   "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
MIME-Version: 1.0
To:     JoeJ <tttechmail@gmail.com>
CC:     linux-mips@linux-mips.org, sjhill@mips.com
Subject: Re: SMVP Support on MIPS34KC (linux-2.6.35)
References: <34219711.post@talk.nabble.com>
In-Reply-To: <34219711.post@talk.nabble.com>
X-Enigmail-Version: 1.4.3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33992
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

Hello Joe.

The 2.6.35.9 is obsolete with regards to SMVP support. You should grab the
latest 3.4.2 kernel that has complete and working SMVP. To access it, do the
following:

git clone git://git.linux-mips.org/pub/scm/linux-mti
git checkout -b linux-mti-3.4.2 origin/linux-mti-3.4.2

Use the 'arch/mips/configs/maltasmvp_defconfig' as your base configuration
file. If you have any issues, please let me know.

- -Steve

P.S. You can also reach me at <sjhill AT mips DOT com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlASzaQACgkQgyK5H2Ic36cjbACfcgtny/+QYPBNhiDqC0I9QIfV
4ZQAn2TlJWe+t2Jsriji2KAAtk8fwnu3
=0aZ6
-----END PGP SIGNATURE-----
