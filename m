Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Feb 2005 14:38:35 +0000 (GMT)
Received: from imfep06.dion.ne.jp ([IPv6:::ffff:210.174.120.157]:24142 "EHLO
	imfep06.dion.ne.jp") by linux-mips.org with ESMTP
	id <S8225192AbVBZOhE>; Sat, 26 Feb 2005 14:37:04 +0000
Received: from [192.168.0.2] ([218.222.92.182]) by imfep06.dion.ne.jp
          (InterMail vM.4.01.03.31 201-229-121-131-20020322) with ESMTP
          id <20050226143651.MQJB23095.imfep06.dion.ne.jp@[192.168.0.2]>;
          Sat, 26 Feb 2005 23:36:51 +0900
Message-ID: <42208982.30201@mb.neweb.ne.jp>
Date:	Sat, 26 Feb 2005 23:36:50 +0900
From:	Nyauyama <ichinoh@mb.neweb.ne.jp>
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	Nyauyama <ichinoh@mb.neweb.ne.jp>
Subject: Question DbAu1500 PCI
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-Path: <ichinoh@mb.neweb.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ichinoh@mb.neweb.ne.jp
Precedence: bulk
X-list: linux-mips

Hello!

I have a problem about DbAu1500's PCI.

The PCI Configuration space of DbAu1500 is not seen by
the boot loader that I made.
However, if the PCI board is not installed in DbAu1500,
the Configuration space of PCI HOST is seen.

Have you ever encountered this phenomenon?

Nyauyama
