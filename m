Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Dec 2006 05:33:00 +0000 (GMT)
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:9579 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037692AbWLBFcz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 2 Dec 2006 05:32:55 +0000
Received: (qmail 31870 invoked from network); 2 Dec 2006 05:32:48 -0000
Received: from unknown (HELO stupidest.org) (cwedgwood@sbcglobal.net@24.5.75.45 with login)
  by smtp104.sbc.mail.re2.yahoo.com with SMTP; 2 Dec 2006 05:32:48 -0000
X-YMail-OSG: X_e_DZ8VM1lU01lklG0gB46OlsdDAx8FcFU2PMfn3WmGw9OzKiVC_vjc7ssAGZftcLL59BijWmQ_CL2uk.vZ6f1p2_IoSpxHoQo3ePqGc9Jrcf.f31Lq
Received: by tuatara.stupidest.org (Postfix, from userid 10000)
	id 5567E1827280; Fri,  1 Dec 2006 21:32:47 -0800 (PST)
Date:	Fri, 1 Dec 2006 21:32:47 -0800
From:	Chris Wedgwood <cw@f00f.org>
To:	Ashlesha Shintre <ashlesha@kenati.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: initramfs -- boot args?
Message-ID: <20061202053247.GB12580@tuatara.stupidest.org>
References: <1165024791.6535.43.camel@sandbar.kenati.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165024791.6535.43.camel@sandbar.kenati.com>
Return-Path: <cw@f00f.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cw@f00f.org
Precedence: bulk
X-list: linux-mips

On Fri, Dec 01, 2006 at 05:59:51PM -0800, Ashlesha Shintre wrote:

> I built my own initramfs_data.cpio.gz file that contains the object file
> for the hello world code below-
> 
> printkf("Hello World\n");
> sleep(99999999);
> return(0)

as what filename?

initramfs can be very picky.

can you show me "cpio --list --verbose < initramfs.cpio" or similar
please?
