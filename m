Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jun 2003 19:14:18 +0100 (BST)
Received: from ftp.mips.com ([IPv6:::ffff:206.31.31.227]:63405 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225199AbTFFSOQ>;
	Fri, 6 Jun 2003 19:14:16 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h56IDaUe024565;
	Fri, 6 Jun 2003 11:13:36 -0700 (PDT)
Received: from xchange.mips.com (xchange [192.168.20.31])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id LAA00793;
	Fri, 6 Jun 2003 11:13:40 -0700 (PDT)
Received: by xchange.mips.com with Internet Mail Service (5.5.2653.19)
	id <LJWWNP3X>; Fri, 6 Jun 2003 11:13:24 -0700
Message-ID: <0C5F4C7A1E3ED51194E200508B2CE32A022649CF@xchange.mips.com>
From: "Mitchell, Earl" <earlm@mips.com>
To: "'HG'" <henri@broadbandnetdevices.com>, linux-mips@linux-mips.org
Subject: RE: how to get older version instead of bleeding edge 
Date: Fri, 6 Jun 2003 11:13:23 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Return-Path: <earlm@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2557
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: earlm@mips.com
Precedence: bulk
X-list: linux-mips

Setup env and login ...

export CVSROOT=:pserver:cvs@ftp.linux-mips.org:/home/cvs
cvs login    # password=cvs

To get list of tags available ...

cvs history -r -T linux

Latest stable version is 2_4_21-pre3, to download ..

mkdir ./linux_2_4_21-pre3
cd ./linux_2_4_21-pre3
cvs checkout -r linux_2_4_21-pre3 linux

-earlm


>-----Original Message-----
>From: HG [mailto:henri@broadbandnetdevices.com]
>Sent: Friday, June 06, 2003 10:57 AM
>To: linux-mips@linux-mips.org
>Subject: how to get older version instead of bleeding edge
>
>Hi all
>
>How I get the older version of the linux for mips kernel , in particular I
>would like the 2.4.20
>
>after downloading successfully the latest cvs with the web example
>i tried to upgrade with : $ cvs
>cvs -d :pserver:cvs@ftp.linux-mips.org:/home/cvs  update -r2.4.20 linux
>a long list of ..../filename is no longer in the repository was obtained
>
>any hints of the command line necessary
>
>thanks
>
>Henri
