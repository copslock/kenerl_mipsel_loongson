Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jan 2010 08:46:44 +0100 (CET)
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:60550 "EHLO
        rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491056Ab0ANHqj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jan 2010 08:46:39 +0100
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
        id 03E1B40094; Thu, 14 Jan 2010 08:46:38 +0100 (CET)
Date:   Thu, 14 Jan 2010 08:46:38 +0100
From:   Andreas Mohr <andi@lisas.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Andreas Mohr <andi@lisas.de>, alsa-devel@alsa-project.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kumar Gala <galak@gate.crashing.org>,
        Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH 0/5] PCM mmap (temporary) fixes for non-coherent
        architectures
Message-ID: <20100114074638.GA12266@rhlx01.hs-esslingen.de>
References: <1259248388-20095-1-git-send-email-tiwai@suse.de> <20100101193130.GA21510@rhlx01.hs-esslingen.de> <s5haawj7qlv.wl%tiwai@suse.de> <s5hljg24bl7.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hljg24bl7.wl%tiwai@suse.de>
X-Priority: none
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@lisas.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 9218

On Wed, Jan 13, 2010 at 10:07:32AM +0100, Takashi Iwai wrote:
> > As I mentioned in the previous followup, if your device is a
> > USB-audio, the patch doesn't help because it's for devices with
> > buffers using dma_alloc_coherent().  For USB-audio, it uses vmalloc
> > for an intermediate buffer.  Maybe this should be changed to dma_*()
> > stuff for such architectures.
> 
> A quick patch below (totally untested!) might do that.
> It's passing the device struct blindly, so not sure whether this would
> actually work for all dma_alloc_coherent().

Thanks a lot, tested, but AFAICS there isn't much of a change unfortunately
(log below).
Note that the old snd-usb-audio.ko did contain
snd_pcm_get_vmalloc_page(), and the new one (put in the correct kernel
version dir and depmod -a) doesn't, thus the patch was applied and did make it
to the binary side, and it did get loaded correctly upon plugging I think.

Would one also want strace/ltrace output of the userspace side of things?
(likely rather useless, except for perhaps nailing that it does crash
where we think it crashes or so)

Frankly I'm still pretty much in uninformed shape concerning this mmap
pcm buffer issue, would need to take quite a bit more time for research
in order to be able to take part in the discussion in a productive way ;)

Thanks,

Andreas Mohr

# cat /usr/local/bin/audio_test.sh
#!/bin/sh

# better make sure...
sync
sleep 1

aplay /usr/local/sounds/attention

[LOCKUP]


