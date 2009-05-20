Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 08:08:02 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34423 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024712AbZETHHy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 May 2009 08:07:54 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4K77LLa017157;
	Wed, 20 May 2009 08:07:22 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4K77Jc2017155;
	Wed, 20 May 2009 08:07:19 +0100
Date:	Wed, 20 May 2009 08:07:19 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	yanh <yanh@lemote.com>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
Subject: Re: [PATCH 26/30] loongson: flush irq write operation
Message-ID: <20090520070719.GA24231@linux-mips.org>
References: <1242426527.10164.174.camel@falcon> <20090518163603.GA22779@linux-mips.org> <1242700637.4382.21.camel@localhost.localdomain> <20090519160117.GA19672@linux-mips.org> <1242786494.4382.58.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1242786494.4382.58.camel@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 20, 2009 at 10:28:14AM +0800, yanh wrote:

> I have test this patch just now. It works well on yeeloong. 

Thanks for testing.

> I have one question what's the difference between the two patch? 

Uncached writes can't be re-ordered.  By adding a read after the last
write my patch forces not only completion of the preceding write but due
to this ordering constraint also completion of all preceding writes is
enforced.

I/O space writes are slow.  I mean slower than slugs in space.  So my
patch is an optimization but that was not the point; I really only meant
to verify that we understood what's going on and we seem to.  Now let's
fix the real issue and make outX() non-posted.

  Ralf
