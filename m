Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Oct 2002 08:53:15 +0100 (CET)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:19246 "EHLO
	ubik.localnet") by linux-mips.org with ESMTP id <S1121806AbSJ3HxP>;
	Wed, 30 Oct 2002 08:53:15 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id g9U7r16m025171;
	Wed, 30 Oct 2002 08:53:02 +0100
Message-ID: <3DBF8FDD.9000309@murphy.dk>
Date: Wed, 30 Oct 2002 08:53:01 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: "TWEDE,ROGER (HP-Boise,ex1)" <roger_twede@hp.com>
CC: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: Recent Kernel Page Fault Problems Spawning Init?
References: <CBD6266EA291D5118144009027AA63353F9412@xboi05.boi.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

TWEDE,ROGER (HP-Boise,ex1) wrote:

>I would be appreciative of any advice anyone can offer in this regard.
>
>Were any fundamental kernel changes made in the 2.4.17 through 2.4.19
>timeframe which could explain why the spawning of init would hang?
>
>After mounting a root filesystem and attempting to spawn init, 3 or 4 page
>faults occur.  The entry point of init, its bss section and an elf loader
>.text section get hit, etc.  followed by an endless series of page faults to
>a bad address which just faults repeatedly, never allowing init or the elf
>loader to proceed.
>
>I've tried a RM 7000A and 20KC based boards so far with apparently identical
>behavior on both.
>
>Thanks,
>
>Roger Twede
>Hewlett Packard
>
>
>  
>
I have a very similar problem but with the 2.5 kernel. I haven't gotten 
any further than
you in finding the cause. I don't have these problems with 2.4.19 though.

/Brian
