Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Mar 2003 09:07:35 +0000 (GMT)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:45145
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225201AbTCBJHf> convert rfc822-to-8bit; Sun, 2 Mar 2003 09:07:35 +0000
Received: from yaelgilad [81.218.92.190] by myrealbox.com
	with NetMail ModWeb Module; Sun, 02 Mar 2003 09:07:28 +0000
Subject: Static variables and "gp"
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: linux-mips@linux-mips.org
Date: Sun, 02 Mar 2003 09:07:28 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1046596048.d43b0c00yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

Hi,
How can I force a specific static variable to be used by the "gp" register
rather than by a two-step load ?
Compiling a mips-linux using gcc.

I was poking around for information and stumbled across the "-G" flag,
the "__attribute__ ((section (".sdata")))" (or sbss), the "-msdata" but to no avail.
I only got more confused.

Any help will be appreciated
