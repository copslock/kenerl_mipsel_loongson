Received:  by oss.sgi.com id <S553858AbQKHM63>;
	Wed, 8 Nov 2000 04:58:29 -0800
Received: from u-203.karlsruhe.ipdial.viaginterkom.de ([62.180.21.203]:40968
        "EHLO u-203.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553765AbQKHM6P>; Wed, 8 Nov 2000 04:58:15 -0800
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868643AbQKHD6E>;
        Wed, 8 Nov 2000 04:58:04 +0100
Date:   Wed, 8 Nov 2000 04:58:04 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Michl Ladislav <xmichl03@stud.fee.vutbr.cz>
Cc:     linux-mips@oss.sgi.com
Subject: Re: setenv eaddr
Message-ID: <20001108045804.A12999@bacchus.dhis.org>
References: <Pine.BSF.4.05.10011071158500.58171-100000@fest.stud.fee.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.BSF.4.05.10011071158500.58171-100000@fest.stud.fee.vutbr.cz>; from xmichl03@stud.fee.vutbr.cz on Tue, Nov 07, 2000 at 03:50:28PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Nov 07, 2000 at 03:50:28PM +0100, Michl Ladislav wrote:

> I was looking to the archives and HOWTOs to find way how to change eaddr
> of sgi Indy (which was incorrectly set after 2.4.0-test6 crash) and find
> couple of questions and no answer. I think about -p switch of setenv
> mentioned in archives supposing that it means "permanent" and trying to
> imagine how to FORCE set eaddr. This is the key.

The -p option doesn't work for the eaddr variable.  Hey, SGI didn't want
it's customers to arbitrarily change serial numbers of the machine ...

  Ralf
