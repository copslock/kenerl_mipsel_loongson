Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Jun 2006 09:19:32 +0100 (BST)
Received: from deliver-2.mx.triera.net ([213.161.0.32]:49303 "EHLO
	deliver-2.mx.triera.net") by ftp.linux-mips.org with ESMTP
	id S8133429AbWF0ITP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 27 Jun 2006 09:19:15 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-2.mx.triera.net (Postfix) with ESMTP id 3FA91143;
	Tue, 27 Jun 2006 10:19:05 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id AB48F1BC07E;
	Tue, 27 Jun 2006 10:19:06 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 47B5F1A18A7;
	Tue, 27 Jun 2006 10:19:07 +0200 (CEST)
Date:	Tue, 27 Jun 2006 10:19:08 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
Subject: Re: Commit 78eef01b0fae087c5fadbd85dd4fe2918c3a015f (on_each_cpu(): disable local interrupts) Breaks SGI IP32
Message-ID: <20060627081908.GB31105@domen.ultra.si>
References: <4478C0F1.8000006@gentoo.org> <20060528010603.GA24997@linux-mips.org> <20060527194243.a8157338.akpm@osdl.org> <4479250E.3080604@gentoo.org> <20060528105014.GA28621@linux-mips.org> <20060621095150.GO5568@domen.ultra.si> <20060621121110.GA12545@linux-mips.org> <20060622064930.GP5568@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622064930.GP5568@domen.ultra.si>
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

So... to sum it up... any idea, why (with this patch applied)
set_c0_status(ALL_INTS) increases preempt_count?

Any pointers appreaciated!


	Domen
