Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2003 19:49:55 +0100 (BST)
Received: from il-la.la.idealab.com ([IPv6:::ffff:63.251.211.5]:53706 "HELO
	idealab.com") by linux-mips.org with SMTP id <S8225211AbTFIStx>;
	Mon, 9 Jun 2003 19:49:53 +0100
Received: (qmail 18187 invoked by uid 6180); 9 Jun 2003 18:49:51 -0000
Date: Mon, 9 Jun 2003 11:49:51 -0700
From: Jeff Baitis <baitisj@evolution.com>
To: Baruch Chaikin <bchaikin@il.marvell.com>
Cc: linux-mips@linux-mips.org, Rabeeh Khoury <rabeeh@galileo.co.il>,
	Baruch Chaikin <bchaikin@galileo.co.il>
Subject: Re: Building a stand-alone FS on a very limited flash (newbie  question)
Message-ID: <20030609114951.O29389@luca.pas.lab>
Reply-To: baitisj@evolution.com
References: <Pine.GSO.4.44.0306061234410.4045-100000@hydra.mmc.atmel.com> <Pine.GSO.3.96.1030609164009.2806n-100000@delta.ds2.pg.gda.pl> <20030609154408.GA1781@nevyn.them.org> <3EE4C5CF.3050607@galileo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EE4C5CF.3050607@galileo.co.il>; from bchaikin@il.marvell.com on Mon, Jun 09, 2003 at 07:37:19PM +0200
Return-Path: <baitisj@idealab.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: baitisj@evolution.com
Precedence: bulk
X-list: linux-mips

I highly recommend looking at the UClibC project. Erik's code is a pleasure to
work with.  http://www.uclibc.org/

It is even possible to build libstdc++ with UClibC, if you are so inclined...
And, a number of commercial projects use UClibC , such as Linksys:
http://lkml.org/archive/2003/6/7/164/index.html

and Belkin:

http://lkml.org/archive/2003/6/8/31/index.html

<shameless YRO plug>

-Jeff



On Mon, Jun 09, 2003 at 07:37:19PM +0200, Baruch Chaikin wrote:
> Hi all,
> 
> I'm using MIPS kernel 2.4.18 with NFS file system mounted on a RedHat 
> machine. This works fine, but is unsuitable for system deployment. Do 
> you have hints for me where to start, in order to put the file system on 
> flash? The platform I'm using is very limited - only one MTD block of 
> 2.5 MB is available for the file system, out of a 4 MB flash:
>     0.5 MB is allocated for the firmware code
>     1.0 MB for the compressed kernel image
>     2.5 MB for the (compressed?) file system
> 
> For example, I've noticed LibC itself is ~5 MB !
> 
> Thanks for any tip,
> -    Baruch.
> 
> 
> 

-- 
         Jeffrey Baitis - Associate Software Engineer

                    Evolution Robotics, Inc.
                     130 West Union Street
                       Pasadena CA 91103

 tel: 626.535.2776  |  fax: 626.535.2777  |  baitisj@evolution.com 
