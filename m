Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2006 18:11:00 +0000 (GMT)
Received: from oola.is.scarlet.be ([193.74.71.23]:57732 "EHLO
	oola.is.scarlet.be") by ftp.linux-mips.org with ESMTP
	id S20039494AbWLKSKz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 11 Dec 2006 18:10:55 +0000
Received: from (fuji.is.scarlet.be [193.74.71.41]) 
	by oola.is.scarlet.be  with ESMTP id kBBIAro04841; 
	Mon, 11 Dec 2006 19:10:53 +0100
Date:	Mon, 11 Dec 2006 19:10:53 +0100
Message-Id: <JA4FU5$15B25B9E0AEC49C3D47C4ABD5469CF70@scarlet.be>
Subject: Re:hwo to improve a video decoder program's timeslice
MIME-Version: 1.0
X-Sensitivity: 3
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
From:	"Philippe De Swert" <philippedeswert@scarlet.be>
To:	"zzh\.hust" <zzh.hust@gmail.com>
Cc:	"linux-mips" <linux-mips@linux-mips.org>
X-XaM3-API-Version: 4.1 (B54)
X-type:	0
X-SenderIP: 192.100.124.218
Return-Path: <philippedeswert@scarlet.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-Envid: <JA4FU5$15B25B9E0AEC49C3D47C4ABD5469CF70
Envelope-Id: <JA4FU5$15B25B9E0AEC49C3D47C4ABD5469CF70
X-archive-position: 13427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: philippedeswert@scarlet.be
Precedence: bulk
X-list: linux-mips

Hi,

>  i have a video decoder program run as aplication
> and i now have change the HZ from 1000 to 100, set the decoder program
> priority as 99.

Seems you are mixing things here... The HZ change will just change the
interval of the timer tick. For some more explanations about this, look here :
http://kerneltrap.org/node/464

> if i want to the video decoder program to get more time to run, is
> there any other way to improve it ?

Maybe using nice? Try "man nice" in a terminal on your Linux box to get more
explanations about this.

Cheers,

Philippe---
Scarlet ONE -  Combine ADSL with unlimited fixed phone and save 400 euros
http://www.scarlet.be
