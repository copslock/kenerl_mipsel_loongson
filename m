Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3ILpcH24236
	for linux-mips-outgoing; Wed, 18 Apr 2001 14:51:38 -0700
Received: from dea.waldorf-gmbh.de (IDENT:root@localhost [127.0.0.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3ILpYM24233
	for <linux-mips@oss.sgi.com>; Wed, 18 Apr 2001 14:51:35 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f3ILg7G01550;
	Wed, 18 Apr 2001 18:42:07 -0300
Date: Wed, 18 Apr 2001 18:42:07 -0300
From: Ralf Baechle <ralf@oss.sgi.com>
To: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: New crosscompilers
Message-ID: <20010418184207.C1437@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I've uploaded new egcs 1.1.2 based crosscompiler to oss.sgi.com into
/pub/linux/mips/crossdev/.  The only change for version 1.1.2-4 affects
mips64-linux and mips64el-linux targets where asking for alignments
larger than 8 bytes was ignored with a warning message.  This did
possibly result in some performance penalty for mips64 kernels.

  Ralf
