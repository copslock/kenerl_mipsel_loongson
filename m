Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2008 15:50:56 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:19130 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28603665AbYCFPux (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Mar 2008 15:50:53 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m26FogJi016362;
	Thu, 6 Mar 2008 15:50:42 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m26FnriU016331;
	Thu, 6 Mar 2008 15:49:53 GMT
Date:	Thu, 6 Mar 2008 15:49:53 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	okumoto@ucsd.edu, linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
Message-ID: <20080306154952.GA16097@linux-mips.org>
References: <479A134D.7090206@ucsd.edu> <20080126.140802.126142689.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080126.140802.126142689.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 26, 2008 at 02:08:02PM +0900, Atsushi Nemoto wrote:

> 
> On Fri, 25 Jan 2008 08:50:21 -0800, Max Okumoto <okumoto@ucsd.edu> wrote:
> > I have a JMR3927 based system and I got it to work with the 2.6.23.14 kernel, but
> > used 0xff0000 instead of 0xff000.  The offset passed in was 0xfffec000 which isn't
> > within the 0xff000000 - 0xff0ff000.
> 
> Thank you for good news.  (and excuse my double fault...)
> 
> Ralf, please apply this to 2.6.23-stable and 2.6.24-stable.

Applied.  Thanks,

  Ralf
