Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2005 08:23:49 +0000 (GMT)
Received: from smtp2.wanadoo.fr ([IPv6:::ffff:193.252.22.29]:50410 "EHLO
	smtp2.wanadoo.fr") by linux-mips.org with ESMTP id <S8225221AbVAKIXo>;
	Tue, 11 Jan 2005 08:23:44 +0000
Received: from me-wanadoo.net (unknown [127.0.0.1])
	by mwinf0207.wanadoo.fr (SMTP Server) with ESMTP id 77A8B1C003E1
	for <linux-mips@linux-mips.org>; Tue, 11 Jan 2005 09:23:38 +0100 (CET)
Received: from smtp.innova-card.com (AMarseille-206-1-6-143.w80-14.abo.wanadoo.fr [80.14.198.143])
	by mwinf0207.wanadoo.fr (SMTP Server) with ESMTP id 52B1F1C00352
	for <linux-mips@linux-mips.org>; Tue, 11 Jan 2005 09:23:38 +0100 (CET)
Received: from [192.168.0.24] (spoutnik.innova-card.com [192.168.0.24])
	by smtp.innova-card.com (Postfix) with ESMTP id 68B1E3800C
	for <linux-mips@linux-mips.org>; Tue, 11 Jan 2005 09:23:32 +0100 (CET)
Message-ID: <41E38CDA.0@innova-card.com>
Date: Tue, 11 Jan 2005 09:22:50 +0100
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: [PATCH] setup.c (clean up only)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <franck.bui-huu@innova-card.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: franck.bui-huu@innova-card.com
Precedence: bulk
X-list: linux-mips

Hi,

Here is a patch that contains some clean up for bootmem_init()
function. It should be (...well I hope so :-) ) a little bit more
readable than previous versions.

Now IP27's specific code could be easly moved into its boot
memory init. Look for FIXME pattern...

    Franck.
