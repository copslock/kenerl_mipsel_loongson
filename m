Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7G8oYd19014
	for linux-mips-outgoing; Thu, 16 Aug 2001 01:50:34 -0700
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7G8oWj19008
	for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 01:50:32 -0700
Received: from eicon.com (brian.localnet [10.0.0.2])
        by ubik.localnet (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f7G8oPhT016842
        for <linux-mips@oss.sgi.com>; Thu, 16 Aug 2001 10:50:25 +0200
Message-ID: <3B7B8951.B666A175@eicon.com>
Date: Thu, 16 Aug 2001 10:50:25 +0200
From: Brian Murphy <brian.murphy@eicon.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-mips@oss.sgi.com
Subject: Re: glibc
References: <E15X7kU-000416-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Alan Cox wrote:

> > I am porting Linux version 2.2.12 to Mips R3000 and need to build glibc
> > but I could not find the following files:
>
> Oh no not again.
>
> 2.2.12 is historical value only. It has remote vulnerabilities and shouldnt
> be used for anything.
>
> >       glibc-2.0.6.tar.gz
>
> glibc 2.0 is also obsolete, heavily so

We use 2.0.6 here because it is half the size of the newer glibcs and it seems

to work fine for us.

/Brian
