Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 May 2003 11:56:45 +0100 (BST)
Received: (from localhost user: 'ladis' uid#10009 fake: STDIN
	(ladis@sirjeppe-pt.tunnel.tserv1.fmt.ipv6.he.net)) by linux-mips.org
	id <S8225203AbTELK4l>; Mon, 12 May 2003 11:56:41 +0100
Date: Mon, 12 May 2003 11:56:41 +0100
From: Ladislav Michl <ladis@linux-mips.org>
To: linux-mips@linux-mips.org
Subject: memory for exception vectors
Message-ID: <20030512115641.F17151@ftp.linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Return-Path: <ladis@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ladis@linux-mips.org
Precedence: bulk
X-list: linux-mips

Could anyone tell me where is space for exception vectors reserved? Many boards
(for example Alchemy Pb1000, Galileo EV96100 or Galileo EV64120A) simply
registers all available RAM with add_memory_region call, but I didn't find code
which reserves first 0x200 (on most CPUs) for exceptions vectors anywhere. I'd
guess there is something obvious what I'm missing. Can you help me to see it?

Thanks,
	ladis
