Received:  by oss.sgi.com id <S42374AbQI0XjP>;
	Wed, 27 Sep 2000 16:39:15 -0700
Received: from u-141.karlsruhe.ipdial.viaginterkom.de ([62.180.18.141]:62980
        "EHLO u-141.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42375AbQI0Xi6>; Wed, 27 Sep 2000 16:38:58 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869612AbQI0XDl>;
        Thu, 28 Sep 2000 01:03:41 +0200
Date:   Thu, 28 Sep 2000 01:03:41 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Ian Chilton <mailinglist@ichilton.co.uk>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Problem with the new glibc-2.0.6
Message-ID: <20000928010341.A1834@bacchus.dhis.org>
References: <20000927214754.A20741@woody.ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000927214754.A20741@woody.ichilton.co.uk>; from mailinglist@ichilton.co.uk on Wed, Sep 27, 2000 at 09:47:54PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Sep 27, 2000 at 09:47:54PM +0100, Ian Chilton wrote:

> I built the older glibc 2.0.6 fine, but had problems with egcs when I built dynamically, and ldconfig would not work...so, I started again...
> 
> However, the new glibc that was released the other day, does not work :(
> 
> I am using binutils 2.8.1 and egcs 1.0.3a
> 
> Any ideas?

The common dominator of the bug reports I have is building with binutils
2.8.1, so I'll have to take another look at this piece of sh^H^Hpleasure.

  Ralf
