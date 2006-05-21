Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 May 2006 20:15:19 +0200 (CEST)
Received: from polyphem.dascon.de ([212.117.81.146]:61162 "HELO mail.dascon.de")
	by ftp.linux-mips.org with SMTP id S8133895AbWEUSPJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 21 May 2006 20:15:09 +0200
Received: by mail.dascon.de (Postfix, from userid 10)
	id 3AE4F10A75A; Sun, 21 May 2006 20:15:06 +0200 (CEST)
Received: by discworld.dascon.de (Postfix, from userid 1000)
	id 523A53B704; Sun, 21 May 2006 20:13:24 +0200 (CEST)
Date:	Sun, 21 May 2006 20:13:24 +0200
To:	linux-mips@linux-mips.org
Subject: Soundcard problems on Cobalt Qube 2
Message-ID: <20060521181323.GA3740@discworld.dascon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-message-flag:	Please send plain text messages only. Thank you.
User-Agent: Mutt/1.5.11+cvs20060403
From:	rincewind@discworld.dascon.de (Michael Schwingen)
Return-Path: <rincewind@discworld.dascon.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11504
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rincewind@discworld.dascon.de
Precedence: bulk
X-list: linux-mips

Hi,

I am new here - if there is a more appropriate place for this question,
please redirect me there.

I got a Qube 2 which I want to use as a living-room audio device, using a
Terratec sound card with ICE1712 chipset - that card works fine in my
Linux-x86 box and provides good sound quality.

I installed Debian testing and compiled a kernel.org 2.6.16.14 kernel.
Everything works fine until I start playing sound - at that point, I get
crash #1 below. 

Just for comparison, I tried two different soundcards - a Yamaha
YMF744-based card, which at least plays 8-bit WAV files using aplay, but
causes crash #2 when playing mp3 files using mocp. A ES1938-based card does
not respond to alsamixer, and showed crash #3 when playing mp3 files using
mocp. An Intel EEPRO100 ethernet card works just fine.

I am only really interested in getting the ICE1712 card working, but the
other two crashes seemed quite similar, so there may be a common or similar
problem in the drivers. I have a bit of kernel driver experience, but have
not used DMA or interrupts until now, and have no experience on MIPS.

Do you have any idea what goes wrong, or lacking that, where I might start
looking?

cu
Michael


Crash #1 - snd_ice1712:

