Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jan 2006 13:52:16 +0000 (GMT)
Received: from neptune.nocserver.net ([209.59.140.34]:43173 "EHLO
	neptune.nocserver.net") by ftp.linux-mips.org with ESMTP
	id S8133503AbWADNv5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jan 2006 13:51:57 +0000
Received: from [81.214.210.213] (port=32805 helo=boras)
	by neptune.nocserver.net with esmtpsa (TLSv1:RC4-MD5:128)
	(Exim 4.52)
	id 1Eu95V-0002jU-M9; Wed, 04 Jan 2006 08:54:02 -0500
From:	bora.sahin@ttnet.net.tr
To:	Matej Kupljen <matej.kupljen@ultra.si>
Subject: Re: ALCHEMY:  AU1200 USB Host Controller (OHCI/EHCI)
Date:	Wed, 4 Jan 2006 15:54:29 +0200
User-Agent: KMail/1.7.2
Cc:	matthias.lenk@amd.com, Jordan Crouse <jordan.crouse@amd.com>,
	linux-mips@linux-mips.org, linux-usb-devel@lists.sourceforge.net
References: <20051208210042.GB17458@cosmic.amd.com> <200601041332.16043.matthias.lenk@amd.com> <1136380071.27748.49.camel@localhost.localdomain>
In-Reply-To: <1136380071.27748.49.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="Iso-8859-9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601041554.29497.bora.sahin@ttnet.net.tr>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - neptune.nocserver.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - ttnet.net.tr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <bora.sahin@ttnet.net.tr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9773
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bora.sahin@ttnet.net.tr
Precedence: bulk
X-list: linux-mips

Hi,

> I think Bora Sahin said he used OHCI successfully on 2.5.15-rc4.
> Bora, can you confirm this?

Yes, it works both in my version of patch and Jordan's...

But my kernel version is 
	#define UTS_RELEASE "2.6.15-rc4-g2b269cc6"
not 2.5.15-rc4

--
Bora SAHIN
