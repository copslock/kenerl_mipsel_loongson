Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Oct 2007 21:27:30 +0100 (BST)
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:48570 "EHLO
	mailrelay003.isp.belgacom.be") by ftp.linux-mips.org with ESMTP
	id S20024774AbXJGU1W (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 7 Oct 2007 21:27:22 +0100
X-Belgacom-Dynamic: yes
Received: from 150.2-200-80.adsl-dyn.isp.belgacom.be (HELO infomag.iguana.be) ([80.200.2.150])
  by relay.skynet.be with ESMTP; 07 Oct 2007 22:26:15 +0200
Received: from infomag.iguana.be (localhost.localdomain [127.0.0.1])
	by infomag.iguana.be (8.13.8/8.12.11) with ESMTP id l97KVuRq003439;
	Sun, 7 Oct 2007 22:31:56 +0200
Received: (from wim@localhost)
	by infomag.iguana.be (8.13.8/8.13.8/Submit) id l97KVrxN003438;
	Sun, 7 Oct 2007 22:31:53 +0200
Date:	Sun, 7 Oct 2007 22:31:53 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Nicolas Thill <nico@openwrt.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Christer Weinigel <wingel@nano-system.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Message-ID: <20071007203153.GA2666@infomag.infomag.iguana.be>
References: <200709201728.10866.technoboy85@gmail.com> <200709201806.41942.technoboy85@gmail.com> <20071003192414.GA7543@infomag.infomag.iguana.be> <40101cc30710031317n360ea4c7y6491f549c62e3edb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40101cc30710031317n360ea4c7y6491f549c62e3edb@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16881
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Matteo,

> > If you want I'll add it to the linux-2.6-watchdog-mm tree with
> > the above mentioned changes.
> Yes, please

It's in the linux-2.6-watchdog-mm tree. I added an extra iounmap in the
errorhandling of the init procedure.

Please test.

Thanks,
Wim.
