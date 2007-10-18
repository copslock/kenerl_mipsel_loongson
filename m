Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 09:19:12 +0100 (BST)
Received: from smtp2.int-evry.fr ([157.159.10.45]:44454 "EHLO
	smtp2.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20029445AbXJRITD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 09:19:03 +0100
Received: from meteor.local (unknown [157.159.47.35])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 818343EE481;
	Thu, 18 Oct 2007 10:18:55 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	Matteo Croce <technoboy85@gmail.com>
Subject: Re: [PATCH][MIPS][0/6] AR7: AR7 strikes back
Date:	Thu, 18 Oct 2007 10:22:09 +0200
User-Agent: KMail/1.9.6
Cc:	linux-mips@linux-mips.org, nico@openwrt.org, nbd@openwrt.org,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>
References: <200710110248.33028.technoboy85@gmail.com>
In-Reply-To: <200710110248.33028.technoboy85@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710181022.11385.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17114
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

Hi all,

Jeff Garzik merged the AR7 ethernet driver and Wim Van Sebroeck merged the 
watchdog driver.

Is there anything that needs some cleanup for a linux-mips inclusion ?

On Thursday 11 October 2007 02:48:32 Matteo Croce wrote:
> Here are the new patches made against latest 2.6.23 git tree
