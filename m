Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jan 2005 11:10:26 +0000 (GMT)
Received: from smtp4.wanadoo.fr ([IPv6:::ffff:193.252.22.27]:47027 "EHLO
	smtp4.wanadoo.fr") by linux-mips.org with ESMTP id <S8225305AbVAJLKV>;
	Mon, 10 Jan 2005 11:10:21 +0000
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0406.wanadoo.fr (SMTP Server) with ESMTP id 4BF791C00620
	for <linux-mips@linux-mips.org>; Mon, 10 Jan 2005 12:10:15 +0100 (CET)
Received: from smtp.innova-card.com (AMarseille-206-1-6-143.w80-14.abo.wanadoo.fr [80.14.198.143])
	by mwinf0406.wanadoo.fr (SMTP Server) with ESMTP id 24FA61C000FC
	for <linux-mips@linux-mips.org>; Mon, 10 Jan 2005 12:10:15 +0100 (CET)
Received: from [192.168.0.24] (spoutnik.innova-card.com [192.168.0.24])
	by smtp.innova-card.com (Postfix) with ESMTP id 2318D38023
	for <linux-mips@linux-mips.org>; Mon, 10 Jan 2005 12:10:09 +0100 (CET)
Message-ID: <41E26267.2090300@innova-card.com>
Date: Mon, 10 Jan 2005 12:09:27 +0100
From: Franck Bui-Huu <franck.bui-huu@innova-card.com>
Reply-To: franck.bui-huu@innova-card.com
Organization: Innova Card
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: CPHYSADDR in setup.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <franck.bui-huu@innova-card.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: franck.bui-huu@innova-card.com
Precedence: bulk
X-list: linux-mips

Hi

I have noticed that someone has comitted some changes because
of 64 bits proc and specially added CPHYSADDR macro in
resource_init function. Is it really needed to add specific code
in setup.c ? Couldn't we modify "virt_to_phys" or "__pa"
instead of ?

I think we should get ride of this CPHYSADDR macro if
it's possible.

Thanks for your answers.

    Franck
