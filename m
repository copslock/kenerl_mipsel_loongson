Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Jan 2005 16:25:47 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.188]:4333 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8225271AbVAEQZm>; Wed, 5 Jan 2005 16:25:42 +0000
Received: from [212.227.126.206] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CmDyV-0000bH-00
	for linux-mips@linux-mips.org; Wed, 05 Jan 2005 17:25:31 +0100
Received: from [217.91.102.65] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1CmDyV-0004Q8-00
	for linux-mips@linux-mips.org; Wed, 05 Jan 2005 17:25:31 +0100
From: Michael Stickel <michael.stickel@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: Re: problem of cross compile
Date: Wed, 5 Jan 2005 17:26:02 +0100
User-Agent: KMail/1.7
References: <1104911780.5055@157.120.127.3.DIONWebMail>
In-Reply-To: <1104911780.5055@157.120.127.3.DIONWebMail>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501051726.02703.michael.stickel@4g-systems.biz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:f72049c8971f462876d14eb8b3ccbbf1
Return-Path: <michael.stickel@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.stickel@4g-systems.biz
Precedence: bulk
X-list: linux-mips

On Wednesday 05 January 2005 08:56, you wrote:
> Hi!
>
> I have a question about cross compile(MIPS on REDHAT9).

Make shure you used the corss strip (eg. mips-linux-strip) and not the host 
strip.

> "test:ELF 32-bit LSB executable, no machine, version 1(SYSV), for GNU/Linux
> 2.4.17, dynamically linked (uses shared libs), stripped"

Michael
