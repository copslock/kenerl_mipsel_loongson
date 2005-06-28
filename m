Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Jun 2005 18:55:39 +0100 (BST)
Received: from [IPv6:::ffff:81.2.110.250] ([IPv6:::ffff:81.2.110.250]:31708
	"EHLO lxorguk.ukuu.org.uk") by linux-mips.org with ESMTP
	id <S8226064AbVF1RzX>; Tue, 28 Jun 2005 18:55:23 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by lxorguk.ukuu.org.uk (8.12.11/8.12.11) with ESMTP id j5SHqQ1v001236;
	Tue, 28 Jun 2005 18:52:27 +0100
Received: (from alan@localhost)
	by localhost.localdomain (8.12.11/8.12.11/Submit) id j5SHqQgr001235;
	Tue, 28 Jun 2005 18:52:26 +0100
X-Authentication-Warning: localhost.localdomain: alan set sender to alan@lxorguk.ukuu.org.uk using -f
Subject: Re: can't find interrupt number under /proc/interrupts for the pci
	multi-port on db1550
From:	Alan Cox <alan@lxorguk.ukuu.org.uk>
To:	rolf liu <rolfliu@gmail.com>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <2db32b720506280930a5de769@mail.gmail.com>
References: <2db32b720506271706201a66fb@mail.gmail.com>
	 <1119966279.32381.7.camel@localhost.localdomain>
	 <2db32b720506280930a5de769@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1119981143.32369.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date:	Tue, 28 Jun 2005 18:52:25 +0100
Return-Path: <alan@lxorguk.ukuu.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alan@lxorguk.ukuu.org.uk
Precedence: bulk
X-list: linux-mips

On Maw, 2005-06-28 at 17:30, rolf liu wrote:
> but the number of interrupts for that driver is always 0, which seems
> not OK. I am wondering if such interrupt is routed to somewhere else? 

I'd expect it to stay zero unless characters were received or events
occurred. Something like

   (echo "Hello world"; cat ) <> /dev/ttywhatever

ought to cause interrupts 

[That bit of script writes Hello world to the serial port and then
copies anything from it back to it until you hit ^C]
