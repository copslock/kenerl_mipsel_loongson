Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2009 21:50:10 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:41375 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493731AbZJNTuH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 14 Oct 2009 21:50:07 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n9EJpHZj027652;
	Wed, 14 Oct 2009 21:51:22 +0200
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n9EJbTMB026480;
	Wed, 14 Oct 2009 21:37:29 +0200
Date:	Wed, 14 Oct 2009 21:37:29 +0200
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	Dmitri Vorobiev <dmitri.vorobiev@movial.com>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] [MIPS] remove an unused header file
Message-ID: <20091014193729.GA20868@linux-mips.org>
References: <1255546939-3302-1-git-send-email-dmitri.vorobiev@movial.com> <1255546939-3302-4-git-send-email-dmitri.vorobiev@movial.com> <f861ec6f0910141212h562eda08le338842f90690419@mail.gmail.com> <90edad820910141217x65406d02x183935dd56e60fdf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90edad820910141217x65406d02x183935dd56e60fdf@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 14, 2009 at 10:17:16PM +0300, Dmitri Vorobiev wrote:

> On Wed, Oct 14, 2009 at 10:12 PM, Manuel Lauss
> <manuel.lauss@googlemail.com> wrote:
> > On Wed, Oct 14, 2009 at 9:02 PM, Dmitri Vorobiev
> > <dmitri.vorobiev@movial.com> wrote:
> >> Nobody includes arch/mips/include/asm/mach-au1x00/prom.h, so remove
> >> this header file now.
> >
> > My compiler disagrees:
> 
> Hi Manuel,
> 
> Thanks for testing this and sorry for the untested patch. Ralf, please
> drop this one; the other two in the series must be OK since I
> build-tested them.

Ok, dropped.

  Ralf
