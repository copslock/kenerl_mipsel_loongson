Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 09:18:26 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:36037 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133448AbWD1ISP
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Apr 2006 09:18:15 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k3S8I0qY002474;
	Fri, 28 Apr 2006 01:18:01 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with SMTP id k3S8HxsI007394;
	Fri, 28 Apr 2006 01:18:00 -0700 (PDT)
Message-ID: <000d01c66a9c$c6686290$10eca8c0@grendel>
From:	"Kevin D. Kissell" <kevink@mips.com>
To:	<gowri@bitel.co.kr>, <linux-mips@linux-mips.org>
References: <1146188366.3034.6.camel@localhost.localdomain>
Subject: Re: Java virtual machine on linux MIPS
Date:	Fri, 28 Apr 2006 10:21:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

It's been several years, but at one point I successfully tested
and benchmarked commercail JVMs from Insignia (now part
of Esmertec, www.esmertec.com) and Skelmir (www.skelmir.com),
and managed to get the open source Kaffe VM (www.kaffe.org) 
running on MIPS Linux as well.  Kaffe has a JIT that has, alas,
been broken for MIPS and most other RISC architectures for
the last couple of years, but the JVM still works OK in interpreted 
mode. I'm sure that there are other options - those are just the ones
I've had hands-on experience with.

            Regards,

            Kevin K.

----- Original Message ----- 
From: "Gowri Satish Adimulam" <gowri@bitel.co.kr>
To: <linux-mips@linux-mips.org>
Sent: Friday, April 28, 2006 3:39 AM
Subject: Java virtual machine on linux MIPS


> Hi , 
> 
> He is there  any java virtual machine runs on mips based linux .
> 
> any pointers will be helpful
> 
> Regards
> Gowri 
> 
> 
> 
