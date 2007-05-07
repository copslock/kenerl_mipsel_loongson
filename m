Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2007 18:38:20 +0100 (BST)
Received: from moutng.kundenserver.de ([212.227.126.171]:50633 "EHLO
	moutng.kundenserver.de") by ftp.linux-mips.org with ESMTP
	id S20022095AbXEGRiS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 7 May 2007 18:38:18 +0100
Received: from [87.166.150.201] (helo=[192.168.6.7])
	by mrelayeu.kundenserver.de (node=mrelayeu4) with ESMTP (Nemesis),
	id 0ML21M-1Hl79a0Ili-0003GP; Mon, 07 May 2007 19:37:42 +0200
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Transfer-Encoding: 8BIT
Message-Id: <8FBE82E8-F399-426A-A263-E0EA85095A08@mailprocessor.de>
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
To:	linux-mips@linux-mips.org
From:	Guido Zeiger <guido.zeiger@mailprocessor.de>
Subject: Segmentation Fault from MP3-Player with Etch on Qube2
Date:	Mon, 7 May 2007 19:37:40 +0200
X-Mailer: Apple Mail (2.752.3)
X-Provags-ID: V01U2FsdGVkX1/q2QwEPqIOlrFtVQamVd3Wp9r+WFRuZTz6KCq
 tXKW9U14cAe3osRwN+ouAxhpZF75wM0FjlkMGUCkEZzxkkp6Ie
 JwkB5ST2NIAY6UscFV+Xg==
Return-Path: <guido.zeiger@mailprocessor.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: guido.zeiger@mailprocessor.de
Precedence: bulk
X-list: linux-mips

Hello,

after reinstalling debian, (now etch , therefore sid) on my Qube2,  
because of changing to a 2.5" HD (from 3.5") and installing the
current debian version I got a Segmentation Fault on every usage of a  
program which should produce sound  :-((

The programs are

> mpg123
> mpg321
> mp3blaster

The programs did work with this qube2, soundcard and mp3-file under  
debian sid,
but now with etch it didnt work anymore.


Hopefully someone could point me to the problem which is generating  
the Segmentation Fault.

Here the complete SegFault-Listing...if this could help to find the  
problem:


littleghost:/home/guido# mpg321 ./mss.mp3
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layer 1, 2, and 3.
Version 0.59q (2002/03/23). Written and copyrights by Joe Drew.
Uses code from various people. See 'README' for more!
THIS SOFTWARE COMES WITH ABSOLUTELY NO WARRANTY! USE AT YOUR OWN RISK!
Title  : Magical Sound Shower (Original  Artist: Sega/S.S.T. Band
Album  : Outrun OST                      Year  : 1986
Comment: copyright Pony Canyon Records∆  Genre : Soundtrack

Directory: ./
Playing MPEG stream from mss.mp3 ...
MPEG 1.0 layer III, 160 kbit/s, 44100 Hz stereo
Data bus error, epc == 801ae38c, ra == c00904b4
Oops[#1]:
Cpu 0
$ 0   : 00000000 100028c8 00000000 80000000
$ 4   : c011f000 100016c8 000011e0 100016c8
$ 8   : ffff0001 ffff0001 00000000 00010000
$12   : 0000ffff 00001fff 0000000d 00000000
$16   : 00004000 8f80d000 00000480 00000000
$20   : 80389c80 00000480 100016c8 00000000
$24   : 00000000 c008c738
$28   : 8e544000 8e545de8 c0090408 c00904b4
Hi    : 00000000
Lo    : 00000000
epc   : 801ae38c both_aligned+0x2c/0x64     Not tainted
ra    : c00904b4 snd_pcm_lib_write_transfer+0xac/0xc4 [snd_pcm]
Status: b0006c03    KERNEL EXL IE
Cause : 0080801c
PrId  : 000028a0
Modules linked in: ipv6 dm_snapshot dm_mirror dm_mod loop snd_emu10k1  
snd_rawmid
i snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer  
snd_page_alloc sn
d_util_mem snd_hwdep uhci_hcd snd usbcore soundcore
Process mpg321 (pid: 889, threadinfo=8e544000, task=8037a8b8)
Stack : 8eb0fe24 2afd7000 00000000 8e5242ac 2afd7c7c 00000f5c  
c008ea40 800defd4
         8ff20df4 00000000 8e545e28 00000000 00000480 00000100  
00000000 00000000
         00000002 00000000 00000000 00000000 00000000 00000000  
00000000 7fe40b20
         80389c80 800c4150 00000004 100327e8 7fe42ca8 1002f370  
10004050 c008ed50
         8f95a980 c0684113 00000004 00000000 c0090408 00000000  
c008c92c c008c794
         ...
Call Trace:
[<801ae38c>] both_aligned+0x2c/0x64
[<c00904b4>] snd_pcm_lib_write_transfer+0xac/0xc4 [snd_pcm]
[<c008ea40>] snd_pcm_lib_write1+0x3c8/0x620 [snd_pcm]
[<c008ed50>] snd_pcm_lib_write+0x50/0x7c [snd_pcm]
[<c008c92c>] snd_pcm_playback_ioctl1+0x1f4/0x5ec [snd_pcm]
[<8010a4bc>] do_ioctl+0x2c/0x80
[<8010a57c>] vfs_ioctl+0x6c/0x34c
[<8010a908>] sys_ioctl+0xac/0xc4
[<8008a9a0>] stack_done+0x20/0x3c


Code: 24c6ffe0  8cac0010  8caf0014 <ac880000> ac890004  8ca80018   
8ca9001c  24a5
0020  24840020
Segmentation fault


lspci for the soundcard which did work on Sid:
00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1  
(rev 04)
00:0a.1 Input device controller: Creative Labs SB Live! Game Port  
(rev 01)

littleghost:/home/guido# lsmod
Module                  Size  Used by
ipv6                  314976  10
dm_snapshot            20000  0
dm_mirror              24512  0
dm_mod                 68320  2 dm_snapshot,dm_mirror
loop                   17168  0
snd_emu10k1           134864  0
snd_rawmidi            29696  1 snd_emu10k1
snd_ac97_codec        105152  1 snd_emu10k1
snd_ac97_bus            2208  1 snd_ac97_codec
snd_pcm                89440  2 snd_emu10k1,snd_ac97_codec
snd_seq_device          9968  2 snd_emu10k1,snd_rawmidi
snd_timer              27024  2 snd_emu10k1,snd_pcm
snd_page_alloc         11248  2 snd_emu10k1,snd_pcm
snd_util_mem            5184  1 snd_emu10k1
snd_hwdep              10576  1 snd_emu10k1
uhci_hcd               27536  0
snd                    58992  7  
snd_emu10k1,snd_rawmidi,snd_ac97_codec,snd_pcm,s
nd_seq_device,snd_timer,snd_hwdep
usbcore               130896  1 uhci_hcd
soundcore              11056  1 snd


The programs saytime and saydate did produce a error regarding the  
pcm sounddevice.


Thanks
Bye
Guido.
