Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Dec 2004 08:46:58 +0000 (GMT)
Received: from [IPv6:::ffff:193.232.173.111] ([IPv6:::ffff:193.232.173.111]:1243
	"EHLO t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225002AbULTIqx>; Mon, 20 Dec 2004 08:46:53 +0000
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.12.11/8.12.11) with ESMTP id iBK8hFfg007114;
	Mon, 20 Dec 2004 11:43:16 +0300
Received: from t06.niisi.ras.ru (localhost.localdomain [127.0.0.1])
	by t06.niisi.ras.ru (8.12.8/8.12.8) with ESMTP id iBK8iJSO011229;
	Mon, 20 Dec 2004 11:44:19 +0300
Received: (from uucp@localhost)
	by t06.niisi.ras.ru (8.12.8/8.12.8/Submit) with UUCP id iBK8iJNA011227;
	Mon, 20 Dec 2004 11:44:19 +0300
Received: from [192.168.173.2] (t34 [193.232.173.34])
	by aa19.niisi.msk.ru (8.12.8/8.12.8) with ESMTP id iBK8RCZI017561;
	Mon, 20 Dec 2004 11:27:12 +0300
Message-ID: <41C690CF.2010306@niisi.msk.ru>
Date: Mon, 20 Dec 2004 11:43:59 +0300
From: "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wuming <wuming@ict.ac.cn>
CC: linux-mips@linux-mips.org
Subject: Re: problem about dma
References: <001501c4e646$7f676c00$6f64a8c0@spark>
In-Reply-To: <001501c4e646$7f676c00$6f64a8c0@spark>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: milter-spamc/0.13.216 (aa19 [172.16.0.19]); Mon, 20 Dec 2004 11:27:13 +0300
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

wuming wrote:
> Before the dma transfer, pci_map_sg will map the memory space covered by sg_table,
> and it will flush and invalidate cache indexed by that memory space.
> After the dma transfer, pci_unmap_sg also needs to be called to flush and invalidate
> the same cache. But I do not know why the second flush will be demanded.
> I think that in the interval between the two flush, there would be nothing to access
> the memory covered by the dma. But it is not the case.
> I want to know what can access that memory and I need some help.

In 2.4, memcpy's prefetch may (and, in practice, do, no smiles, it cost 
me a lot of time to realize) access that memory. I though it has been 
fixed in 2.6 someday.

Regards,
Gleb.
