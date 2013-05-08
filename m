Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 May 2013 05:19:04 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:33161 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816822Ab3EHDTChBtk8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 May 2013 05:19:02 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@realitydiluted.com>)
        id 1UZuu7-0002oO-4r
        for linux-mips@linux-mips.org; Tue, 07 May 2013 22:18:55 -0500
Message-ID: <5189C41D.3000005@realitydiluted.com>
Date:   Tue, 07 May 2013 22:18:53 -0500
From:   "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH v99,11/13] MIPS: microMIPS: Optimise 'strncpy' core library
 function.
References: <1354856737-28678-1-git-send-email-sjhill@mips.com> <1354856737-28678-12-git-send-email-sjhill@mips.com> <518987BD.7030900@gmail.com>
In-Reply-To: <518987BD.7030900@gmail.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36354
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

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/07/2013 06:01 PM, David Daney wrote:
> On 12/06/2012 09:05 PM, Steven J. Hill wrote:
>> From: "Steven J. Hill" <sjhill@mips.com>
>> 
>> Optimise 'strncpy' to use microMIPS instructions and/or optimisations for
>> binary size reduction. When the microMIPS ISA is not being used, the
>> library function compiles to the original binary code.
> 
> This is an untrue statement.  Why mislead us by saying the original binary
> code is obtained?
> 
I you are building a classic MIPS kernel, the instructions generated will be
the same even with this patch. The changes only make a difference when
building a pure microMIPS kernel.

> You don't really explain how the change helps optimization either.
> 
The exercise is left to the reader. Build a microMIPS kernel yourself and
figure it out.

- -Steve
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGJxBcACgkQgyK5H2Ic36c4hQCeLGI8MI2rr6KgOv7G15lnBdok
bbcAoKY+BvVyTCzG033Bc+pJ07xCtGMq
=xJmM
-----END PGP SIGNATURE-----
