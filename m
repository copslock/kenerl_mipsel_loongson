Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2003 08:50:35 +0100 (BST)
Received: from port48.ds1-vbr.adsl.cybercity.dk ([IPv6:::ffff:212.242.58.113]:36162
	"EHLO valis.localnet") by linux-mips.org with ESMTP
	id <S8225196AbTDKHue>; Fri, 11 Apr 2003 08:50:34 +0100
Received: from murphy.dk (brm@brian.localnet [10.0.0.2])
	by valis.localnet (8.12.7/8.12.7/Debian-2) with ESMTP id h3B7oNBs002113;
	Fri, 11 Apr 2003 09:50:24 +0200
Message-ID: <3E9673BF.2050808@murphy.dk>
Date: Fri, 11 Apr 2003 09:50:23 +0200
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Hartvig Ekner <hartvig@ekner.info>
CC: linux-mips@linux-mips.org
Subject: Re: ext3 under MIPS?
References: <3E954651.C7AECB90@ekner.info> <20030410154050.GI5242@lug-owl.de> <3E95D16D.1671BA5A@ekner.info>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <brian@murphy.dk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brian@murphy.dk
Precedence: bulk
X-list: linux-mips

Hartvig Ekner wrote:

>Is there anybody with ext3 up and running who would volunteer to do a couple of unclean
>shutdowns and see if the recovery works without any fsck errors present afterwards?
>
>  
>

Works every time here:

EXT3-fs: INFO: recovery required on readonly 
filesystem.                       
EXT3-fs: write access will be enabled during 
recovery.                         
kjournald starting.  Commit interval 5 
seconds                                 
EXT3-fs: recovery 
complete.                                                    
EXT3-fs: mounted filesystem with ordered data 
mode.                            
VFS: Mounted root (ext3 filesystem) 
readonly.                                  
Freeing unused kernel memory: 64k 
freed                                        
modprobe: modprobe: Can't open dependencies file 
/lib/modules/2.4.21-pre4/modul)
INIT: version 2.84 
booting                                                     
Activating 
swap.                                                               
Adding Swap: 131532k swap-space (priority 
-1)                                  
Checking root file 
system...                                                   
fsck 1.27 
(8-Mar-2002)                                                         
/dev/hda2: clean, 34571/1235456 files, 175807/2469096 
blocks                   
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal 
journal              
System time was Fri Apr 11 07:45:01 UTC 
2003.                                  

mqpro:~# e2fsck 
/dev/hda2                                                      
e2fsck 1.27 
(8-Mar-2002)                                                       
/dev/hda2: clean, 34565/1235456 files, 175809/2469096 
blocks                   
mqpro:~# e2fsck -f 
/dev/hda2                                                   
e2fsck 1.27 
(8-Mar-2002)                                                       
Pass 1: Checking inodes, blocks, and 
sizes                                     
Pass 2: Checking directory 
structure                                           
Pass 3: Checking directory 
connectivity                                        
Pass 4: Checking reference 
counts                                              
Pass 5: Checking group summary 
information                                     
/dev/hda2: 34565/1235456 files (1.1% non-contiguous), 175809/2469096 
blocks    
mqpro:~#


/Brian
