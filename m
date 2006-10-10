Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Oct 2006 16:22:49 +0100 (BST)
Received: from mailserver.astro.rug.nl ([129.125.6.166]:31635 "EHLO
	mailserver.intra.astro.rug.nl") by ftp.linux-mips.org with ESMTP
	id S20039896AbWJJPWp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Oct 2006 16:22:45 +0100
Received: from [145.99.147.181] (guesswhos.boldlygoingnowhere.org [145.99.147.181])
	(authenticated bits=0)
	by mailserver.intra.astro.rug.nl (8.12.11.20060308/8.12.11) with ESMTP id k9AFMccp003947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-mips@linux-mips.org>; Tue, 10 Oct 2006 17:22:38 +0200
Message-ID: <452BBB03.2080709@gmail.com>
Date:	Tue, 10 Oct 2006 17:23:47 +0200
From:	Maarten Lankhorst <M.B.Lankhorst@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: [MIPS] Add bcm947xx support [5/5]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <M.B.Lankhorst@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: M.B.Lankhorst@gmail.com
Precedence: bulk
X-list: linux-mips

Add support for the leds in this device. (I know, I forgot 'depends on' 
in Kconfig)
