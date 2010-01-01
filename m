Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jan 2010 20:31:36 +0100 (CET)
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:33405 "EHLO
        rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492167Ab0AATbb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jan 2010 20:31:31 +0100
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
        id 499A640080; Fri,  1 Jan 2010 20:31:30 +0100 (CET)
Date:   Fri, 1 Jan 2010 20:31:30 +0100
From:   Andreas Mohr <andi@lisas.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kumar Gala <galak@gate.crashing.org>,
        Becky Bruce <beckyb@kernel.crashing.org>
Subject: Re: [PATCH 0/5] PCM mmap (temporary) fixes for non-coherent
        architectures
Message-ID: <20100101193130.GA21510@rhlx01.hs-esslingen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <1259248388-20095-1-git-send-email-tiwai@suse.de>
X-Priority: none
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andi@lisas.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1466


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've tried this patch set (with the typo-corrected part 4) on my ASUS
WL-500gP v2 MIPSEL via a backport to 2.6.31.9, but all I get is a
small blip of the sound I wanted to play, and then the system is fubar
(I believe just the same thing as what happened without having this patch
applied).

Probably I'm dense and the patch is ARM-only, or my MIPSEL has incorrect
cache coherency versus this patch set, or the backport failed due to
missing requirements or conflicts.

Attached are two crash logs.

Any ideas?

Would be nice to see this resolved as well, since I now _finally_ have a
working consterna^Wconstellation (netconsole, boot, USB host, USB serial)
with my patched-up 2.6.31.9 build.

Thanks,

Andreas Mohr

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb_audio_crash_after_patches.log"

