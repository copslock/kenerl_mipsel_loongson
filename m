Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Apr 2005 18:54:53 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:44948 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225281AbVDGRyB>;
	Thu, 7 Apr 2005 18:54:01 +0100
Received: from drow by nevyn.them.org with local (Exim 4.50 #1 (Debian))
	id 1DJbCY-0004Gi-NX; Thu, 07 Apr 2005 13:53:58 -0400
Date:	Thu, 7 Apr 2005 13:53:58 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Brian Kuschak <bkuschak@yahoo.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: gdb backtrace with core files
Message-ID: <20050407175358.GA16385@nevyn.them.org>
References: <20050407174454.77209.qmail@web40909.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050407174454.77209.qmail@web40909.mail.yahoo.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7636
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Thu, Apr 07, 2005 at 10:44:54AM -0700, Brian Kuschak wrote:
> Is anyone succesfully using gdb for mipsel to debug
> core dumps?  If so, can you share your secrets for
> success?  I tried various recent versions (6.3,
> 6.1.1), but backtrace never works right, even though
> the stack pointer appears to be valid.  gdb-5.3
> partially works, but not completely.  

Give the CVS version a try, please.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
