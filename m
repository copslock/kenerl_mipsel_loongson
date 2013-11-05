Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Nov 2013 00:52:26 +0100 (CET)
Received: from mail-out.m-online.net ([212.18.0.10]:56552 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823083Ab3KEXwYYgmbB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 6 Nov 2013 00:52:24 +0100
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
        by mail-out.m-online.net (Postfix) with ESMTP id 3dDnjX2dWdz3hj1X;
        Wed,  6 Nov 2013 00:52:15 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3dDnjW6lRkzbbjd;
        Wed,  6 Nov 2013 00:52:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id ROsFvl2qYFKv; Wed,  6 Nov 2013 00:52:14 +0100 (CET)
X-Auth-Info: QcbDWV/uc6gMXZ3FC0JKelBc5MfUgtvFzKOyXT2NHl4=
Received: from igel.home (ppp-88-217-38-26.dynamic.mnet-online.de [88.217.38.26])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Wed,  6 Nov 2013 00:52:14 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id 4BEFC2C1786; Wed,  6 Nov 2013 00:52:14 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Rich Felker <dalias@aerifal.cx>
Cc:     "Joseph S. Myers" <joseph@codesourcery.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "Pinski\, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Andreas Barth <aba@ayous.org>,
        David Miller <davem@davemloft.net>, aurelien@aurel32.net,
        linux-mips@linux-mips.org, libc-alpha@sourceware.org
Subject: Re: prlimit64: inconsistencies between kernel and userland
References: <20130628133835.GA21839@hall.aurel32.net>
        <20131104213756.GD18700@hall.aurel32.net>
        <20131104.194519.1657797548878784116.davem@davemloft.net>
        <Pine.LNX.4.64.1311050058580.9883@digraph.polyomino.org.uk>
        <20131105012203.GA24286@brightrain.aerifal.cx>
        <20131105085859.GE28240@mails.so.argh.org>
        <20131105183732.GB24286@brightrain.aerifal.cx>
        <52793C50.9030300@gmail.com>
        <Pine.LNX.4.64.1311052234420.30260@digraph.polyomino.org.uk>
        <20131105223953.GG24286@brightrain.aerifal.cx>
X-Yow:  ..Everything is....FLIPPING AROUND!!
Date:   Wed, 06 Nov 2013 00:52:14 +0100
In-Reply-To: <20131105223953.GG24286@brightrain.aerifal.cx> (Rich Felker's
        message of "Tue, 5 Nov 2013 17:39:53 -0500")
Message-ID: <87ppqez9sh.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <whitebox@nefkom.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: schwab@linux-m68k.org
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

Rich Felker <dalias@aerifal.cx> writes:

> BTW, what happens on a distro where -dev packages are separate and the
> user compiles with old headers (not having upgraded the dev package)
> but new libc.so? :-)

The devel package must either be self-contained or require the matching
non-devel package.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
