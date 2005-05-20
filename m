Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 May 2005 10:19:44 +0100 (BST)
Received: from smtp.wicomtechnologies.com ([IPv6:::ffff:195.234.214.162]:8138
	"EHLO smtp.wicomtechnologies.com") by linux-mips.org with ESMTP
	id <S8226374AbVETJT3>; Fri, 20 May 2005 10:19:29 +0100
Received: from jerry (wcm-24.wicom.kiev.ua [192.168.0.24] (may be forged))
	by smtp.wicomtechnologies.com (8.12.10/8.12.10) with ESMTP id j4K9JIwK093571;
	Fri, 20 May 2005 12:19:18 +0300 (EEST)
	(envelope-from jerry@izmiran.rssi.ru)
Date:	Fri, 20 May 2005 12:20:59 +0300
From:	"Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
X-Mailer: The Bat! (v3.0.1.33) Professional
Reply-To: "Ruslan V.Pisarev" <jerry@izmiran.rssi.ru>
Organization: Home
X-Priority: 3 (Normal)
Message-ID: <17280353.20050520122059@wicomtechnologies.com>
To:	Pete Popov <ppopov@embeddedalley.com>
CC:	linux-mips <linux-mips@linux-mips.org>
Subject: Re[2]: au1200 status
In-Reply-To: <1116341942.5802.15.camel@localhost.localdomain>
References: <1547700103.20050517142217@izmiran.rssi.ru>
 <1116341942.5802.15.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <jerry@izmiran.rssi.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry@izmiran.rssi.ru
Precedence: bulk
X-list: linux-mips

>[In reply to "au1200 status" from Pete Popov <ppopov@embeddedalley.com> to Ruslan V.Pisarev <jerry@izmiran.rssi.ru>  17/05/2005 17:59]

PP> The Au1200 support will from migrate from 2.4 to 2.6 when either someone
PP> funds the effort or someone has time to do it for fun.

  A few thoughts in addition.. At my point of view, au1200 support is
a big mess now. Some companies (AMD, Montawisra, etc) released their
kernels which are not fully synch-ed nor with 2.4 tree at linux-mips
nor with 2.6 one nor with each other. Therefore we forced to "sit and
stay" on one of these old and undeveloped projects (especially most of
them are commercial product (I think even if we'll need a good stable
commercial product - we buy windows :)) or do the same job - make this
all creepy stuff to work on last released kernel. (which will be
replaced after some months with analoguis but better one from amd,
mwista, mr.Jones, mrs.Addams, etc..)
  Have you any ideas about this?



   ()_()
--( ^,^ )---[21398845]- -<The Bat! 3.0.1.33>- -<20/05/2005 11:42>-
  (") (")
