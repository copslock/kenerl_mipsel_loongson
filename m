Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Sep 2003 18:27:47 +0100 (BST)
Received: from pub234.cambridge.redhat.com ([IPv6:::ffff:213.86.99.234]:25611
	"EHLO phoenix.infradead.org") by linux-mips.org with ESMTP
	id <S8225351AbTILR1p>; Fri, 12 Sep 2003 18:27:45 +0100
Received: from localhost.localdomain ([127.0.0.1] helo=localhost)
	by phoenix.infradead.org with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19xrhv-0001ah-JF; Fri, 12 Sep 2003 18:27:43 +0100
Date: Fri, 12 Sep 2003 18:27:38 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
cc: ralf@linux-mips.org, <linux-mips@linux-mips.org>
Subject: Re: [patch] NEC VR4100 KIU support
In-Reply-To: <20030912004420.4d7e0091.yuasa@hh.iij4u.or.jp>
Message-ID: <Pine.LNX.4.44.0309121827180.5017-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jsimmons@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsimmons@infradead.org
Precedence: bulk
X-list: linux-mips


Nice. Would you consider porting that to the input api for 2.6.X?



On Fri, 12 Sep 2003, Yoichi Yuasa wrote:

> Hello Ralf,
> 
> I rewrote NEC VR4100 KIU driver for v2.4.
> This driver adds keyboard support to IBM WorkPad z50 and Victor MP-C303/304.
> 
> Please apply this patch to v2.4 tree.
> 
> Yoichi
> 
