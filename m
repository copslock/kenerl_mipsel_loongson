Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2003 18:34:48 +0100 (BST)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:23495 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225351AbTILRep>;
	Fri, 12 Sep 2003 18:34:45 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id CAA11289;
	Sat, 13 Sep 2003 02:34:31 +0900 (JST)
Received: 4UMDO00 id h8CHYVu04706; Sat, 13 Sep 2003 02:34:31 +0900 (JST)
Received: 4UMRO00 id h8CHYTa21466; Sat, 13 Sep 2003 02:34:29 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Sat, 13 Sep 2003 02:34:28 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: James Simmons <jsimmons@infradead.org>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
	yuasa@hh.iij4u.or.jp
Subject: Re: [patch] NEC VR4100 KIU support
Message-Id: <20030913023428.7fa72ac3.yuasa@hh.iij4u.or.jp>
In-Reply-To: <Pine.LNX.4.44.0309121827180.5017-100000@phoenix.infradead.org>
References: <20030912004420.4d7e0091.yuasa@hh.iij4u.or.jp>
	<Pine.LNX.4.44.0309121827180.5017-100000@phoenix.infradead.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3175
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

On Fri, 12 Sep 2003 18:27:38 +0100 (BST)
James Simmons <jsimmons@infradead.org> wrote:

> 
> Nice. Would you consider porting that to the input api for 2.6.X?

Yes, of course.

Yoichi

> 
> On Fri, 12 Sep 2003, Yoichi Yuasa wrote:
> 
> > Hello Ralf,
> > 
> > I rewrote NEC VR4100 KIU driver for v2.4.
> > This driver adds keyboard support to IBM WorkPad z50 and Victor MP-C303/304.
> > 
> > Please apply this patch to v2.4 tree.
> > 
> > Yoichi
> > 
> 
> 
