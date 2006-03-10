Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Mar 2006 17:37:16 +0000 (GMT)
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:50879 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133967AbWCJRhG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Mar 2006 17:37:06 +0000
Received: (qmail 61932 invoked from network); 10 Mar 2006 17:45:40 -0000
Received: from unknown (HELO stupidest.org) (cwedgwood@sbcglobal.net@70.231.226.182 with login)
  by smtp110.sbc.mail.mud.yahoo.com with SMTP; 10 Mar 2006 17:45:40 -0000
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 0EFE551FAC0; Fri, 10 Mar 2006 09:45:36 -0800 (PST)
Date:	Fri, 10 Mar 2006 09:45:35 -0800
From:	Chris Wedgwood <cw@f00f.org>
To:	"Tiwari, Rakesh" <Rakesh.Tiwari@idt.com>
Cc:	'Ralf Baechle' <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] IDT Interprise Processor Support for Linux  2.6.x
Message-ID: <20060310174535.GA9040@taniwha.stupidest.org>
References: <73943A6B3BEAA1468EE1A4A090129F4316B15A73@corpbridge.corp.idt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73943A6B3BEAA1468EE1A4A090129F4316B15A73@corpbridge.corp.idt.com>
Return-Path: <cw@f00f.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cw@f00f.org
Precedence: bulk
X-list: linux-mips

Additional comments:

  * Firstly, it's really great to see this!

  * A single 1.6MB patch is far from ideal, please try to break it
    into a series of smaller logically separate patches.  It's hard to
    comment on a giant patch.  Perhaps something like:
      - a patch for each CPU
      - a patch for each driver
      - a patch for each platform/eval-board
    and see what you have left. Each patch should have a suitable
    description.  Also put "Signed-off-by:" lines on your patches.

  * You shouldn't be removing .gitignore :-)

  * The Ethernet drivers should probably go jeff@garzik.org and cc
    netdev@vger.kernel.org

  * The code contains unreferenced functions?  Without even looking
    hard I can see rc32434_mii_handler is declared and not used for
    example.

  * It might be that some of the CPU-level code should be platform
    level.  For example having two UARTs is a feature of the EB434 not
    the rc32434 so EB434_UART1_IRQ is misplaced I would argue.

  * Some init code should probably be declared __init and similar

  * There is quite a bit of extraneous white-space that could be
    cleaned up and some minor indentation cleanups to match what is
    elsewhere in the kernel.

Sorry this is a little vague and 'hand-wavy', if you post smaller
logically complete patches I think you'll get better feedback where
people can comment more easily.  Ideally inline to the email if you
can, m$ lookout/$exchange as that just makes a mess, if you have to
use that then attach them as you did.
