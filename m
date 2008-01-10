Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Jan 2008 13:31:12 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:11169 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S28577281AbYAJNbE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Jan 2008 13:31:04 +0000
Received: (qmail 3819 invoked from network); 10 Jan 2008 13:31:01 -0000
Received: from 75-144-238-166-atlanta.hfc.comcastbusiness.net (HELO ?10.41.13.3?) (75.144.238.166)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 10 Jan 2008 06:31:00 -0700
Subject: Re: Linux mips and DMA
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20080110113931.GA4774@linux-mips.org>
References: <1199905038.3572.8.camel@microwave.infinitevideocorporation.com>
	 <20080110113931.GA4774@linux-mips.org>
Content-Type: text/plain
Date:	Thu, 10 Jan 2008 08:30:16 -0500
Message-Id: <1199971818.4344.5.camel@microwave.infinitevideocorporation.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

> MIPS hardware is different so pci_alloc_consistent is implemented
> differently.  For correct use however this should not matter.  Any bugs
> you may find porting to MIPS were already bugs on x86.
> 
> (Or in pci_alloc_consistent but I'm optimistic ;-)


Is there a chance that my platform does not support coherent DMA
mappings? Or is this unheard of for a MIPs platform?

Thanks for the help!
Jon
