Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 May 2004 19:31:06 +0100 (BST)
Received: from [IPv6:::ffff:81.187.251.134] ([IPv6:::ffff:81.187.251.134]:39430
	"EHLO getyour.pawsoff.org") by linux-mips.org with ESMTP
	id <S8225972AbUEMSbE>; Thu, 13 May 2004 19:31:04 +0100
Received: by getyour.pawsoff.org (Postfix, from userid 1000)
	id 079A4387CF1; Thu, 13 May 2004 19:30:59 +0100 (BST)
Date: Thu, 13 May 2004 19:30:59 +0100
To: linux-mips@linux-mips.org
Subject: IRQ problem on cobalt / 2.6.6
Message-ID: <20040513183059.GA25743@getyour.pawsoff.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: kieran@pawsoff.org (Kieran Fulke)
Return-Path: <kieran@pawsoff.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4993
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kieran@pawsoff.org
Precedence: bulk
X-list: linux-mips


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi folks,=20

getting the below when loading the dvb budget_ci module. it disables IRQ=20
#23 which is attached to the card, rendering it useless. i asked the=20
same question over there and none of them suspect it to be a DVB=20
problem. some esoteric pci bug perhaps?

lspci -vv
0000:00:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev=20
01)
        Subsystem: Technotrend Systemtechnik GmbH: Unknown device 1011
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=20
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort-=
=20
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (3750ns min, 9500ns max)
        Interrupt: pin A routed to IRQ 23
        Region 0: Memory at 12080800 (32-bit, non-prefetchable)

cat /proc/interrupts
           CPU0
  2:          0          XT-PIC  cascade
 14:     321895          XT-PIC  ide0
 18:   82942617            MIPS  timer
 19:     131702            MIPS  eth0
 21:        345            MIPS  serial
 22:          0            MIPS  cascade
 23:     100002            MIPS  saa7146 (0)

ERR:          0

 dmesg | ksymoops
ksymoops 2.4.9 on mips 2.6.6-mipscvs-20040510.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.6-mipscvs-20040510/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace: [<80084624>]  [<8008461c>]  [<80084720>]  [<800b179c>] =20
[<800b1788>]  [<80084a78>]  [<800b1af8>]  [<800826d0>]  [<800ac718>] =20
[<80082ec0>]  [<801593c0>]  [<800ac7f4>]  [<80084b18>]  [<800ac6f8>] =20
[<80084578>]  [<80084578>]  [<800ac7f4>]  [<80084b18>]  [<80082ec0>] =20
[<800826d0>]  [<80082ec0>]  [<801594a4>]  [<801593c0>]  [<80085468>] =20
[<80085480>]  [<8019c624>]  [<8019c610>]  [<c001b570>]  [<80084bec>] =20
[<8015bff8>]  [<800ce3ec>]  [<800ce3ec>]  [<c001bc24>]  [<80126eb8>] =20
[<8015d338>]  [<c001b544>]  [<801780e0>]  [<8015d3a0>]  [<8015d7b4>] =20
[<8015d408>]  [<80153bf4>]  [<80178eb0>]  [<80154140>]  [<80154018>] =20
[<80154258>]  [<80178fec>]  [<80179284>]  [<80179608>]  [<800a83e4>] =20
[<800a8264>]  [<8015d684>]  [<800a81d4>]  [<c001c298>]  [<c001c288>] =20
[<c002a020>]  [<800c2b98>]  [<800c2b40>]  [<800e7ef0>]  [<8008be88>]
[<c001b570>]
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; 80084624 <__report_bad_irq+48/8c>
Trace; 8008461c <__report_bad_irq+40/8c>
Trace; 80084720 <note_interrupt+88/d0>
Trace; 800b179c <update_process_times+40/54>
Trace; 800b1788 <update_process_times+2c/54>
Trace; 80084a78 <do_IRQ+110/1dc>
Trace; 800b1af8 <do_timer+78/144>
Trace; 800826d0 <cobalt_irq+150/180>
Trace; 800ac718 <__do_softirq+68/ec>
Trace; 80082ec0 <ret_from_exception+0/0>
Trace; 801593c0 <memset+0/1c>
Trace; 800ac7f4 <do_softirq+58/8c>
Trace; 80084b18 <do_IRQ+1b0/1dc>
Trace; 800ac6f8 <__do_softirq+48/ec>
Trace; 80084578 <handle_IRQ_event+6c/d0>
Trace; 80084578 <handle_IRQ_event+6c/d0>
Trace; 800ac7f4 <do_softirq+58/8c>
Trace; 80084b18 <do_IRQ+1b0/1dc>
Trace; 80082ec0 <ret_from_exception+0/0>
Trace; 800826d0 <cobalt_irq+150/180>
Trace; 80082ec0 <ret_from_exception+0/0>
Trace; 801594a4 <memset_partial+48/6c>
Trace; 801593c0 <memset+0/1c>
Trace; 80085468 <setup_irq+134/1b0>
Trace; 80085480 <setup_irq+14c/1b0>
Trace; 8019c624 <pcibios_set_master+8c/9c>
Trace; 8019c610 <pcibios_set_master+78/9c>
Trace; c001b570 <__crc_bio_map_user+64b64/130ac7>
Trace; 80084bec <request_irq+a8/e4>
Trace; 8015bff8 <pci_set_master+54/64>
Trace; 800ce3ec <kmem_cache_alloc+0/98>
Trace; 800ce3ec <kmem_cache_alloc+0/98>
Trace; c001bc24 <__crc_bio_map_user+65218/130ac7>
Trace; 80126eb8 <sysfs_create+7c/d0>
Trace; 8015d338 <pci_device_probe_static+50/80>
Trace; c001b544 <__crc_bio_map_user+64b38/130ac7>
Trace; 801780e0 <get_device+20/34>
Trace; 8015d3a0 <__pci_device_probe+38/70>
Trace; 8015d7b4 <pci_dev_get+20/38>
Trace; 8015d408 <pci_device_probe+30/5c>
Trace; 80153bf4 <create_dir+3c/68>
Trace; 80178eb0 <bus_match+4c/84>
Trace; 80154140 <kobject_add+9c/fc>
Trace; 80154018 <kobject_init+3c/5c>
Trace; 80154258 <kobject_set_name+50/104>
Trace; 80178fec <driver_attach+50/9c>
Trace; 80179284 <bus_add_driver+84/b0>
Trace; 80179608 <driver_register+34/40>
Trace; 800a83e4 <printk+210/280>
Trace; 800a8264 <printk+90/280>
Trace; 8015d684 <pci_register_driver+70/a0>
Trace; 800a81d4 <printk+0/280>
Trace; c001c298 <__crc_bio_map_user+6588c/130ac7>
Trace; c001c288 <__crc_bio_map_user+6587c/130ac7>
Trace; c002a020 <__crc_bio_map_user+73614/130ac7>
Trace; 800c2b98 <sys_init_module+2bc/4f0>
Trace; 800c2b40 <sys_init_module+264/4f0>
Trace; 800e7ef0 <sys_close+d4/120>
Trace; 8008be88 <stack_done+24/40>
Trace; c001b570 <__crc_bio_map_user+64b64/130ac7>


2 warnings and 1 error issued.  Results may not be reliable.


cheers,
Kieran.

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAo77jOWPbH1PXZ18RAliUAKCf7R6z2KQJlCwvjaM6xG7xdvGwKgCfcTdz
qGwaNbSb/g4YqBi+6RUTNb0=
=Bxg6
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
