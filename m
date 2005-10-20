Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2005 23:23:44 +0100 (BST)
Received: from baldrick.bootc.net ([83.142.228.48]:21680 "EHLO
	baldrick.bootc.net") by ftp.linux-mips.org with ESMTP
	id S3465735AbVJTWXX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Oct 2005 23:23:23 +0100
Received: from [192.168.1.3] (cpc4-hudd6-3-1-cust172.hudd.cable.ntl.com [82.21.103.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by baldrick.bootc.net (Postfix) with ESMTP id 185621400C00
	for <linux-mips@linux-mips.org>; Thu, 20 Oct 2005 23:23:19 +0100 (BST)
Message-ID: <435818D5.7080807@bootc.net>
Date:	Thu, 20 Oct 2005 23:23:17 +0100
From:	Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [Slightly-OT] VR4110 core
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at bootc.plus.com
Return-Path: <bootc@bootc.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bootc@bootc.net
Precedence: bulk
X-list: linux-mips

Hi All,

I'm in my final year doing a BSc Computing Science degree in the UK, and 
for my project/dissertation I've chosen to attempt to get Linux to run 
on an old Sky Digibox (PACE 2500N) set-top-box. So far my research has 
revealed the CPU has is a NEC VR4110 core with lots of MPEG and graphics 
processing stuff tacked on. The board itself is quite interesting, with 
a PC-Card slot, audio out, 2x SCART, RF-out, modem, and serial connection.

I was just wondering if anyone had any suggestions regarding what kernel 
to use (it seems as though the best would be 2.4, is this correct?), or 
any knowledge whatsoever of similar chips and especially how to 
bootstrap, etc...

I'm currently reading Sweetman's "See MIPS Run" which is a great book, 
but I'm curious as to how much the chip differs from what's documented 
therein. NEC seem to have lost the documentation about this chip, so 
they're no help...

Many thanks,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/
