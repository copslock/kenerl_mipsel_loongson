Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 14:19:42 +0100 (CET)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:46374 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493133AbZKWNTg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 14:19:36 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id nANDJZU8029224;
	Mon, 23 Nov 2009 13:19:35 GMT
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id nANDJW4j029222;
	Mon, 23 Nov 2009 13:19:32 GMT
Date:	Mon, 23 Nov 2009 13:19:32 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Michal Simek <michal.simek@petalogix.com>
Cc:	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org
Subject: Re: linux-next: Tree for November 23
Message-ID: <20091123131932.GA28687@linux-mips.org>
References: <20091123185232.1423c56b.sfr@canb.auug.org.au> <4B0A8841.8090905@petalogix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B0A8841.8090905@petalogix.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25061
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 02:04:01PM +0100, Michal Simek wrote:

>> The microblaze tree still has a build failure for which I reverted a
>> commit.
>>
>> The mips tree gained a conflict against the microblaze tree.
>
> It is problem which is caused one my ftrace patch. MIPS ftrace  
> implementation was first that's why I should solve it. It is easy to fix.
> I just need to know where mips/mips-for-linux-next branch is.

Gitweb:  http://www.linux-mips.org/git?p=upstream-sfr.git;a=summary
Git:     git://www.linux-mips.org/pub/scm/upstream-sfr.git

  Ralf 
