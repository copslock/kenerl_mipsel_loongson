Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Mar 2003 12:41:42 +0000 (GMT)
Received: from t111.niisi.ras.ru ([IPv6:::ffff:193.232.173.111]:51295 "EHLO
	t111.niisi.ras.ru") by linux-mips.org with ESMTP
	id <S8225227AbTCCMll>; Mon, 3 Mar 2003 12:41:41 +0000
Received: from t06.niisi.ras.ru (t06.niisi.ras.ru [193.232.173.6])
	by t111.niisi.ras.ru (8.9.1/8.9.1) with ESMTP id PAA11729
	for <linux-mips@linux-mips.org>; Mon, 3 Mar 2003 15:41:42 +0300
Received: (from uucp@localhost) by t06.niisi.ras.ru (8.7.6/8.7.3) with UUCP id PAA32236 for linux-mips@linux-mips.org; Mon, 3 Mar 2003 15:54:37 +0300
Received: from niisi.msk.ru (t34 [193.232.173.34])
	by niisi.msk.ru (8.12.5/8.12.5) with ESMTP id h23C2Iuj006018
	for <linux-mips@linux-mips.org>; Mon, 3 Mar 2003 15:02:19 +0300 (MSK)
Message-ID: <3E6370F1.3030603@niisi.msk.ru>
Date: Mon, 03 Mar 2003 15:12:49 +0000
From: Alexandr Andreev <andreev@niisi.msk.ru>
Organization: niisi
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: HIGMEM and boot ROM
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <andreev@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1599
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreev@niisi.msk.ru
Precedence: bulk
X-list: linux-mips

Hi.
As i understand, MIPS Linux does not support DISCONTIGMEM yet.
But what I have to do, if my MIPS32 station has more than 512 Mb of
physical ram. I can set HIGMEM for my station, but how can I
avoid boot ROM region, which is at 0x1FC00000. I can avoid these
4Mbytes of memory in memory allocation routines, but I suppose that
there are some better solutions in MIPS linux. How do other MIPSes work?

Thanks in advance.
