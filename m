Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Dec 2007 18:32:56 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:46266 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S20032875AbXLNScr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 14 Dec 2007 18:32:47 +0000
Received: (qmail 9983 invoked from network); 14 Dec 2007 18:32:42 -0000
Received: from adsl-232-70-239.asm.bellsouth.net (HELO ?10.41.13.3?) (74.232.70.239)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 14 Dec 2007 11:32:41 -0700
Subject: Re: PCI resource unavailable on mips
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
In-Reply-To: <20071214093945.GA25186@linux-mips.org>
References: <1197557806.3370.7.camel@microwave.infinitevideocorporation.com>
	 <20071214093945.GA25186@linux-mips.org>
Content-Type: text/plain
Date:	Fri, 14 Dec 2007 13:32:40 -0500
Message-Id: <1197657160.3420.11.camel@microwave.infinitevideocorporation.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17820
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips


> 
> Odd.  I knew the resource allocation stuff has it's issues for some
> non-trivial configuration but that one is a new one.  Which makes me
> wonder if your platform runs the PCI code in probe-only mode where it
> will not actually assign resources but only inherit the whole PCI setup
> except interrupt routing from the firmware.
> 
> What MIPS platform do you use?  I'd like to take a look at its PCI setup
> code.
> 

I am using the MDS 810 STB as provided by MDS
(http://www.mds.com/products/product.asp?prod=MDS-810). The kernel and
entire environment (except my driver) was set up by MDS. uname output is
as follows.

 # uname -a
Linux 10.41.13.87 2.6.19PNX8550 #1 Wed Nov 21 14:55:52 EST 2007 mips
unknown

If I can provide additional information for you I'd be happy to help.

Thanks,
Jon
