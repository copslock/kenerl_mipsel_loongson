Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5IIodl20228
	for linux-mips-outgoing; Mon, 18 Jun 2001 11:50:39 -0700
Received: from ubik.localnet (port48.ds1-vbr.adsl.cybercity.dk [212.242.58.113])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5IIobV20225
	for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 11:50:38 -0700
Received: from murphy.dk (brian.localnet [10.0.0.2])
        by ubik.localnet (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f5IIoTq6013216
        for <linux-mips@oss.sgi.com>; Mon, 18 Jun 2001 20:50:31 +0200
Message-ID: <3B2E4D74.27E3D7FE@murphy.dk>
Date: Mon, 18 Jun 2001 20:50:28 +0200
From: Brian Murphy <brian@murphy.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Problems with mips2 compiled libc and linux 2.4.3
References: <3B2E4458.1637A08A@murphy.dk> <20010618202239.C25814@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:

> On Mon, Jun 18, 2001 at 08:11:36PM +0200, Brian Murphy wrote:
>
> >         if (__h->e_flags & EF_MIPS_ARCH)
> > \
> >                 __res = 0;
>
>

Will this be removed from the cvs version then?

With all the talk of ll/sc and mips 1 and 2  in the last few months
how has anyone tested/run with a mips2 libc if this test existed in
their kernel?

/Brian
