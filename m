Received:  by oss.sgi.com id <S553922AbQLAAAW>;
	Thu, 30 Nov 2000 16:00:22 -0800
Received: from u-59-20.karlsruhe.ipdial.viaginterkom.de ([62.180.20.59]:45320
        "EHLO u-59-20.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S553918AbQLAAAC>; Thu, 30 Nov 2000 16:00:02 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S869735AbQK3X7m>;
	Fri, 1 Dec 2000 00:59:42 +0100
Date:	Fri, 1 Dec 2000 00:59:42 +0100
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	"Kevin D. Kissell" <kevink@mips.com>
Cc:	Jesse Dyson <jesse@winston-salem.com>,
        Klaus Naumann <spock@mgnet.de>, linux-mips@oss.sgi.com
Subject: Re: Indigo2 Kernel Boots!!!
Message-ID: <20001201005942.A6172@bacchus.dhis.org>
References: <Pine.LNX.4.10.10011300938100.6504-100000@mail.netunlimited.net> <00f601c05ae8$19014500$0deca8c0@Ulysses>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <00f601c05ae8$19014500$0deca8c0@Ulysses>; from kevink@mips.com on Thu, Nov 30, 2000 at 05:10:32PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Nov 30, 2000 at 05:10:32PM +0100, Kevin D. Kissell wrote:

> When the init process fires up, it opens /dev/console as the
> console output device.  A default SGI workstation installation
> file system will have /dev/console bound to the major/minor device
> node of the graphics display console.  If you want to run with a serial
> console, you must therefore change this to bind /dev/console
> to the serial port.  You can do this by doing an explicit mknod,
> or by linking to the appropriate serial port device node,
> which is usually /dev/ttyS0.

Which both are wrong.  /dev/console should be a char device major 5, minor 1.
There is no need to change this ever except for very old kernels.  With 2.2
or 2.4 whenever people change /dev/console's major/minor it's usually painting
over some bug.

  Ralf
