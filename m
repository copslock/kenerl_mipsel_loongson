Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Apr 2003 09:15:40 +0100 (BST)
Received: from smtp-send.myrealbox.com ([IPv6:::ffff:192.108.102.143]:5283
	"EHLO smtp-send.myrealbox.com") by linux-mips.org with ESMTP
	id <S8225203AbTD2IP2> convert rfc822-to-8bit; Tue, 29 Apr 2003 09:15:28 +0100
Received: from yaelgilad [212.179.232.198] by myrealbox.com
	with NetMail ModWeb Module; Tue, 29 Apr 2003 08:15:23 +0000
Subject: getting cycles in 64 bit resolution
From: "Gilad Benjamini" <yaelgilad@myrealbox.com>
To: linux-mips@linux-mips.org
Date: Tue, 29 Apr 2003 08:15:23 +0000
X-Mailer: NetMail ModWeb Module
X-Sender: yaelgilad
MIME-Version: 1.0
Message-ID: <1051604123.bea267c0yaelgilad@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <yaelgilad@myrealbox.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Spam-Checker-Version: SpamAssassin 2.50 (1.173-2003-02-20-exp)
X-archive-position: 2225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yaelgilad@myrealbox.com
Precedence: bulk
X-list: linux-mips

Hi,
get_cycles provides me the low 32 bit of the number
of cycles.
How can I, in a 32 bit system, get the high 32 bit ?

TIA
