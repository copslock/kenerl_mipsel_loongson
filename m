Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jan 2005 14:45:04 +0000 (GMT)
Received: from schenk.ISAR.de ([IPv6:::ffff:212.14.78.13]:7244 "EHLO
	schenk.isar.de") by linux-mips.org with ESMTP id <S8225008AbVAROo7>;
	Tue, 18 Jan 2005 14:44:59 +0000
Received: from gwhaus.rt.schenk (gwhaus.rt.schenk [172.22.0.4])
	by schenk.isar.de (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0IEip429136
	for <linux-mips@linux-mips.org>; Tue, 18 Jan 2005 15:44:51 +0100
Received: from [172.22.10.24] (pcimr4.rt.schenk [172.22.10.24])
	by gwhaus.rt.schenk (8.11.6/8.11.6/SuSE Linux 0.5) with ESMTP id j0IEipi06439
	for <linux-mips@linux-mips.org>; Tue, 18 Jan 2005 15:44:51 +0100
Message-ID: <41ED20E3.60309@schenk.isar.de>
Date: Tue, 18 Jan 2005 15:44:51 +0100
From: Rojhalat Ibrahim <ibrahim@schenk.isar.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: More than 512MB of memory
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ibrahim@schenk.isar.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ibrahim@schenk.isar.de
Precedence: bulk
X-list: linux-mips

Hi,

is there anything special I have to do
when I want to use more than 512MB of memory?
My Yosemite board works fine with 512MB
but when I try 1GB it crashes in 32bit mode
with highmem and also in 64bit mode.
The boot monitor (PMON) maps the 1024MB
to physical addresses 0x0000.0000 - 0x4000.0000.

Thanks
Rojhalat Ibrahim
