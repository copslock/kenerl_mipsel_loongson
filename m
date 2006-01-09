Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2006 01:45:09 +0000 (GMT)
Received: from wproxy.gmail.com ([64.233.184.203]:60679 "EHLO wproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133656AbWAIBov convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 9 Jan 2006 01:44:51 +0000
Received: by wproxy.gmail.com with SMTP id 36so3202370wra
        for <linux-mips@linux-mips.org>; Sun, 08 Jan 2006 17:47:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rDwoPTCDVsMQMxA15EIOhSGBTNf9jU/jF1tvm/EP9gduGxN18bmTwQo2KXLAzGUZFq5Bfmr6B7hlaH86IGVw4T20+i2HZGvg1x5pvd2+9jNHYv1vuZv/z1oB4hK6fcgZXrGNJeUti6Aoiu4ui4l2jDqjTi8kZsNEMREgL5XD/D8=
Received: by 10.54.60.10 with SMTP id i10mr5897478wra;
        Sun, 08 Jan 2006 17:47:46 -0800 (PST)
Received: by 10.54.156.1 with HTTP; Sun, 8 Jan 2006 17:47:46 -0800 (PST)
Message-ID: <50c9a2250601081747l55c5b03p1601329141047c3d@mail.gmail.com>
Date:	Mon, 9 Jan 2006 09:47:46 +0800
From:	zhuzhenhua <zzh.hust@gmail.com>
To:	linux-mips <linux-mips@linux-mips.org>
Subject: Re: sometimes get "crc error" while uncompressed ramdisk
In-Reply-To: <50c9a2250601061939j42c4cc85n1c0246d9f8068938@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <50c9a2250601052240n5696e353teb2b798ecbf802f0@mail.gmail.com>
	 <1136537813.5239.23.camel@localhost.localdomain>
	 <50c9a2250601061939j42c4cc85n1c0246d9f8068938@mail.gmail.com>
Return-Path: <zzh.hust@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9804
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zzh.hust@gmail.com
Precedence: bulk
X-list: linux-mips

and i find the ramdisk sometimes uncompressed correctly, sometimes not.
if if uncorrect, if often stop at
generic_file_write_nolock -> __grab_cache_page
->add_to_page_cache_unique
->__add_to_page_cache->add_page_to_hash_queue

static void add_page_to_hash_queue(struct page * page, struct page **p)
{
	struct page *next = *p;

	*p = page;
	page->next_hash = next;
	page->pprev_hash = p;
	if (next)
		next->pprev_hash = &page->next_hash;
	if (page->buffers)
		PAGE_BUG(page);
~~~~~~~~~~~~~~~~~~~~~~~~~~
	atomic_inc(&page_cache_size);
}

it occur oops at
	if (page->buffers)
		PAGE_BUG(page);

i am not sure it may caused by hardware or uncorrect initialized of sdram?
or maybe uncorrect-maked ramdisk can cause this?

thanks for any hints!

Best regards!

Zhuzhenhua




On 1/7/06, zhuzhenhua <zzh.hust@gmail.com> wrote:
> On 1/6/06, jp <jaypee@hotpop.com> wrote:
> > On Fri, 2006-01-06 at 14:40 +0800, zhuzhenhua wrote:
> > > i make a ramdisk by myself, and sometimes the kernel boot the ramdisk
> > > correctly but sometimes it printk "crc error" while uncompressed
> > > ramdisk, did someone meet this situation?
> > > thanks for any hints
> > >
> >
> > Assuming your build and everything else is as it should be it may be a
> > RAM fault. Are you using a custom board?
> >
> > I had some prototype boards here with some really long tracks to RAM.
> > (and some really short ones too!)
> >
> > Memory tests such walking ones worked fine but the decompress of the
> > ramdisk works RAM pretty hard and it showed up intermittent faults like
> > you describe. Tended to be worse when the board was warm. I'd spray some
> > Freezit on and it would go back to working OK.
> >
> > You could also try running the RAM slower and see if the fault
> > disappears.
> >
> >
> > JP
> >
> >
> >
> maybe you are right, because i work on our FPGA board, and the
> situation is similiar as your description. i will try to slow down the
> sdram and to see what will happen
>
> thanks!
>
> Best regards
>
> zhuzhenhua
>
