Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBV93k430142
	for linux-mips-outgoing; Mon, 31 Dec 2001 01:03:46 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBV93Tg30132;
	Mon, 31 Dec 2001 01:03:30 -0800
Received: from smtp.huawei.com ([61.144.161.21]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA09338; Thu, 27 Dec 2001 16:56:26 -0800 (PST)
	mail_from (dony.he@huawei.com)
Received: from h11752a ([172.17.254.1]) by smtp.huawei.com
          (Netscape Messaging Server 4.15) with SMTP id GP13OP00.B2F; Fri,
          28 Dec 2001 08:50:49 +0800 
Message-ID: <001301c18f39$5685c640$9b6e0b0a@huawei.com>
From: "machael thailer" <dony.he@huawei.com>
To: "Ralf Baechle" <ralf@oss.sgi.com>,
   "Tommy S. Christensen" <tommy.christensen@eicon.com>
Cc: "Atsushi Nemoto" <nemoto@toshiba-tops.co.jp>, <linux-mips@oss.sgi.com>
References: <20011226013221.A737@dea.linux-mips.net> <20011227.105518.74756316.nemoto@toshiba-tops.co.jp> <20011227011222.A16695@dea.linux-mips.net> <20011227.125122.71082554.nemoto@toshiba-tops.co.jp> <20011227022936.A19397@dea.linux-mips.net> <3C2B45D3.B938CA44@eicon.com> <20011227191959.B1553@dea.linux-mips.net>
Subject: Re: vmalloc bugs in 2.4.5???
Date: Fri, 28 Dec 2001 08:48:16 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id fBV93fg30133
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


----- Original Message ----- 
From: Ralf Baechle <ralf@oss.sgi.com>
To: Tommy S. Christensen <tommy.christensen@eicon.com>
Cc: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>; <dony.he@huawei.com>; <linux-mips@oss.sgi.com>
Sent: Friday, December 28, 2001 5:19 AM
Subject: Re: vmalloc bugs in 2.4.5???


> On Thu, Dec 27, 2001 at 05:01:23PM +0100, Tommy S. Christensen wrote:
> 
> > Great! But please make sure that the cache is flushed after the pages
> > are allocated instead of before.
> > 
> > With 2.4.9 that still had the cache-flushing in vmalloc_area_pages(), I
> > got cache aliasing problems in low memory situations (since alloc_page()
> > will re-schedule when no pages are available).
> 
> Correct; I fixed that one.  That's actually a nasty one, affects all
> previous Linux releases.  I wonder how this one went unnoticed for so long.
> Probably because loading modules is a relativly rare event or so.

How do you fix it? Can you mail your fixup code to me please?

machael
