Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2003 22:32:43 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:29994
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8224861AbTGAVcl>; Tue, 1 Jul 2003 22:32:41 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h61LWZ9g009024
	for <linux-mips@linux-mips.org>; Tue, 1 Jul 2003 23:32:35 +0200
Message-ID: <3F01FDF3.1090105@murphy.dk>
Date: Tue, 01 Jul 2003 23:32:35 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-mips@linux-mips.org
Subject: Re: 2.5 crash on boot
References: <3F01CB57.7090408@murphy.dk> <3F01CD50.49F34BAC@broadcom.com>
In-Reply-To: <3F01CD50.49F34BAC@broadcom.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2747
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
Now (with the latest source) I get:

kjournald starting.  Commit interval 5 
seconds                                 
EXT3-fs: mounted filesystem with ordered data 
mode.                            
VFS: Mounted root (ext3 filesystem) 
readonly.                                  
Freeing unused kernel memory: 88k 
freed                                        
Adding 131532k swap on /dev/hda1.  Priority:-1 
extents:1                       
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on hda2, internal 
journal                      
mount: Exception at [<800e5650>] 
(800e5830)                                    
mount: Exception at [<800e5650>] 
(800e5830)                                    
mount: Exception at [<800e5650>] 
(800e5830)                                    
 
The error is in __copy_user (both_aligned), closer and closer...

/Brian
