Received:  by oss.sgi.com id <S42227AbQGMXq3>;
	Thu, 13 Jul 2000 16:46:29 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:53055 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42205AbQGMXq0>;
	Thu, 13 Jul 2000 16:46:26 -0700
Received: from thor ([207.246.91.243]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via SMTP id QAA23831; Thu, 13 Jul 2000 16:39:04 -0700 (PDT)
	mail_from (jsk@tetracon-eng.net)
Received: from localhost (localhost [127.0.0.1]) by thor (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id TAA21555; Thu, 13 Jul 2000 19:39:50 -0300
Date:   Thu, 13 Jul 2000 19:39:50 -0300
From:   "J. Scott Kasten" <jsk@tetracon-eng.net>
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
In-Reply-To: <20000714005155.C8972@bacchus.dhis.org>
Message-ID: <Pine.SGI.4.10.10007131925490.21532-100000@thor.tetracon-eng.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


On Fri, 14 Jul 2000, Ralf Baechle wrote:

> We have various known problems with the various binutils version around.
> We're working on getting a current snapshot of binutils working
> properly but right now we still have various problems, therefore
> egcs 1.0.3a + binutils 2.8.1 is still the recommended version.

OK, I'll give that a shot along with the binutils-000707, gcc-000707 on
the Simple Linux site.  I've disovered that SOME of the shared objects I
build work, some do not at this point using the egcs-1.1.2 and
binutils-2.9.5 from the first Simple release.  I'll keep hammering at
this until I find a combo that does the job.

Thanks.
