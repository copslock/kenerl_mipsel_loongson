Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2008 05:23:35 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:28103 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030966AbYEMEXd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 May 2008 05:23:33 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m4D4NETk029758;
	Tue, 13 May 2008 05:23:14 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m4D4NBVc029738;
	Tue, 13 May 2008 05:23:11 +0100
Date:	Tue, 13 May 2008 05:23:11 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Stephen Rothwell <sfr@canb.auug.org.au>
Cc:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>,
	Theodore Tso <tytso@mit.edu>,
	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	linux-ext4@vger.kernel.org
Subject: Re: ext4dev build failure on mips: "empty_zero_page" undefined
Message-ID: <20080513042311.GA22226@linux-mips.org>
References: <20080512130604.GA15008@deprecation.cyrius.com> <90edad820805120654n50f7a00cm3c7b4a4f9346d5ea@mail.gmail.com> <20080512143426.GB7029@mit.edu> <20080512145836.GE15866@deprecation.cyrius.com> <90edad820805120814l7ee3f5d3h7f9939854bccf0@mail.gmail.com> <20080512173537.GG7029@mit.edu> <90edad820805121237r7f4b6e16g135df49cfe27499a@mail.gmail.com> <20080513105549.bb1563f8.sfr@canb.auug.org.au> <20080513114244.736cf625.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080513114244.736cf625.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19241
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2008 at 11:42:44AM +1000, Stephen Rothwell wrote:

> Also, the only compiler version that crosstool seems to know about for
> mips is 3.4.5.  Is this version ok for building mips kernels?

Minimum is 3.2 for building a 32-bit kernel and 3.3 for a 64-bit kernel
but I really wouldn't recommend anything older than 3.4.

There are crosscompiler rpms on ftp.linux-mips.org in
/pub/linux/mips/crossdev for various host / target combinations.  They
come without libraries so just good enough for building kernels - but that's
the only purpose I build them for.  Also I don't have access to a powerpc
box so no power rpms.

  Ralf
