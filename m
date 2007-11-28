Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Nov 2007 20:19:10 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:60126 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026191AbXK1UTI (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Nov 2007 20:19:08 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lASKJ3hP028066;
	Wed, 28 Nov 2007 20:19:03 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lASKJ2vF028065;
	Wed, 28 Nov 2007 20:19:02 GMT
Date:	Wed, 28 Nov 2007 20:19:02 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thomas Koeller <thomas@koeller.dyndns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: git problem
Message-ID: <20071128201902.GA27645@linux-mips.org>
References: <200711281950.46472.thomas@koeller.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200711281950.46472.thomas@koeller.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Nov 28, 2007 at 07:50:46PM +0100, Thomas Koeller wrote:

> on my machine I have clones of both the linux-mips and
> Linus' kernel tree. I recently found that git-describe
> behaves differently in those trees:
> 
> bash-3.2$ cd linux-2.6.git/
> bash-3.2$ git-status
> # On branch master
> nothing to commit (working directory clean)
> bash-3.2$ git-describe bd71c182d5a02337305fc381831c11029dd17d64
> v2.6.21-2747-gbd71c18
> bash-3.2$ cd ../excite.git/
> bash-3.2$ git-status
> # On branch master
> nothing to commit (working directory clean)
> bash-3.2$ git-describe bd71c182d5a02337305fc381831c11029dd17d64
> fatal: cannot describe 'bd71c182d5a02337305fc381831c11029dd17d64'
> 
> The commit is of course present in both trees. AFAIK the
> 'cannot describe' error shows if there are no tags at all,
> but this is not the case; .git/refs/tags is fully populated.
> Has anybody got a clue as to what may be wrong here?

I know the issue, for example:

[ralf@denk linux-mips]$ git log linux-1.3.0 | head -5
commit 908d4681a1dc3792ecafbe64265783a86c4cccb6
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Sun Oct 6 07:00:00 1996 +0000

    Import of Linux/MIPS 2.1.1
[ralf@denk linux-mips]$ git describe 908d4681a1dc3792ecafbe64265783a86c4cccb6
fatal: cannot describe '908d4681a1dc3792ecafbe64265783a86c4cccb6'
[ralf@denk linux-mips]$ 

I notice it primarily with fairly old tags though not necessarily as
antique as this one.

Cheers,

  Ralf
