Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Mar 2008 20:27:55 +0000 (GMT)
Received: from host194-211-dynamic.20-79-r.retail.telecomitalia.it ([79.20.211.194]:53904
	"EHLO eppesuigoccas.homedns.org") by ftp.linux-mips.org with ESMTP
	id S20026298AbYCPU1x (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 16 Mar 2008 20:27:53 +0000
Received: from casa ([192.168.2.34])
	by eppesuigoccas.homedns.org with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.63)
	(envelope-from <giuseppe@eppesuigoccas.homedns.org>)
	id 1JazSJ-0002Gd-Hg
	for linux-mips@linux-mips.org; Sun, 16 Mar 2008 21:27:45 +0100
Subject: Compiler error? [was: Re: new kernel oops in recent kernels]
From:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
To:	linux-mips@linux-mips.org
In-Reply-To: <1205664563.3050.4.camel@localhost>
References: <1205664563.3050.4.camel@localhost>
Content-Type: text/plain
Date:	Sun, 16 Mar 2008 21:27:37 +0100
Message-Id: <1205699257.4159.14.camel@casa>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Return-Path: <giuseppe@eppesuigoccas.homedns.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giuseppe@eppesuigoccas.homedns.org
Precedence: bulk
X-list: linux-mips

Hi all,
the Oops I reported earlier today, may be related to a problem of the
GNU C compiler, but I do not know MIPS assembly, so I ask for help.

Call Trace of the original oops:

> [<ffffffff802460b0>] sr_drive_status+0x50/0xe8
> [<ffffffff8024bb84>] cdrom_ioctl+0x5f4/0x1208
> [<ffffffff80245c6c>] sr_block_ioctl+0x64/0xe8
> [<ffffffff801ad8bc>] compat_blkdev_ioctl+0x7cc/0x18e0
> [<ffffffff800d1870>] do_open+0x98/0x310
> [<ffffffff800d1d60>] blkdev_open+0x0/0xc0
> [<ffffffff800d1da8>] blkdev_open+0x48/0xc0
> [<ffffffff8009c444>] __dentry_open+0x114/0x2e0
> [<ffffffff8009c740>] do_filp_open+0x48/0x58
> [<ffffffff8009c740>] do_filp_open+0x48/0x58
> [<ffffffff800def8c>] compat_sys_ioctl+0xf4/0x440
> [<ffffffff80019154>] handle_sys+0x114/0x130
> [<ffffffff8001fcf3>] fpu_emulator_cop1Handler+0x362/0x2270

sr_drive_status+0x50 is, in decimal, sr_drive_status+80
The gdb disassable the code as this:

(gdb) disassemble sr_drive_status+0x50
Dump of assembler code for function sr_drive_status:
0xffffffff80246060 <sr_drive_status+0>: daddiu  sp,sp,-32
0xffffffff80246064 <sr_drive_status+4>: lui     v0,0x7fff
0xffffffff80246068 <sr_drive_status+8>: sd      s0,16(sp)
0xffffffff8024606c <sr_drive_status+12>:        sd      ra,24(sp)
0xffffffff80246070 <sr_drive_status+16>:        ori     v0,v0,0xffff
0xffffffff80246074 <sr_drive_status+20>:        move    s0,a0
0xffffffff80246078 <sr_drive_status+24>:        bne     a1,v0,0xffffffff802460e8 <sr_drive_status+136>
0xffffffff8024607c <sr_drive_status+28>:        ld      v1,24(a0)
0xffffffff80246080 <sr_drive_status+32>:        ld      a0,16(v1)
0xffffffff80246084 <sr_drive_status+36>:        jal     0xffffffff80244c70 <sr_test_unit_ready>
0xffffffff80246088 <sr_drive_status+40>:        daddiu  a1,sp,4
0xffffffff8024608c <sr_drive_status+44>:        bnez    v0,0xffffffff802460a8 <sr_drive_status+72>
0xffffffff80246090 <sr_drive_status+48>:        move    a0,s0
0xffffffff80246094 <sr_drive_status+52>:        li      v0,4
0xffffffff80246098 <sr_drive_status+56>:        ld      ra,24(sp)
0xffffffff8024609c <sr_drive_status+60>:        ld      s0,16(sp)
0xffffffff802460a0 <sr_drive_status+64>:        jr      ra
0xffffffff802460a4 <sr_drive_status+68>:        daddiu  sp,sp,32
0xffffffff802460a8 <sr_drive_status+72>:        jal     0xffffffff8024c838 <cdrom_get_media_event>
0xffffffff802460ac <sr_drive_status+76>:        move    a1,sp
0xffffffff802460b0 <sr_drive_status+80>:        bnez    v0,0xffffffff802460fc <sr_drive_status+156>
0xffffffff802460b4 <sr_drive_status+84>:        lhu     v0,0(sp)
0xffffffff802460b8 <sr_drive_status+88>:        sll     v0,v0,0x0
0xffffffff802460bc <sr_drive_status+92>:        andi    v0,v0,0xff
0xffffffff802460c0 <sr_drive_status+96>:        andi    v1,v0,0x2
0xffffffff802460c4 <sr_drive_status+100>:       bnez    v1,0xffffffff80246094 <sr_drive_status+52>
0xffffffff802460c8 <sr_drive_status+104>:       andi    v0,v0,0x1
0xffffffff802460cc <sr_drive_status+108>:       beqz    v0,0xffffffff80246098 <sr_drive_status+56>
0xffffffff802460d0 <sr_drive_status+112>:       li      v0,1
0xffffffff802460d4 <sr_drive_status+116>:       ld      ra,24(sp)

