Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 09:53:30 +0000 (GMT)
Received: from outmail1.freedom2surf.net ([194.106.33.237]:59589 "EHLO
	outmail1.freedom2surf.net") by ftp.linux-mips.org with ESMTP
	id S28771549AbXAPJxZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 09:53:25 +0000
Received: from [172.16.97.170] (f2s.colonel-panic.org [83.67.53.76])
	by outmail1.freedom2surf.net (Postfix) with ESMTP
	id 6590324CA14; Tue, 16 Jan 2007 09:53:19 +0000 (GMT)
Message-ID: <45ACA08F.8000203@bitbox.co.uk>
Date:	Tue, 16 Jan 2007 09:53:19 +0000
From:	Peter Horton <phorton@bitbox.co.uk>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To:	Florian Fainelli <florian.fainelli@int-evry.fr>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for Cobalt Server front LED
References: <200701151936.57738.florian.fainelli@int-evry.fr>
In-Reply-To: <200701151936.57738.florian.fainelli@int-evry.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13606
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Florian Fainelli wrote:
> 
> This patch adds support for controlling the front LED on Cobalt Server. It has 
> been tested on Qube 2 with either no default trigger, or the IDE-activity 
> trigger. Both work fine. Please comment and test !
>

Why did you add COBALT_LED_BASE when there was already a COBALT_LED_PORT 
define on the line above ?

All your

	*(volatile uint8_t *) COBALT_LED_BASE = n;

can be replaced by

	COBALT_LED_PORT = n;

P.
