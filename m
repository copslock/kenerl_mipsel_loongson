Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Aug 2007 13:55:27 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:65183 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024099AbXHGMzZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 7 Aug 2007 13:55:25 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l77CtMtv023898;
	Tue, 7 Aug 2007 13:55:22 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l77CtLiU023897;
	Tue, 7 Aug 2007 13:55:21 +0100
Date:	Tue, 7 Aug 2007 13:55:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Aurelien Jarno <aurelien@aurel32.net>
Cc:	Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	Michael Buesch <mb@bu3sch.de>,
	Waldemar Brodkorb <wbx@openwrt.org>,
	Felix Fietkau <nbd@openwrt.org>,
	Florian Schirmer <jolt@tuxbox.org>
Subject: Re: [PATCH -mm 0/4] MIPS BCM947xx CPUs support
Message-ID: <20070807125521.GA23739@linux-mips.org>
References: <20070806150701.GE24308@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070806150701.GE24308@hall.aurel32.net>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 06, 2007 at 05:07:01PM +0200, Aurelien Jarno wrote:

> The following series of patches add basic support for the BCM947xx 
> CPUs. CFE support still needs work and thus is not included in those 
> patches, so the command line has to be included in the kernel. 
> Everything else is fully functional and the resulting kernel works
> fine on a Netgear WGT634U.

Any reason why not to simply share the CFE related code with what the
Broadcom Sibyte family of chips are using?

> I am submitting those patches for inclusion into -mm as they depend
> on features that are not present in the linux-mips git tree, but are
> present in the -mm series, namely Sonic Silicon Backplane bus support.

That won't fly as akpm is pulling from the MIPS tree also, so there
will be conflicts really soon.

  Ralf
