Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Aug 2004 10:05:58 +0100 (BST)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.188]:6876 "EHLO
	moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224949AbUHKJFy>; Wed, 11 Aug 2004 10:05:54 +0100
Received: from [212.227.126.179] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Bup3Q-0002lP-00
	for linux-mips@linux-mips.org; Wed, 11 Aug 2004 11:05:52 +0200
Received: from [80.129.147.123] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1Bup3Q-0002C9-00
	for linux-mips@linux-mips.org; Wed, 11 Aug 2004 11:05:52 +0200
From: Michael Stickel <michael.stickel@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: Re: Q: XFree86 (on MeshCube) from Debian?
Date: Wed, 11 Aug 2004 11:05:49 +0200
User-Agent: KMail/1.5.4
References: <Pine.LNX.4.58.0408110935080.16674@shofar.kom.e-technik.tu-darmstadt.de>
In-Reply-To: <Pine.LNX.4.58.0408110935080.16674@shofar.kom.e-technik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408111105.50140.michael.stickel@4g-systems.biz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:f72049c8971f462876d14eb8b3ccbbf1
Return-Path: <michael.stickel@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.stickel@4g-systems.biz
Precedence: bulk
X-list: linux-mips


Do you have an nfs-rootfs?
If you have a serial cable you can load an alternate kernel from tftp.
It has to be in srec format.

On Wednesday 11 August 2004 09:35, you wrote:
> thanks a lot to the persons who helped me setting up a Debian/Sarge
> environment for the MeshCube (using cdebootstrap worked like a charm).
>
> I may go on with an XFree86 server now (I tried using the ati module):
> ...
> XFree86 Version 4.3.0.1 (Debian 4.3.0.dfsg.1-6 20040709164028
> root@remake.rfc822
> .org)
> Release Date: 15 August 2003
> X Protocol Version 11, Revision 0, Release 6.6
> Build Operating System: Linux 2.4.25 mips [ELF]
> Build Date: 10 July 2004
