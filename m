Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBRH13i25431
	for linux-mips-outgoing; Thu, 27 Dec 2001 09:01:03 -0800
Received: from firewall.i-data.com (firewall.i-data.com [195.24.22.194])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBRH0xX25417
	for <linux-mips@oss.sgi.com>; Thu, 27 Dec 2001 09:00:59 -0800
Received: (qmail 5545 invoked from network); 27 Dec 2001 16:00:55 -0000
Received: from idahub2000.i-data.com (HELO idanshub.i-data.com) (172.16.1.8)
  by firewall.i-data.com with SMTP; 27 Dec 2001 16:00:55 -0000
Received: from eicon.com ([172.16.2.227])
          by idanshub.i-data.com (Lotus Domino Release 5.0.8)
          with ESMTP id 2001122717005390:44752 ;
          Thu, 27 Dec 2001 17:00:53 +0100 
Message-ID: <3C2B45D3.B938CA44@eicon.com>
Date: Thu, 27 Dec 2001 17:01:23 +0100
From: "Tommy S. Christensen" <tommy.christensen@eicon.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@oss.sgi.com>
CC: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>, dony.he@huawei.com,
   linux-mips@oss.sgi.com
Subject: Re: vmalloc bugs in 2.4.5???
References: <20011226013221.A737@dea.linux-mips.net> <20011227.105518.74756316.nemoto@toshiba-tops.co.jp> <20011227011222.A16695@dea.linux-mips.net> <20011227.125122.71082554.nemoto@toshiba-tops.co.jp> <20011227022936.A19397@dea.linux-mips.net>
X-MIMETrack: Itemize by SMTP Server on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at
 27-12-2001 17:00:54,
	Serialize by Router on idaHUB2000/INT(Release 5.0.8 |June 18, 2001) at 27-12-2001
 17:00:55,
	Serialize complete at 27-12-2001 17:00:55
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> On Thu, Dec 27, 2001 at 12:51:22PM +0900, Atsushi Nemoto wrote:
> 
> > >>>>> On Thu, 27 Dec 2001 01:12:22 -0200, Ralf Baechle <ralf@oss.sgi.com> said:
> > ralf> Yes, you're right as for the cache.  But there is no reason for
> > ralf> the TLB flush, right?
> >
> > Yes, I agree.
> 
> Ok, I'll make a patch for Marcelo.  Being in Brazil right now is useful,
> I can beat him into accepting it ;-)
> 
>   Ralf

Great! But please make sure that the cache is flushed after the pages
are allocated instead of before.

With 2.4.9 that still had the cache-flushing in vmalloc_area_pages(), I
got cache aliasing problems in low memory situations (since alloc_page()
will re-schedule when no pages are available).

-Tommy
