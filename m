Received:  by oss.sgi.com id <S42249AbQJKCN4>;
	Tue, 10 Oct 2000 19:13:56 -0700
Received: from u-73.karlsruhe.ipdial.viaginterkom.de ([62.180.18.73]:23558
        "EHLO u-73.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42215AbQJKCNf>; Tue, 10 Oct 2000 19:13:35 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S870106AbQJKCMo>;
        Wed, 11 Oct 2000 04:12:44 +0200
Date:   Wed, 11 Oct 2000 04:12:44 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        debian-mips@lists.debian.org
Subject: Re: glibc on MIPS ...
Message-ID: <20001011041244.C7458@bacchus.dhis.org>
References: <39E3D0B8.7F221344@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <39E3D0B8.7F221344@mvista.com>; from jsun@mvista.com on Tue, Oct 10, 2000 at 07:30:16PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Oct 10, 2000 at 07:30:16PM -0700, Jun Sun wrote:

> Does anybody what is the status of glibc on MIPS?
> 
> So far I have been using the glibc coming from linux-vr project.  It is
> v2.0.7.  Somehow the pthread does not appear to be working. 
> pthread_create() returns EAGIN error, even though clone() system returns
> correct result.

2.0.7 is filling my mailfolders with obscure bug reports.  Seems like
nobody is bothering to keep it updated with any kind of bug fixes.

> I looked at the cvs tree on oss.sgi.com.  The glibc version is 2.0.6. 
> What is the status of this version?

Cvs on oss should be equivalent to glibc-2.0.6-5lm.src.rpm which is the
version which I'm still recommending for now.  Don't use -6lm, it's
broken.

> I also heard about the debian-mips project.  What glibc is used here?

A pre-2.2 snapshot.  Not yet stable and requires a binutils snapshot to
build which also isn't yet stable.  But we're getting closer and things
are beginning to look promising.

  Ralf
