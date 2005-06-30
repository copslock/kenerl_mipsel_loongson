Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Jun 2005 20:17:16 +0100 (BST)
Received: from anchor-post-35.mail.demon.net ([IPv6:::ffff:194.217.242.85]:57874
	"EHLO anchor-post-35.mail.demon.net") by linux-mips.org with ESMTP
	id <S8226101AbVF3TQ4>; Thu, 30 Jun 2005 20:16:56 +0100
Received: from pr-webmail-1.demon.net ([194.159.244.51] helo=pr-webmail-1.mail.demon.net)
	by anchor-post-35.mail.demon.net with esmtp (Exim 4.42)
	id 1Do4Si-000LPs-HS; Thu, 30 Jun 2005 19:12:36 +0000
Received: from localhost ([127.0.0.1] helo=web.mail.demon.net)
	by pr-webmail-1.mail.demon.net with smtp (Exim 4.42)
	id 1Do4Wg-0005bB-2V; Thu, 30 Jun 2005 20:16:42 +0100
Received: from skylon.demon.co.uk ([81.104.197.162])
	by web.mail.demon.net with http; Thu, 30 Jun 2005 20:16:42 +0100
From:	jrc@skylon.demon.co.uk
To:	maxim@mox.ru, ralf@linux-mips.org
Cc:	"Krishna B S" <bskris@gmail.com>, linux-mips@linux-mips.org
In-Reply-To: <6097c49050630030859b061c5@mail.gmail.com>
Subject: Re: Popular MIPS4Kc boards?
Date:	Thu, 30 Jun 2005 20:16:42 +0100
User-Agent: Demon-WebMail/2.0
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <20050630191656Z8226101-3678+743@linux-mips.org>
Return-Path: <jrc@skylon.demon.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8273
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jrc@skylon.demon.co.uk
Precedence: bulk
X-list: linux-mips

maxim.osipov@gmail.com wrote:
> And if we talk about fan project, are there any MIPS64 based devices
> on market?

A possibility for a MIPS64 based device might be the recently announced
Broadcom BCM97398 IPTV set-top box reference design platform:

    http://tinyurl.com/bm44b

This contains a BCM7038 with a 300 MHz R5Kf together with enough
peripherals to make it interesting: 2 x UART; 2 x SATA; 2 x USB 2.0;
10/100 Ethernet.  If produced in quantity and available it would
probably be more affordable than low volume evaluation boards.

What I would like to see is a multicore (multithreading?) MIPS64 chip
attached by HyperTransport to a PC chipset (eg. Via KN800A) on a small
form factor board (mini-itx; micro-atx; micro-btx).  An ideal plaything
for the kernel hacker and a useful resource for academic teaching and
research - a modern version of the UNSW U4600 ...
