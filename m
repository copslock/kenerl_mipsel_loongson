Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2006 10:21:01 +0000 (GMT)
Received: from mx1.redhat.com ([66.187.233.31]:54198 "EHLO mx1.redhat.com")
	by ftp.linux-mips.org with ESMTP id S3458455AbWBFKUx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2006 10:20:53 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id k16AQHTE016876;
	Mon, 6 Feb 2006 05:26:17 -0500
Received: from file.cambridge.redhat.com (file.cambridge.redhat.com [172.16.18.10])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id k16AQC112662;
	Mon, 6 Feb 2006 05:26:13 -0500
Received: from warthog.cambridge.redhat.com (warthog.cambridge.redhat.com [172.16.18.73])
	by file.cambridge.redhat.com (8.11.6/8.11.6) with ESMTP id k16AQB118919;
	Mon, 6 Feb 2006 10:26:11 GMT
Received: from warthog.cambridge.redhat.com (localhost.localdomain [127.0.0.1])
	by warthog.cambridge.redhat.com (8.13.4/8.13.4) with ESMTP id k16AQ0kQ012368;
	Mon, 6 Feb 2006 10:26:01 GMT
From:	David Howells <dhowells@redhat.com>
In-Reply-To: <20060201090324.373982000@localhost.localdomain> 
References: <20060201090324.373982000@localhost.localdomain>  <20060201090224.536581000@localhost.localdomain> 
To:	Akinobu Mita <mita@miraclelinux.com>
Cc:	linux-kernel@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, dev-etrax@axis.com,
	David Howells <dhowells@redhat.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-ia64@vger.kernel.org,
	Hirokazu Takata <takata@linux-m32r.org>,
	Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
	parisc-linux@parisc-linux.org, linuxsh-dev@lists.sourceforge.net,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
	Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Chris Zankel <chris@zankel.net>
Subject: Re: [patch 11/44] generic find_{next,first}{,_zero}_bit() 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date:	Mon, 06 Feb 2006 10:26:00 +0000
Message-ID: <12367.1139221560@warthog.cambridge.redhat.com>
Return-Path: <dhowells@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dhowells@redhat.com
Precedence: bulk
X-list: linux-mips

Akinobu Mita <mita@miraclelinux.com> wrote:

> This patch introduces the C-language equivalents of the functions below:
> 
> unsigned logn find_next_bit(const unsigned long *addr, unsigned long size,
>                             unsigned long offset);
> unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
>                                  unsigned long offset);
> unsigned long find_first_zero_bit(const unsigned long *addr,
>                                   unsigned long size);
> unsigned long find_first_bit(const unsigned long *addr, unsigned long size);

These big functions should perhaps be out of line.

David
