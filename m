Received:  by oss.sgi.com id <S553765AbQJYWde>;
	Wed, 25 Oct 2000 15:33:34 -0700
Received: from gandalf1.physik.uni-konstanz.de ([134.34.144.69]:51721 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553757AbQJYWdL>; Wed, 25 Oct 2000 15:33:11 -0700
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 13oZ6O-0001m9-00; Thu, 26 Oct 2000 00:32:56 +0200
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 13oZ6O-0007WV-00; Thu, 26 Oct 2000 00:32:56 +0200
Date:   Thu, 26 Oct 2000 00:32:56 +0200
From:   Guido Guenther <guido.guenther@gmx.net>
To:     Klaus Naumann <spock@mgnet.de>
Cc:     Keith M Wesolowski <wesolows@chem.unr.edu>, linux-mips@oss.sgi.com
Subject: Re: fdisk/kernel oddity
Message-ID: <20001026003256.A28902@bilbo.physik.uni-konstanz.de>
References: <20001025194348.A1164@gandalf.physik.uni-konstanz.de> <Pine.LNX.4.21.0010252242560.726-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010252242560.726-100000@spock.mgnet.de>; from spock@mgnet.de on Wed, Oct 25, 2000 at 10:46:12PM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Wed, Oct 25, 2000 at 10:46:12PM +0200, Klaus Naumann wrote:
> I've been geeting this correuption a while back too - look at the mailing
> list archives. The problem seems to be cache corruption as far as I can
> see. Since Ralf checked in some small fixes for the cache handling it's a
> bit better - but not completely fixed.
Can you explain in what sense it is "a bit better" now. 
> The Problem is also tracked on the buc tracker btw (#5) .
Ian was so kind to but it into the BTS after he told me that this is a
known problem. 
> 
> I have seen this only when copying from one harddisk to another.
> Especialy if one wants to copy the kernel sources it will messup.
I also see problems when dd'ing from /dev/sda to e.g. /dev/null, 
so this does not only occur when copying between disks. Also in this
case I don't get the illegal instructions but rather strange
"/etc/shadow file not found" messages.
Regards,
 -- Guido
