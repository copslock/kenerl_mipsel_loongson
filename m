Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 15:43:40 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:11463 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025409AbXJLOni (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 15:43:38 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9CEhbgF029398;
	Fri, 12 Oct 2007 15:43:37 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9CEhaai029397;
	Fri, 12 Oct 2007 15:43:36 +0100
Date:	Fri, 12 Oct 2007 15:43:36 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 1/6] tlbex.c: Cleanup __init usages.
Message-ID: <20071012144336.GA18799@linux-mips.org>
References: <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com> <470BE5D2.50101@gmail.com> <20071011161654.GB12782@linux-mips.org> <470F15D7.1010106@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470F15D7.1010106@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16986
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 12, 2007 at 08:36:07AM +0200, Franck Bui-Huu wrote:

> Could you drop this one too ?
> 
> The patchset I sent was badly ordered I should have put clean up
> stuffs first then optimization stuff.
> 
> I'm going to resend a pachset that deals with clean up only.

Okay, reverted.  It was causing mostpost warnings anyway ...

  Ralf
