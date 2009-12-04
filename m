Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 14:42:55 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:36700 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492335AbZLDNmv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2009 14:42:51 +0100
Received: by pwi18 with SMTP id 18so1061535pwi.24
        for <multiple recipients>; Fri, 04 Dec 2009 05:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        bh=/yZGfbXHp+yR+SloRTBHYK8tM1LOKZlpYl4X/L4X3Tw=;
        b=EKOykCQXOs1oHHKeUW+QLL6sounVk0IbpLfN75vtEF/amxlY7U0mOHsubHYmTpKPgn
         0N8SuOFqslitPjbx4nnq9oYnpSAO2o19DgZExH59346M/WNbGHwe+L7oRgFpSAquwkcc
         cr846o+BtBJjymU+8sH2QM9qt2wg71R4nWTxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        b=cgIfse2D2UiiYJzlUwovAAqw8RFU3UrJA9E/+ONXwcFM7yRJispriTpZaGlFRH/CPo
         gOIS1C6X+jzafkSBmA381F3Uy3JyZ4RGy1hy4xoUFMtj40bDPiEo/Qlh56JITAcQI3Gf
         v3w9+LgFH5C2VOKVXxMTG48RDuPV0ayN+GZxw=
Received: by 10.114.187.20 with SMTP id k20mr3971344waf.213.1259934164446;
        Fri, 04 Dec 2009 05:42:44 -0800 (PST)
Received: from ?192.168.1.100? ([118.132.131.118])
        by mx.google.com with ESMTPS id 22sm954020pxi.10.2009.12.04.05.42.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Dec 2009 05:42:43 -0800 (PST)
Subject: is it some issue about HIGHMEM for mips32?
From:   "Figo.zhang" <figo1802@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 04 Dec 2009 21:44:59 +0800
Message-ID: <1259934299.2070.3.camel@myhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.1 
Content-Transfer-Encoding: 7bit
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips



hi,
i am using 24KC soc, and linux2.6.21.5 kernel and set CONFIG_HIGHMEM
enable. if my realy physic RAM is not more than HIGHMEM, such as only
32MB, it is some issue about kernel, i dont know how to fix it? I try
linux-2.6.31.4, it is no this issue, is it some change , how to fix it?
 
here is my kernel log:
Linux version 2.6.21.5 (figo@myhost) (gcc version 4.1.2) #22 Fri Dec 4
10:33:25 CST 2009
CPU revision is: 00019655
Determined physical RAM map:
memory: start:0x0,size=0x2000000,type=0x1
(usable)
User-defined physical RAM map:
memory: start:0x0,size=0x2000000,type=0x1
(usable)
Initrd not found or empty - disabling initrd
Built 1 zonelists.  Total pages: 8128
Kernel command line: console=ttyS0,115200 rdinit=/linuxrc mem=32M nofpu
mac=00:aa:aa:bb:bb:99
Updated MAC address from u-boot: 8024ff24M
Primary instruction cache 32kB, physically tagged, 4-way, linesize 32
bytes.
Primary data cache 32kB, 4-way, linesize 32 bytes.
Synthesized TLB refill handler (20 instructions).
Synthesized TLB load handler fastpath (32 instructions).
Synthesized TLB store handler fastpath (32 instructions).
Synthesized TLB modify handler fastpath (31 instructions).
Cache parity protection disabled
arch/mips/mach-opulan/optrann/irq.c,arch_init_irq
PID hash table entries: 128 (order: 7, 512 bytes)
Using 150.000 MHz high precision timer.
arch/mips/mach-opulan/optrann/time.c,plat_timer_setup
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 29012k/32768k available (1798k kernel code, 3756k reserved, 369k
data, 900k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
Generic PHY: Registered new driver
Time: MIPS clocksource has been installed.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: optrann serial driver $Revision: 1.0
uart_register_driver finished
ttyS0 at MMIO map 0xbf004000 mem 0xbf004000 (irq = 23) is a UART 0
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
optrann_fe_ether Ethernet driver, V1.00
FE:dmac_regs =0xbf014000,msg_regs=0xbf028000, irq=26
FE MAC: 00:aa:aa:bb:bb:99
TCP cubic registered
Freeing unused kernel memory: 900k freed
ramdisk_execute_command=/linuxrc, execute_command=<NULL>
Bad pte = 0135c79f, process = linuxrc, vm_flags = 100073, vaddr =
2aaae000
Call Trace:
[<80048d70>] dump_stack+0x8/0x34
[<8009ebb0>] vm_normal_page+0x68/0x90
[<8009f850>] unmap_vmas+0x1e8/0x5e8
[<800a3428>] unmap_region+0x9c/0x184
[<800a4268>] do_munmap+0x1b0/0x25c
[<800a4358>] sys_munmap+0x44/0x70
[<8004af40>] stack_done+0x20/0x3c
Bad pte = 0135e79f, process = linuxrc, vm_flags = 100073, vaddr =
2aaae000
Call Trace:
[<80048d70>] dump_stack+0x8/0x34
[<8009ebb0>] vm_normal_page+0x68/0x90
[<8009f850>] unmap_vmas+0x1e8/0x5e8
[<800a3428>] unmap_region+0x9c/0x184
[<800a4268>] do_munmap+0x1b0/0x25c
[<800a4358>] sys_munmap+0x44/0x70
[<8004af40>] stack_done+0x20/0x3c
Bad pte = 0026079f, process = linuxrc, vm_flags = 100073, vaddr =
2aaae000
Call Trace:
[<80048d70>] dump_stack+0x8/0x34
[<8009ebb0>] vm_normal_page+0x68/0x90
[<8009f850>] unmap_vmas+0x1e8/0x5e8
[<800a3428>] unmap_region+0x9c/0x184
[<800a4268>] do_munmap+0x1b0/0x25c
[<800a4358>] sys_munmap+0x44/0x70
[<8004af40>] stack_done+0x20/0x3c
 
.........
 
 
Best,
Figo.zhang
