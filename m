Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Nov 2002 21:58:37 +0100 (CET)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:32298 "EHLO
	ubik.localnet") by linux-mips.org with ESMTP id <S1124140AbSKQU6g>;
	Sun, 17 Nov 2002 21:58:36 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id gAHKwQfA018134;
	Sun, 17 Nov 2002 21:58:26 +0100
Message-ID: <3DD802F2.4040306@murphy.dk>
Date: Sun, 17 Nov 2002 21:58:26 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: loadavg calculation current cvs
References: <20021117175217.GA23404@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Florian Lohoff wrote:

>Could it be that somethings broken ? Although the machine is 
>idle after booting the load is automatically at 1 - Some process
>is getting counted in the loadavg although it shouldnt. This is 2.4cvs
>2 days old.
>
>
>root         3  0.0  0.0     0    0 ?        RWN  17:55   0:00 [ksoftirqd_CPU0]
>  
>
ksoftirqd is always running, it seems, even when it's not.

/Brian
