Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Sep 2006 11:41:57 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:45779 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038589AbWI1Klz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 28 Sep 2006 11:41:55 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.7/8.13.7) with ESMTP id k8SAgmj7025872;
	Thu, 28 Sep 2006 11:42:49 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.7/8.13.7/Submit) id k8SAgmtY025871;
	Thu, 28 Sep 2006 11:42:48 +0100
Date:	Thu, 28 Sep 2006 11:42:47 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, mingo@redhat.com
Subject: Re: [PATCH 2/3] [MIPS] lockdep: add STACKTRACE_SUPPORT and enable LOCKDEP_SUPPORT
Message-ID: <20060928104247.GA3857@linux-mips.org>
References: <20060926.234401.08077257.anemo@mba.ocn.ne.jp> <20060927.001631.78705973.anemo@mba.ocn.ne.jp> <20060928.192637.27955275.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928.192637.27955275.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Sep 28, 2006 at 07:26:37PM +0900, Atsushi Nemoto wrote:

> On Wed, 27 Sep 2006 00:16:31 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> > And I got this output when I booted kernel 2.6.18 using nfsroot:
> 
> With updated stacktrace (now it shows all kernel context), I got:

Thanks.  Now the lockdep output makes sense.  At a glance it also looks
like this case isn't a false positive ...

  Ralf
