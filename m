Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 May 2009 08:58:59 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:35108 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20024866AbZETH6x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 May 2009 08:58:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id 0E64531C8F3;
	Wed, 20 May 2009 15:53:59 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jS135HUT++vX; Wed, 20 May 2009 15:53:44 +0800 (CST)
Received: from [172.16.2.16] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 6391231C92D;
	Wed, 20 May 2009 15:53:40 +0800 (CST)
Subject: Re: [PATCH 26/30] loongson: flush irq write operation
From:	yanh <yanh@lemote.com>
Reply-To: yanh@lemote.com
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, zhangfx@lemote.com,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>, Erwan Lerale <erwan@thiscow.com>
In-Reply-To: <20090520070719.GA24231@linux-mips.org>
References: <1242426527.10164.174.camel@falcon>
	 <20090518163603.GA22779@linux-mips.org>
	 <1242700637.4382.21.camel@localhost.localdomain>
	 <20090519160117.GA19672@linux-mips.org>
	 <1242786494.4382.58.camel@localhost.localdomain>
	 <20090520070719.GA24231@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Date:	Wed, 20 May 2009 15:58:04 +0800
Message-Id: <1242806284.4382.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

在 2009-05-20三的 08:07 +0100，Ralf Baechle写道：
> On Wed, May 20, 2009 at 10:28:14AM +0800, yanh wrote:
> 
> > I have test this patch just now. It works well on yeeloong. 
> 
> Thanks for testing.
> 
> > I have one question what's the difference between the two patch? 
> 
> Uncached writes can't be re-ordered.  By adding a read after the last
> write my patch forces not only completion of the preceding write but due
> to this ordering constraint also completion of all preceding writes is
> enforced.
> 
> I/O space writes are slow.  I mean slower than slugs in space.  So my
> patch is an optimization but that was not the point; I really only meant
> to verify that we understood what's going on and we seem to.  Now let's
> fix the real issue and make outX() non-posted.
Thanks for your explanation. 
> 
>   Ralf
> 
