Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2005 08:07:11 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:42787 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224915AbVBIIGx>;
	Wed, 9 Feb 2005 08:06:53 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1986hH08172;
	Wed, 9 Feb 2005 09:06:43 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j1986gc19514;
	Wed, 9 Feb 2005 09:06:43 +0100
Message-ID: <4209C492.4050201@schenk.isar.de>
Date:	Wed, 09 Feb 2005 09:06:42 +0100
From:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
References: <41ED20E3.60309@schenk.isar.de> <20050204004028.GC22311@linux-mips.org> <42072264.6000001@schenk.isar.de> <20050208001742.GA15336@linux-mips.org> <42088CFA.6090605@schenk.isar.de> <20050209000640.GA10651@linux-mips.org>
In-Reply-To: <20050209000640.GA10651@linux-mips.org>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Feb 08, 2005 at 10:57:14AM +0100, Rojhalat Ibrahim wrote:
> 
> 
>>I presume CKSEG is CKSEG0 in the above patch. With that it works
>>about the same as before. So do you have any clue what the problem
>>behind all that really is? Furthermore I still have all those
>>"Illegal instruction" and "Segmentation fault" messages that
>>shouldn't be there.
> 
> 
> Sorry, yes I indeed meant CKSEG0. And this version of the patch really was
> only meant to optimize the large performance impact your previous patch
> had; it wasn't meant to fix anything beyond that.
> 
> As I can't replicate your configuration I'm still starring at the code to
> find what's wrong ...
> 
>   Ralf
> 

Ok, thanks. If I can try anything that might help track down
the problem, please let me know.

Rojhalat
