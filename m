Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Dec 2007 18:41:25 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:21383 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S28579772AbXLRSlQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Dec 2007 18:41:16 +0000
Received: (qmail 25667 invoked from network); 18 Dec 2007 18:41:15 -0000
Received: from c-76-17-127-170.hsd1.ga.comcast.net (HELO ?10.41.13.3?) (76.17.127.170)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 18 Dec 2007 11:41:14 -0700
Subject: Re: PCI resource unavailable on mips
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	Robert Hancock <hancockr@shaw.ca>
Cc:	linux-kernel@vger.kernel.org,
	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <4761C26C.3010708@shaw.ca>
References: <fa.vbvzhsk+kDPCopbmajO8EsxAnKE@ifi.uio.no>
	 <4761C26C.3010708@shaw.ca>
Content-Type: text/plain
Date:	Tue, 18 Dec 2007 13:40:43 -0500
Message-Id: <1198003243.3382.11.camel@microwave.infinitevideocorporation.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17852
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

> > Bar0:PHYS=e0000000 LEN=04000000
> > Bar1:PHYS=efa00000 LEN=00200000
> > Bar2:PHYS=e8000000 LEN=04000000
> 
> So, two 64MB BARs and a 2MB one?

That is right.

> Any PCI resource allocation errors in dmesg during the boot process? 
> Could be the kernel wasn't able to find a place to map all of the BARs.
> 

I went back and looked at the boot up messages and I found this:

PCI: Failed to allocate mem resource #2:4000000@24000000 for
0000:00:0c.0


That is my device. So it does appear that there is an allocation issue.
Any idea how to get around this?

Thanks,
Jon
