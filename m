Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 20:37:56 +0100 (BST)
Received: from mailrelay010.isp.belgacom.be ([195.238.6.177]:2158 "EHLO
	mailrelay010.isp.belgacom.be") by ftp.linux-mips.org with ESMTP
	id S20023615AbXILThs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 12 Sep 2007 20:37:48 +0100
Received: from 174.218-200-80.adsl-dyn.isp.belgacom.be (HELO infomag.iguana.be) ([80.200.218.174])
  by mailrelay010.isp.belgacom.be with ESMTP; 12 Sep 2007 21:36:41 +0200
X-Belgacom-Dynamic: yes
Received: from infomag.iguana.be (localhost.localdomain [127.0.0.1])
	by infomag.iguana.be (8.13.8/8.12.11) with ESMTP id l8CJfc46003132;
	Wed, 12 Sep 2007 21:41:38 +0200
Received: (from wim@localhost)
	by infomag.iguana.be (8.13.8/8.13.8/Submit) id l8CJfbwO003131;
	Wed, 12 Sep 2007 21:41:37 +0200
Date:	Wed, 12 Sep 2007 21:41:37 +0200
From:	Wim Van Sebroeck <wim@iguana.be>
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org, Nicolas Thill <nico@openwrt.org>,
	Enrik Berkhan <Enrik.Berkhan@akk.org>,
	Christer Weinigel <wingel@nano-system.com>
Subject: Re: [PATCH][MIPS][5/7] AR7: watchdog timer
Message-ID: <20070912194137.GC2901@infomag.infomag.iguana.be>
References: <200708201704.11529.technoboy85@gmail.com> <200709061731.26655.technoboy85@gmail.com> <20070909084752.GB2654@infomag.infomag.iguana.be> <200709092019.43471.technoboy85@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200709092019.43471.technoboy85@gmail.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <wim@iguana.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wim@iguana.be
Precedence: bulk
X-list: linux-mips

Hi Matteo,

> > > Driver for the watchdog timer. It worked with 2.4, doesn't does with 2.6.
> > > Apart that it doesn't reboots the device it works :)
> > 
> > Can you please explain this a bit more? Is this driver working under 2.4
> > (and also rebooting the device) but not under 2.6?
> 
> Exactly.
> A guy had it working with the attached patch but it doesn't works for me.

I'll have a look at the driver this weekend.

Greetings,
Wim.
