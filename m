Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2005 11:35:49 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.186]:43233
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225311AbVCCLfe>; Thu, 3 Mar 2005 11:35:34 +0000
Received: from [213.39.254.66] (helo=tuxator.satorlaser-intern.com)
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML21M-1D6oc90jYK-0006vz; Thu, 03 Mar 2005 12:35:33 +0100
From:	Ulrich Eckhardt <eckhardt@satorlaser.com>
Organization: Sator Laser GmbH
To:	linux-mips@linux-mips.org
Subject: Re: sparse and mips
Date:	Thu, 3 Mar 2005 12:38:38 +0100
User-Agent: KMail/1.7.1
References: <422256A3.2030407@amsat.org> <4223240C.4010207@amsat.org> <20050303104654.GB5457@linux-mips.org>
In-Reply-To: <20050303104654.GB5457@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503031238.38363.eckhardt@satorlaser.com>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e35cee35a663f5c944b9750a965814ae
Return-Path: <eckhardt@satorlaser.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7359
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eckhardt@satorlaser.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> CHECKFLAGS-$(CONFIG_CPU_BIG_ENDIAN)     += -D__MIPSEL__
> CHECKFLAGS-$(CONFIG_CPU_LITTLE_ENDIAN)  += -D__MIPSEL__

typo? ;)

Uli
