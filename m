Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 21:55:10 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:25386
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225235AbTGAUzI>; Tue, 1 Jul 2003 21:55:08 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h61Kt09g008199;
	Tue, 1 Jul 2003 22:55:01 +0200
Message-ID: <3F01F524.8050608@murphy.dk>
Date: Tue, 01 Jul 2003 22:55:00 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en
MIME-Version: 1.0
To: Kip Walker <kwalker@broadcom.com>
CC: linux-mips@linux-mips.org
Subject: Re: 2.5 crash on boot
References: <3F01CB57.7090408@murphy.dk> <3F01CD50.49F34BAC@broadcom.com>
In-Reply-To: <3F01CD50.49F34BAC@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Kip Walker wrote:

>This may be related to something I just found -- in pmd_populate_kernel,
>a physical address is installed in the pmd instead of a virtual
>address.  The patch I sent Ralf 30 minutes ago is attached :-)
>
>Kip
>  
>
>
With your patch I get a hang instead of a short hang and then the crash.
On the other hand it manages to enable the swap partition before hanging:

EXT3-fs: mounted filesystem with ordered data 
mode.                            
VFS: Mounted root (ext3 filesystem) 
readonly.                                  
Freeing unused kernel memory: 88k 
freed                                        
Adding 131532k swap on /dev/hda1.  Priority:-1 extents:1

Has anyone booted 32 bit 2.5 fully into userspace?

/Brian
