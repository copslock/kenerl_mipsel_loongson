Received:  by oss.sgi.com id <S553762AbQKBDII>;
	Wed, 1 Nov 2000 19:08:08 -0800
Received: from u-1.karlsruhe.ipdial.viaginterkom.de ([62.180.20.1]:24336 "EHLO
        u-1.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S553751AbQKBDHl>; Wed, 1 Nov 2000 19:07:41 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869089AbQKBDG6>;
        Thu, 2 Nov 2000 04:06:58 +0100
Date:   Thu, 2 Nov 2000 04:06:58 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: "Setting flush to zero for ..." - what is the warning?
Message-ID: <20001102040657.A17786@bacchus.dhis.org>
References: <3A0067C5.BA9E3174@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A0067C5.BA9E3174@mvista.com>; from jsun@mvista.com on Wed, Nov 01, 2000 at 10:58:13AM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Nov 01, 2000 at 10:58:13AM -0800, Jun Sun wrote:

> I ran some stress tests and start to get this warning.  It appears to be
> generated in do_fpe() routine.  See below.  I wonder why this is
> happening.  Can someone explain what is going on?  Thanks.

It tells you the over-the-thumb-fp-mode has been activated ;-)

Somebody at MIPS is working on merging the necessary fp support software
into the kernel, so this problem should be solved soon.

  Ralf
