Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 18:57:20 +0200 (CEST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:18239 "EHLO
	ubik.localnet") by linux-mips.org with ESMTP id <S1122961AbSIRQ5T>;
	Wed, 18 Sep 2002 18:57:19 +0200
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by ubik.localnet (8.12.3/8.12.3/Debian -4) with ESMTP id g8IGvD6m010593;
	Wed, 18 Sep 2002 18:57:13 +0200
Message-ID: <3D88B068.6080303@murphy.dk>
Date: Wed, 18 Sep 2002 18:57:12 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-MIPS <linux-mips@linux-mips.org>
CC: Matthew Dharm <mdharm@momenco.com>
Subject: Re: fs problem between 2.4.19-rc1 and tip?
References: <NEBBLJGMNKKEEMNLHGAIKEPOCIAA.mdharm@momenco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Matthew Dharm wrote:

>Is anyone else seeing a problem using SCSI disks (ext2 format) that
>was introduced between 2.4.19-rc1 and the tip revision?
>
>Upon booting the 2.4.20-pre6 (tip of CVS), the root filesystem throws
>an error about an "unaligned directory entry" and then cannot find
>init.
>  
>
This sounds like a problem I had with cache flushing in pci.h which got 
triggered
by a change in the ide dma driver. Is it a pci driver? If so you could 
try the fix
I submitted a few days ago with ide-dma in the subject line.

/Brian
