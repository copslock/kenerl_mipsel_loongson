Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA7BTGG06885
	for linux-mips-outgoing; Wed, 7 Nov 2001 03:29:16 -0800
Received: from smtp.huawei.com ([61.144.161.21])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA7BTA006880;
	Wed, 7 Nov 2001 03:29:10 -0800
Received: from hcdong11752a ([10.105.28.74]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GMFH2Y00.NGO; Wed,
          7 Nov 2001 19:25:46 +0800 
Message-ID: <000f01c1677f$88fd6560$4a1c690a@huawei.com>
From: "machael" <dony.he@huawei.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>
Cc: <linux-mips@oss.sgi.com>
References: <013301c165cc$5d030fa0$4a1c690a@huawei.com> <20011106130839.B30219@dea.linux-mips.net> <20011107.103947.74756322.nemoto@toshiba-tops.co.jp> <20011107024146.A1740@dea.linux-mips.net>
Subject: Re: vmalloc bugs in 2.4.5???
Date: Wed, 7 Nov 2001 19:29:59 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> On Wed, Nov 07, 2001 at 10:39:47AM +0900, Atsushi Nemoto wrote:
>
> > In 2.4.5, flush_cache_all() (and flush_tlb_all()) is called in
> > vmalloc_area_pages().  I think this call protect us from virtual
> > aliasing problem.
> >
> > By the way, does anybody have any problem with vmalloc on recent
> > kernel?
> >
> > In somewhere between 2.4.6 and 2.4.9, the call to flush_cache_all()
> > disappered from vmalloc_area_pages().  I have a data corruption
> > problem in vmalloc()ed area without this call.  I think we still need
> > this call.
>
> Entirely correct.  I'm just trying to find why this call got removed
> in 2.4.10.  Clearly wrong;  I had not noticed that these two lines
> got removed and thus was assuming the code of those two must somehow
> be malfunctioning.

I have added these two lines to vmalloc_area_pages in 2.4.10,but the
problems  still appear.
Why?

machael
