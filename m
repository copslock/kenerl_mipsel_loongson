Received:  by oss.sgi.com id <S553742AbRCNM55>;
	Wed, 14 Mar 2001 04:57:57 -0800
Received: from u-21-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.21]:15612
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553717AbRCNM5q>; Wed, 14 Mar 2001 04:57:46 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f2ECvQR30821;
	Wed, 14 Mar 2001 13:57:26 +0100
Date:   Wed, 14 Mar 2001 13:57:26 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Pete Popov <ppopov@mvista.com>
Cc:     "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: rdev
Message-ID: <20010314135726.B30630@bacchus.dhis.org>
References: <3AAE846E.916F16BE@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AAE846E.916F16BE@mvista.com>; from ppopov@mvista.com on Tue, Mar 13, 2001 at 12:34:54PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Tue, Mar 13, 2001 at 12:34:54PM -0800, Pete Popov wrote:

> Can you "rdev vmlinux /dev/hda1" a mips kernel and have it work (have
> the kernel recognize that its root fs is /dev/hda1 without passing any
> command line arguments)?  I tried it and it doesn't seem to work, unless
> you have to specify offset or other options that I don't know about.

No, rdev works only on x86.

  Ralf
