Received:  by oss.sgi.com id <S42220AbQGKX5e>;
	Tue, 11 Jul 2000 16:57:34 -0700
Received: from u-215.karlsruhe.ipdial.viaginterkom.de ([62.180.10.215]:31751
        "EHLO u-215.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42190AbQGKX5S>; Tue, 11 Jul 2000 16:57:18 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S639437AbQGKX5Q>;
        Wed, 12 Jul 2000 01:57:16 +0200
Date:   Wed, 12 Jul 2000 01:57:16 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Tor Arntsen <tor@spacetec.no>
Cc:     linux-mips@oss.sgi.com, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr
Subject: Re: Kernel boot tips.
Message-ID: <20000712015716.C4606@bacchus.dhis.org>
References: <ralf@oss.sgi.com> <200007111419.QAA08466@pallas.spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200007111419.QAA08466@pallas.spacetec.no>; from tor@spacetec.no on Tue, Jul 11, 2000 at 04:19:18PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Jul 11, 2000 at 04:19:18PM +0200, Tor Arntsen wrote:

> On Jul 10, 23:53, Ralf Baechle wrote:
> [...]
> >It's a while that I last worked on it but as I remember --vh-to-unix was
> >actually working while the other direction was work in progress.
> 
> It is indeed working, I was merely using it incorrectly (I had specified 
> the device as I do with the SGI dvhtool instead of using -d).
> 
> >Maybe some nroff fan also wants to provide a manpage?
> 
> I can do it if nobody else beats me to it.

While still somewhat inaccurate the manpage is still a big improvment
over the current Read-The-Fucking-Source state of things, so I've applied
it.

  Ralf
