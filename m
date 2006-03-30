Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2006 07:09:28 +0100 (BST)
Received: from deliver-1.mx.triera.net ([213.161.0.31]:3033 "HELO
	deliver-1.mx.triera.net") by ftp.linux-mips.org with SMTP
	id S8127173AbWC3GJP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 30 Mar 2006 07:09:15 +0100
Received: from localhost (in-3.mx.triera.net [213.161.0.27])
	by deliver-1.mx.triera.net (Postfix) with ESMTP id 7DE23C0B3;
	Thu, 30 Mar 2006 08:19:47 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-3.mx.triera.net (Postfix) with SMTP id 656961BC08E;
	Thu, 30 Mar 2006 08:19:48 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id BD99B1A18BC;
	Thu, 30 Mar 2006 08:19:48 +0200 (CEST)
Date:	Thu, 30 Mar 2006 08:19:50 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	Chris Boot <bootc@bootc.net>
Cc:	Thiemo Seufer <ths@networkno.de>, linux-mips@linux-mips.org
Subject: Re: Emulating MIPS -- please help!
Message-ID: <20060330061950.GA29489@domen.ultra.si>
References: <44299EE6.7010309@bootc.net> <20060328235827.GC31939@networkno.de> <671FD00E-F2EB-4D8C-A391-5393096BC43D@bootc.net> <20060329160337.GI31939@networkno.de> <E9A44E96-DD59-4543-AC62-586BFDB6E720@bootc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E9A44E96-DD59-4543-AC62-586BFDB6E720@bootc.net>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

On 29/03/06 22:31 +0100, Chris Boot wrote:
> On 29 Mar 2006, at 17:03, Thiemo Seufer wrote:
> 
> >On Wed, Mar 29, 2006 at 04:47:23PM +0100, Chris Boot wrote:
> >[snip]
> >>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> >>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> >>Memory: 128480k/131072k available (907k kernel code, 2556k reserved,
> >>172k data, 96k init, 0k highmem)
> >>Mount-cache hash table entries: 512
> >>Checking for 'wait' instruction...  available.
> >>
> >>At this stage it gets stuck and I have to kill qemu. Any ideas how to
> >>debug this?
> >
> >Familiar symptom, I fixed it but don't remember offhand which patch
> >contains the fix. It was either related to TLB emulation or to
> >kernel-mode/user-mode mismatch.
> 
> Well, I added a few more patches and it finally boots now, but it  
> can't mount the root FS off the RAMDISK. I'm not sure if this is a  
> side-effect of the previous initrd problem or what, but it feels good  
> to be getting further...

I was unable to boot userspace from initrd too. It was loaded to the
wrong address or something. "Fixing" that didn't work either.

OTOH initramfs worked fine for me. Maybe you can live with that.


	Domen

> 
> >>I've only applied the elf-loader patch since I was having
> >>trouble applying some of the others to my Ubuntu qemu 0.8.0.
> >
> >The patches are for upstream CVS.
> 
> Hmm, well I might give it a shot and see what happens. I'd rather  
> stick with a stable version, but if it gets me somewhere it's  
> probably worth it.
> 
> Thanks very much,
> Chris
> 
> -- 
> Chris Boot
> bootc@bootc.net
> http://www.bootc.net/
> 
> 
