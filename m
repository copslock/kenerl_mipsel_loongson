Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Sep 2008 09:32:09 +0100 (BST)
Received: from elvis.franken.de ([193.175.24.41]:39867 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S62077814AbYIJIcH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Sep 2008 09:32:07 +0100
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1KdL7N-0000PR-00; Wed, 10 Sep 2008 10:32:05 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
	id AAFC1DE3D8; Wed, 10 Sep 2008 10:31:57 +0200 (CEST)
Date:	Wed, 10 Sep 2008 10:31:57 +0200
To:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:	ralf@linux-mips.org, ths@networkno.de, linux-mips@linux-mips.org,
	michael@free-electrons.com
Subject: Re: [PATCH 1/1] mips: clear IV bit in CP0 cause if the CPU doesn't support divec
Message-ID: <20080910083157.GA6286@alpha.franken.de>
References: <1220948125-3550-1-git-send-email-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1220948125-3550-1-git-send-email-thomas.petazzoni@free-electrons.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From:	tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Tue, Sep 09, 2008 at 10:15:25AM +0200, Thomas Petazzoni wrote:
> +	else {
> +		clear_c0_cause(CAUSEF_IV);
> +	}

so we now touch a bit, which is at least marked reserved for R10k CPUs
and hope nobody did something else with it ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
