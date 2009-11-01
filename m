Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Nov 2009 08:16:53 +0100 (CET)
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39541 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492586AbZKAHQq (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 1 Nov 2009 08:16:46 +0100
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id nA17Gbba027855
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 1 Nov 2009 00:16:38 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id nA17GXCS014372;
	Sun, 1 Nov 2009 00:16:35 -0700
Date:	Sun, 1 Nov 2009 00:16:33 -0700
From:	Andrew Morton <akpm@linux-foundation.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@googlemail.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org, Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH] serial 8250: fixes for Alchemy uarts.
Message-Id: <20091101001633.6ce9d957.akpm@linux-foundation.org>
In-Reply-To: <20091101070900.GB4551@linux-mips.org>
References: <1256762248-4305-1-git-send-email-manuel.lauss@gmail.com>
	<20091101070900.GB4551@linux-mips.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
Precedence: bulk
X-list: linux-mips

On Sun, 1 Nov 2009 08:09:00 +0100 Ralf Baechle <ralf@linux-mips.org> wrote:

> On Wed, Oct 28, 2009 at 09:37:28PM +0100, Manuel Lauss wrote:
> 
> > Limit the amount of address space claimed for Alchemy serial ports
> > to 0x1000.  On the Au1300, ports are only 0x1000 apart, and the
> > registers only extend to 0x110 at most on all supported alchemy models.
> > 
> > On the Au1300 the autodetect logic no longer works and this makes
> > it necessary to specify the port type through platform data.  Because
> > of this the MSR quirk needs to be moved outside the autoconfig()
> > function which will no longer be called when UPF_FIXED_TYPE is
> > specified.
> 
> Andrew,
> 
> looks sane to me.  Since this is a MIPS patch I'd like to funnel it through
> the MIPS tree.  Ok?

Sure.
