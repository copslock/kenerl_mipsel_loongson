Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Sep 2006 02:02:52 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:10911 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037867AbWIGBCu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Sep 2006 02:02:50 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8713OwS017635;
	Thu, 7 Sep 2006 03:03:24 +0200
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8713OjX017634;
	Thu, 7 Sep 2006 03:03:24 +0200
Date:	Thu, 7 Sep 2006 03:03:24 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jonathan Day <imipak@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Resetting a Broadcom in software
Message-ID: <20060907010324.GA17536@linux-mips.org>
References: <20060906223224.GA12175@linux-mips.org> <20060906225939.55259.qmail@web31503.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060906225939.55259.qmail@web31503.mail.mud.yahoo.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12528
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 06, 2006 at 03:59:39PM -0700, Jonathan Day wrote:

> The Sentosa uses a dual-core Broadcom 1250 processor
> with an SB1 version 0.2 core. The board is BCM91250E
> Revision 1.
> 
> The Swarm also uses a Broadcom 1250 with an SB1
> version 0.2 core, but the board is a BCM91250A.
> 
> Most of the difference seems to be in the motherboard,
> rather than the CPU, but I couldn't tell you what the
> difference is between an E and an A, and why the A
> seems better-behaved.

There are sub-types to pass 2 but I don't know how to identify those.
Probably by the content of the wafer id register or something like that.

  Ralf
