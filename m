Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 10:06:22 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.190]:41408
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224990AbULGKGR>; Tue, 7 Dec 2004 10:06:17 +0000
Received: from [212.227.126.161] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CbcEZ-0007XP-00
	for linux-mips@linux-mips.org; Tue, 07 Dec 2004 11:06:15 +0100
Received: from [217.91.102.65] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CbcEZ-0007vg-00
	for linux-mips@linux-mips.org; Tue, 07 Dec 2004 11:06:15 +0100
From: Michael Stickel <michael.stickel@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] Ocelot-3 memory configuration patch
Date: Tue, 7 Dec 2004 11:06:14 +0100
User-Agent: KMail/1.7
References: <20041207003553.GA22456@prometheus.mvista.com>
In-Reply-To: <20041207003553.GA22456@prometheus.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412071106.14064.michael.stickel@4g-systems.biz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:f72049c8971f462876d14eb8b3ccbbf1
Return-Path: <michael.stickel@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.stickel@4g-systems.biz
Precedence: bulk
X-list: linux-mips

What if the "memsize" PMON variable is not defined?
Can that happen. Then the memory size is either 0L,
or an undefined value.
Shouldn't it be initialized to 128 by default?

On Tuesday 07 December 2004 01:35, you wrote:
> Hi Ralf,
>
> Based on your suggestion, I have now modified the Ocelot-3 code
> to probe for memory that has been configured by PMON. Please review ...
>
> Thanks
> Manish Lachwani
