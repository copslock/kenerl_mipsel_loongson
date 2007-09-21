Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 03:09:58 +0100 (BST)
Received: from an-out-0708.google.com ([209.85.132.249]:27541 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20024923AbXIUCJt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 21 Sep 2007 03:09:49 +0100
Received: by an-out-0708.google.com with SMTP id d26so109582and
        for <linux-mips@linux-mips.org>; Thu, 20 Sep 2007 19:09:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=SkHd8JwQ3SZ5YqzfkZpM3Or0rOngbtOI+T582RiCI2k=;
        b=S/UDZhNvFa6DfFTttRpENyHdPCOnm5SA68om9mazsehL+e+V1GMhFpOUESzjoXUWkaz3fp2N1F09CkWNFUGR8Sia5V6ykFYUkinLfq5ug1cNLBQnaM8ykJALfyt3urdQK7JNt9hZr+iTwPxq8xk5ETO77UZ/HXDAXbepfpwU/x8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=TETQNGcu1GgL6hK4d3CEDmhpIN0IXd8uOGNpfrN0STfLflyX4ZpW9OpEvMwZQUq4ecWwgWIfqevHZc4BMWSnApuveg2z6xQROeIeVCgOsRoNlmTTMXLRHkxiJqliU9OWhd3rKA1UeswvVqSeK9bwtmHKvN3dKOn2uW+ud22Z+8o=
Received: by 10.100.167.7 with SMTP id p7mr3631534ane.1190340571333;
        Thu, 20 Sep 2007 19:09:31 -0700 (PDT)
Received: from ?192.168.0.3? ( [87.6.117.29])
        by mx.google.com with ESMTPS id c15sm323273anc.2007.09.20.19.09.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Sep 2007 19:09:30 -0700 (PDT)
From:	Matteo Croce <technoboy85@gmail.com>
To:	=?utf-8?q?J=C3=B6rn_Engel?= <joern@logfs.org>
Subject: Re: [PATCH][MIPS][2/7] AR7: mtd partition map
Date:	Fri, 21 Sep 2007 04:09:22 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
	Felix Fietkau <nbd@openwrt.org>,
	Eugene Konev <ejka@imfi.kspu.ru>,
	linux-mtd@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>, dwmw2@infradead.org
References: <200709201728.10866.technoboy85@gmail.com> <20070920193547.GA911@lst.de> <20070920200058.GB1692@lazybastard.org>
In-Reply-To: <20070920200058.GB1692@lazybastard.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200709210409.23521.technoboy85@gmail.com>
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16610
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

Il Thursday 20 September 2007 22:00:59 Jörn Engel ha scritto:
> On Thu, 20 September 2007 21:35:49 +0200, Christoph Hellwig wrote:
> > On Thu, Sep 20, 2007 at 09:29:11PM +0200, Matteo Croce wrote:
> > > +#ifdef CONFIG_CPU_LITTLE_ENDIAN
> > > +#define LOADER_MAGIC1	0xfeedfa42
> > > +#define LOADER_MAGIC2	0xfeed1281
> > > +#else
> > > +#define LOADER_MAGIC1	0x42faedfe
> > > +#define LOADER_MAGIC2	0x8112edfe
> > > +#endif
> > 
> > Please keep only one defintion and use le/be32_to_cpu on it.
> > 
> > > +struct ar7_bin_rec {
> > > +	unsigned int checksum;
> > > +	unsigned int length;
> > > +	unsigned int address;
> > > +};
> > 
> > Wich means you'd need an endianess annotation here.  What about the
> > length and address fields, are they always native-endian unlike
> > the checksum field or will the need to be byte-swapped aswell?
> 
> <slightly off-topic, feel free to skip>
> If this is indeed the squashfs magic, le/be32_to_cpu won't help.
> Squashfs can have either endianness, tries to detect the one actually
> used by checking either magic and sets a flag in the superblock.
> Afterwards every single access checks the flag and conditionally swaps
> fields around or not.
> 
> If squashfs had a fixed endianness, quite a lot of this logic could get
> removed and both source and object size would shrink.  Some two years
> after requesting this for the first time, I'm thinking about just doing
> it myself.  If I find a sponsor who pays me for it, I might even do it
> soon.
> </offtopic>
> 
> 
> I don't really understand why the squashfs magic number should be used
> in this code at all.  It may have set a bad example, though.  In general
> you should decide on a fixed endianness (1) and use the beXX_to_cpu
> macros when accessing data unless you have a very good reason to do
> otherwise.
> 
> 1) Big endian is my preferred choice because it is easy to read in a
> hexdump and the opposite of my notebook.  Being forced to do endian
> conversions during development/testing helps to find problems early.

I use little endian since 99% of AR7s are little endian. Dunno if
le/be32_to_cpu does some runtime calculations. Do they?
