Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Feb 2005 15:42:12 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:23077 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8224942AbVBIPl4>;
	Wed, 9 Feb 2005 15:41:56 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j19FfYH11240;
	Wed, 9 Feb 2005 16:41:34 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j19FfXc23637;
	Wed, 9 Feb 2005 16:41:33 +0100
Message-ID: <420A2F2D.8050404@schenk.isar.de>
Date:	Wed, 09 Feb 2005 16:41:33 +0100
From:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: More than 512MB of memory
References: <41ED20E3.60309@schenk.isar.de> <20050204004028.GC22311@linux-mips.org> <42072264.6000001@schenk.isar.de> <20050208001742.GA15336@linux-mips.org> <42088CFA.6090605@schenk.isar.de>
In-Reply-To: <42088CFA.6090605@schenk.isar.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Rojhalat Ibrahim wrote:
> Furthermore I still have all those
> "Illegal instruction" and "Segmentation fault" messages that
> shouldn't be there.
> 

Those messages actually go away when I do not
define cpu_has_64bit_gp_regs, which is strange
because the RM9000 definitely has 64bit gp regs.
Any ideas?

Thanks
Rojhalat Ibrahim
