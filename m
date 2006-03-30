Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 08:57:46 +0100 (BST)
Received: from bender.bawue.de ([193.7.176.20]:16544 "EHLO bender.bawue.de")
	by ftp.linux-mips.org with ESMTP id S8133353AbWC3H5h (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2006 08:57:37 +0100
Received: from lagash (88-106-238-34.dynamic.dsl.as9105.com [88.106.238.34])
	(using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by bender.bawue.de (Postfix) with ESMTP
	id 670D644441; Thu, 30 Mar 2006 10:08:12 +0200 (MEST)
Received: from ths by lagash with local (Exim 4.60)
	(envelope-from <ths@networkno.de>)
	id 1FOsCD-0002yv-19; Thu, 30 Mar 2006 09:07:57 +0100
Date:	Thu, 30 Mar 2006 09:07:47 +0100
To:	Domen Puncer <domen.puncer@ultra.si>
Cc:	Chris Boot <bootc@bootc.net>, linux-mips@linux-mips.org
Subject: Re: Emulating MIPS -- please help!
Message-ID: <20060330080746.GM31939@networkno.de>
References: <44299EE6.7010309@bootc.net> <20060328235827.GC31939@networkno.de> <671FD00E-F2EB-4D8C-A391-5393096BC43D@bootc.net> <20060329160337.GI31939@networkno.de> <E9A44E96-DD59-4543-AC62-586BFDB6E720@bootc.net> <20060330061950.GA29489@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330061950.GA29489@domen.ultra.si>
User-Agent: Mutt/1.5.11+cvs20060126
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

On Thu, Mar 30, 2006 at 08:19:50AM +0200, Domen Puncer wrote:
> On 29/03/06 22:31 +0100, Chris Boot wrote:
> > On 29 Mar 2006, at 17:03, Thiemo Seufer wrote:
> > 
> > >On Wed, Mar 29, 2006 at 04:47:23PM +0100, Chris Boot wrote:
> > >[snip]
> > >>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> > >>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> > >>Memory: 128480k/131072k available (907k kernel code, 2556k reserved,
> > >>172k data, 96k init, 0k highmem)
> > >>Mount-cache hash table entries: 512
> > >>Checking for 'wait' instruction...  available.
> > >>
> > >>At this stage it gets stuck and I have to kill qemu. Any ideas how to
> > >>debug this?
> > >
> > >Familiar symptom, I fixed it but don't remember offhand which patch
> > >contains the fix. It was either related to TLB emulation or to
> > >kernel-mode/user-mode mismatch.
> > 
> > Well, I added a few more patches and it finally boots now, but it  
> > can't mount the root FS off the RAMDISK. I'm not sure if this is a  
> > side-effect of the previous initrd problem or what, but it feels good  
> > to be getting further...
> 
> I was unable to boot userspace from initrd too. It was loaded to the
> wrong address or something. "Fixing" that didn't work either.

It gets loaded to 0x80800000, feeding rd_start/rd_size derived from
that address as kernel parameters should work.


Thiemo