$ ../netconsole.sh 
kobject: 'ep_01' (81f70090): kobject_add_internal: parent: '2-1.1.1:1.1', set: 'devices'
kobject: 'ep_01' (81f70090): kobject_uevent_env                                         
kobject: 'ep_01' (81f70090): kobject_uevent_env: filter function caused the event to drop!
setting usb interface 1:1                                                                 
Instruction bus error, epc == 2ab4f178, ra == 80000018                                    
kobject: 'ep_01' (81f70090): kobject_uevent_env                                           
kobject: 'ep_01' (81f70090): kobject_uevent_env: filter function caused the event to drop!
kobject: 'ep_01' (81f70090): kobject_cleanup                                              
kobject: 'ep_01' (81f70090): calling ktype release                                        
kobject: 'ep_01': free name                                                               
EHCI_DIS: hcd 81dd7080 ep 81604800 qh (null) (#01)                                        
Instruction bus error, epc == 8003475c, ra == 80000018                                    
Oops[#1]:                                                                                 
Cpu 0                                                                                     
$ 0   : 00000000 1000d001 00000000 80000000                                               
$ 4   : 81d30838 81e57ac0 00000000 00000000                                               
$ 8   : 00000000 00000000 81040000 81ec8000                                               
$12   : 81d37868 80340000 81d37868 0000000a                                               
$16   : 00000000 7fa911e8 00000538 81d30838                                               
$20   : 0000000a 81f0def8 20000000 fffffff6                                               
$24   : 00000000 801874c0                                                                 
$28   : 81f0c000 81f0de40 00000001 80000018                                               
Hi    : 00000000                                                                          
Lo    : 00000000                                                                          
epc   : 8003475c wait_consider_task+0x49c/0xe20                                           
    Not tainted                                                                           
ra    : 80000018 0x80000018                                                               
Status: 1000d003    KERNEL EXL IE                                                         
Cause : 00800018                                                                          
PrId  : 00029029 (Broadcom BCM3302)                                                       
Modules linked in: snd_usb_audio snd_pcm_oss snd_mixer_oss snd_pcm snd_timer evdev snd_page_alloc snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep usbhid hid snd input_core soundcore ipv6 arc4 ecb cryptomgr aead pcompress crypto_blkcipher crypto_hash crypto_algapi b43 ftdi_sio mac80211 cfg80211 usbserial                                                 
Process audio_test.sh (pid: 1333, threadinfo=81f0c000, task=81d37838, tls=00000000)                                   
Stack : 8033dab8 80027e24 81e8488c 802b89e0 8033c000 81d37838 00000000 8000ace0                                       
        00000000 00000000 81e57e60 80018238 81d30838 81d37838 00000000 81d3794c                                       
        81f0def8 ffffffff 20000000 fffffff6 00000001 800351b4 00000004 801c7cf8                                       
        7fa911a8 81db5870 00000000 81d37838 8002d0c4 81e57ac8 81e57ac8 81d37838                                       
        00000000 00000000 7fa911e8 00000000 0051f56c 00000000 00440000 00525790                                       
        ...                                                                                                           
Call Trace:                                                                                                           
[<8003475c>] wait_consider_task+0x49c/0xe20                                                                           
[<800351b4>] do_wait+0xd4/0x340                                                                                       
[<800354e0>] sys_wait4+0xc0/0xec                                                                                      
[<800031f0>] stack_done+0x20/0x3c                                                                                     


Code: 00431024  14400251  00000000 <ae340000> 16000051  8eb1000c  12200051  8fa30020  0c002bc1 
Disabling lock debugging due to kernel taint                                                   
Instruction bus error, epc == 80004dd8, ra == 80000018                                         
Oops[#2]:                                                                                      
Cpu 0                                                                                          
$ 0   : 00000000 1000d000 00000000 00000000                                                    
$ 4   : 7ff0dc60 81c0ddd0 00000000 1000d001                                                    
$ 8   : 00000000 00000000 00000000 81f0c000                                                    
$12   : 81c084b0 003d0900 81c084b0 00000000                                                    
$16   : 00000004 00000000 81c0ddc0 81c0ddc0                                                    
$20   : 7ff0dc60 00000000 81c0ddcc 00000000                                                    
$24   : 00000000 801874c0                                                                      
$28   : 81c0c000 81c0dd98 00000001 80000018                                                    
Hi    : 0000007f                                                                               
Lo    : 3d391e00                                                                               
epc   : 80004dd8 __copy_user+0xd4/0x2bc                                                        
    Tainted: G      D                                                                          
ra    : 80000018 0x80000018                                                                    
Status: 1000d003    KERNEL EXL IE                                                              
Cause : 00800018                                                                               
PrId  : 00029029 (Broadcom BCM3302)                                                            
Modules linked in: snd_usb_audio snd_pcm_oss snd_mixer_oss snd_pcm snd_timer evdev snd_page_alloc snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep usbhid hid snd input_core soundcore ipv6 arc4 ecb cryptomgr aead pcompress crypto_blkcipher crypto_hash crypto_algapi b43 ftdi_sio mac80211 cfg80211 usbserial                                                 
Process init (pid: 1, threadinfo=81c0c000, task=81c08480, tls=00000000)                                               
Stack : 00000000 81c0dda8 81c0df00 80350fb0 81c0ddc0 81c0ddc4 81c0ddc8 81c0ddcc                                       
        81c0ddd0 81c0ddd4 00000400 00000000 00000000 00000000 00000000 00000000                                       
        00000000 00000000 81f04000 ffffff9c 81c0dea8 0044a234 7ff0e048 8009b864                                       
        00000001 81c0dea8 00000001 81f04000 ffffff9c 800a2d18 00000003 00000002                                       
        00000003 00000003 0000000d 00000000 00000000 00000000 000000cc 00001180                                       
        ...                                                                                                           
Call Trace:                                                                                                           
[<80004dd8>] __copy_user+0xd4/0x2bc                                                                                   


Code: 8ca80000  24a50004  24c6fffc <ac880000> 1706fffb  24840004  10c00040  00864821  240a0020 
Instruction bus error, epc == 8003475c, ra == 80000018                                         
Oops[#3]:                                                                                      
Cpu 0                                                                                          
$ 0   : 00000000 1000d001 00000000 80000000                                                    
$ 4   : 81d37838 80415e00 00000000 00000000                                                    
$ 8   : 00000000 00000000 81040000 81f0c000                                                    
$12   : 80484868 80340000 80484868 0000000b                                                    
$16   : 00000000 7febff60 00000535 81d37838                                                    
$20   : 0000000b 81e2bef8 20000000 fffffff6                                                    
$24   : 00000000 80018ff0                                                                      
$28   : 81e2a000 81e2be40 00000001 80000018                                                    
Hi    : 00000000                                                                               
Lo    : 00000000                                                                               
epc   : 8003475c wait_consider_task+0x49c/0xe20                                                
    Tainted: G      D                                                                          
ra    : 80000018 0x80000018                                                                    
Status: 1000d003    KERNEL EXL IE                                                              
Cause : 00800018                                                                               
PrId  : 00029029 (Broadcom BCM3302)                                                            
Modules linked in: snd_usb_audio snd_pcm_oss snd_mixer_oss snd_pcm snd_timer evdev snd_page_alloc snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep usbhid hid snd input_core soundcore ipv6 arc4 ecb cryptomgr aead pcompress crypto_blkcipher crypto_hash crypto_algapi b43 ftdi_sio mac80211 cfg80211 usbserial                                                 
Process bash (pid: 1175, threadinfo=81e2a000, task=80484838, tls=00000000)                                            
Stack : 8033dab8 80027e24 81f18390 00002a84 81d37838 80484838 81e57e60 8000ace0                                       
        00000000 00000000 80047476 0051f510 81d37838 80484838 00000000 8048494c                                       
        81e2bef8 ffffffff 20000000 fffffff6 00000001 800351b4 81e8a1e0 00000008                                       
        81e8a0d4 81d37870 00000000 80484838 8002d0c4 80415e08 80415e08 80484838                                       
        0000000a 00000000 7febff60 00000000 0051f56c 00000000 00440000 00525790                                       
        ...                                                                                                           
Call Trace:                                                                                                           
[<8003475c>] wait_consider_task+0x49c/0xe20                                                                           
[<800351b4>] do_wait+0xd4/0x340                                                                                       
[<800354e0>] sys_wait4+0xc0/0xec                                                                                      
[<800031f0>] stack_done+0x20/0x3c                                                                                     


Code: 00431024  14400251  00000000 <ae340000> 16000051  8eb1000c  12200051  8fa30020  0c002bc1 
Instruction bus error, epc == 80096fa0, ra == 80000018                                         
Oops[#4]:                                                                                      
Cpu 0                                                                                          
$ 0   : 00000000 1000d000 c0180002 00000002                                                    
$ 4   : 00000001 803b5514 00000001 81e24000                                                    
$ 8   : 80351000 00080000 81040000 81e2a000                                                    
$12   : 00000000 07de2900 ffffffff 00000000                                                    
$16   : 00000001 81e24fa0 2abe8000 003cbf03                                                    
$20   : 2abe9000 0119a613 00000000 00000000                                                    
$24   : 00000000 80018ff0                                                                      
$28   : 81c0c000 81c0db48 00000000 80000018                                                    
Hi    : 00000000                                                                               
Lo    : 00000000                                                                               
epc   : 80096fa0 swap_info_get+0x74/0xfc                                                       
    Tainted: G      D                                                                          
ra    : 80000018 0x80000018                                                                    
Status: 1000d003    KERNEL EXL IE                                                              
Cause : 00800018                                                                               
PrId  : 00029029 (Broadcom BCM3302)                                                            
Modules linked in: snd_usb_audio snd_pcm_oss snd_mixer_oss snd_pcm snd_timer evdev snd_page_alloc snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep usbhid hid snd input_core soundcore ipv6 arc4 ecb cryptomgr aead pcompress crypto_blkcipher crypto_hash crypto_algapi b43 ftdi_sio mac80211 cfg80211 usbserial                                                 
Process init (pid: 1, threadinfo=81c0c000, task=81c08480, tls=00000000)                                               
Stack : ffffffff 800736a0 80002000 80000600 80350fd0 80099498 00002000 81023340                                       
        81e24f9c 2abe7000 00002000 81e24fa0 2abe8000 80088a30 81e0da9c 81e1e000                                       
        8037f840 81e1e034 2abe8fff 8033d9c0 81e1e000 81e1f2a8 81e1f2a8 2abe9000                                       
        00000000 00000001 81e0da9c 81e1e000 8037f840 81e1e034 81c08480 00000000                                       
        00000001 00000000 00000001 8008db1c 81c0dbf0 81e26000 00000000 ffffffff                                       
        ...                                                                                                           
Call Trace:                                                                                                           
[<80096fa0>] swap_info_get+0x74/0xfc                                                                                  
[<80099498>] free_swap_and_cache+0x1c/0x218                                                                           
[<80088a30>] unmap_vmas+0x418/0x63c                                                                                   
[<8008db1c>] exit_mmap+0xb8/0x148                                                                                     
[<8002e3c4>] mmput+0xc0/0x1d8                                                                                         
[<800333e8>] exit_mm+0x260/0x298                                                                                      
[<800357cc>] do_exit+0x1cc/0x688                                                                                      
[<80014658>] nmi_exception_handler+0x0/0x34                                                                           


Code: 00041840  8ca20020  00431021 <94440000> 1480001d  8fbf0014  3c048030  3c05802c  24a5f280 
Fixing recursive fault but reboot is needed!                                                   
Instruction bus error, epc == 80004dd8, ra == 80000018                                         
Oops[#5]:                                                                                      
Cpu 0                                                                                          
$ 0   : 00000000 1000d000 00000000 00000004                                                    
$ 4   : 004c2a30 81e3ddd0 00000000 1000d001                                                    
$ 8   : 00000080 00000000 00000000 81e2a000                                                    
$12   : 81d66868 00000000 81d66868 00000000                                                    
$16   : 00000004 00000001 81e3ddc0 81e3ddc0                                                    
$20   : 004c2a30 004c7c98 81e3ddcc 00000000                                                    
$24   : 00000000 80181208                                                                      
$28   : 81e3c000 81e3dd98 004b0000 80000018                                                    
Hi    : 00000000                                                                               
Lo    : 00000000                                                                               
epc   : 80004dd8 __copy_user+0xd4/0x2bc                                                        
    Tainted: G      D                                                                          
ra    : 80000018 0x80000018                                                                    
Status: 1000d003    KERNEL EXL IE                                                              
Cause : 00800018                                                                               
PrId  : 00029029 (Broadcom BCM3302)                                                            
Modules linked in: snd_usb_audio snd_pcm_oss snd_mixer_oss snd_pcm snd_timer evdev snd_page_alloc snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep usbhid hid snd input_core soundcore ipv6 arc4 ecb cryptomgr aead pcompress crypto_blkcipher crypto_hash crypto_algapi b43 ftdi_sio mac80211 cfg80211 usbserial                                                 
Process sshd (pid: 1173, threadinfo=81e3c000, task=81d66838, tls=00000000)                                            
Stack : 0041663c 81e3dda8 00000000 80200478 81e3ddc0 81e3ddc4 81e3ddc8 81e3ddcc                                       
        81e3ddd0 81e3ddd4 00000098 00000000 00000000 00000080 00000000 00000000                                       
        00000000 00000000 81e3de20 00000001 00000000 00000000 00000040 81e3de28                                       
        81e3de28 fffffdee 81e3de20 8009e530 00000000 814a5a20 81f5d8ec 81ed3900                                       
        00000000 00000000 004bd538 00000038 81d41900 8017a668 00000000 00000001                                       
        ...
Call Trace:
[<80004dd8>] __copy_user+0xd4/0x2bc


Code: 8ca80000  24a50004  24c6fffc <ac880000> 1706fffb  24840004  10c00040  00864821  240a0020
Instruction bus error, epc == 80011530, ra == 80000018
Oops[#6]:
Cpu 0
$ 0   : 00000000 1000d001 24020000 80000000
$ 4   : 7fb160e0 24021017 00000278 81c6ec2c
$ 8   : 800125cc 8155fe80 ffffffff ffffffff
$12   : 00000000 80340000 81c6e8b0 0000000b
$16   : 00000000 00000000 7fb160d0 8155ff30
$20   : 7fb160e8 7fb160e0 81c6ec2c 00000012
$24   : 00000000 8025e170
$28   : 8155e000 8155fe10 8155fe80 80000018
Hi    : 00000000
Lo    : 00000000
epc   : 80011530 install_sigtramp+0x20/0x54
    Tainted: G      D
ra    : 80000018 0x80000018
Status: 1000d003    KERNEL EXL IE
Cause : 00800018
PrId  : 00029029 (Broadcom BCM3302)
Modules linked in: snd_usb_audio snd_pcm_oss snd_mixer_oss snd_pcm snd_timer evdev snd_page_alloc snd_usb_lib snd_rawmidi snd_seq_device snd_hwdep usbhid hid snd input_core soundcore ipv6 arc4 ecb cryptomgr aead pcompress crypto_blkcipher crypto_hash crypto_algapi b43 ftdi_sio mac80211 cfg80211 usbserial
Process sshd (pid: 1100, threadinfo=8155e000, task=81c6e880, tls=00000000)
Stack : 8155ff30 8155fe98 8167f000 8169f004 00000009 8155ff30 00000012 8001263c
        81d58b18 81d58b18 81c59808 800b212c 8155ff30 00000012 8155fe80 81c6ec2c
        8155fe98 ffffffff 004b352c 00000000 00000004 800116bc 8167f1e0 8155fe80
        8155ff30 8155fea8 00000010 81d58b18 00000000 0040ac18 00000000 00000000
        00000000 00000000 00000012 00040002 00000000 00000495 00000000 0000000b
        ...
Call Trace:
[<80011530>] install_sigtramp+0x20/0x54
[<8001263c>] setup_frame+0x70/0x110
[<800116bc>] do_notify_resume+0x158/0x428
[<800015f0>] work_notifysig+0xc/0x14


Code: afbf001c  00a22821  02008821 <ac850000> 2402000c  ac820004  3c038038  8c620038  0040f809
Instruction bus error, epc == 2ac458ec, ra == 80000018
