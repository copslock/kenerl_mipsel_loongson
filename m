Received:  by oss.sgi.com id <S553874AbQLPSE5>;
	Sat, 16 Dec 2000 10:04:57 -0800
Received: from wn42-146.sdc.org ([209.155.42.146]:54255 "EHLO lappi")
	by oss.sgi.com with ESMTP id <S553871AbQLPSEb>;
	Sat, 16 Dec 2000 10:04:31 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S870675AbQLPLpj>;
	Sat, 16 Dec 2000 04:45:39 -0700
Date:	Sat, 16 Dec 2000 12:45:39 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Nicu Popovici <octavp@isratech.ro>, linux-mips@oss.sgi.com
Subject: Re: Little endian.
Message-ID: <20001216124539.A6896@bacchus.dhis.org>
References: <3A3ABFA9.8608799D@isratech.ro> <001301c066c4$d2b9f7c0$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <001301c066c4$d2b9f7c0$0deca8c0@Ulysses>; from kevink@mips.com on Fri, Dec 15, 2000 at 07:28:15PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Dec 15, 2000 at 07:28:15PM +0100, Kevin D. Kissell wrote:

> If you want to run little-endian, you need to install
> the little-endian binaries and libraries.  Since I needed
> to "swing both ways", I put both a big-endian root and
> a little-endian root partition on my Atlas disk, with user/data 
> partitions that can be mounted on either one - fortunately, 
> the Ext2FS metadata seems to be consistent regardless 
> of endianness.

Ext2fs on-disk data structures are defined to be little endian.  Some very
old ext2 filesystems which afaik where all created on Linux/M68K were big
endian; for those e2fsck has the option to change the endianess of the
filesystem during a fsck run; the current kernel will refuse to accept
such big endian ext2 filesystems.

  Ralf
