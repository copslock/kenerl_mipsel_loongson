Received:  by oss.sgi.com id <S553796AbQLQUUW>;
	Sun, 17 Dec 2000 12:20:22 -0800
Received: from iris1.csv.ica.uni-stuttgart.de ([129.69.118.2]:13640 "EHLO
        iris1.csv.ica.uni-stuttgart.de") by oss.sgi.com with ESMTP
	id <S553785AbQLQUTy>; Sun, 17 Dec 2000 12:19:54 -0800
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id VAA314308;
	Sun, 17 Dec 2000 21:19:38 +0100 (MET)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.12 #1 (Debian))
	id 147kHL-0006iV-00; Sun, 17 Dec 2000 21:19:31 +0100
Date:   Sun, 17 Dec 2000 21:19:31 +0100
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
Subject: Re: 64 bit build fails
Message-ID: <20001217211931.D25660@rembrandt.csv.ica.uni-stuttgart.de>
Mail-Followup-To: ica2_ts, Carsten Langgaard <carstenl@mips.com>,
	Ralf Baechle <ralf@oss.sgi.com>, linux-mips@oss.sgi.com
References: <3A379CBC.ED1D9F@mips.com> <20001214215933.C28871@bacchus.dhis.org> <3A39CC1F.8FE7B2FE@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A39CC1F.8FE7B2FE@mips.com>; from carstenl@mips.com on Fri, Dec 15, 2000 at 08:45:35AM +0100
From:   Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Carsten Langgaard wrote:
[snip]
>> Looks like an attempt to build a 64-bit Indy kernel.  Various people working
>> on the Origin support have completly broken the support for anything else in
>> their battle tank-style approach ...
>
>Ok, that explains why a lot of things are broken.

You might be interested in some work i have done [1] to create a 64-bit
kernel for SGI IP28 aka Indigo2 Impact. Don't expect it to be less
broken, it basically does an controlled crash at the very beginning of
kernel initialization.

(The IP28 Firmware doesn't like 32-bit ELF or even ecoff kernels.)

>So who will be responsible for fixing all the broken pieces ?

The one who asks about it, i assume. ;-)

[1] http://www.csv.ica.uni-stuttgart.de/homes/ths/linux-mips/


Thiemo
