Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 19:10:15 +0000 (GMT)
Received: from outbound.mailhop.org ([IPv6:::ffff:63.208.196.171]:21267 "EHLO
	outbound.mailhop.org") by linux-mips.org with ESMTP
	id <S8225296AbUK2TKI>; Mon, 29 Nov 2004 19:10:08 +0000
Received: from toronto-hse-ppp3957581.sympatico.ca ([69.157.181.100])
	by outbound.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.42)
	id 1CYquS-000HRv-I0; Mon, 29 Nov 2004 14:10:04 -0500
Date: Mon, 29 Nov 2004 14:09:57 -0500 (EST)
From: "Eric Y. Theriault" <eric@eyt.ca>
X-X-Sender: eric@ingress.local.fxdevelopment.com
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
cc: linux-mips@linux-mips.org
Subject: Re: dvhtool support for variable block factor...
In-Reply-To: <20041129172020.GP6804@rembrandt.csv.ica.uni-stuttgart.de>
Message-ID: <Pine.LNX.4.61.0411291403190.20405@ingress.local.fxdevelopment.com>
References: <Pine.LNX.4.61.0411291004110.14874@ingress.local.fxdevelopment.com>
 <20041129172020.GP6804@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Mail-Handler: MailHop Outbound by DynDNS.org
X-Originating-IP: 69.157.181.100
X-Report-Abuse-To: abuse@dyndns.org (see http://www.mailhop.org/outbound/abuse.html for abuse reporting information)
X-MHO-User: etheriau
Return-Path: <eric@eyt.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eric@eyt.ca
Precedence: bulk
X-list: linux-mips

On Mon, 29 Nov 2004, Thiemo Seufer wrote:
> This would be linux-utils, but be warned the fdisk code is competely
> FUBAR. I gave up on it when I realized that some mysterious segfaults
> ware caused by unaligned pointer arithmetic and/or conversion of some
> data to little endianness, and changing those would likely have broken
> fdisk for other architectures.
>
> A testcase which always "worked" for me on IP22: create a DVH with
> parted, and then try to read/change it with fdisk. Apparently
> parted poisons the DVH for fdisk. :-)

Could you provide me a link/contact to linux-util to submit such a patch? 
The change is that while the length of the partition properly takes into 
account the blocksize, it still sets the block size to 512 no matter what 
the actual block size is.  The change is to set this value to sector_size 
instead of hard coding 512.

Thanks for your assistance in this matter.



eyt*
--
Eric Y. Theriault
http://www.eyt.ca
