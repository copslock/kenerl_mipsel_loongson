Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Oct 2007 17:18:10 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:57267 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023353AbXJKQSI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 11 Oct 2007 17:18:08 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9BGHKuM025928;
	Thu, 11 Oct 2007 17:17:20 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9BGGsS0025584;
	Thu, 11 Oct 2007 17:16:54 +0100
Date:	Thu, 11 Oct 2007 17:16:54 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/6] tlbex.c: Cleanup __init usages.
Message-ID: <20071011161654.GB12782@linux-mips.org>
References: <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com> <470BE5D2.50101@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470BE5D2.50101@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 09, 2007 at 10:34:26PM +0200, Franck Bui-Huu wrote:

> Subject: [PATCH 1/6] tlbex.c: Cleanup __init usages.  

So I applied this one only while we sort out the .init.bss stuff.

Thanks!

  Ralf
