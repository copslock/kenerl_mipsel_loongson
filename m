Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2008 17:06:11 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:2719 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S24037373AbYLRRGG (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2008 17:06:06 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id mBIH63W1007340;
	Thu, 18 Dec 2008 17:06:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id mBIH62b6007338;
	Thu, 18 Dec 2008 17:06:02 GMT
Date:	Thu, 18 Dec 2008 17:06:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Define  __arch_swab64 for all mips r2 cpus.
Message-ID: <20081218170602.GC6868@linux-mips.org>
References: <1229546644-3030-1-git-send-email-ddaney@caviumnetworks.com> <20081218080740.GA15338@linux-mips.org> <494A7D5F.6060103@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <494A7D5F.6060103@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Dec 18, 2008 at 08:42:07AM -0800, David Daney wrote:

>> This breaks every non-R2 64-bit processor.
>>
> I disagree. As I said before, the entire block is wrapped by #ifdef  
> MIPS_R2.  non-R2 processors will not get any of the optimized byte  
> swapping code.  I just want to allow all 64 bit R2 processors to use the  
> optimized code.

Whops sorry.  I missed that this was wrapped into yet another #ifdef.

  Ralf
