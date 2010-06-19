Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Jun 2010 05:49:28 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:38492 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490970Ab0FSDtX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Jun 2010 05:49:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 1320A34F;
        Sat, 19 Jun 2010 05:49:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OyxiO3Q0HY9x; Sat, 19 Jun 2010 05:49:13 +0200 (CEST)
Received: from [172.31.16.226] (d024024.adsl.hansenet.de [80.171.24.24])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 3367334E;
        Sat, 19 Jun 2010 05:49:06 +0200 (CEST)
Message-ID: <4C1C3E17.10702@metafoo.de>
Date:   Sat, 19 Jun 2010 05:48:39 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Mark Brown <broonie@opensource.wolfsonmicro.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Anton Vorontsov <cbouatmailru@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        lrg@slimlogic.co.uk
Subject: Re: [RFC][PATCH 23/26] power: Add JZ4740 battery driver.
References: <1275505397-16758-1-git-send-email-lars@metafoo.de> <1275505950-17334-7-git-send-email-lars@metafoo.de> <20100614155108.GA30552@oksana.dev.rtsoft.ru> <20100615173432.GA27904@linux-mips.org> <20100616122042.GB31387@sirena.org.uk>
In-Reply-To: <20100616122042.GB31387@sirena.org.uk>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27173
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13329

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi
Mark Brown wrote:
> On Tue, Jun 15, 2010 at 06:34:32PM +0100, Ralf Baechle wrote:
>> To allow for reasonable testing while this patchset is getting
>> integrated I suggest I apply all the patches that were acked by
>> the respective maintainers to the MIPS tree, feed them to -next
>> for testing  and once that phase is complete send the whole thing
>> to Linus.
>
> Due to major pending changes in the audio subsystem at least the
> audio subsystem changes will have merge issues in -next from that.
> To avoid these I suggest putting the audio changes on a branch
> which can be pulled into both trees.
In my opinion the ASoC drivers can go through the ASoC tree. The core
patches will build without the ASoC patches and the ASoC drivers wont
be selectable without the core patches. Thus we wont see any build
failures due to merging both parts individually. And given that there
will be some changes required when the multi-component branch is
merged it will simplify things if the patches only go through one tree.
I've talked to Ralf and he said he is ok with it.

- - Lars
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkwcPhcACgkQBX4mSR26RiOJSgCfScB+QFGTbzAqfbmvAVntvqDb
Xv8An1672tE+ZkLqBBYuhU18AEZdVmkT
=n6/A
-----END PGP SIGNATURE-----
