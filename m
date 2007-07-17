Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2007 08:57:07 +0100 (BST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:62631 "EHLO
	t111.niisi.ras.ru") by ftp.linux-mips.org with ESMTP
	id S20023136AbXGQH5E (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jul 2007 08:57:04 +0100
Received: from t111.niisi.ras.ru (localhost [127.0.0.1])
	by t111.niisi.ras.ru (8.13.4/8.13.4) with ESMTP id l6H7ug2i025979;
	Tue, 17 Jul 2007 11:56:42 +0400
Received: (from uucp@localhost)
	by t111.niisi.ras.ru (8.13.4/8.13.4/Submit) with UUCP id l6H7ugtW025973;
	Tue, 17 Jul 2007 11:56:42 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id l6H7swGh017278;
	Tue, 17 Jul 2007 11:54:58 +0400
Message-ID: <469C75BC.5040501@niisi.msk.ru>
Date:	Tue, 17 Jul 2007 11:54:36 +0400
From:	"Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Sergey Rogozhkin <rogozhkin@niisi.msk.ru>, kumba@gentoo.org,
	linux-mips@linux-mips.org
Subject: Re: O2 RM7000 Issues
References: <4687DCE2.8070302@gentoo.org> <468825BE.6090001@gmx.net> <50451.70.107.91.207.1183381723.squirrel@webmail.wesleyan.edu> <20070704152729.GA2925@linux-mips.org> <20070704192208.GA7873@linux-mips.org> <469B5C2E.5080905@niisi.msk.ru> <20070716123343.GA13439@linux-mips.org>
In-Reply-To: <20070716123343.GA13439@linux-mips.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15785
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Ralf,

Considering RM7k the latest kernel improperly sets some hazards. At 
least, mtc0_tlbw_hazard and tlbw_use_hazard shall contain 4 nops, not 2.

Also, there shall be 10 nops after modification of the K0 field of the 
config register. The suspicious place I see is in 
arch/mips/mm/c-r4k.c:coherency_setup():
	change_c0_config(CONF_CM_CMASK, CONF_CM_DEFAULT);

If the K0 field has the value different than CONF_CM_DEFAULT, we 
definitely need nops here and, I'm afraid, even the line shall be 
executed uncached.

Strictly speaking, manual doesn't clearly define the term 
"modification". I expect, if I write the same value in the K0 field, it 
doesn't consider "modification".

And I guess all boards with RM7k select DMA_NONCOHERENT. Otherwise, 
CONF_CM_DEFAULT will have a garbage in case of RM7k. Perhaps, it's worth
to select DMA_NONCOHERENT inside the "config CPU_RM7000" block.

Regards,
Gleb.
