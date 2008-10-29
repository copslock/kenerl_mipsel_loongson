Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 17:10:27 +0000 (GMT)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:56984 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S22670423AbYJ2RKU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 17:10:20 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9THAGfq026357;
	Wed, 29 Oct 2008 17:10:16 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9THAFhF026356;
	Wed, 29 Oct 2008 17:10:15 GMT
Date:	Wed, 29 Oct 2008 17:10:15 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>,
	Paul Gortmaker <Paul.Gortmaker@windriver.com>
Subject: Re: [PATCH 15/36] Probe for Cavium OCTEON CPUs.
Message-ID: <20081029171015.GD26256@linux-mips.org>
References: <1225152181-3221-10-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-11-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-12-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-13-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-14-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-15-git-send-email-ddaney@caviumnetworks.com> <20081029121737.GA26256@linux-mips.org> <49088CBF.8060109@caviumnetworks.com> <20081029162642.GC26256@linux-mips.org> <49088FF7.9060103@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49088FF7.9060103@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 29, 2008 at 09:31:51AM -0700, David Daney wrote:

>> The watch bit is a standard feature of the MIPS R1/R2 architecture.  What
>> Sandcraft did was bascially an RM7000 clone with some extensions.  I'm
>> still trying to track somebody who could verify the correctness of that
>> code as I don't have Sandcraft docs ...
>>
>
> R4400 and R10K have the watch registers, but they do not have mips  
> semantics, so are not currently usable with the watch register support.   
> This is why I initially was very conservative about the conditions under 
> which I probed watch registers.  So I think it is good to try to verify 
> these things.

All the esotheric stuff really is covered in cpu_probe_legacy.  Anything
else should comply with MIPS32/MIPS64.  Exceptions apply.

Thanks to an old advertisment leaflet I was able to find that the Sandcraft
SR71000 is indeed a MIPS64 processor, so the patch was right.

  Ralf
