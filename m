Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 21:56:07 +0100 (BST)
Received: from main6.ezpublishing.com ([IPv6:::ffff:216.121.96.152]:51471 "EHLO
	main6.ezpublishing.com") by linux-mips.org with ESMTP
	id <S8224918AbUJSUz7>; Tue, 19 Oct 2004 21:55:59 +0100
Received: from [10.0.0.7] (elk-righthand-router.dataflo.net [207.252.249.22])
	by main6.ezpublishing.com (8.9.3p2/8.9.3) with ESMTP id NAA29752;
	Tue, 19 Oct 2004 13:55:47 -0700
Message-ID: <41757F58.3030708@xmlink.net>
Date: Tue, 19 Oct 2004 15:55:52 -0500
From: GeoD <gdotts@xmlink.net>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: db1550 - sm501pci video - virtual console switch broken
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <gdotts@xmlink.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gdotts@xmlink.net
Precedence: bulk
X-list: linux-mips

Attempting to use virtual terminal switching on amd alchemy db1550.
kernel 2.4.26   driver smi501fb.c (AMD driver)

Single virtual terminal 1 login works so vt appears to be OK but
any attempt to switch to another vt fails crashing in fbcon_setup.
Cause is divide by zero - rows & cols in config are 0 (oops).

Tried using the Voyager driver from the SM site but it crashes on
boot when setting the console mode.

Anyone got any ideas while I try debugging fbcon_setup?

~GeoD
