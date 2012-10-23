Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Oct 2012 21:57:50 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:41906 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825606Ab2JWT5uMp0Jw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Oct 2012 21:57:50 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@realitydiluted.com>)
        id 1TQkbe-0003HB-Qn
        for linux-mips@linux-mips.org; Tue, 23 Oct 2012 14:57:42 -0500
Message-ID: <5086F6AE.4030105@realitydiluted.com>
Date:   Tue, 23 Oct 2012 14:57:34 -0500
From:   "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [RFC 00/13] MIPS: JZ4750D: Add base support for Ingenic JZ4750D
 SOC
References: <1351014241-3207-1-git-send-email-antonynpavlov@gmail.com> <5086DEBB.1030506@metafoo.de>
In-Reply-To: <5086DEBB.1030506@metafoo.de>
X-Enigmail-Version: 1.4.4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34766
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

On 10/23/2012 01:15 PM, Lars-Peter Clausen wrote:
> As for the renaming I'm not so sure if it is really necessary. We often
> stick we the name for the driver or architecture version which was first
> supported by the kernel and add note in Kconfig and comments that the
> driver also supports other version/variants of the peripheral or SoC.
> 
We currently have 'jz4740' and 'jz4770' directories. I think putting the
jz4750d code into 'jz4740' is a good idea too. Perhaps someday a 'jz47xx'
directory could be possible, but not sure it is worth the work.

- -Steve
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCG9qgACgkQgyK5H2Ic36f+CACfTGI06BoH5wXS5SXeN2PBqDI0
FkUAoJRV8473SruXkIy4ZF6RXYg3l873
=eK1h
-----END PGP SIGNATURE-----
