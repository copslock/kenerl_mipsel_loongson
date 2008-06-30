Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2008 22:20:04 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:49557 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S28792135AbYF3VTz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 30 Jun 2008 22:19:55 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 8565D98413;
	Mon, 30 Jun 2008 21:19:51 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 674FA9840B;
	Mon, 30 Jun 2008 21:19:51 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1KDQms-00081w-NZ; Mon, 30 Jun 2008 17:19:50 -0400
Date:	Mon, 30 Jun 2008 17:19:50 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	David VomLehn <dvomlehn@cisco.com>
Cc:	binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
Message-ID: <20080630211950.GA30847@caradoc.them.org>
Mail-Followup-To: David VomLehn <dvomlehn@cisco.com>,
	binutils@sourceware.org, gcc@gcc.gnu.org, linux-mips@linux-mips.org,
	rdsandiford@googlemail.com
References: <87y74pxwyl.fsf@firetop.home> <48694927.90906@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48694927.90906@cisco.com>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Jun 30, 2008 at 01:59:19PM -0700, David VomLehn wrote:
> This sounds like really good stuff and, on first reading, it all seems to 
> make sense to me. My only real concern is documentation of these changes. 

FWIW, I'll be posting our version of this project shortly, and it
includes an ABI supplement.  Supplemental to a somewhat hypothetical
document, but there you go...

-- 
Daniel Jacobowitz
CodeSourcery
