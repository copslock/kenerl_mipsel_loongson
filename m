Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Aug 2007 13:31:26 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:3526 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20023783AbXHWM20 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 23 Aug 2007 13:28:26 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l7NCSE8q012232;
	Thu, 23 Aug 2007 13:28:24 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l7MM3LMh004479;
	Wed, 22 Aug 2007 23:03:21 +0100
Date:	Wed, 22 Aug 2007 23:03:21 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Jiri Slaby <jirislaby@gmail.com>
Cc:	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, source@mvista.com,
	dougthompson@xmission.com, bluesmoke-devel@lists.sourceforge.net,
	dtor@mail.ru, linux-input@atrey.karlin.mff.cuni.cz,
	netdev@vger.kernel.org, James.Bottomley@SteelEye.com,
	linux-scsi@vger.kernel.org, gtolstolytkin@ru.mvista.com,
	vitalywool@gmail.com, dsaxena@plexity.net,
	linux-mips@linux-mips.org, mchehab@infradead.org,
	video4linux-list@redhat.com, jbenc@suse.cz,
	flamingice@sourmilk.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 8/9] define global BIT macro
Message-ID: <20070822220321.GA4473@linux-mips.org>
References: <737828602404912540@wsc.cz> <428714662539710215@wsc.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428714662539710215@wsc.cz>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16259
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Aug 18, 2007 at 11:44:12AM +0200, Jiri Slaby wrote:

> define global BIT macro
> 
> move all local BIT defines to the new globally define macro.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Ralf Baechle <ralf@linux-mips.org>

for the MACE ethernet and MIPS bits.

  Ralf
