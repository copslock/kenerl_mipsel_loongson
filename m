Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jun 2012 05:08:31 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:53096 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1901164Ab2FNDIY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jun 2012 05:08:24 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@realitydiluted.com>)
        id 1Sf0Px-0001jb-65; Wed, 13 Jun 2012 22:08:17 -0500
Message-ID: <4FD95599.9070708@realitydiluted.com>
Date:   Wed, 13 Jun 2012 22:08:09 -0500
From:   "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120312 Thunderbird/11.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: MIPS: Fixup ordering of micro assembler instructions.
References: <S1903563Ab2E3UqG/20120530204607Z+6387@eddie.linux-mips.org>
In-Reply-To: <S1903563Ab2E3UqG/20120530204607Z+6387@eddie.linux-mips.org>
X-Enigmail-Version: 1.4.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33633
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

On 05/30/2012 03:46 PM, linux-mips@linux-mips.org wrote:
> Author: Steven J. Hill <sjhill@mips.com> Fri May 11 01:35:47 2012 -0500 
> Comitter: Ralf Baechle <ralf@linux-mips.org> Wed May 30 21:37:16 2012
> +0100 Commit: 6e3f8b69731d6dc03afdd47cfdddb0e479a6d2a9 Gitweb: 
> http://git.linux-mips.org/g/ralf/linux/6e3f8b69731d Branch: master
> 
> A number of new instructions have been added to the micro assembler
> causing the list to no longer be in alphabetical order. This patch fixes up
> the name ordering.
> 
> Signed-off-by: Steven J. Hill <sjhill@mips.com> Cc: 
> linux-mips@linux-mips.org Patchwork: 
> https://patchwork.linux-mips.org/patch/3789/ Signed-off-by: Ralf Baechle 
> <ralf@linux-mips.org>
> 
Ralf,

This patch is fscked. The lines for _bbit0 and _bbit1 are duplicated. Please
commit a patch to remove the duplicate lines. Thanks.

- -Steve
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/ZVZkACgkQgyK5H2Ic36drewCeKUkFQ27TQFv2H9yC2Qm2PrxG
y7cAnRWHD8HNU/FD3mKIlkGXEhHor+Xw
=Oumy
-----END PGP SIGNATURE-----
