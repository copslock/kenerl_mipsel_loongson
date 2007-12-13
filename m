Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Dec 2007 19:45:36 +0000 (GMT)
Received: from NaN.false.org ([208.75.86.248]:48021 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S20033224AbXLMTp1 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Dec 2007 19:45:27 +0000
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 9C33D98052;
	Thu, 13 Dec 2007 15:36:22 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 7F3C998021;
	Thu, 13 Dec 2007 15:36:22 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.68)
	(envelope-from <drow@caradoc.them.org>)
	id 1J2q6n-0008U8-Ls; Thu, 13 Dec 2007 10:36:21 -0500
Date:	Thu, 13 Dec 2007 10:36:21 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Chris Friesen <cfriesen@nortel.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: questions on struct sigcontext
Message-ID: <20071213153621.GA32600@caradoc.them.org>
References: <47601DEE.4090200@nortel.com> <20071212190032.GA30506@caradoc.them.org> <47607327.5090709@nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47607327.5090709@nortel.com>
User-Agent: Mutt/1.5.17 (2007-12-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Dec 12, 2007 at 05:47:51PM -0600, Chris Friesen wrote:
> If the cause/badvaddr entries in struct sigcontext were filled in by the  
> exception handler in the kernel, wouldn't the values in that struct be  
> completely valid even if the registers themselves were changed before  
> userspace could handle the signal?

Yeah, my reply didn't make much sense.  Trust Ralf's instead.

-- 
Daniel Jacobowitz
CodeSourcery
