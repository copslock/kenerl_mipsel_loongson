Received:  by oss.sgi.com id <S553773AbQJTHTJ>;
	Fri, 20 Oct 2000 00:19:09 -0700
Received: from gandalf1.physik.uni-konstanz.de ([134.34.144.69]:16657 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553751AbQJTHTC>; Fri, 20 Oct 2000 00:19:02 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 13mWSB-0001XB-00; Fri, 20 Oct 2000 09:18:59 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13mWSB-0008LH-00; Fri, 20 Oct 2000 09:18:59 +0200
Date:   Fri, 20 Oct 2000 09:18:58 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Ralf Baechle <ralf@oss.sgi.com>
Cc:     Guido Guenther <guido.guenther@gmx.net>, linux-mips@oss.sgi.com
Subject: Re: patches for dvhtool
Message-ID: <20001020091858.A32040@bilbo.physik.uni-konstanz.de>
References: <20001015021522.B3106@bilbo.physik.uni-konstanz.de> <20001019222501.A20568@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001019222501.A20568@bacchus.dhis.org>; from ralf@oss.sgi.com on Thu, Oct 19, 2000 at 10:25:01PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Oct 19, 2000 at 10:25:01PM +0200, Ralf Baechle wrote:
> On Sun, Oct 15, 2000 at 02:15:23AM +0200, Guido Guenther wrote:
> 
> I've applied your patches with exception of the debug junk and the
> partition ID stuff - the values for the prtition ids exceed the maximum
> value and we don't have assigned partition ids anyway.
Fdisk created the linux partitions with 0x83 which is the same as on
i386. Any reasons why we can't use them?
Regards,
 -- Guido
