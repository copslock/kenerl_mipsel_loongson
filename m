Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 06:16:29 +0000 (GMT)
Received: from mail.baslerweb.com ([IPv6:::ffff:145.253.187.130]:41675 "EHLO
	mail.baslerweb.com") by linux-mips.org with ESMTP
	id <S8224898AbUKVGQY>; Mon, 22 Nov 2004 06:16:24 +0000
Received: (from mail@localhost)
	by mail.baslerweb.com (8.12.10/8.12.10) id iAM6E4HN012332
	for <linux-mips@linux-mips.org>; Mon, 22 Nov 2004 07:14:04 +0100
Received: from unknown by gateway id /var/KryptoWall/smtpp/kwL0JuON; Mon Nov 22 07:13:05 2004
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Manish Lachwani <mlachwani@mvista.com>
Subject: titan code question
Date: Fri, 19 Nov 2004 16:23:14 +0100
User-Agent: KMail/1.6.2
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
X-KMail-Identity: 87982748
Message-Id: <200411191623.14760.thomas.koeller@baslerweb.com>
X-KMail-EncryptionState: N
X-KMail-SignatureState: N
X-KMail-MDN-Sent: 
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: <Thomas.Koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6393
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Hi Manish & Ralf,

the code below is from tian_ge.c:

	/*
	 * This is the 1.2 revision of the chip. It has fix for the
	 * IP header alignment. Now, the IP header begins at an
	 * aligned address and this wont need an extra copy in the
	 * driver. This performance drawback existed in the previous
	 * versions of the silicon
	 */
	reg_data_1 = TITAN_GE_READ(0x103c + (port_num << 12));
	reg_data_1 |= 0x40000000;
	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);

	reg_data_1 |= 0x04000000;
	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);

	mdelay(5);

	reg_data_1 &= ~(0x04000000);
	TITAN_GE_WRITE((0x103c + (port_num << 12)), reg_data_1);

	mdelay(5);


According to the RM9000 user manual, register 0x103c (and 0x203c
and 0x303c), named TTPRI0, contains eight four-bit fields, each
of which is a packet priority value. This would be used to find
the priority for incoming packets.

Given the register description in the cpu manual, I cannot make
any sense of the code above. Whoever did that, would you care to
explain?

thanks,
Thomas
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
