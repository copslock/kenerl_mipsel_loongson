Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Sep 2007 03:33:20 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:33755 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S20024297AbXISCdL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 19 Sep 2007 03:33:11 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 68DC998152;
	Wed, 19 Sep 2007 02:32:38 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id B9E2F9810B;
	Wed, 19 Sep 2007 02:32:37 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.67)
	(envelope-from <drow@caradoc.them.org>)
	id 1IXpMh-000850-Bd; Tue, 18 Sep 2007 22:32:35 -0400
Date:	Tue, 18 Sep 2007 22:32:35 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
Subject: Re: MIPS atomic memory operations (A.K.A PR 33479).
Message-ID: <20070919023235.GA31042@caradoc.them.org>
Mail-Followup-To: David Daney <ddaney@avtrex.com>,
	Richard Sandiford <rsandifo@nildram.co.uk>,
	GCC Mailing List <gcc@gcc.gnu.org>, linux-mips@linux-mips.org
References: <46F06980.4080500@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46F06980.4080500@avtrex.com>
User-Agent: Mutt/1.5.15 (2007-04-09)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 18, 2007 at 05:12:48PM -0700, David Daney wrote:
> I guess my basic question is:  Should MIPS_COMPARE_AND_SWAP have a 'sync' after 
> the 'sc'?  I would have thought that 'sc' made the write visible to all CPUs, 
> but on the SB1 it appears not to be the case.

Yes, a barrier of some sort is definitely necessary.  I believe the
SB1 is weakly ordered, and the architecture spec permits both strong
and weak ordering; but it's been a while since I tried this.

-- 
Daniel Jacobowitz
CodeSourcery
