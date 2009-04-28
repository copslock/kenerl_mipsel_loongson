Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2009 16:06:08 +0100 (BST)
Received: from mail-bw0-f177.google.com ([209.85.218.177]:48266 "EHLO
	mail-bw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025516AbZD1PGD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Apr 2009 16:06:03 +0100
Received: by bwz25 with SMTP id 25so636467bwz.0
        for <multiple recipients>; Tue, 28 Apr 2009 08:05:57 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=p75UIDRrPv7eO9Z2TdOccwKnyuw/v5r/8YjrE9BP3x0=;
        b=jw7UP02aNneuFJL+I01g6J91Mau9wUQXEtvnbwOQKzju/yhOJpcMWbIYU+tjWdxA08
         szwfPZQXtAms9KQtjwdQnc6h1Rl69izDts5E+U2dgBIWoXLMN0BmAGC2LSHIvY8EwYOT
         0l5tJz1Zi39lU72ErnlyA1rKoWPck7kRC14KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Yn18ZsY7JUDSIDHHvAih2lTX/5gsB8huqbe4MsxTl4e3ueF48u4ba17nwAc+gkOsPH
         xoYIhX6/8b0D+PNTBB3+t9OI/OgC0EU6XEp+SzTHprd7Aof1ad4hEmzfNH5VUDGtzQ10
         DZv1+CU4LCRYBJhhkCYDVBstTbeoC2L0yMXgg=
Received: by 10.204.58.16 with SMTP id e16mr6529100bkh.43.1240931157094;
        Tue, 28 Apr 2009 08:05:57 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id d13sm7158301fka.39.2009.04.28.08.05.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Apr 2009 08:05:56 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Shane McDonald <mcdonald.shane@gmail.com>
Subject: Re: [MIPS] Resolve compile issues with msp71xx configuration
Date:	Tue, 28 Apr 2009 17:05:53 +0200
User-Agent: KMail/1.9.9
Cc:	Christoph Hellwig <hch@lst.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
References: <E1LyQQX-00047N-6E@localhost> <20090428092005.GA2408@lst.de> <b2b2f2320904280748q3a45ecf6r46dcb536877663c@mail.gmail.com>
In-Reply-To: <b2b2f2320904280748q3a45ecf6r46dcb536877663c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200904281705.54721.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22514
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Shane,

Le Tuesday 28 April 2009 16:48:52 Shane McDonald, vous avez écrit :
> Hello:
>
> On Tue, Apr 28, 2009 at 3:20 AM, Christoph Hellwig <hch@lst.de> wrote:
> > On Mon, Apr 27, 2009 at 03:22:33PM +0200, Geert Uytterhoeven wrote:
> > > He needs the definition of struct squashfs_super_block to access the
> >
> > .bytes_used
> >
> > > field. Alternatively, the offset of that field must be hardcoded.
> >
> > No, that whole crap needs to go.  FS code has no business poking into fs
> > internal structures.  BTW, this whole setup is really, really gross,
> > it's mtd map driver calling arch code to get base + size for mapping,
> > poking into fs internal structures.  I really wonder what people have
> > been smoking to come up with crap like that.
> >
> > We should just leave it uncompilable as a sign for future generations
> > not to such stupid stuff.
>
> So, just so I'm clear, you prefer option 4 of removing the entire
> get_ramroot() code? :-)
>
> > If the rootfs really is in ram only (and thus you discard any changes to
> > it) you can just use an initramfs which is a lot simpler than any of the
> > cramfs and squashfs hacks and supported by platform-independent code.
>
> The rootfs is ram only with a union mount of a jffs2 filesystem to retain
> changes.  The target system is a resource-constrained router board, and we
> were trying to keep everything as small as possible.  If I remember
> correctly, this code originally came over from an internal 2.4 port on an
> even more resource-constrained platform; perhaps there are better options
> in today's world.

Initramfs is supposed to address that kind of issue, coupled to the use of 
mini_fo/unionfs with a jffs2 partition for instance.

If you want to compress initramfs even more you may want to have a look at the 
patch we maintain here: 
https://dev.openwrt.org/browser/trunk/target/linux/brcm47xx/patches-2.6.28/500-lzma_initramfs.patch

>
> I will look into a better solution to this problem.  In the meantime, I'm
> hesitant to remove the existing code -- I think I prefer to leave it
> uncompilable until that solution is found.

It is likely to confuse people that may want to try get it compiling again, 
removing sounds like a safe bet to me.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
