Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2005 17:47:38 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.183]:23232
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225981AbVF0QrX>; Mon, 27 Jun 2005 17:47:23 +0100
Received: from p54A2A924.dip0.t-ipconnect.de [84.162.169.36] (helo=[192.168.178.44])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML2Dk-1Dmwkz3khq-0006ka; Mon, 27 Jun 2005 18:46:49 +0200
Message-ID: <42C02DB5.9010206@cantastic.de>
Date:	Mon, 27 Jun 2005 18:47:49 +0200
From:	=?ISO-8859-15?Q?Ralf_R=F6sch?= <linux@cantastic.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [PATCH]  tx4927_setup.c Get rid of early_init ...
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:fe0074b40cafaf3a4e4a4699a3836908
Return-Path: <linux@cantastic.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@cantastic.de
Precedence: bulk
X-list: linux-mips

This patch leaves the TX4927 board without an board setup handler
and the linker ends with an unknown plat_setup() error.
I would propose the following patch:

Index: arch/mips/tx4927/common/tx4927_setup.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/tx4927/common/tx4927_setup.c,v
retrieving revision 1.8
diff -u -r1.8 tx4927_setup.c
--- arch/mips/tx4927/common/tx4927_setup.c      21 Jun 2005 13:56:32 -00001.8
+++ arch/mips/tx4927/common/tx4927_setup.c      27 Jun 2005 16:43:39 -0000
@@ -64,7 +64,7 @@
 }


-static void __init tx4927_setup(void)
+void __init plat_setup(void)
 {
        board_time_init = tx4927_time_init;
        board_timer_setup = tx4927_timer_setup;

--
  Ralf
