Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Jan 2004 23:16:19 +0000 (GMT)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:52346
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225226AbUARXQS> convert rfc822-to-8bit; Sun, 18 Jan 2004 23:16:18 +0000
Received: from yaelgilad [82.166.46.79] by myrealbox.com
	with NetMail ModWeb Module; Sun, 18 Jan 2004 23:16:20 +0000
Subject: "-G" optimizations
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: linux-mips@linux-mips.org
Date: Sun, 18 Jan 2004 23:16:20 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1074467780.c913e0a0yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

Hi,
If I understand correctly, "-G" flag tells gcc that
static variables below a certain size are placed
in a small area that allows easier access to them by
avoiding the two step load.
Ralf's reply to a question on the same issue I posted
a year ago, implied that this optimization is not
available in mips kernel.
Is it ?

I ran into an existing project where the kernel
was compiled with "-G0" while a module was compiled
with "-G8".
Is this a legal combination ?
If it isn't, what could the implications be ?
TIA