Unhandled kernel unaligned access[#1]:                                   
Cpu 0                                                                           
$ 0   : 00000000 b0006c00 00004000 ffbf63fd                                     
$ 4   : 81460a40 00012000 83aad400 811b3580                                     
$ 8   : b0006c01 1000001e 00000028 00000028                                     
$12   : 00000028 007fffff ff800000 7fff0000                                     
$16   : 82b93e20 00000000 822ba3e8 00000000                                     
$20   : 831352b0 2b0fae80 000003e8 8292de8c                                     
$24   : 0000ffff 2ab910f0                                                       
$28   : 82b92000 82b93de8 83423680 800d93f4                                     
Hi    : 00000000                                                                
Lo    : 00000000                                                                
epc   : c00922dc snd_pcm_mmap_data_nopage+0xa0/0x10c [snd_pcm]     Not tainted  
ra    : 800d93f4 __handle_mm_fault+0x310/0xb14                                  
Status: b0006c03    KERNEL EXL IE                                               
Cause : 00808010                                                                
BadVA : ffbf6401                                                                
PrId  : 000028a0                                                                
Modules linked in: snd_ice1712 snd_ice17xx_ak4xxx snd_ak4xxx_adda snd_cs8427 snd
_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_ac97_
bus snd_i2c snd_mpu401_uart snd_rawmidi snd_seq_device snd                      
Process aplay (pid: 1380, threadinfo=82b92000, task=8377ccc8)                   
Stack : 00465ce0 7f961a88 c0067400 00465ed0 80000000 800d93f4 00000000 00000000 
        00465ed0 83be6f00 200054a0 c0069158 00000000 00000000 00000002 00000400 
        2b0fa000 00000000 00000000 00000000 00000000 821403b4 8292de8c 834236b4 
        8377ccc8 82b93f30 83423680 2b0fae80 00030000 00000000 00001800 8008bcb0 
        811b3580 8227c360 00465ce0 7f961a88 00000400 000000aa 00000003 c0095fc4 
        ...                                                                     
Call Trace:                                                                     
 [<c0067400>] snd_timer_start+0x78/0xf8 [snd_timer]                             
 [<800d93f4>] __handle_mm_fault+0x310/0xb14                                     
 [<c0069158>] snd_timer_user_ioctl+0x3a8/0x11e0 [snd_timer]                     
 [<8008bcb0>] do_page_fault+0x270/0x3d0                                         
 [<c0095fc4>] snd_pcm_playback_ioctl1+0x68/0x6b8 [snd_pcm]                      
 [<800b0018>] run_timer_softirq+0x2c/0x248                                      
 [<80102b4c>] do_ioctl+0x2c/0x80                                                
 [<80102b4c>] do_ioctl+0x2c/0x80                                                
 [<8008619c>] sys_ipc+0x74/0x2e8                                                
 [<8008c340>] tlb_do_page_fault_0+0x100/0x108                                   
 [<8008a4e0>] stack_done+0x20/0x3c                                              
Code: 54400002  8c83000c  00801821 <c0620004> 24420001  e0620004  1040fffc  0000
0000  1200ffda                                                                  

---------------------------------------------------------------------------
Crash #2 - snd_ymfpci:
Data bus error, epc == 2ab66928, ra == 2ab677bc                     
Bad pte = 2310079f, process = ???, vm_flags = 800fb, vaddr = 2aadc000
Call Trace:
 [<800d77d0>] vm_normal_page+0x98/0xa8
 [<800d7be4>] unmap_vmas+0x218/0x674
 [<800d7c7c>] unmap_vmas+0x2b0/0x674
 [<800db270>] exit_mmap+0x70/0x10c
 [<800a2424>] mmput+0x54/0xdc
 [<800a241c>] mmput+0x4c/0xdc
 [<800a7484>] do_exit+0x154/0x890
 [<800a7bfc>] do_group_exit+0x3c/0xb8
 [<800b3e14>] get_signal_to_deliver+0x2a4/0x514
 [<800b3378>] __group_send_sig_info+0x94/0xd8
 [<800b330c>] __group_send_sig_info+0x28/0xd8
 [<800b43a4>] group_send_sig_info+0x14c/0x17c
 [<800840d4>] do_signal+0x74/0x300
 [<800b45e4>] sys_kill+0x6c/0x190
 [<c0085774>] snd_ymfpci_interrupt+0xec/0x200 [snd_ymfpci]
 [<800b0018>] run_timer_softirq+0x2c/0x248
 [<800c67f4>] handle_IRQ_event+0x7c/0xf0
 [<800c698c>] __do_IRQ+0x124/0x148
 [<800817f0>] work_notifysig+0xc/0x14                                           
 [<800817ac>] work_resched+0x8/0x40                                             


-------------------------------------------------------------------
Crash #3 - snd_es1938:
snd_es1938_write_cmd timeout (0x02c0/0x0280)                             
snd_es1938_write_cmd timeout (0x02b4/0x0280)                                    
snd_es1938_write_cmd timeout (0x02c0/0x0280)                                    
snd_es1938_write_cmd timeout (0x02a8/0x0280)                                    
snd_es1938_write_cmd timeout (0x02c0/0x0280)                                    
snd_es1938_write_cmd timeout (0x02b4/0x0280)                                    
snd_es1938_write_cmd timeout (0x02c0/0x0280)                                    
snd_es1938_write_cmd timeout (0x02a8/0x0280)                                    


Data bus error, epc == 2ab66928, ra == 2ab677bc                                 
Bad pte = 230b079f, process = ???, vm_flags = 800fb, vaddr = 2aadc000           
Call Trace:                                                                     
 [<800d77d0>] vm_normal_page+0x98/0xa8
 [<800d775c>] vm_normal_page+0x24/0xa8
 [<800d7be4>] unmap_vmas+0x218/0x674
 [<800d7c7c>] unmap_vmas+0x2b0/0x674
 [<80238954>] schedule+0x608/0x8c8
 [<800db270>] exit_mmap+0x70/0x10c
 [<800a2424>] mmput+0x54/0xdc
 [<800a241c>] mmput+0x4c/0xdc                                                   
 [<800a7484>] do_exit+0x154/0x890                                               
 [<800b2a18>] __dequeue_signal+0x1cc/0x26c                                      
 [<800d9b48>] __handle_mm_fault+0xa64/0xb14                                     
 [<800a7bfc>] do_group_exit+0x3c/0xb8                                           
 [<800b3e14>] get_signal_to_deliver+0x2a4/0x514                                 
 [<800b3378>] __group_send_sig_info+0x94/0xd8                                   
 [<800b330c>] __group_send_sig_info+0x28/0xd8                                   
 [<800840d4>] do_signal+0x74/0x300                                              
 [<800b45e4>] sys_kill+0x6c/0x190                                               
 [<802387d8>] schedule+0x48c/0x8c8                                              
 [<800aadb4>] __do_softirq+0x8c/0x150                                           
 [<8008458c>] _sys_rt_sigsuspend+0x114/0x13c                                    
 [<800817f0>] work_notifysig+0xc/0x14                                           
 [<800817ac>] work_resched+0x8/0x40                                             



 

-- 
Some people have no repect of age unless it is bottled.
