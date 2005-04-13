Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Apr 2005 19:35:35 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:41005 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225932AbVDMSfT>; Wed, 13 Apr 2005 19:35:19 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 13 Apr 2005 14:30:45 -0400
Message-ID: <425D665F.5080605@timesys.com>
Date:	Wed, 13 Apr 2005 14:35:11 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: USB on malta
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Apr 2005 18:30:45.0062 (UTC) FILETIME=[E7D26E60:01C54056]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Has anyone tried USB on malta recently? It's turned off on the default 
config. Turning it on an plugging something in results in:

uhci_hcd 0000:00:0a.2: host system error, PCI problems?
uhci_hcd 0000:00:0a.2: host controller process error, something bad 
happened!
uhci_hcd 0000:00:0a.2: host controller halted, very bad!
usb 1-1: khubd timed out on ep0in
usb 1-1: unable to read config index 0 descriptor/start
usb 1-1: can't read configurations, error -145
usb 1-1: khubd timed out on ep0in
usb 1-1: khubd timed out on ep0out
eth0: transmit timed out, status 06f3, resetting.
usb 1-1: khubd timed out on ep0out
usb 1-1: device not accepting address 3, error -145

And what appaears to be no more interrupts.

Has anyone chased this yet?

Greg Weeks
