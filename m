Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2003 17:56:21 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:39465
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225211AbTFIQ4T>; Mon, 9 Jun 2003 17:56:19 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.35 #1)
	id 19PPwL-00010P-00; Mon, 09 Jun 2003 18:56:13 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 19PPwL-0006Jd-00; Mon, 09 Jun 2003 18:56:13 +0200
Date: Mon, 9 Jun 2003 18:56:12 +0200
To: Baruch Chaikin <bchaikin@il.marvell.com>
Cc: linux-mips@linux-mips.org, Rabeeh Khoury <rabeeh@galileo.co.il>
Subject: Re: Building a stand-alone FS on a very limited flash (newbie  question)
Message-ID: <20030609165612.GE32450@rembrandt.csv.ica.uni-stuttgart.de>
References: <Pine.GSO.4.44.0306061234410.4045-100000@hydra.mmc.atmel.com> <Pine.GSO.3.96.1030609164009.2806n-100000@delta.ds2.pg.gda.pl> <20030609154408.GA1781@nevyn.them.org> <3EE4C5CF.3050607@galileo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE4C5CF.3050607@galileo.co.il>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2571
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Baruch Chaikin wrote:
> Hi all,
> 
> I'm using MIPS kernel 2.4.18 with NFS file system mounted on a RedHat 
> machine. This works fine, but is unsuitable for system deployment. Do 
> you have hints for me where to start, in order to put the file system on 
> flash? The platform I'm using is very limited - only one MTD block of 
> 2.5 MB is available for the file system, out of a 4 MB flash:
>    0.5 MB is allocated for the firmware code
>    1.0 MB for the compressed kernel image
>    2.5 MB for the (compressed?) file system
> 
> For example, I've noticed LibC itself is ~5 MB !

You'll need a smaller libc, dietlibc comes to mind.
http://www.dietlibc.org/


Thiemo
