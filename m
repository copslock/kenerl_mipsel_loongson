Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 15:20:05 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:54680
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225278AbTEJOUD>; Sat, 10 May 2003 15:20:03 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 19EVCj-0018X4-00
	for linux-mips@linux-mips.org; Sat, 10 May 2003 16:20:01 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19EVCi-0002ZR-00
	for <linux-mips@linux-mips.org>; Sat, 10 May 2003 16:20:00 +0200
Date: Sat, 10 May 2003 16:19:59 +0200
To: linux-mips@linux-mips.org
Subject: Re: OpenSSL/Binutils Issues
Message-ID: <20030510141959.GB18697@rembrandt.csv.ica.uni-stuttgart.de>
References: <3EBC7E21.6040109@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBC7E21.6040109@gentoo.org>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2339
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Kumba wrote:
[snip]
> 	Which builds fine.  Then the error hits when attempting to execute 
> 	the "conftest" executable:
> 
> 		./conftest: error while loading shared libraries:
> 		usr/lib/libcrypto.so.0.9.6: unexpected reloc type 0x68

This libcrypto seems to be broken. 0x68 is not a valid MIPS reloc type
at all, and a shared lib should use only R_MIPS_32 (type 2) relocations
anyway.

> 	Has anyone seen anything like this?  My base mips install on my SGI 
> Indigo2 is built using binutils-2.13.90.0.16, which builds everything 
> fine, just doesn't cooperate well with -mips3 or higher options.  I'm 
> not sure if this is mips-specific, or if I need to bother the OpenSSL 
> team about it.

It is probably a binutils issue. Can you send the output of
objdump -R usr/lib/libcrypto.so.0.9.6 |grep R_MIPS |grep -v \(R_MIPS_32\|R_MIPS_NONE\)


Thiemo
