Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2003 16:29:01 +0000 (GMT)
Received: from t111.niisi.ras.ru ([IPv6:::ffff:193.232.173.111]:13832 "EHLO
	t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225212AbTBGQ3A>; Fri, 7 Feb 2003 16:29:00 +0000
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id TAA32085;
	Fri, 7 Feb 2003 19:29:08 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id TAA23604; Fri, 7 Feb 2003 19:29:43 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34])
	by niisi.msk.ru (8.12.5/8.12.5) with ESMTP id h17GKTxl013989;
	Fri, 7 Feb 2003 19:20:30 +0300 (MSK)
Message-ID: <3E440894.1060509@niisi.msk.ru>
Date: Fri, 07 Feb 2003 19:27:16 +0000
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Guido Guenther <agx@sigxcpu.org>
CC: linux-mips@linux-mips.org
Subject: Re: Endianity problems in XFree86-4.2 XAA on MIPSEB
References: <3E43ECC6.8090109@niisi.msk.ru> <20030207154539.GA748@bogon.ms20.nix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <andreev@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreev@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Guido Guenther wrote:
> On Fri, Feb 07, 2003 at 05:28:38PM +0000, Alexandr Andreev wrote:
> 
>>We have a MipsEB machine and a video card which has a 2D BitBLT engine.
> 
> It would help a lot if you'd tell us what card you're using. Some of the
> drivers are more endian clean then others.

We have got our own card and our own driver, but it looks like this problem
is driver independant, because patterns are maked up in different ways 
for BE.


> Did you have a look at the XAA.HOWTO at:
>  xc/programs/Xserver/hw/xfree86/xaa
> especially the
>   BIT_ORDER_IN_BYTE_MSBFIRST
>   BIT_ORDER_IN_BYTE_LSBFIRST
> flags?
>  --Guido

Yes, but these flags specify bit ordering, not byte. And these flags 
work fine for
MipsEB.
