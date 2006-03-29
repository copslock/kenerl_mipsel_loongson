Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Mar 2006 16:53:42 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:45257 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133728AbWC2Pxe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Mar 2006 16:53:34 +0100
Received: from lagash (unknown [194.74.144.146])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 1206344104; Wed, 29 Mar 2006 18:04:08 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1FOd8z-00004y-QF; Wed, 29 Mar 2006 17:03:37 +0100
Date:	Wed, 29 Mar 2006 17:03:37 +0100
To:	Chris Boot <bootc@bootc.net>
Cc:	linux-mips@linux-mips.org
Subject: Re: Emulating MIPS -- please help!
Message-ID: <20060329160337.GI31939@networkno.de>
References: <44299EE6.7010309@bootc.net> <20060328235827.GC31939@networkno.de> <671FD00E-F2EB-4D8C-A391-5393096BC43D@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <671FD00E-F2EB-4D8C-A391-5393096BC43D@bootc.net>
User-Agent: Mutt/1.5.11+cvs20060126
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Wed, Mar 29, 2006 at 04:47:23PM +0100, Chris Boot wrote:
[snip]
> Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Memory: 128480k/131072k available (907k kernel code, 2556k reserved,  
> 172k data, 96k init, 0k highmem)
> Mount-cache hash table entries: 512
> Checking for 'wait' instruction...  available.
> 
> At this stage it gets stuck and I have to kill qemu. Any ideas how to  
> debug this?

Familiar symptom, I fixed it but don't remember offhand which patch
contains the fix. It was either related to TLB emulation or to
kernel-mode/user-mode mismatch.

> I've only applied the elf-loader patch since I was having  
> trouble applying some of the others to my Ubuntu qemu 0.8.0.

The patches are for upstream CVS.


Thiemo
