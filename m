Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2007 02:28:54 +0000 (GMT)
Received: from smtp109.plus.mail.re1.yahoo.com ([69.147.102.72]:6818 "HELO
	smtp109.plus.mail.re1.yahoo.com") by ftp.linux-mips.org with SMTP
	id S28576807AbXKAC2p (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Nov 2007 02:28:45 +0000
Received: (qmail 49570 invoked from network); 1 Nov 2007 02:27:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=VeJJhY2mLtbp9GND6o0+eblWWNAD72OGWlAqdRja6wQwfuxmyGt72OgTSlT3mSoPc76uAM1cp2sBl+OKp0PQGMf0Z73whct4+VsTSlVuMEw3a1/Tjsd8O2/KWxNnREq3eWsrc/ktAvdd9Ga+7K/Sd/aNWI1Fu+tukjDpvvjtpeg=  ;
Received: from unknown (HELO zeus.tetracon-eng.net) (jscottkasten@72.185.69.24 with login)
  by smtp109.plus.mail.re1.yahoo.com with SMTP; 1 Nov 2007 02:27:38 -0000
X-YMail-OSG: gdlf6UwVM1n07P_vX.NsPycmeVKluZxOQVc5j.l6IJpG1sJ2qXh0T3_Cx5MPnk_8.UdIbut6Ag--
Date:	Wed, 31 Oct 2007 22:27:31 -0400
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@zeus.tetracon-eng.net
To:	Hyon Lim <alex@alexlab.net>
cc:	linux-mips@linux-mips.org
Subject: Re: implementation of software suspend on MIPS. (system log)
In-Reply-To: <dd7dc2bc0710311846ve03e03eued4ed72c89b06e4f@mail.gmail.com>
Message-ID: <Pine.SGI.4.60.0710312221360.4697@zeus.tetracon-eng.net>
References: <DDAE9570F73FC744918E843E20BE598B096E8E@server1.RightHand.righthandtech.com>
 <dd7dc2bc0710311846ve03e03eued4ed72c89b06e4f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips


On Thu, 1 Nov 2007, Hyon Lim wrote:

> Yes. you're right. I did same as you said.
> However, is there any options for disassembly with variable name?
> Often I cannot find that variable's allocated register.
> There is only r0,r1... but I want a comment for variable assignment 
> status.

I just have to ask the question, but is it really necessary to code the 
whole thing in assembly?  I understand that the interface probably does 
need to be, but the main body of the function?  If it's very large or 
complicated, it would seem simpler to use C and write assembly glue to 
pull it all together rather than trying to debug hand assembly.  Many of 
us here have spent hours before tracking down problems with stale data in 
branch delay slots.  The compiler is a tad more convienient.

Regards,

-S-
