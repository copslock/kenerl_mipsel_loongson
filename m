Received:  by oss.sgi.com id <S42378AbQJFWWl>;
	Fri, 6 Oct 2000 15:22:41 -0700
Received: from u-150.karlsruhe.ipdial.viaginterkom.de ([62.180.18.150]:10502
        "EHLO u-150.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42374AbQJFWWi>; Fri, 6 Oct 2000 15:22:38 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869498AbQJFRxc>;
        Fri, 6 Oct 2000 19:53:32 +0200
Date:   Fri, 6 Oct 2000 19:53:32 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: SMB in 2.4 Kernel
Message-ID: <20001006195332.B8544@bacchus.dhis.org>
References: <20001006140734.A11647@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001006140734.A11647@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Fri, Oct 06, 2000 at 02:07:34PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Oct 06, 2000 at 02:07:34PM +0100, Ian Chilton wrote:

> Compiling nativly on an Indy 4k with glibc 2.0.6, egcs 1.0.3a, binutils 2.8.1 and 2.2.14

I'm just comitting an untested fix for this problem.  It also did affect
mips64.

  Ralf
