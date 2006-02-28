Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Feb 2006 22:05:27 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:47620 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S8133642AbWB1WFS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Feb 2006 22:05:18 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 8CD6C64D3D; Tue, 28 Feb 2006 22:13:01 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 6B39881F5; Tue, 28 Feb 2006 23:12:52 +0100 (CET)
Date:	Tue, 28 Feb 2006 22:12:52 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	Mark E Mason <mark.e.mason@broadcom.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: BCM91x80A/B PCI DMA problems
Message-ID: <20060228221252.GF24493@deprecation.cyrius.com>
References: <7E000E7F06B05C49BDBB769ADAF44D077D6432@NT-SJCA-0750.brcm.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D077D6432@NT-SJCA-0750.brcm.ad.broadcom.com>
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Mark E Mason <mark.e.mason@broadcom.com> [2006-02-28 13:53]:
> Is this a 32-bit, or 64-bit kernel?  If 64-bit, do you have more than 1G
> of DRAM installed in the system (DRAM above 1G is accessed at >32-bit
> physical addresses).

Erm, I have 2 GB of RAM and used a 64-bit kernel.  Using a 32-bit
kernel works.

> Are you using CFE 1.2.5?  The PCI interrupt assignments in earlier

Yes.

> versions of CFE were not correct.
-- 
Martin Michlmayr
http://www.cyrius.com/
