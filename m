Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 11:15:33 +0100 (BST)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:22647
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225196AbTDVKPc> convert rfc822-to-8bit; Tue, 22 Apr 2003 11:15:32 +0100
Received: from yaelgilad [81.218.83.49] by myrealbox.com
	with NetMail ModWeb Module; Tue, 22 Apr 2003 10:15:32 +0000
Subject: RE: Crash on insmod
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Date: Tue, 22 Apr 2003 10:15:32 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1051006532.8589a060yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

This is the interesting part from the oops message:

Using /lib/modules/2.4.20-pre6-sb20021114 ...
unable to handle kernel paging request at virtual address 00006e76, epc == c0005100, ra == 80117e08
Oops in fault.c::do_page_fault, line 224:
