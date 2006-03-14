Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2006 16:29:43 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:36880 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133603AbWCNQ3d (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Mar 2006 16:29:33 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 3FD7F64D3F; Tue, 14 Mar 2006 16:38:38 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 04AD466ED3; Tue, 14 Mar 2006 16:38:22 +0000 (GMT)
Date:	Tue, 14 Mar 2006 16:38:22 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Mark E Mason <mark.e.mason@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: BCM91x80A/B PCI DMA problems
Message-ID: <20060314163822.GK6277@deprecation.cyrius.com>
References: <7E000E7F06B05C49BDBB769ADAF44D0786817B@NT-SJCA-0750.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D0786817B@NT-SJCA-0750.brcm.ad.broadcom.com>
User-Agent: Mutt/1.5.11+cvs20060126
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Mark E Mason <mark.e.mason@broadcom.com> [2006-03-14 08:21]:
> There's a lot of PCI HW out there that's 32-bit only, but there's
> also a fair bit that isn't.  A 32-bit device in a 64-bit system is
> going to require bounce buffering by the driver/OS.

If I understand you correctly, you're saying that you currently don't
supporting 32 bit PCI cards on the SB1 platform.  Is this something
you care about, or should I get a 64-bit PCI card instead?  How hard
would it be to implement bounce buffering anyway?
-- 
Martin Michlmayr
http://www.cyrius.com/
