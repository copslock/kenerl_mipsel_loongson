Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 17:20:30 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:53549
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225274AbUK2RUZ>; Mon, 29 Nov 2004 17:20:25 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CYpCG-0001zj-00; Mon, 29 Nov 2004 18:20:20 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CYpCG-0004vC-00; Mon, 29 Nov 2004 18:20:20 +0100
Date: Mon, 29 Nov 2004 18:20:20 +0100
To: "Eric Y. Theriault" <eric@eyt.ca>
Cc: linux-mips@linux-mips.org
Subject: Re: dvhtool support for variable block factor...
Message-ID: <20041129172020.GP6804@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.LNX.4.61.0411291004110.14874@ingress.local.fxdevelopment.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411291004110.14874@ingress.local.fxdevelopment.com>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Eric Y. Theriault wrote:
[snip]
> There is also a similar bug with fdisk's SGI header creation; are you also 
> in charge of this?  Do you know where I should send that patch?

This would be linux-utils, but be warned the fdisk code is competely
FUBAR. I gave up on it when I realized that some mysterious segfaults
ware caused by unaligned pointer arithmetic and/or conversion of some
data to little endianness, and changing those would likely have broken
fdisk for other architectures.

A testcase which always "worked" for me on IP22: create a DVH with
parted, and then try to read/change it with fdisk. Apparently
parted poisons the DVH for fdisk. :-)


Thiemo
