Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2006 19:00:30 +0100 (BST)
Received: from firewall.dcbnet.com ([12.96.67.19]:10470 "EHLO
	firewall.dcbnet.com") by ftp.linux-mips.org with ESMTP
	id S7620194AbWECSAU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 May 2006 19:00:20 +0100
Received: from mschank.dcbnet.com (mschank.dcbnet.com [205.166.54.128])
	by firewall.dcbnet.com (8.12.10/8.12.10) with ESMTP id k43I08i7013390;
	Wed, 3 May 2006 13:00:11 -0500
Message-Id: <5.1.0.14.2.20060503122616.0283e3b0@205.166.54.3>
X-Sender: mschank@205.166.54.3
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date:	Wed, 03 May 2006 13:01:02 -0500
To:	Herbert Valerio Riedel <hvr@gnu.org>
From:	Mark Schank <mschank@dcbnet.com>
Subject: Re: RFC: au1000_etc.c phylib rewrite
Cc:	linux-mips@linux-mips.org
In-Reply-To: <1146674056.31241.18.camel@localhost.localdomain>
References: <5.1.0.14.2.20060502095256.01fd4210@205.166.54.3>
 <5.1.0.14.2.20060501144633.025e4e20@205.166.54.3>
 <1146510542.16643.10.camel@localhost.localdomain>
 <1146510542.16643.10.camel@localhost.localdomain>
 <5.1.0.14.2.20060501144633.025e4e20@205.166.54.3>
 <5.1.0.14.2.20060502095256.01fd4210@205.166.54.3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-Path: <mschank@dcbnet.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mschank@dcbnet.com
Precedence: bulk
X-list: linux-mips

Herbert,

>btw, is the CSB655 supported at all in the 2.6 linux-mips branch, I
>couldn't find any mention of it in Kconfig files either?

The CSB655 makes use of some of these seeming "unused" options, but the 
board specific code for the CSB655 was never submitted back to linux-mips 
tree.  I did not develop of any of this code, so I am not sure of the 
reason why it was not submitted back.  I received the code when I purchased 
a CSB655/955 developers kit and have since ported portions of it forward to 
the 2.6.16 branch.  I am willing to submit what I have done, but I don't 
want to step on the original developers toes.  There were also several 
changes I had to make to generic MIPs and Linux code, and I am not sure of 
the proper way to handle them in the general linux-mips tree.

-Mark
