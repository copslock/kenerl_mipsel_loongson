Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2009 23:14:40 +0100 (BST)
Received: from apfelkorn.psychaos.be ([195.144.77.38]:49863 "EHLO
	apfelkorn.psychaos.be" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20025443AbZELWOe (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2009 23:14:34 +0100
Received: from p2 by apfelkorn.psychaos.be with local (Exim 4.69)
	(envelope-from <p2@psychaos.be>)
	id 1M40F6-0008K9-OU
	for linux-mips@linux-mips.org; Wed, 13 May 2009 01:14:32 +0300
Date:	Wed, 13 May 2009 01:14:32 +0300
From:	Peter 'p2' De Schrijver <p2@debian.org>
To:	linux-mips@linux-mips.org
Subject: warm boot failure
Message-ID: <20090512221432.GM1835@apfelkorn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
X-Unexpected-Header: The spanish inquisition !
X-mate:	Mate, mann gewohnt sich an alles
X-Paddo: Munch, Munch
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <p2@psychaos.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

2.6.30-rc5-sb1-bcm91250a boots fine when doing a cold boot. On warm reboot, it 
panics while reading from the PATA HD though. Insights welcome. See also attached
logfile.

Cheers,

Peter.

--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="log-2.6.30-rc5-sb1-bcm91250a-warm"
Content-Transfer-Encoding: quoted-printable

bo=08 =08=08 =08ifconfig eth0 -auto=0D
=0Deth0: Link speed: 100BaseT FDX=1B[J=0D=0D
Device eth0:  hwaddr 00-02-4C-FE-0D-72, ipaddr 192.168.1.22, mask 255.255.2=
55.0=0D
        gateway 192.168.1.254, nameserver 192.168.1.19, domain elisa-laajak=
aista.fi=0D
*** command status =3D 0=0D
CFE> boot -tftp 192.168.1.138:sibyl=0D
Loader:raw Filesys:tftp Dev:eth0 File:192.168.1.138:sibyl Options:(null)=0D
Loading: ....... 130116 bytes read=0D
Entry at 0x0000000020000000=0D
Closing network.=0D
Starting program at 0x0000000020000000=0D
SiByte Loader, version 2.4.2=0D
Built on Oct  4 2005=0D
Network device 'eth0' configured=0D
Getting configuration file tftp:192.168.1.138:sibyl.conf...=0D
Config file retrieved.=0D
Available configurations:=0D
  deb-tftp=0D
Boot which configuration [deb-tftp]: =0D
Loading kernel (ELF64):=0D
    5204576@0x80100000=0D
done=0D
Set up command line arguments to: root=3D/dev/sda1 console=3Dduart0=0D
Setting up initial prom_init arguments=0D
Cleaning up state...=0D
Transferring control to the kernel.=0D
Kernel entry point is at 0x80105c50=0D
[    0.000000] Initializing cgroup subsys cpuset=0D
[    0.000000] Initializing cgroup subsys cpu=0D
[    0.000000] Linux version 2.6.30-rc5-sb1-bcm91250a (Debian 2.6.30~rc5-1~=
experimental.1) (maks@debian.org) (gcc version 4.1.3 20080420 (prerelease) =
(Debian 4.1.2-22)) #1 SMP Tue May 12 20:49:26 UTC 2009=0D
[    0.000000] console [early0] enabled=0D
[    0.000000] CPU revision is: 01040102 (SiByte SB1)=0D
[    0.000000] FPU revision is: 000f0102=0D
[    0.000000] Checking for the multiply/shift bug... no.=0D
[    0.000000] Checking for the daddiu bug... no.=0D
[    0.000000] Broadcom SiByte BCM1250 B2 @ 800 MHz (SB1 rev 2)=0D
[    0.000000] Board type: SiByte BCM91250A (SWARM)=0D
[    0.000000] This kernel optimized for board runs with CFE=0D
[    0.000000] Determined physical RAM map:=0D
[    0.000000]  memory: 000000000fe47e00 @ 0000000000000000 (usable)=0D
[    0.000000] Initrd not found or empty - disabling initrd=0D
[    0.000000] Zone PFN ranges:=0D
[    0.000000]   DMA32    0x00000000 -> 0x00100000=0D
[    0.000000]   Normal   0x00100000 -> 0x00100000=0D
[    0.000000] Movable zone start PFN for each node=0D
[    0.000000] early_node_map[1] active PFN ranges=0D
[    0.000000]     0: 0x00000000 -> 0x0000fe47=0D
[    0.000000] Detected 1 available secondary CPU(s)=0D
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Tota=
l pages: 64205=0D
[    0.000000] Kernel command line: root=3D/dev/sda1 console=3Dduart0=0D
[    0.000000] Primary instruction cache 32kB, VIVT, 4-way, linesize 32 byt=
es.=0D
[    0.000000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 3=
2 bytes=0D
[    0.000000] NR_IRQS:128=0D
[    0.000000] PID hash table entries: 1024 (order: 10, 8192 bytes)=0D
[17179569.184000] Conso=81=8D=BD=B9=CD=BD=B1=95=81=A1=85=B9=91=BD=D9=95=C9=
=E9=81=12=BD=BD=D1=81m=95=85=C9=B1=E5=C1u=81=B5=F2=02=92=95=85=B1=81m=91=D5=
=85=C9=D1=C1u5)=DA=C5=DD=8A=BA=CA=AA=B2=CAr=8A=81=95=B9=D1=C9=E5=81=8D=85=
=8D=A1=95=81=A1=85=CD=A1=81=D1=85=89=B1=95=81=95=B9=D1=C9=A5=95=CD=E9=81=9A=
=92=BA=B2=C2=02Bz=C9=91=95=C9=E9=81=B2b=02=92=B2=92=8A=A2=A2=02=12=E5=D1=95=
5R=FE[17179569.196000] Inode-cache hash table entries: 16384 (order: 5, 131=
072 bytes)=0D
[17179569.232000] Memory: 249540k/260380k available (3659k kernel code, 106=
64k reserved, 1202k data, 220k init, 0k highmem)=0D
[17179569.236000] Calibrating delay loop... 532.48 BogoMIPS (lpj=3D1064960)=
=0D
[17179569.340000] Security Framework initialized=0D
[17179569.344000] SELinux:  Disabled at boot.=0D
[17179569.348000] Mount-cache hash table entries: 256=0D
[17179569.356000] Initializing cgroup subsys ns=0D
[17179569.360000] Initializing cgroup subsys cpuacct=0D
[17179569.364000] Initializing cgroup subsys devices=0D
[17179569.368000] Initializing cgroup subsys freezer=0D
[17179569.372000] Initializing cgroup subsys net_cls=0D
[17179569.376000] Checking for the daddi bug... no.=0D
[17179569.384000] CPU revision is: 03040102 (SiByte SB1)=0D
[17179569.384000] FPU revision is: 000f0102=0D
[17179569.384000] Primary instruction cache 32kB, VIVT, 4-way, linesize 32 =
bytes.=0D
[17179569.384000] Primary data cache 32kB, 4-way, PIPT, no aliases, linesiz=
e 32 bytes=0D
[17179569.384000] Calibrating delay loop... 532.48 BogoMIPS (lpj=3D1064960)=
=0D
[17179569.484000] Brought up 2 CPUs=0D
[17179569.488000] net_namespace: 1936 bytes=0D
[17179569.492000] regulator: core version 0.5=0D
[17179569.496000] NET: Registered protocol family 16=0D
[17179569.512000] bio: create slab <bio-0> at 0=0D
[17179569.516000] SCSI subsystem initialized=0D
[17179569.520000] pci 0000:00:05.0: PME# supported from D0 D1 D2 D3hot=0D
[17179569.524000] pci 0000:00:05.0: PME# disabled=0D
[17179569.528000] pci 0000:01:08.0: PME# supported from D0 D1 D2 D3hot=0D
[17179569.532000] pci 0000:01:08.0: PME# disabled=0D
[17179569.536000] pci 0000:01:08.1: PME# supported from D0 D1 D2 D3hot=0D
[17179569.540000] pci 0000:01:08.1: PME# disabled=0D
[17179569.544000] pci 0000:01:08.2: PME# supported from D0 D1 D2 D3hot=0D
[17179569.548000] pci 0000:01:08.2: PME# disabled=0D
[17179569.552000] pci 0000:01:09.0: PME# supported from D2 D3hot D3cold=0D
[17179569.556000] pci 0000:01:09.0: PME# disabled=0D
[17179569.576000] NET: Registered protocol family 2=0D
[17179569.628000] IP route cache hash table entries: 2048 (order: 2, 16384 =
bytes)=0D
[17179569.636000] TCP established hash table entries: 8192 (order: 5, 13107=
2 bytes)=0D
[17179569.640000] TCP bind hash table entries: 8192 (order: 5, 131072 bytes=
)=0D
[17179569.648000] TCP: Hash tables configured (established 8192 bind 8192)=
=0D
[17179569.656000] TCP reno registered=0D
[17179569.672000] NET: Registered protocol family 1=0D
[17179569.676000] pata-swarm: PATA interface at GenBus slot 4=0D
[17179569.680000] audit: initializing netlink socket (disabled)=0D
[17179569.688000] type=3D2000 audit(1242158714.504:1): initialized=0D
[17179569.692000] VFS: Disk quotas dquot_6.5.2=0D
[17179569.696000] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)=
=0D
[17179569.704000] msgmni has been set to 487=0D
[17179569.708000] alg: No test for stdrng (krng)=0D
[17179569.716000] Block layer SCSI generic (bsg) driver version 0.4 loaded =
(major 253)=0D
[17179569.720000] io scheduler noop registered=0D
[17179569.724000] io scheduler anticipatory registered=0D
[17179569.732000] io scheduler deadline registered=0D
[17179569.736000] io scheduler cfq registered (default)=0D
[17179569.752000] duart0 at MMIO 0x10060100 (irq =3D 8) is a SB1250 DUART=0D
[17179569.756000] duart1 at MMIO 0x10060200 (irq =3D 9) is a SB1250 DUART=0D
[17179569.768000] brd: module loaded=0D
[17179569.772000] Driver 'sd' needs updating - please use bus_type methods=
=0D
[17179569.780000] sil680: 133MHz clock.=0D
[17179569.784000] attempted to set irq affinity for irq 58 to multiple CPUs=
=0D
[17179569.792000] scsi0 : pata_sil680=0D
[17179569.796000] scsi1 : pata_sil680=0D
[17179569.800000] ata1: PATA max UDMA/133 cmd 0x8098 ctl 0x80a0 bmdma 0x808=
0 irq 58=0D
[17179569.804000] ata2: PATA max UDMA/133 cmd 0x8090 ctl 0x80a4 bmdma 0x808=
8 irq 58=0D
[17179569.812000] mice: PS/2 mouse device common for all mice=0D
[17179569.820000] TCP cubic registered=0D
[17179569.824000] NET: Registered protocol family 17=0D
[17179569.828000] RPC: Registered udp transport module.=0D
[17179569.832000] RPC: Registered tcp transport module.=0D
[17179569.840000] registered taskstats version 1=0D
[17179569.844000] /home/tbm/kernel/linux-2.6-2.6.30~rc5/debian/build/source=
_mips_none/drivers/rtc/hctosys.c: unable to open rtc device (rtc0)=0D
[17179570.144000] ata2.00: ATA-6: WDC WD2000JB-00GVA0, 08.02D08, max UDMA/1=
00=0D
[17179570.152000] ata2.00: 390721968 sectors, multi 0: LBA48 =0D
[17179570.172000] ata2.00: configured for UDMA/100=0D
[17179570.176000] scsi 1:0:0:0: Direct-Access     ATA      WDC WD2000JB-00G=
 08.0 PQ: 0 ANSI: 5=0D
[17179570.184000] sd 1:0:0:0: [sda] 390721968 512-byte hardware sectors: (2=
00 GB/186 GiB)=0D
[17179570.192000] sd 1:0:0:0: [sda] Write Protect is off=0D
[17179570.196000] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabl=
ed, doesn't support DPO or FUA=0D
[17179570.208000]  sda:DBE physical address: 00dc0080a0=0D
[17179601.000000] Data bus error, epc =3D=3D ffffffff80331a0c, ra =3D=3D ff=
ffffff803abed8=0D
[17179601.000000] Oops[#1]:=0D
[17179601.000000] Cpu 0=0D
[17179601.000000] $ 0   : 0000000000000000 0000000014001fe0 00000000000000f=
f 0000000000000001=0D
[17179601.000000] $ 4   : 90000000dc0080a6 0000000000000000 000000000000000=
2 ffffffff804c6ad0=0D
[17179601.000000] $ 8   : 0000000000000002 ffffffffffffffc0 000000000000001=
3 0000000000000001=0D
[17179601.000000] $12   : a80000000fb93fe0 0000000000001f00 000000000000000=
0 a80000000f894000=0D
[17179601.000000] $16   : a80000000fbfc000 a80000000fbfc0d0 0000000014001fe=
1 a80000000fb87880=0D
[17179601.000000] $20   : a80000000fbfc000 ffffffff804bc8e0 a80000000fb8780=
0 0000000000000000=0D
[17179601.000000] $24   : 0000000000000000 ffffffff80115d68                =
                  =0D
[17179601.000000] $28   : a80000000fb90000 a80000000fb93ed0 000000000000000=
0 ffffffff803abed8=0D
[17179601.000000] Hi    : 0000000000000000=0D
[17179601.000000] Lo    : 0000000000000000=0D
[17179601.000000] epc   : ffffffff80331a0c ioread8+0x4/0x10=0D
[17179601.000000]     Not tainted=0D
[17179601.000000] ra    : ffffffff803abed8 ata_sff_altstatus+0x38/0x48=0D
[17179601.000000] Status: 14001fe2    KX SX UX KERNEL EXL =0D
[17179601.000000] Cause : 8080801c=0D
[17179601.000000] PrId  : 01040102 (SiByte SB1)=0D
[17179601.000000] Modules linked in:=0D
[17179601.000000] Process scsi_eh_1 (pid: 255, threadinfo=3Da80000000fb9000=
0, task=3Da80000000f9d0038, tls=3D0000000000000000)=0D
[17179601.000000] Stack : ffffffff803ada78 0000000000000000 0000000014001fe=
1 a80000000fb87800=0D
[17179601.000000]         ffffffff803aae40 ffffffff803aae0c 0000000014001fe=
1 a80000000fb87800=0D
[17179601.000000]         fffffffffffffffc a80000000fb87880 a80000000fb93f6=
0 ffffffff804bc8e0=0D
[17179601.000000]         0000000000000000 0000000000000000 000000000000000=
0 ffffffff80389590=0D
[17179601.000000]         a80000000fb87800 ffffffff80389498 fffffffffffffff=
c 0000000000000000=0D
[17179601.000000]         a80000000fb87800 ffffffff80389498 fffffffffffffff=
c 0000000000000000=0D
[17179601.000000]         0000000000000000 0000000000000000 ffffffff8015da4=
0 ffffffff8015da20=0D
[17179601.000000]         0000000000000000 0000000000000000 000000000000000=
0 ffffffff80110cc8=0D
[17179601.000000]         0000000000000000 ffffffff80110cb8 000000000000000=
0 0000000000000000=0D
[17179601.000000]         0000000000000000 0000000000000000=0D
[17179601.000000] Call Trace:=0D
[17179601.000000] [<ffffffff80331a0c>] ioread8+0x4/0x10=0D
[17179601.000000] [<ffffffff803abed8>] ata_sff_altstatus+0x38/0x48=0D
[17179601.000000] [<ffffffff803ada78>] ata_sff_lost_interrupt+0xc0/0x108=0D
[17179601.000000] [<ffffffff803aae40>] ata_scsi_error+0x70/0x6c8=0D
[17179601.000000] [<ffffffff80389590>] scsi_error_handler+0xf8/0x3f0=0D
[17179601.000000] [<ffffffff8015da40>] kthread+0x60/0xa0=0D
[17179601.000000] [<ffffffff80110cc8>] kernel_thread_helper+0x10/0x18=0D
[17179601.000000] =0D
[17179601.000000] =0D
[17179601.000000] Code: 080cc671  0000102d  90820000 <03e00008> 304200ff  0=
0000000  94820000  03e00008  3042ffff =0D
[17179601.000000] Disabling lock debugging due to kernel taint=0D
=FF=0D

--7ZAtKRhVyVSsbBD2--
