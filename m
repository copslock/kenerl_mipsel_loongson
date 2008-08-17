Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Aug 2008 15:31:33 +0100 (BST)
Received: from hiauly1.hia.nrc.ca ([132.246.100.193]:62733 "EHLO
	hiauly1.hia.nrc.ca") by ftp.linux-mips.org with ESMTP
	id S28577606AbYHQObZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 17 Aug 2008 15:31:25 +0100
Received: by hiauly1.hia.nrc.ca (Postfix, from userid 1000)
	id 7CD574E77; Sun, 17 Aug 2008 10:31:18 -0400 (EDT)
Subject: Re: missing compat_sys_ptrace conversions for mips and parisc
To:	deller@gmx.de (Helge Deller)
Date:	Sun, 17 Aug 2008 10:31:18 -0400 (EDT)
From:	"John David Anglin" <dave@hiauly1.hia.nrc.ca>
Cc:	hch@lst.de, kyle@mcmartin.ca, linux-mips@linux-mips.org,
	linux-parisc@vger.kernel.org
In-Reply-To: <48A8081A.4080609@gmx.de> from "Helge Deller" at Aug 17, 2008 01:14:34 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20080817143118.7CD574E77@hiauly1.hia.nrc.ca>
Return-Path: <dave@hiauly1.hia.nrc.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@hiauly1.hia.nrc.ca
Precedence: bulk
X-list: linux-mips

> I could take care of this for parisc. Just looked into the code and it 
> seems it could cleanup the code nicely as well.
> 
> But I don't want to step on Kyle's toe, since I assume he prepares the 
> asm-parisc/ move in the parisc-2.6 git tree during the next days.
> 
> Kyle: any comments? Should I prepare some patches? Or do you want to 
> take care of the compat_sys_ptrace yourself?

In my builds, I noticed that there are also about five "new" syscalls 
that aren't wired up for parisc.

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
