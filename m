Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2005 16:56:20 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.171]:6394 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225804AbVFFP4E>; Mon, 6 Jun 2005 16:56:04 +0100
Received: from p54A2929F.dip0.t-ipconnect.de [84.162.146.159] (helo=[192.168.178.44])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0MKwh2-1DfJxK2Cy7-0007Gr; Mon, 06 Jun 2005 17:56:02 +0200
Message-ID: <42A47252.2010906@cantastic.de>
Date:	Mon, 06 Jun 2005 17:57:06 +0200
From:	=?ISO-8859-15?Q?Ralf_R=F6sch?= <linux@cantastic.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Compiler warnings / linux-2.6
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fe0074b40cafaf3a4e4a4699a3836908
Return-Path: <linux@cantastic.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@cantastic.de
Precedence: bulk
X-list: linux-mips

Since a few days I get a lot of compiler warnings:

include2/asm/dsp.h: In function `__init_dsp':
include2/asm/dsp.h:34: warning: statement with no effect

What could I do to prevent these?

Thanks
    Ralf
