Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2009 15:08:11 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38880 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493477AbZKROIG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Nov 2009 15:08:06 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nAIE8BOx017124;
	Wed, 18 Nov 2009 15:08:14 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nAIE89TX017122;
	Wed, 18 Nov 2009 15:08:09 +0100
Date:	Wed, 18 Nov 2009 15:08:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	figo zhang <figo1802@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: why it not write those 6bits to entrylo0/1 register?
Message-ID: <20091118140809.GA6615@linux-mips.org>
References: <c6ed1ac50911170012u7a52fbb9h1ae62cabf766122f@mail.gmail.com> <20091117084047.GA2923@linux-mips.org> <c6ed1ac50911170059w600de299kfe4d79916547d809@mail.gmail.com> <20091117092601.GB2923@linux-mips.org> <c6ed1ac50911170137u7463ad53k1568e722696ca570@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ed1ac50911170137u7463ad53k1568e722696ca570@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 17, 2009 at 05:37:25PM +0800, figo zhang wrote:

> > > so, if i set a page attrubite is PAGE_READONLY, this attribute will set
> > to
> > > pte , right? so ,
> > > why it should shift 6 bits?
> >
> 
> Thanks a lot. I am puzzle that  if i set a page attrubite is PAGE_READONLY,
> tlb_write_indexed()
> will write the 6 bits to entrylo0 register? i am using 24KEC soc.

Yes, tlb_write_indexed() does that.  Equally tlb_write_random() writes a
TLB entry into the TLB.  Basically we use tlb_write_indexed() to overwrite
and update an existing TLB entry.  But if there is no TLB entry yet then
we just use tlb_write_random() an allow the CPU to pick an arbitrary entry.

  Ralf
