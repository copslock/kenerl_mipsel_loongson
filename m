Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 06:56:47 +0000 (GMT)
Received: from dfpost.ru ([IPv6:::ffff:194.85.103.225]:42680 "EHLO
	mail.dfpost.ru") by linux-mips.org with ESMTP id <S8224991AbULIG4i>;
	Thu, 9 Dec 2004 06:56:38 +0000
Received: from toch.dfpost.ru (toch.dfpost.ru [192.168.7.60])
	by mail.dfpost.ru (Postfix) with SMTP id 239C33E517;
	Thu,  9 Dec 2004 09:50:52 +0300 (MSK)
Date: Thu, 9 Dec 2004 09:56:59 +0300
From: Dmitriy Tochansky <toch@dfpost.ru>
To: Dan Malek <dan@embeddededge.com>
Cc: linux-mips@linux-mips.org
Subject: Re: mmap problem another :)
Message-Id: <20041209095659.651b7a1d.toch@dfpost.ru>
In-Reply-To: <5FE01AB3-493E-11D9-81C3-003065F9B7DC@embeddededge.com>
References: <20041208194014.1302df6f.toch@dfpost.ru>
	<5FE01AB3-493E-11D9-81C3-003065F9B7DC@embeddededge.com>
Organization: Special Technology Center
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <toch@dfpost.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: toch@dfpost.ru
Precedence: bulk
X-list: linux-mips

On Wed, 8 Dec 2004 12:27:02 -0500
Dan Malek <dan@embeddededge.com> wrote:

> 
> On Dec 8, 2004, at 11:40 AM, Dmitriy Tochansky wrote:
> 
> >   ret = remap_page_range_high (start, offset, size,
> >   vma->vm_page_prot);
> 
> Hmmm....this is in 2.4?  Did you apply all of the 36-bit IO
> patch as Pete Popov has mentioned in past e-mail messages?
  Could you please direct me where it is exectly? In this maillist? May be on the web?

> Did you make sure you enabled CONFIG_64BIT_PHYS_ADDR?
  Yes. I'm sure.
