Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 01:44:44 +0100 (BST)
Received: from smtp101.biz.mail.mud.yahoo.com ([68.142.200.236]:54391 "HELO
	smtp101.biz.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3465666AbVJDAo0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 01:44:26 +0100
Received: (qmail 55784 invoked from network); 4 Oct 2005 00:44:18 -0000
Received: from unknown (HELO ?192.168.1.107?) (dan@embeddedalley.com@71.128.175.242 with plain)
  by smtp101.biz.mail.mud.yahoo.com with SMTP; 4 Oct 2005 00:44:18 -0000
In-Reply-To: <000f01c5c876$a2b78740$0400a8c0@buzz>
References: <000f01c5c876$a2b78740$0400a8c0@buzz>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2e5c8ef0628b1886bde6e6ca6d76b79e@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	<linux-mips@linux-mips.org>
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: Au1550 Serial port - linux-2.6.13.2
Date:	Mon, 3 Oct 2005 17:43:56 -0700
To:	"Kyle Unice" <unixe@comcast.net>
X-Mailer: Apple Mail (2.623)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9126
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Oct 3, 2005, at 5:00 PM, Kyle Unice wrote:

> I have configured linux-2.6.13.2 for a db1550_defconfig build.  When I
> compile it, I get this error when compiling au1x00_uart.c:

You need to use the linux-mips.org CVS tree.  Current top of
tree is 2.6.14-rc2, which builds and boots fine on the db1550.

Thanks.

	-- Dan
