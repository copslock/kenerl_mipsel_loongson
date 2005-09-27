Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Sep 2005 14:10:18 +0100 (BST)
Received: from nevyn.them.org ([66.93.172.17]:20440 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S8134019AbVI0NJy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 27 Sep 2005 14:09:54 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1EKFDT-0000EI-T4; Tue, 27 Sep 2005 09:09:51 -0400
Date:	Tue, 27 Sep 2005 09:09:51 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Jim Gifford <maillist@jg555.com>
Cc:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: MIPS64 NPTL Status
Message-ID: <20050927130951.GA867@nevyn.them.org>
References: <43323D35.9030905@jg555.com> <20050922213020.GA15905@nevyn.them.org> <43333001.3080703@jg555.com> <4338111C.6040401@jg555.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4338111C.6040401@jg555.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Sep 26, 2005 at 08:17:48AM -0700, Jim Gifford wrote:
> Daniel,
>    Got passed the first issue, but the second one came around when 
> trying to get NPTL to compile with N32. Here's what I got. The code does 
> compile under pure 64 bit no problems.

I must have sent you an outdated patch.  Remove the mips-specific
sys/ptrace.h header and use the generic one.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
