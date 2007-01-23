Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Jan 2007 14:58:54 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:48853 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S28573884AbXAWO6u (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 23 Jan 2007 14:58:50 +0000
Received: from drow by nevyn.them.org with local (Exim 4.63)
	(envelope-from <drow@nevyn.them.org>)
	id 1H9N6m-0002aj-LE; Tue, 23 Jan 2007 09:58:48 -0500
Date:	Tue, 23 Jan 2007 09:58:48 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/7] Clean up signal code
Message-ID: <20070123145848.GA9900@nevyn.them.org>
References: <1169561903878-git-send-email-fbuihuu@gmail.com> <20070123143214.GC18083@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070123143214.GC18083@linux-mips.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 23, 2007 at 02:32:14PM +0000, Ralf Baechle wrote:
> >     (b) Status register is saved by setup_sigcontext32() but
> >         not restored by restore_sigcontext(). Is it a bug ?
> 
> Not really a bug but useless code, yes.  We used to save c0_status in the
> dark ages but again, no known code - not even IRIX code - relies on this
> field.

For once not even GDB uses it :-)

-- 
Daniel Jacobowitz
CodeSourcery
