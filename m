Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Feb 2012 21:02:09 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36339 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903594Ab2BSUCF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Feb 2012 21:02:05 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 0D6908F61;
        Sun, 19 Feb 2012 21:02:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tUtydwpgOfHp; Sun, 19 Feb 2012 21:01:50 +0100 (CET)
Received: from [192.168.1.220] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 9C91C8F60;
        Sun, 19 Feb 2012 21:01:50 +0100 (CET)
Message-ID: <4F41552D.2020109@hauke-m.de>
Date:   Sun, 19 Feb 2012 21:01:49 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     =?ISO-8859-1?Q?Michael_B=FCsch?= <m@bues.ch>
CC:     linville@tuxdriver.com, zajec5@gmail.com,
        b43-dev@lists.infradead.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, arend@broadcom.com
Subject: Re: [PATCH 04/11] ssb: add ccode
References: <1329676345-15856-1-git-send-email-hauke@hauke-m.de> <1329676345-15856-5-git-send-email-hauke@hauke-m.de> <20120219194923.566f3fe8@milhouse> <4F414D63.1070409@hauke-m.de> <20120219205016.742a4bad@milhouse>
In-Reply-To: <20120219205016.742a4bad@milhouse>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-archive-position: 32486
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/19/2012 08:50 PM, Michael Büsch wrote:
> On Sun, 19 Feb 2012 20:28:35 +0100 Hauke Mehrtens
> <hauke@hauke-m.de> wrote:
>>>> u8 country_code;	/* Country Code */ +	char ccode[2];		/*
>>>> Country Code as two chars like EU or US */
>>> 
>>> This usually is referred to as "alpha2". So we should name it
>>> like that, too.
>> I can not find any references to "alpha2" in the spec
> 
> http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
> 
OK, I will rename it.

Hauke
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPQVUWAAoJEIZ0px9YPRMyiJgP/i8PzgoVBhlPcUwdDwigbDVw
oUcRWdLs6Elo1cvfao0Txu3ntB02bT7wKn262AYgRUUPerp2CmvF9jEXziSLFV5L
/GEzkm2+yyM+dYNatL+6De9qNZGdzzJNR4lHZ/7aAFzE/0PY9Pg5OvY8cZdJDPb5
jQK97Vjdd1mfpFYpEJYUw24JOa/fF4+Ve/yHSjSJ3djf60h7i2GVWf/QBlQXNRc5
TEKb95wQUwXmGDjgkO41ZtmtN0XA506FzU5uy6kLFKTuiWM6EDcKQWhlfw+S90pR
7PpbyAvzLyZKpiOutV9SHgW0eimhFmEo9H7f3bwkBLDjkJKmEKrK3pqZ3pz8VQdK
JfOijxPnd91UAPUkIvDv7aFgrAt+HCYYq5T6KFsLvk4kLLX36Sgoxe3f+htBd2Mj
+as0i2xFBWniifAnPA1oWRGJsNvDAFDuix8XSaNqkz9RxCEZ+35KE4jw9rsqUwKJ
vYPmKZsen9YmI72N82eT/nww31Ppkc4p9JdvHn8qsa3G/QjA/fYm3r7ymOrOcA4o
Wb1MBx9584jukks1/HgVueUf77rj0q5A99bvuMuKpwrvtX0HlWBUdvG90oUJl5wL
cF0almhAj2oB4DfHaaAseFlq52WRF2VSXS296VZ8k7EZfnFELxtHrDXC7ku9jaut
92sDSHze8ron+1PmclEm
=BIVY
-----END PGP SIGNATURE-----
