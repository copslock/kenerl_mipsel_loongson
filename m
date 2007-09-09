Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Sep 2007 09:43:16 +0100 (BST)
Received: from mailrelay009.isp.belgacom.be ([195.238.6.176]:44418 "EHLO
	mailrelay009.isp.belgacom.be") by ftp.linux-mips.org with ESMTP
	id S20021410AbXIIInH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 9 Sep 2007 09:43:07 +0100
Received: from 10.99-201-80.adsl-dyn.isp.belgacom.be (HELO infomag.iguana.be) ([80.201.99.10])
  by mailrelay009.isp.belgacom.be with ESMTP; 09 Sep 2007 10:43:01 +0200
X-Belgacom-Dynamic: yes
Received: from infomag.iguana.be (localhost.localdomain [127.0.0.1])
	by infomag.iguana.be (8.13.8/8.12.11) with ESMTP id l898lqBc003097;
	Sun, 9 Sep 2007 10:47:52 +0200
Received: (from wim@localhost)
	by infomag.iguana.be (8.13.8/8.13.8/Submit) id l898lqPA003096;
	Sun, 9 Sep 2007 10:47:52 +0200
Date:	Sun, 9 Sep 2007 10:47:52 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Nicolas Thill <nico@openwrt.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Christer Weinigel <wingel@nano-system.com>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Message-ID: <20070909084752.GB2654@infomag.infomag.iguana.be>
References: <200708201704.11529.technoboy85@gmail.com> <200709061731.26655.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709061731.26655.technoboy85@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Matteo,

> Driver for the watchdog timer. It worked with 2.4, doesn't does with 2.6.
> Apart that it doesn't reboots the device it works :)

Can you please explain this a bit more? Is this driver working under 2.4
(and also rebooting the device) but not under 2.6?

Thanks in advance,
Wim.
