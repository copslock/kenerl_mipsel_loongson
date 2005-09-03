Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2005 05:48:53 +0100 (BST)
Received: from smtp102.biz.mail.mud.yahoo.com ([IPv6:::ffff:68.142.200.237]:63843
	"HELO smtp102.biz.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8224981AbVICEsh>; Sat, 3 Sep 2005 05:48:37 +0100
Received: (qmail 84210 invoked from network); 3 Sep 2005 04:55:01 -0000
Received: from unknown (HELO ?192.168.1.107?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp102.biz.mail.mud.yahoo.com with SMTP; 3 Sep 2005 04:55:00 -0000
Subject: Re: framebuffer for au1000 based board.
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Maxim Moroz <maxim@kde.ru>
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
In-Reply-To: <43192384.6010308@kde.ru>
References: <43190B15.7080301@kde.ru>
	 <e603bacb50427983d7330a58abccb4fa@embeddedalley.com>
	 <43192384.6010308@kde.ru>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Fri, 02 Sep 2005 21:54:58 -0700
Message-Id: <1125723298.17941.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8869
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


> The choice is not bad. au1000 also has 36 bit addresses.

The Au1500 doesn't have an internal video controller so I'm not sure
which fb driver you based your work on.

> I was toooooo bad using address 0xbe00_0000.
> changed to 0x1e00_0000 and got working video.

Ah, so you just had the physical address setup incorrectly.

> Thanks all who made such perfect port to au1x00 processors!

Enjoy :)

Pete
