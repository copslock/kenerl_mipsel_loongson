Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jul 2005 17:20:48 +0100 (BST)
Received: from smtp002.bizmail.yahoo.com ([IPv6:::ffff:216.136.172.126]:51350
	"HELO smtp002.bizmail.yahoo.com") by linux-mips.org with SMTP
	id <S8226800AbVGQQU3>; Sun, 17 Jul 2005 17:20:29 +0100
Received: (qmail 26552 invoked from network); 17 Jul 2005 16:21:56 -0000
Received: from unknown (HELO ?192.168.1.107?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp002.bizmail.yahoo.com with SMTP; 17 Jul 2005 16:21:56 -0000
Subject: Re: Support for (au1100) 64-bit physical address space broken on
	2.6.12?
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
To:	Rodolfo Giometti <giometti@linux.it>
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20050717105853.GA21844@enneenne.com>
References: <20050716124205.GA26127@enneenne.com>
	 <1121528575.27121.3.camel@localhost.localdomain>
	 <20050717105853.GA21844@enneenne.com>
Content-Type: text/plain
Organization: Embedded Alley Solutions, Inc
Date:	Sun, 17 Jul 2005 09:22:04 -0700
Message-Id: <1121617324.27121.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8521
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

On Sun, 2005-07-17 at 12:58 +0200, Rodolfo Giometti wrote:
> On Sat, Jul 16, 2005 at 08:42:55AM -0700, Pete Popov wrote:
> > I fixed this is the latest tree a couple of days ago.
> 
> Great! :)
> 
> Did you already publish it? I checked the linux-mips CVS before
> sending my patches but I saw nothing about it. :-o
> 
> Where can I get your patch in order to compare the two solutions?

Just do a cvs update in your directory and you'll get the patch.

Pete
