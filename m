Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Jan 2005 15:23:02 +0000 (GMT)
Received: from imfep06.dion.ne.jp ([IPv6:::ffff:210.174.120.157]:54021 "EHLO
	imfep06.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8224802AbVAaPWr>; Mon, 31 Jan 2005 15:22:47 +0000
Received: from [192.168.0.2] ([61.198.202.135]) by imfep06.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with ESMTP
          id <20050131152242.DZTR23095.imfep06.dion.ne.jp@[192.168.0.2]>
          for <linux-mips@linux-mips.org>; Tue, 1 Feb 2005 00:22:42 +0900
Message-ID: <41FE4D3F.8090003@mb.neweb.ne.jp>
Date:	Tue, 01 Feb 2005 00:22:39 +0900
From:	Nyauyama <ichinoh@mb.neweb.ne.jp>
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Problem of Au1100 uart3
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Hello,

I have the problem of Au1100 uart3.

After some data is received to UART3, the character can be transmitted
from UART3.
However, it is not possible to transmit as long as it doesn't receive
the data.

Has someone encountered this phenomenon?

Regards,
Nyauyama.
