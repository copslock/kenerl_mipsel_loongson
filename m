Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2003 17:02:14 +0100 (BST)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:182 "EHLO
	smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225425AbTIRQCM> convert rfc822-to-8bit; Thu, 18 Sep 2003 17:02:12 +0100
Received: from yaelgilad [81.218.80.94] by myrealbox.com
	with NetMail ModWeb Module; Thu, 18 Sep 2003 16:02:10 +0000
Subject: High mem and static memory
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: linux-mips@linux-mips.org
Date: Thu, 18 Sep 2003 16:02:11 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1063900931.725cf2a0yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

Hi,
We have already implemented the following scheme:
In our firmware, we define an area of memory as
un-usable.
In the kernel, we access this memory based on fixed
addresses.
This area of memory is approximately around 200-200Mb
at the bottom of the memory.

Is there anything preventing me from moving this
region to high-mem, around 500Mb (my total memory is 512) ?