then, I changed the code in sr_drive_status, adding the printk line, as
shown below:

int sr_drive_status(struct cdrom_device_info *cdi, int slot)
{
        struct scsi_cd *cd = cdi->handle;
        struct scsi_sense_hdr sshdr;
        struct media_event_desc med;

        if (CDSL_CURRENT != slot) {
                /* we have no changer support */
                return -EINVAL;
        }
        if (0 == sr_test_unit_ready(cd->device, &sshdr))
                return CDS_DISC_OK;

printk(KERN_INFO "sr_drive_status() cdi=0x%p, cd=0x%p\n", cdi, cd);

        if (!cdrom_get_media_event(cdi, &med)) {
                if (med.media_present)
                        return CDS_DISC_OK;
[...]

and now, I cannot reproduce any oops.

The new assembly code is:

0xffffffff80246060 <sr_drive_status+0>: daddiu  sp,sp,-48
0xffffffff80246064 <sr_drive_status+4>: lui     v0,0x7fff
0xffffffff80246068 <sr_drive_status+8>: sd      s0,16(sp)
0xffffffff8024606c <sr_drive_status+12>:        sd      ra,32(sp)
0xffffffff80246070 <sr_drive_status+16>:        sd      s1,24(sp)
0xffffffff80246074 <sr_drive_status+20>:        ori     v0,v0,0xffff
0xffffffff80246078 <sr_drive_status+24>:        move    s0,a0
0xffffffff8024607c <sr_drive_status+28>:        bne     a1,v0,0xffffffff80246108 <sr_drive_status+168>
0xffffffff80246080 <sr_drive_status+32>:        ld      s1,24(a0)
0xffffffff80246084 <sr_drive_status+36>:        ld      a0,16(s1)
0xffffffff80246088 <sr_drive_status+40>:        jal     0xffffffff80244c70 <sr_test_unit_ready>
0xffffffff8024608c <sr_drive_status+44>:        daddiu  a1,sp,4
0xffffffff80246090 <sr_drive_status+48>:        bnez    v0,0xffffffff802460b0 <sr_drive_status+80>
0xffffffff80246094 <sr_drive_status+52>:        lui     a0,0x803c
0xffffffff80246098 <sr_drive_status+56>:        li      v0,4
0xffffffff8024609c <sr_drive_status+60>:        ld      ra,32(sp)
0xffffffff802460a0 <sr_drive_status+64>:        ld      s1,24(sp)
0xffffffff802460a4 <sr_drive_status+68>:        ld      s0,16(sp)
0xffffffff802460a8 <sr_drive_status+72>:        jr      ra
0xffffffff802460ac <sr_drive_status+76>:        daddiu  sp,sp,48
0xffffffff802460b0 <sr_drive_status+80>:        daddiu  a0,a0,-4560
0xffffffff802460b4 <sr_drive_status+84>:        move    a1,s0
0xffffffff802460b8 <sr_drive_status+88>:        jal     0xffffffff80032ba8 <printk>
0xffffffff802460bc <sr_drive_status+92>:        move    a2,s1
0xffffffff802460c0 <sr_drive_status+96>:        move    a0,s0
0xffffffff802460c4 <sr_drive_status+100>:       jal     0xffffffff8024c858 <cdrom_get_media_event>
0xffffffff802460c8 <sr_drive_status+104>:       move    a1,sp
0xffffffff802460cc <sr_drive_status+108>:       bnez    v0,0xffffffff80246120 <sr_drive_status+192>
0xffffffff802460d0 <sr_drive_status+112>:       lhu     v0,0(sp)

the gcc I am using in versione 4.1.2. Any help is really appreciated.

Thanks,
Giuseppe
