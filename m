Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Feb 2003 12:13:54 +0000 (GMT)
Received: from sonicwall.montavista.co.jp ([IPv6:::ffff:202.232.97.131]:3650
	"EHLO yuubin.montavista.co.jp") by linux-mips.org with ESMTP
	id <S8224939AbTBXMNy>; Mon, 24 Feb 2003 12:13:54 +0000
Received: from pudding.montavista.co.jp ([10.200.0.40])
	by yuubin.montavista.co.jp (8.12.5/8.12.5) with SMTP id h1OCJa44008899;
	Mon, 24 Feb 2003 21:19:37 +0900
Date: Mon, 24 Feb 2003 21:07:55 +0900
From: Yoichi Yuasa <yoichi_yuasa@montavista.co.jp>
To: ralf@linux-mips.org
Cc: yoichi_yuasa@montavista.co.jp, linux-mips@linux-mips.org
Subject: Change -mcpu option for VR41xx
Message-Id: <20030224210755.1f5fac0a.yoichi_yuasa@montavista.co.jp>
Organization: MontaVista Software Japan, Inc.
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yoichi_yuasa@montavista.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1533
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yoichi_yuasa@montavista.co.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

We need to change -mcpu in order to use an instruction peculiar to VR4100.
The option of -mcpu changes with versions of binutils.

If it is limited to some versions, I can be corresponded using check_gcc.
Can you tell me some versions of binutils?

Yoichi