Instruction bus error, epc == 2ab4f178, ra == 80000018
kobject: 'ep_01' (81e8a690): kobject_uevent_env
kobject: 'ep_01' (81e8a690): kobject_uevent_env: filter function caused the event to drop!
kobject: 'ep_01' (81e8a690): kobject_cleanup
kobject: 'ep_01' (81e8a690): calling ktype release
kobject: 'ep_01': free name
EHCI_DIS: hcd 81dd7080 ep 81e09180 qh (null) (#01)
Instruction bus error, epc == 8003475c, ra == 80000018
Oops[#1]:
Cpu 0
$ 0   : 00000000 1000d001 00000000 80000000
$ 4   : 81dad838 806e5e00 00000000 00000000
$ 8   : 00000000 00000000 81040000 81f16000
$12   : 81da0868 80340000 81da0868 0000000a
$16   : 00000000 7fb2dd68 000005b8 81dad838
$20   : 0000000a 81e37ef8 20000000 fffffff6
$24   : 00000000 801874c0                  
$28   : 81e36000 81e37e40 00000001 80000018
Hi    : 00000000
Lo    : 00000000
epc   : 8003475c wait_consider_task+0x49c/0xe20
    Not tainted
ra    : 80000018 0x80000018
Status: 1000d003    KERNEL EXL IE 
Cause : 00800018
PrId  : 00029029 (Broadcom BCM3302)
Modules linked in: ipv6 snd_usb_audio arc4 snd_pcm_oss ecb snd_mixer_oss cryptomgr aead snd_pcm pcompress crypto_blkcipher snd_timer crypto_hash snd_page_alloc evdev ftdi_sio crypto_algapi snd_usb_lib snd_rawmidi b43 mac80211 snd_seq_device snd_hwdep usbhid cfg80211 usbserial hid snd input_core soundcore
Process bash (pid: 1447, threadinfo=81e36000, task=81da0838, tls=00000000)
Stack : 8033dab8 80027e24 815bdde4 802b89e0 8033c000 81da0838 00000000 8000ace0
        00000000 00000000 80047476 0051f510 81dad838 81da0838 00000000 81da094c
        81e37ef8 ffffffff 20000000 fffffff6 00000001 800351b4 00000004 801c7cf8
        81f323d8 81db5870 00000000 81da0838 8002d0c4 806e5e08 806e5e08 81da0838
        0000000a 00000000 7fb2dd68 00000000 0051f56c 00000000 00440000 00525790
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
$ 4   : 7f9765d0 81c0ddd0 00000000 1000d001
$ 8   : 00000000 00000000 00000000 81e36000
$12   : 81c084b0 003d0900 81c084b0 00000000
$16   : 00000004 00000000 81c0ddc0 81c0ddc0
$20   : 7f9765d0 00000000 81c0ddcc 00000000
$24   : 00000000 801874c0                  
$28   : 81c0c000 81c0dd98 00000001 80000018
Hi    : 0000004d
Lo    : ab64ed00
epc   : 80004dd8 __copy_user+0xd4/0x2bc
    Tainted: G      D   
ra    : 80000018 0x80000018
Status: 1000d003    KERNEL EXL IE 
Cause : 00800018
PrId  : 00029029 (Broadcom BCM3302)
Modules linked in: ipv6 snd_usb_audio arc4 snd_pcm_oss ecb snd_mixer_oss cryptomgr aead snd_pcm pcompress crypto_blkcipher snd_timer crypto_hash snd_page_alloc evdev ftdi_sio crypto_algapi snd_usb_lib snd_rawmidi b43 mac80211 snd_seq_device snd_hwdep usbhid cfg80211 usbserial hid snd input_core soundcore
Process init (pid: 1, threadinfo=81c0c000, task=81c08480, tls=00000000)
Stack : 00000000 81c0dda8 81c0df00 80350fb0 81c0ddc0 81c0ddc4 81c0ddc8 81c0ddcc
        81c0ddd0 81c0ddd4 00000400 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 81f0b000 ffffff9c 81c0dea8 0044a234 7f9769b8 8009b864
        00000001 81c0dea8 00000001 81f0b000 ffffff9c 800a2d18 00000003 00000002
        00000003 00000003 0000000d 00000000 00000000 00000000 000000c9 00001180
        ...
Call Trace:
[<80004dd8>] __copy_user+0xd4/0x2bc


Code: 8ca80000  24a50004  24c6fffc <ac880000> 1706fffb  24840004  10c00040  00864821  240a0020 
Instruction bus error, epc == 80004dd8, ra == 80000018
Oops[#3]:
Cpu 0
$ 0   : 00000000 1000d000 00000000 00000004
$ 4   : 004c7130 81735dd0 00000000 1000d001
$ 8   : 00000080 00000000 00000000 81e36000
$12   : 81d0e868 00000000 81d0e868 00000000
$16   : 00000004 00000001 81735dc0 81735dc0
$20   : 004c7130 004c7360 81735dcc 00000000
$24   : 00000000 80181208                  
$28   : 81734000 81735d98 004b0000 80000018
Hi    : 00000000
Lo    : 00000000
epc   : 80004dd8 __copy_user+0xd4/0x2bc
    Tainted: G      D   
ra    : 80000018 0x80000018
Status: 1000d003    KERNEL EXL IE 
Cause : 00800018
PrId  : 00029029 (Broadcom BCM3302)
Modules linked in: ipv6 snd_usb_audio arc4 snd_pcm_oss ecb snd_mixer_oss cryptomgr aead snd_pcm pcompress crypto_blkcipher snd_timer crypto_hash snd_page_alloc evdev ftdi_sio crypto_algapi snd_usb_lib snd_rawmidi b43 mac80211 snd_seq_device snd_hwdep usbhid cfg80211 usbserial hid snd input_core soundcore
Process sshd (pid: 1445, threadinfo=81734000, task=81d0e838, tls=00000000)
Stack : 0041663c 81735da8 00000000 80200478 81735dc0 81735dc4 81735dc8 81735dcc
        81735dd0 81735dd4 00000098 00000000 00000000 00000080 00000000 00000000
        00000000 00000000 81735e20 00000001 00000000 00000000 00000040 81735e28
        81735e28 fffffdee 81735e20 8009e530 00000000 8173b080 81f731e8 8167d900
        00000000 00000000 004bd538 00000090 81cdd360 81ed3160 00000000 00000001
        ...
Call Trace:
[<80004dd8>] __copy_user+0xd4/0x2bc


Code: 8ca80000  24a50004  24c6fffc <ac880000> 1706fffb  24840004  10c00040  00864821  240a0020 
Instruction bus error, epc == 80096fa0, ra == 80000018
Oops[#4]:
Cpu 0
$ 0   : 00000000 1000d000 c02e2002 00000002
$ 4   : 00000001 803b5514 00000001 00000001
$ 8   : 80351000 00080000 81040000 81e36000
$12   : 00000000 645fcd00 81da0868 0000000b
$16   : 00000001 81e26138 0044e000 003f0fff
$20   : 0046c000 0126b79f 00000000 00000000
$24   : 00000000 80018ff0                  
$28   : 81c0c000 81c0db48 fffffffe 80000018
Hi    : 00000000
Lo    : 00000000
epc   : 80096fa0 swap_info_get+0x74/0xfc
    Tainted: G      D   
ra    : 80000018 0x80000018
Status: 1000d003    KERNEL EXL IE 
Cause : 00800018
PrId  : 00029029 (Broadcom BCM3302)
Modules linked in: ipv6 snd_usb_audio arc4 snd_pcm_oss ecb snd_mixer_oss cryptomgr aead snd_pcm pcompress crypto_blkcipher snd_timer crypto_hash snd_page_alloc evdev ftdi_sio crypto_algapi snd_usb_lib snd_rawmidi b43 mac80211 snd_seq_device snd_hwdep usbhid cfg80211 usbserial hid snd input_core soundcore
Process init (pid: 1, threadinfo=81c0c000, task=81c08480, tls=00000000)
Stack : fffffffe 800736a0 00000008 81da0870 80350fd0 80099498 81c08614 81024d60
        81e26130 0044c000 00002000 81e26138 0044e000 80088a30 8033dab8 80029d78
        7f9765d0 00000000 0046bfff 8033d9c0 81e244a0 81e25004 81e25004 0046c000
        00000000 00000001 81e0ba9c 81e244a0 8037f840 81e244d4 81c08480 00000000
        00000001 00000000 00000001 8008db1c 81c0dbf0 81e2d354 00000000 ffffffff
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
Instruction bus error, epc == 80011530, ra == 80000018
Oops[#5]:
Cpu 0
$ 0   : 00000000 1000d001 24020000 80000000
$ 4   : 7fe3fd00 24021017 00000278 81d86be4
$ 8   : 800125cc 80621e80 ffffffff ffffffff
$12   : 00000000 80340000 81d86868 0000000b
$16   : 00000000 00000000 7fe3fcf0 80621f30
$20   : 7fe3fd08 7fe3fd00 81d86be4 00000012
$24   : 00000000 8025e170                  
$28   : 80620000 80621e10 80621e80 80000018
Hi    : 00000000
Lo    : 00000000
epc   : 80011530 install_sigtramp+0x20/0x54
    Tainted: G      D   
ra    : 80000018 0x80000018
Status: 1000d003    KERNEL EXL IE 
Cause : 00800018
PrId  : 00029029 (Broadcom BCM3302)
Modules linked in: ipv6 snd_usb_audio arc4 snd_pcm_oss ecb snd_mixer_oss cryptomgr aead snd_pcm pcompress crypto_blkcipher snd_timer crypto_hash snd_page_alloc evdev ftdi_sio crypto_algapi snd_usb_lib snd_rawmidi b43 mac80211 snd_seq_device snd_hwdep usbhid cfg80211 usbserial hid snd input_core soundcore
Process sshd (pid: 1372, threadinfo=80620000, task=81d86838, tls=00000000)
Stack : 80621f30 80621e98 8059ae20 8061f004 00000009 80621f30 00000012 8001263c
        81e82448 81e82448 81c59808 800b212c 80621f30 00000012 80621e80 81d86be4
        80621e98 ffffffff 004b352c 00000000 00000004 800116bc 817a5000 80621e80
        80621f30 80621ea8 00000010 81e82448 00000000 0040ac18 00000000 00000000
        00000000 00000000 00000012 00040002 00000000 000005a5 00000000 0000000b
        ...
Call Trace:
[<80011530>] install_sigtramp+0x20/0x54
[<8001263c>] setup_frame+0x70/0x110
[<800116bc>] do_notify_resume+0x158/0x428
[<800015f0>] work_notifysig+0xc/0x14


Code: afbf001c  00a22821  02008821 <ac850000> 2402000c  ac820004  3c038038  8c620038  0040f809

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb_audio_crash_after_patches_2.log"

Instruction bus error, epc == 2ac68e50, ra == 80000018
Instruction bus error, epc == 8003475c, ra == 80000018
Oops[#1]:
Cpu 0
$ 0   : 00000000 1000d001 00000000 80000000
$ 4   : 81d4f838 80733c00 00000000 00000000
$ 8   : 00000000 00000000 81040000 81ef2000
$12   : 81312868 80340000 81312868 0000000a
$16   : 00000000 7fd95c08 000005af 81d4f838
$20   : 0000000a 81891ef8 20000000 fffffff6
$24   : 00000000 80018ff0                  
$28   : 81890000 81891e40 00000001 80000018
Hi    : 00000000
Lo    : 00000000
epc   : 8003475c wait_consider_task+0x49c/0xe20
    Not tainted
ra    : 80000018 0x80000018
Status: 1000d003    KERNEL EXL IE 
Cause : 00800018
PrId  : 00029029 (Broadcom BCM3302)
Modules linked in: ipv6 arc4 snd_usb_audio ecb snd_pcm_oss cryptomgr snd_mixer_oss aead pcompress snd_pcm crypto_blkcipher crypto_hash snd_timer crypto_algapi snd_page_alloc evdev snd_usb_lib b43 ftdi_sio mac80211 snd_rawmidi snd_seq_device cfg80211 usbhid snd_hwdep usbserial hid snd input_core soundcore
Process bash (pid: 1450, threadinfo=81890000, task=81312838, tls=00000000)
Stack : 8033dab8 80027e24 7fd95c08 802c0000 81db5838 81312838 00000000 8000ace0
        00000000 00000000 80047476 0051f510 81d4f838 81312838 00000000 8131294c
        81891ef8 ffffffff 20000000 fffffff6 00000001 800351b4 00000004 801c7cf8
        81e590b8 81db5870 00000000 81312838 8002d0c4 80733c08 80733c08 81312838
        0000000a 00000000 7fd95c08 00000000 0051f56c 00000000 00440000 00525790
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
$ 4   : 7fca8450 81c0ddd0 00000000 1000d001
$ 8   : 00000000 00000000 00000000 81890000
$12   : 81c084b0 003d0900 81c084b0 00000000
$16   : 00000004 00000000 81c0ddc0 81c0ddc0
$20   : 7fca8450 00000000 81c0ddcc 00000000
$24   : 00000000 801874c0                  
$28   : 81c0c000 81c0dd98 00000001 80000018
Hi    : 0000013d
Lo    : 9812c600
epc   : 80004dd8 __copy_user+0xd4/0x2bc
    Tainted: G      D   
ra    : 80000018 0x80000018
Status: 1000d003    KERNEL EXL IE 
Cause : 00800018
PrId  : 00029029 (Broadcom BCM3302)
Modules linked in: ipv6 arc4 snd_usb_audio ecb snd_pcm_oss cryptomgr snd_mixer_oss aead pcompress snd_pcm crypto_blkcipher crypto_hash snd_timer crypto_algapi snd_page_alloc evdev snd_usb_lib b43 ftdi_sio mac80211 snd_rawmidi snd_seq_device cfg80211 usbhid snd_hwdep usbserial hid snd input_core soundcore
Process init (pid: 1, threadinfo=81c0c000, task=81c08480, tls=00000000)
Stack : 00000000 81c0dda8 81c0df00 80350fb0 81c0ddc0 81c0ddc4 81c0ddc8 81c0ddcc
        81c0ddd0 81c0ddd4 00000400 00000000 00000000 00000000 00000000 00000000
        00000000 00000000 81ec3000 ffffff9c 81c0dea8 0044a234 7fca8838 8009b864
        00000001 81c0dea8 00000001 81ec3000 ffffff9c 800a2d18 00000003 00000002
        00000003 00000003 0000000d 00000000 00000000 00000000 000000cb 00001180
        ...
Call Trace:
[<80004dd8>] __copy_user+0xd4/0x2bc


Code: 8ca80000  24a50004  24c6fffc <ac880000> 1706fffb  24840004  10c00040  00864821  240a0020 
Instruction bus error, epc == 80004dd8, ra == 80000018
Oops[#3]:
Cpu 0
$ 0   : 00000000 1000d000 00000000 00000004
$ 4   : 004c7130 81ebbdd0 00000000 1000d001
$ 8   : 00000080 00000000 00000000 81890000
$12   : 81d5c868 00000000 81d5c868 00000000
$16   : 00000004 00000001 81ebbdc0 81ebbdc0
$20   : 004c7130 004c7360 81ebbdcc 00000000
$24   : 00000000 80181208                  
$28   : 81eba000 81ebbd98 004b0000 80000018
Hi    : 00000000
Lo    : 00000000
epc   : 80004dd8 __copy_user+0xd4/0x2bc
    Tainted: G      D   
ra    : 80000018 0x80000018
Status: 1000d003    KERNEL EXL IE 
Cause : 00800018
PrId  : 00029029 (Broadcom BCM3302)
Modules linked in: ipv6 arc4 snd_usb_audio ecb snd_pcm_oss cryptomgr snd_mixer_oss aead pcompress snd_pcm crypto_blkcipher crypto_hash snd_timer crypto_algapi snd_page_alloc evdev snd_usb_lib b43 ftdi_sio mac80211 snd_rawmidi snd_seq_device cfg80211 usbhid snd_hwdep usbserial hid snd input_core soundcore
Process sshd (pid: 1448, threadinfo=81eba000, task=81d5c838, tls=00000000)
Stack : cd09000a 81ebbda8 00000000 00000005 81ebbdc0 81ebbdc4 81ebbdc8 81ebbdcc
        81ebbdd0 81ebbdd4 00000098 00000000 00000000 00000080 00000000 00000000
        000000e2 81cdd360 81ea39d0 81c4ff20 000000e2 81cdd360 81c4ff20 80251b38
        000000e3 80251e78 81ebbe20 8009e530 81cdd080 81c4ff20 81cdd388 80215c18
        80000000 81c4ff20 00000042 000000e2 81cdd360 81c4ff20 00000042 801af5f0
        ...
Call Trace:
[<80004dd8>] __copy_user+0xd4/0x2bc


Code: 8ca80000  24a50004  24c6fffc <ac880000> 1706fffb  24840004  10c00040  00864821  240a0020 
Kernel panic - not syncing: Attempted to kill init!


--BXVAT5kNtrzKuDFl--
