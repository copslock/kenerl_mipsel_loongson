Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Mar 2003 08:33:22 +0000 (GMT)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:27241
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8224851AbTCZIdV> convert rfc822-to-8bit; Wed, 26 Mar 2003 08:33:21 +0000
Received: from yaelgilad [81.218.95.46] by myrealbox.com
	with NetMail ModWeb Module; Wed, 26 Mar 2003 08:33:21 +0000
Subject: Relative Checksum
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: linux-mips@linux-mips.org
Date: Wed, 26 Mar 2003 08:33:21 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1048667601.7d003520yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1810
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

Hi,
ip_fast_csum provides an asm version for IP checksum.
Any available mips-asm implementation out there for 
a relative checksum?

i.e. I get a packet, change
a field or two, and want to compute just the 
change in the checksum.
