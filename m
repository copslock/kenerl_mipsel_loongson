Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 03:03:40 +0000 (GMT)
Received: from sorrow.cyrius.com ([65.19.161.204]:38674 "EHLO
	sorrow.cyrius.com") by ftp.linux-mips.org with ESMTP
	id S3458479AbWAXDDU (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 03:03:20 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 83BFD64D3D; Tue, 24 Jan 2006 03:07:34 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 77982892F; Tue, 24 Jan 2006 03:07:25 +0000 (GMT)
Date:	Tue, 24 Jan 2006 03:07:25 +0000
From:	Martin Michlmayr <tbm@cyrius.com>
To:	linux-mips@linux-mips.org
Cc:	t.sailer@alumni.ethz.ch, perex@suse.cz
Subject: Ensoniq ES1371 problem on Cobalt MIPS
Message-ID: <20060124030725.GA14063@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10091
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

I get the following problems on a Cobalt MIPS machine with PCI and an
Ensoniq ES1371 sound card when the module is being loaded.  It occurs
both with the ALSA and the OSS driver so I assume there's some MIPS
related issue.  Note that the OSS driver worked fine under 2.4.  This
is now with 2.6.15.

 uhci_hcd 0000:00:09.2: init 0000:00:09.2 fail, -19
 Running 0dns-down to make sure resolv.conf is ok...done.
Setting up networking...done.
Starting hotplug subsystem:
   pci     
     uhci-hcd: already loaded
wait source ready timeout 0x1410 [0x8c8c8c8c]
 wait source ready timeout 0x1410 [0x8c8c8c8c]
[... repeated about 600 times, quite long delays ]
 wait source ready timeout 0x1410 [0x8c8c8c8c]
 AC'97 0 analog subsections not ready
[...]
 wait source ready timeout 0x1410 [0x8c8c8c8c]
 Unhandled kernel unaligned access[#1]:
 Cpu 0
 $ 0   : 0000000000000000 ffffffff900064e0 9b6400000117a388 0000000000000000
 $ 4   : ffffffff802d0f40 ffffffffdc820000 0000000000000000 9b6400000117a380
 $ 8   : 9800000007884000 9800000007887af0 0000000000000000 00000000000001c0
 $12   : ffffffff900064e0 000000001000001e ffffffff802d8588 ffffffff80380000
 $16   : 9800000007887af0 0000000000000004 ffffff0000000000 0000000000010000
 $20   : 0000000000000004 c000000000124250 0000000000000002 0000000000000002
 $24   : ffffffff80390000 ffffffff800a0fc8                                  
 $28   : 9800000007884000 9800000007887ac0 c000000000124250 ffffffff8008234c
 Hi    : 0000000000000000
 Lo    : 0000000000000380
 epc   : ffffffff80089a68 do_ade+0x398/0x4a0     Not tainted
 ra    : ffffffff8008234c handle_adel_int+0x34/0x48
 Status: 900064e2    KX SX UX KERNEL EXL 
 Cause : 00808010
 BadVA : 9b6400000117a387
 PrId  : 000028a0
 Modules linked in: snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd soundcore snd_page_alloc snd_ac97_bus uhci_hcd usbcore
 Process modprobe (pid: 604, threadinfo=9800000007884000, task=980000000785f808)
 Stack : 9800000007850248 0000000000000004 9000000006c10000 0000000000010000
         ffffffff8008234c 0000000000000000 0000000000000000 ffffffff900064e0
         0000000000000380 ffffffff900064e1 9b6400000117a380 9b6400000117a3b8
         9b6400000117a700 0000000000004000 0000000000008000 ffffffff8031fa00
         00000000000068fb 00000000000001c0 0000000000000000 ffffffff801df26c
         ffffffff802d8588 ffffffff80380000 9800000007850248 0000000000000004
         9000000006c10000 0000000000010000 0000000000000004 c000000000124250
         0000000000000002 0000000000000002 ffffffff80390000 ffffffff800a0fc8
         0000000000006c10 ffffffff800ec990 9800000007884000 9800000007887c20
         c000000000124250 c00000000001cbd0 ffffffff900064e2 0000000000000000
         ...
 Call Trace:
  [<ffffffff8008234c>] handle_adel_int+0x34/0x48
  [<ffffffff801df26c>] memset_partial+0x48/0x60
  [<ffffffff80380000>] netfilter_init+0xb0/0x118
  [<c000000000124250>] snd_pcm_lib_preallocate_pages+0x0/0x58 [snd_pcm]
  [<ffffffff800a0fc8>] blast_dcache32+0x0/0x100
  [<ffffffff800ec990>] __get_free_pages+0x60/0xf0
  [<c000000000124250>] snd_pcm_lib_preallocate_pages+0x0/0x58 [snd_pcm]
  [<c00000000001cbd0>] $L92+0x98/0xc0 [snd_page_alloc]
  [<c00000000001c060>] $L8+0x20/0x5c [snd_page_alloc]
  [<c000000000124460>] $L70+0x14/0x44 [snd_pcm]
  [<c000000000124574>] $L85+0x14/0x2c [snd_pcm]
  [<c00000000011cc98>] snd_pcm_set_ops+0x0/0x28 [snd_pcm]
  [<ffffffff801dc7a0>] strcpy+0x0/0x28
  [<c000000000113d60>] snd_pcm_new+0x0/0xa0 [snd_pcm]
  [<c0000000000fa830>] $L434+0x158/0x3f8 [snd_ens1371]
  [<c0000000000f7240>] snd_ensoniq_mixer_free_ac97+0x0/0x10 [snd_ens1371]
  [<ffffffff801ea9e0>] pci_device_probe+0x80/0xb0
  [<ffffffff8020e5a8>] driver_probe_device+0x58/0x100
  [<ffffffff8020e8ac>] __driver_attach+0x104/0x130
  [<ffffffff8020e7a8>] __driver_attach+0x0/0x130
  [<ffffffff8020d530>] bus_for_each_dev+0x50/0xb8
  [<ffffffff801d917c>] kobject_register+0x5c/0xa0
  [<ffffffff8020dc88>] bus_add_driver+0xb8/0x208
  [<ffffffff801ea57c>] __pci_register_driver+0xec/0x150
  [<ffffffff801ea57c>] __pci_register_driver+0xec/0x150
  [<ffffffff800df0a4>] sys_init_module+0x27c/0x628
  [<ffffffff800df038>] sys_init_module+0x210/0x628
  [<ffffffff8009d428>] handle_sys+0x128/0x144
  [<ffffffff8009d428>] handle_sys+0x128/0x144


 Code: 00621824  5460ff7d  de020100 <68e30007> 6ce30000  24020000  1440ffa0  00051402  0802265b 
 Setting up IP spoofing protection: rp_filter.
Configuring network interfaces...done.
Starting portmap daemon: portmap.
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
 
Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Tue Jan 24 02:24:45 GMT 2006

Running ntpdate to synchronize clockNET: Registered protocol family 10
 lo: Disabled Privacy Extensions
 IPv6 over IPv4 tunneling driver
 .
Initializing random number generator...done.
Recovering nvi editor sessions... done.
Setting up X server socket directory /tmp/.X11-unix...done.
Setting up ICE socket directory /tmp/.ICE-unix...done.
 INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
eth0: no IPv6 routers present
 Starting kernel log daemon: klogd.
Starting portmap daemon: portmap.
Starting Cobalt LCD admin menu: paneld.
Starting MTA: exim4.
Starting internet superserver: inetd.
Starting printer spooler: lpd .
Starting OpenBSD Secure Shell server: sshd.
Starting NFS common utilities: statd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.

Debian GNU/Linux 3.1 qube ttyS0

qube login: root
Password: 
Last login: Tue Jan 24 02:11:49 2006 on ttyS0
Linux qube 2.6.15-1-r5k-cobalt #2 Tue Jan 24 01:44:12 GMT 2006 mips64 GNU/Linux

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
qube:~# lsmod
Module                  Size  Used by
md5                     6976  1 
ipv6                  578592  10 
snd_ens1371            39936  1 
snd_rawmidi            49056  1 snd_ens1371
snd_seq_device         18192  1 snd_rawmidi
snd_ac97_codec        179840  1 snd_ens1371
snd_pcm               173440  2 snd_ens1371,snd_ac97_codec
snd_timer              48688  1 snd_pcm
snd                   100768  6 snd_ens1371,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer
soundcore              16560  1 snd
snd_page_alloc         18896  1 snd_pcm
snd_ac97_bus            3104  1 snd_ac97_codec
uhci_hcd               66560  0 
usbcore               224864  1 uhci_hcd
qube:~#
qube:~# lspci
0000:00:00.0 Memory controller: Marvell Technology Group Ltd.: Unknown device 4146 (rev 11)
0000:00:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
0000:00:09.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 27)
0000:00:09.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:09.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 02)
0000:00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
0000:00:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
qube:~#
qube:~# uname -a
Linux qube 2.6.15-1-r5k-cobalt #2 Tue Jan 24 01:44:12 GMT 2006 mips64 GNU/Linux

I also tried the OSS driver but basically got the same:

es1371: version v0.32 time 02:55:42 Jan 24 2006
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x06
es1371: found es1371 rev 6 at io 0x1400 irq 9
es1371: sample rate converter timeout r = 0x8c8c8c8c
es1371: sample rate converter timeout r = 0x8c8c8c8c
es1371: sample rate converter timeout r = 0x8c8c8c8c
es1371: sample rate converter timeout r = 0x8c8c8c8c
es1371: sample rate converter timeout r = 0x8c8c8c8c
es1371: sample rate converter timeout r = 0x8c8c8c8c
es1371: sample rate converter timeout r = 0x8c8c8c8c
es1371: sample rate converter timeout r = 0x8c8c8c8c
es1371: sample rate converter timeout r = 0x8c8c8c8c
...
ac97_codec: Primary ac97 codec not present
es1371: cannot register misc device

-- 
Martin Michlmayr
http://www.cyrius.com/
