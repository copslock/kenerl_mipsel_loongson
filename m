Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1O1ndt15539
	for linux-mips-outgoing; Sat, 23 Feb 2002 17:49:39 -0800
Received: from dea.linux-mips.net (a1as19-p83.stg.tli.de [195.252.194.83])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1O1lY915520
	for <linux-mips@oss.sgi.com>; Sat, 23 Feb 2002 17:47:34 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g1O0lLr31788
	for linux-mips@oss.sgi.com; Sun, 24 Feb 2002 01:47:21 +0100
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1N2vA929838
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 18:57:10 -0800
Received: from beagle (beagle.internal.momenco.com [192.168.0.115])
	by host099.momenco.com (8.11.6/8.11.6) with SMTP id g1N1v8R05204
	for <linux-mips@oss.sgi.com>; Fri, 22 Feb 2002 17:57:08 -0800
From: "Matthew Dharm" <mdharm@momenco.com>
To: "Linux-MIPS" <linux-mips@oss.sgi.com>
Subject: Is this a toolchain bug?
Date: Fri, 22 Feb 2002 17:57:08 -0800
Message-ID: <NEBBLJGMNKKEEMNLHGAICELKCFAA.mdharm@momenco.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002F_01C1BBCA.589767F0"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.

------=_NextPart_000_002F_01C1BBCA.589767F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I'm trying to get the e1000 driver working on my MIPS target... I've
managed to hack it a bit so it works, but at least one of these hacks
looks like a workaround for a toolchain bug.

Attached to this message is the mixed-mode (source and assembly) dump
of one of the driver files.

Specifically, look at the code dealing with the variable
e1000_proc_dir; here is one example:

    if(e1000_proc_dir == NULL)
     53c:       3c020000        lui     v0,0x0
     540:       8c420000        lw      v0,0(v0)
     544:       1440000d        bnez    v0,57c <e1000_probe+0x44c>
     548:       00000000        nop

Is it me, or is that wrong?  load-upper-immediate with zero, then
load-word from that address?  Clearly, v0 is _supposed_ to contain the
value of e1000_proc_dir based on the branch-compare instruction....
but this code just crashes.

In fact, all the references to e1000_proc_dir seem to use the same
lui/lw pair of instructions.

For reference e1000_proc_dir is an extern struct pointer.  No compiler
warnings about it.

Before anyone asks, the assembly doesn't change when linked against
the code that actually declares the variable.

The toolchain I'm using is the one from oss.sgi.com by H.J. Liu
(toolchain-20011020-1).  Because of the way the e1000 driver Makefile
works, I'm actually compiling it using the native compiler on-target.

Full source code available on request (I don't want to spam the list),
or directly from Intel.  I'm using kernel 2.4.17 from CVS (plus the
patch I sent yesterday) with e1000 driver version 4.0.7

If this is user-error, I'd love to know what I'm doing wrong.  If this
is a toolchain bug, who do I report this to?

Matt

--
Matthew D. Dharm                            Senior Software Designer
Momentum Computer Inc.                      1815 Aston Ave.  Suite 107
(760) 431-8663 X-115                        Carlsbad, CA 92008-7310
Momentum Works For You                      www.momenco.com

------=_NextPart_000_002F_01C1BBCA.589767F0
Content-Type: application/octet-stream;
	name="e1000_main.dis"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="e1000_main.dis"

=0A=
e1000_main.o:     file format elf32-tradbigmips=0A=
=0A=
Disassembly of section .text:=0A=
=0A=
00000000 <e1000_init_module>:=0A=
       0:	27bdffe8 	addiu	sp,sp,-24=0A=
       4:	afb00010 	sw	s0,16(sp)=0A=
       8:	afbf0014 	sw	ra,20(sp)=0A=
    E1000_DBG("e1000_init_module\n");=0A=
=0A=
    /* Print the driver ID string and copyright notice */=0A=
=0A=
    printk("%s - version %s\n%s\n", e1000_driver_string, =
e1000_driver_version,=0A=
       c:	3c040000 	lui	a0,0x0=0A=
      10:	24840158 	addiu	a0,a0,344=0A=
      14:	3c050000 	lui	a1,0x0=0A=
      18:	24a50000 	addiu	a1,a1,0=0A=
      1c:	3c060000 	lui	a2,0x0=0A=
      20:	24c60000 	addiu	a2,a2,0=0A=
      24:	3c070000 	lui	a3,0x0=0A=
      28:	24e70000 	addiu	a3,a3,0=0A=
      2c:	3c020000 	lui	v0,0x0=0A=
      30:	24420000 	addiu	v0,v0,0=0A=
      34:	0040f809 	jalr	v0=0A=
      38:	00000000 	nop=0A=
 * This MUST stay in a header, as it checks for -DMODULE=0A=
 */=0A=
static inline int pci_module_init(struct pci_driver *drv)=0A=
{=0A=
	int rc =3D pci_register_driver (drv);=0A=
      3c:	3c040000 	lui	a0,0x0=0A=
      40:	24840288 	addiu	a0,a0,648=0A=
      44:	3c020000 	lui	v0,0x0=0A=
      48:	24420000 	addiu	v0,v0,0=0A=
      4c:	0040f809 	jalr	v0=0A=
      50:	00000000 	nop=0A=
      54:	00408021 	move	s0,v0=0A=
=0A=
	if (rc > 0)=0A=
		return 0;=0A=
=0A=
	/* iff CONFIG_HOTPLUG and built into kernel, we should=0A=
	 * leave the driver around for future hotplug events.=0A=
	 * For the module case, a hotplug daemon of some sort=0A=
	 * should load a module in response to an insert event. */=0A=
#if defined(CONFIG_HOTPLUG) && !defined(MODULE)=0A=
	if (rc =3D=3D 0)=0A=
		return 0;=0A=
#else=0A=
	if (rc =3D=3D 0)=0A=
		rc =3D -ENODEV;		=0A=
#endif=0A=
=0A=
	/* if we get here, we need to clean up pci driver instance=0A=
	 * and return some sort of error */=0A=
	pci_unregister_driver (drv);=0A=
      58:	3c040000 	lui	a0,0x0=0A=
      5c:	24840288 	addiu	a0,a0,648=0A=
      60:	3c030000 	lui	v1,0x0=0A=
      64:	24630000 	addiu	v1,v1,0=0A=
      68:	1e000006 	bgtz	s0,84 <e1000_init_module+0x84>=0A=
      6c:	00001021 	move	v0,zero=0A=
      70:	52000001 	beqzl	s0,78 <e1000_init_module+0x78>=0A=
      74:	2410ffed 	li	s0,-19=0A=
      78:	0060f809 	jalr	v1=0A=
      7c:	00000000 	nop=0A=
	=0A=
	return rc;=0A=
      80:	02001021 	move	v0,s0=0A=
           e1000_copyright);=0A=
=0A=
    /* register the driver with the PCI subsystem */=0A=
=0A=
    return pci_module_init(&e1000_driver);=0A=
      84:	8fbf0014 	lw	ra,20(sp)=0A=
      88:	8fb00010 	lw	s0,16(sp)=0A=
      8c:	03e00008 	jr	ra=0A=
      90:	27bd0018 	addiu	sp,sp,24=0A=
=0A=
00000094 <cleanup_module>:=0A=
      94:	27bdffe8 	addiu	sp,sp,-24=0A=
}=0A=
=0A=
/* this macro creates a special symbol in the object file that=0A=
 * identifies the driver initialization routine=0A=
 */=0A=
module_init(e1000_init_module);=0A=
=0A=
/**=0A=
 * e1000_exit_module - Driver Exit Cleanup Routine=0A=
 *=0A=
 * e1000_exit_module is called just before the driver is removed=0A=
 * from memory.=0A=
 **/=0A=
=0A=
void=0A=
e1000_exit_module()=0A=
{=0A=
#ifdef CONFIG_PROC_FS=0A=
    struct proc_dir_entry *de;=0A=
#endif=0A=
=0A=
    E1000_DBG("e1000_exit_module\n");=0A=
=0A=
    pci_unregister_driver(&e1000_driver);=0A=
      98:	3c020000 	lui	v0,0x0=0A=
      9c:	24420000 	addiu	v0,v0,0=0A=
      a0:	afbf0010 	sw	ra,16(sp)=0A=
      a4:	3c040000 	lui	a0,0x0=0A=
      a8:	24840288 	addiu	a0,a0,648=0A=
      ac:	0040f809 	jalr	v0=0A=
      b0:	00000000 	nop=0A=
=0A=
#ifdef CONFIG_PROC_FS=0A=
    /* if there is no e1000_proc_dir (proc creation failure on load)=0A=
     * then we're done=0A=
     */=0A=
    if(e1000_proc_dir =3D=3D NULL)=0A=
      b4:	3c020000 	lui	v0,0x0=0A=
      b8:	8c420000 	lw	v0,0(v0)=0A=
      bc:	1040001a 	beqz	v0,128 <cleanup_module+0x94>=0A=
      c0:	8fbf0010 	lw	ra,16(sp)=0A=
        return;=0A=
=0A=
    /* If ADAPTERS_PROC_DIR (/proc/net/PRO_LAN_Adapters) is empty=0A=
     * it can be removed now (might still be in use by e100)=0A=
     */=0A=
    for(de =3D e1000_proc_dir->subdir; de; de =3D de->next) {=0A=
      c4:	8c450034 	lw	a1,52(v0)=0A=
      c8:	10a0000e 	beqz	a1,104 <cleanup_module+0x70>=0A=
      cc:	2404002e 	li	a0,46=0A=
=0A=
        /* ignore . and .. */=0A=
=0A=
        if(*(de->name) =3D=3D '.')=0A=
      d0:	8ca20004 	lw	v0,4(a1)=0A=
      d4:	80430000 	lb	v1,0(v0)=0A=
      d8:	14640008 	bne	v1,a0,fc <cleanup_module+0x68>=0A=
      dc:	00000000 	nop=0A=
      e0:	8ca5002c 	lw	a1,44(a1)=0A=
      e4:	10a00007 	beqz	a1,104 <cleanup_module+0x70>=0A=
      e8:	00000000 	nop=0A=
      ec:	8ca20004 	lw	v0,4(a1)=0A=
      f0:	80430000 	lb	v1,0(v0)=0A=
      f4:	5064fffb 	beql	v1,a0,e4 <cleanup_module+0x50>=0A=
      f8:	8ca5002c 	lw	a1,44(a1)=0A=
            continue;=0A=
        break;=0A=
    }=0A=
    if(de)=0A=
      fc:	14a0000a 	bnez	a1,128 <cleanup_module+0x94>=0A=
     100:	8fbf0010 	lw	ra,16(sp)=0A=
        return;=0A=
    remove_proc_entry(ADAPTERS_PROC_DIR, proc_net);=0A=
     104:	3c050000 	lui	a1,0x0=0A=
     108:	8ca50000 	lw	a1,0(a1)=0A=
     10c:	3c040000 	lui	a0,0x0=0A=
     110:	2484016c 	addiu	a0,a0,364=0A=
     114:	3c020000 	lui	v0,0x0=0A=
     118:	24420000 	addiu	v0,v0,0=0A=
     11c:	0040f809 	jalr	v0=0A=
     120:	00000000 	nop=0A=
#endif=0A=
=0A=
    return;=0A=
}=0A=
     124:	8fbf0010 	lw	ra,16(sp)=0A=
     128:	03e00008 	jr	ra=0A=
     12c:	27bd0018 	addiu	sp,sp,24=0A=
=0A=
00000130 <e1000_probe>:=0A=
     130:	27bdffd0 	addiu	sp,sp,-48=0A=
     134:	afb30024 	sw	s3,36(sp)=0A=
     138:	afb00018 	sw	s0,24(sp)=0A=
     13c:	afbf0028 	sw	ra,40(sp)=0A=
     140:	afb20020 	sw	s2,32(sp)=0A=
     144:	afb1001c 	sw	s1,28(sp)=0A=
=0A=
/* this macro creates a special symbol in the object file that=0A=
 * identifies the driver cleanup routine=0A=
 */=0A=
module_exit(e1000_exit_module);=0A=
=0A=
/**=0A=
 * e1000_probe - Device Initialization Routine=0A=
 * @pdev: PCI device information struct=0A=
 * @ent: entry in e1000_pci_table=0A=
 *=0A=
 * Returns 0 on success, negative on failure=0A=
 *=0A=
 * e1000_probe initializes an adapter identified by a pci_dev=0A=
 * structure.  The OS initialization is handled here, and=0A=
 * e1000_sw_init and e1000_hw_init are called to handle the driver=0A=
 * specific software structures and hardware initialization=0A=
 * respectively.=0A=
 **/=0A=
=0A=
int=0A=
e1000_probe(struct pci_dev *pdev,=0A=
            const struct pci_device_id *ent)=0A=
{=0A=
    struct net_device *netdev =3D NULL;=0A=
    struct e1000_adapter *adapter;=0A=
    static int cards_found =3D 0;=0A=
=0A=
#ifdef CONFIG_PROC_FS=0A=
    int len;=0A=
#endif=0A=
=0A=
    E1000_DBG("e1000_probe\n");=0A=
=0A=
    /* Make sure the PCI device has the proper resources available */=0A=
=0A=
    if(pci_enable_device(pdev) !=3D 0) {=0A=
     148:	3c020000 	lui	v0,0x0=0A=
     14c:	24420000 	addiu	v0,v0,0=0A=
     150:	00808021 	move	s0,a0=0A=
     154:	0040f809 	jalr	v0=0A=
     158:	00a09821 	move	s3,a1=0A=
     15c:	10400005 	beqz	v0,174 <e1000_probe+0x44>=0A=
     160:	00000000 	nop=0A=
        E1000_ERR("pci_enable_device failed\n");=0A=
     164:	3c040000 	lui	a0,0x0=0A=
     168:	24840180 	addiu	a0,a0,384=0A=
        return -ENODEV;=0A=
     16c:	0800006b 	j	1ac <e1000_probe+0x7c>=0A=
     170:	00000000 	nop=0A=
    }=0A=
=0A=
    /* Make sure we are enabled as a bus mastering device */=0A=
=0A=
    pci_set_master(pdev);=0A=
     174:	3c020000 	lui	v0,0x0=0A=
     178:	24420000 	addiu	v0,v0,0=0A=
     17c:	0040f809 	jalr	v0=0A=
     180:	02002021 	move	a0,s0=0A=
=0A=
    /* Check to see if our PCI addressing needs are supported */=0A=
    if(pci_set_dma_mask(pdev, E1000_DMA_MASK) < 0) {=0A=
     184:	24060000 	li	a2,0=0A=
     188:	2407ffff 	li	a3,-1=0A=
     18c:	3c020000 	lui	v0,0x0=0A=
     190:	24420000 	addiu	v0,v0,0=0A=
     194:	0040f809 	jalr	v0=0A=
     198:	02002021 	move	a0,s0=0A=
     19c:	04410009 	bgez	v0,1c4 <e1000_probe+0x94>=0A=
     1a0:	00002021 	move	a0,zero=0A=
        E1000_ERR("PCI DMA not supported by the system\n");=0A=
     1a4:	3c040000 	lui	a0,0x0=0A=
     1a8:	248401a4 	addiu	a0,a0,420=0A=
     1ac:	3c020000 	lui	v0,0x0=0A=
     1b0:	24420000 	addiu	v0,v0,0=0A=
     1b4:	0040f809 	jalr	v0=0A=
     1b8:	00000000 	nop=0A=
        return -ENODEV;=0A=
     1bc:	0800018b 	j	62c <e1000_probe+0x4fc>=0A=
     1c0:	2402ffed 	li	v0,-19=0A=
    }=0A=
=0A=
    /* Register a new network interface + allocate=0A=
     * private data structure (struct e1000_adapter)=0A=
     */=0A=
    netdev =3D init_etherdev(netdev, sizeof(struct e1000_adapter));=0A=
     1c4:	3c020000 	lui	v0,0x0=0A=
     1c8:	24420000 	addiu	v0,v0,0=0A=
     1cc:	0040f809 	jalr	v0=0A=
     1d0:	240503b0 	li	a1,944=0A=
     1d4:	00409021 	move	s2,v0=0A=
    if(netdev =3D=3D NULL) {=0A=
     1d8:	56400009 	bnezl	s2,200 <e1000_probe+0xd0>=0A=
     1dc:	8e510064 	lw	s1,100(s2)=0A=
        E1000_ERR("Unable to allocate net_device struct\n");=0A=
     1e0:	3c040000 	lui	a0,0x0=0A=
     1e4:	248401d4 	addiu	a0,a0,468=0A=
     1e8:	3c020000 	lui	v0,0x0=0A=
     1ec:	24420000 	addiu	v0,v0,0=0A=
     1f0:	0040f809 	jalr	v0=0A=
     1f4:	00000000 	nop=0A=
        return -ENOMEM;=0A=
     1f8:	0800018b 	j	62c <e1000_probe+0x4fc>=0A=
     1fc:	2402fff4 	li	v0,-12=0A=
    }=0A=
=0A=
    /* Calling init_etherdev with sizeof(struct e1000_adapter) allocates=0A=
     * a single buffer of size net_device + struct e1000_adapter +=0A=
     * alignment. If this is not done then the struct e1000_adapter needs=0A=
     * to be allocated and freed separately.=0A=
     */=0A=
    adapter =3D (struct e1000_adapter *) netdev->priv;=0A=
    memset(adapter, 0, sizeof(struct e1000_adapter));=0A=
     200:	00002821 	move	a1,zero=0A=
     204:	240603b0 	li	a2,944=0A=
     208:	3c020000 	lui	v0,0x0=0A=
     20c:	24420000 	addiu	v0,v0,0=0A=
     210:	0040f809 	jalr	v0=0A=
     214:	02202021 	move	a0,s1=0A=
    adapter->netdev =3D netdev;=0A=
    adapter->pdev =3D pdev;=0A=
     218:	ae30014c 	sw	s0,332(s1)=0A=
     21c:	ae320148 	sw	s2,328(s1)=0A=
=0A=
    /* link the struct e1000_adapter into the list */=0A=
=0A=
    if(e1000_adapter_list !=3D NULL)=0A=
     220:	3c020000 	lui	v0,0x0=0A=
     224:	8c420000 	lw	v0,0(v0)=0A=
     228:	50400005 	beqzl	v0,240 <e1000_probe+0x110>=0A=
     22c:	ae220000 	sw	v0,0(s1)=0A=
        e1000_adapter_list->prev =3D adapter;=0A=
     230:	ac510004 	sw	s1,4(v0)=0A=
     234:	3c020000 	lui	v0,0x0=0A=
     238:	8c420000 	lw	v0,0(v0)=0A=
    adapter->next =3D e1000_adapter_list;=0A=
     23c:	ae220000 	sw	v0,0(s1)=0A=
    e1000_adapter_list =3D adapter;=0A=
     240:	3c010000 	lui	at,0x0=0A=
     244:	ac310000 	sw	s1,0(at)=0A=
    adapter->shared.back =3D (void *) adapter;=0A=
     248:	ae310014 	sw	s1,20(s1)=0A=
=0A=
    /* reserve the MMIO region as ours */=0A=
=0A=
    if(!request_mem_region=0A=
     24c:	8e030064 	lw	v1,100(s0)=0A=
     250:	14600005 	bnez	v1,268 <e1000_probe+0x138>=0A=
     254:	8e020068 	lw	v0,104(s0)=0A=
     258:	10400005 	beqz	v0,270 <e1000_probe+0x140>=0A=
     25c:	00003021 	move	a2,zero=0A=
     260:	0800009b 	j	26c <e1000_probe+0x13c>=0A=
     264:	00431023 	subu	v0,v0,v1=0A=
     268:	00431023 	subu	v0,v0,v1=0A=
     26c:	24460001 	addiu	a2,v0,1=0A=
     270:	3c070000 	lui	a3,0x0=0A=
     274:	24e70000 	addiu	a3,a3,0=0A=
     278:	3c040000 	lui	a0,0x0=0A=
     27c:	24840000 	addiu	a0,a0,0=0A=
     280:	3c020000 	lui	v0,0x0=0A=
     284:	24420000 	addiu	v0,v0,0=0A=
     288:	0040f809 	jalr	v0=0A=
     28c:	8e050064 	lw	a1,100(s0)=0A=
     290:	54400009 	bnezl	v0,2b8 <e1000_probe+0x188>=0A=
     294:	8e040064 	lw	a0,100(s0)=0A=
       (pci_resource_start(pdev, BAR_0), pci_resource_len(pdev, BAR_0),=0A=
        e1000_driver_name)) {=0A=
        E1000_ERR("request_mem_region failed\n");=0A=
     298:	3c040000 	lui	a0,0x0=0A=
     29c:	24840204 	addiu	a0,a0,516=0A=
     2a0:	3c020000 	lui	v0,0x0=0A=
     2a4:	24420000 	addiu	v0,v0,0=0A=
     2a8:	0040f809 	jalr	v0=0A=
     2ac:	00000000 	nop=0A=
        e1000_remove(pdev);=0A=
        return -ENODEV;=0A=
     2b0:	08000121 	j	484 <e1000_probe+0x354>=0A=
     2b4:	00000000 	nop=0A=
    }=0A=
=0A=
    /* map the MMIO region into the kernel virtual address space */=0A=
=0A=
    adapter->shared.hw_addr =3D=0A=
     2b8:	14800005 	bnez	a0,2d0 <e1000_probe+0x1a0>=0A=
     2bc:	8e020068 	lw	v0,104(s0)=0A=
     2c0:	10400005 	beqz	v0,2d8 <e1000_probe+0x1a8>=0A=
     2c4:	00002821 	move	a1,zero=0A=
     2c8:	080000b5 	j	2d4 <e1000_probe+0x1a4>=0A=
     2cc:	00441023 	subu	v0,v0,a0=0A=
     2d0:	00441023 	subu	v0,v0,a0=0A=
     2d4:	24450001 	addiu	a1,v0,1=0A=
extern void * __ioremap(phys_t offset, phys_t size, unsigned long flags);=0A=
=0A=
static inline void *ioremap(phys_t offset, unsigned long size)=0A=
{=0A=
	return __ioremap(offset, size, _CACHE_UNCACHED);=0A=
     2d8:	3c020000 	lui	v0,0x0=0A=
     2dc:	24420000 	addiu	v0,v0,0=0A=
     2e0:	0040f809 	jalr	v0=0A=
     2e4:	24060400 	li	a2,1024=0A=
        ioremap(pci_resource_start(pdev, BAR_0), pci_resource_len(pdev, =
BAR_0));=0A=
=0A=
    if(adapter->shared.hw_addr =3D=3D NULL) {=0A=
     2e8:	1440001c 	bnez	v0,35c <e1000_probe+0x22c>=0A=
     2ec:	ae220008 	sw	v0,8(s1)=0A=
        E1000_ERR("ioremap failed\n");=0A=
     2f0:	3c040000 	lui	a0,0x0=0A=
     2f4:	2484022c 	addiu	a0,a0,556=0A=
     2f8:	3c020000 	lui	v0,0x0=0A=
     2fc:	24420000 	addiu	v0,v0,0=0A=
     300:	0040f809 	jalr	v0=0A=
     304:	00000000 	nop=0A=
        release_mem_region(pci_resource_start(pdev, BAR_0),=0A=
     308:	8e030064 	lw	v1,100(s0)=0A=
     30c:	14600005 	bnez	v1,324 <e1000_probe+0x1f4>=0A=
     310:	8e020068 	lw	v0,104(s0)=0A=
     314:	10400005 	beqz	v0,32c <e1000_probe+0x1fc>=0A=
     318:	00003021 	move	a2,zero=0A=
     31c:	080000ca 	j	328 <e1000_probe+0x1f8>=0A=
     320:	00431023 	subu	v0,v0,v1=0A=
     324:	00431023 	subu	v0,v0,v1=0A=
     328:	24460001 	addiu	a2,v0,1=0A=
     32c:	3c040000 	lui	a0,0x0=0A=
     330:	24840000 	addiu	a0,a0,0=0A=
     334:	3c020000 	lui	v0,0x0=0A=
     338:	24420000 	addiu	v0,v0,0=0A=
     33c:	0040f809 	jalr	v0=0A=
     340:	8e050064 	lw	a1,100(s0)=0A=
                           pci_resource_len(pdev, BAR_0));=0A=
        e1000_remove(pdev);=0A=
     344:	3c020000 	lui	v0,0x0=0A=
     348:	24420000 	addiu	v0,v0,0=0A=
     34c:	0040f809 	jalr	v0=0A=
     350:	02002021 	move	a0,s0=0A=
        return -ENOMEM;=0A=
     354:	0800018b 	j	62c <e1000_probe+0x4fc>=0A=
     358:	2402fff4 	li	v0,-12=0A=
    }=0A=
=0A=
    /* don't actually register the interrupt handler until e1000_open */=0A=
=0A=
    netdev->irq =3D pdev->irq;=0A=
     35c:	8e02005c 	lw	v0,92(s0)=0A=
     360:	ae420024 	sw	v0,36(s2)=0A=
=0A=
    /* Set the MMIO base address for the NIC */=0A=
=0A=
#ifdef IANS=0A=
    netdev->base_addr =3D pci_resource_start(pdev, BAR_0);=0A=
#endif=0A=
    netdev->mem_start =3D pci_resource_start(pdev, BAR_0);=0A=
     364:	8e030064 	lw	v1,100(s0)=0A=
     368:	ae43001c 	sw	v1,28(s2)=0A=
    netdev->mem_end =3D netdev->mem_start + pci_resource_len(pdev, =
BAR_0);=0A=
     36c:	8e040064 	lw	a0,100(s0)=0A=
     370:	14800005 	bnez	a0,388 <e1000_probe+0x258>=0A=
     374:	8e020068 	lw	v0,104(s0)=0A=
     378:	10400006 	beqz	v0,394 <e1000_probe+0x264>=0A=
     37c:	00605021 	move	t2,v1=0A=
     380:	080000e3 	j	38c <e1000_probe+0x25c>=0A=
     384:	00441023 	subu	v0,v0,a0=0A=
     388:	00441023 	subu	v0,v0,a0=0A=
     38c:	00621021 	addu	v0,v1,v0=0A=
     390:	244a0001 	addiu	t2,v0,1=0A=
=0A=
    /* set up function pointers to driver entry points */=0A=
=0A=
    netdev->open =3D &e1000_open;=0A=
    netdev->stop =3D &e1000_close;=0A=
    netdev->hard_start_xmit =3D &e1000_xmit_frame;=0A=
    netdev->get_stats =3D &e1000_get_stats;=0A=
    netdev->set_multicast_list =3D &e1000_set_multi;=0A=
    netdev->set_mac_address =3D &e1000_set_mac;=0A=
     394:	3c070000 	lui	a3,0x0=0A=
     398:	24e70000 	addiu	a3,a3,0=0A=
    netdev->change_mtu =3D &e1000_change_mtu;=0A=
     39c:	3c080000 	lui	t0,0x0=0A=
     3a0:	25080000 	addiu	t0,t0,0=0A=
    netdev->do_ioctl =3D &e1000_ioctl;=0A=
     3a4:	3c090000 	lui	t1,0x0=0A=
     3a8:	25290000 	addiu	t1,t1,0=0A=
     3ac:	3c020000 	lui	v0,0x0=0A=
     3b0:	24420000 	addiu	v0,v0,0=0A=
     3b4:	3c030000 	lui	v1,0x0=0A=
     3b8:	24630000 	addiu	v1,v1,0=0A=
     3bc:	3c040000 	lui	a0,0x0=0A=
     3c0:	24840000 	addiu	a0,a0,0=0A=
     3c4:	3c050000 	lui	a1,0x0=0A=
     3c8:	24a50000 	addiu	a1,a1,0=0A=
     3cc:	3c060000 	lui	a2,0x0=0A=
     3d0:	24c60000 	addiu	a2,a2,0=0A=
     3d4:	ae4a0018 	sw	t2,24(s2)=0A=
     3d8:	ae470108 	sw	a3,264(s2)=0A=
     3dc:	ae48011c 	sw	t0,284(s2)=0A=
     3e0:	ae49010c 	sw	t1,268(s2)=0A=
     3e4:	ae4400f8 	sw	a0,248(s2)=0A=
     3e8:	ae450044 	sw	a1,68(s2)=0A=
     3ec:	ae4200f0 	sw	v0,240(s2)=0A=
     3f0:	ae4300f4 	sw	v1,244(s2)=0A=
     3f4:	ae460104 	sw	a2,260(s2)=0A=
=0A=
    /* set up the struct e1000_adapter */=0A=
=0A=
    adapter->bd_number =3D cards_found;=0A=
     3f8:	3c020000 	lui	v0,0x0=0A=
     3fc:	8c42043c 	lw	v0,1084(v0)=0A=
    adapter->id_string =3D e1000_strings[ent->driver_data];=0A=
    printk("\n%s\n", adapter->id_string);=0A=
     400:	3c040000 	lui	a0,0x0=0A=
     404:	24840248 	addiu	a0,a0,584=0A=
     408:	ae220090 	sw	v0,144(s1)=0A=
     40c:	8e630018 	lw	v1,24(s3)=0A=
     410:	3c020000 	lui	v0,0x0=0A=
     414:	24420000 	addiu	v0,v0,0=0A=
     418:	00031880 	sll	v1,v1,0x2=0A=
     41c:	3c060000 	lui	a2,0x0=0A=
     420:	00c33021 	addu	a2,a2,v1=0A=
     424:	8cc6027c 	lw	a2,636(a2)=0A=
     428:	00c02821 	move	a1,a2=0A=
     42c:	0040f809 	jalr	v0=0A=
     430:	ae2601ac 	sw	a2,428(s1)=0A=
=0A=
    /* Order is important here.  e1000_sw_init also identifies the=0A=
     * hardware, so that e1000_check_options can treat command line =
parameters=0A=
     * differently depending on the hardware.=0A=
     */=0A=
    e1000_sw_init(adapter);=0A=
     434:	3c020000 	lui	v0,0x0=0A=
     438:	244215a0 	addiu	v0,v0,5536=0A=
     43c:	0040f809 	jalr	v0=0A=
     440:	02202021 	move	a0,s1=0A=
    e1000_check_options(adapter);=0A=
     444:	3c030000 	lui	v1,0x0=0A=
     448:	24630794 	addiu	v1,v1,1940=0A=
     44c:	0060f809 	jalr	v1=0A=
     450:	02202021 	move	a0,s1=0A=
=0A=
#ifdef MAX_SKB_FRAGS=0A=
    if(adapter->shared.mac_type >=3D e1000_82543) {=0A=
     454:	8e22000c 	lw	v0,12(s1)=0A=
     458:	2c420002 	sltiu	v0,v0,2=0A=
     45c:	54400002 	bnezl	v0,468 <e1000_probe+0x338>=0A=
     460:	24020021 	li	v0,33=0A=
        netdev->features =3D NETIF_F_SG | NETIF_F_IP_CSUM | =
NETIF_F_HIGHDMA;=0A=
    } else {=0A=
     464:	24020023 	li	v0,35=0A=
        netdev->features =3D NETIF_F_SG | NETIF_F_HIGHDMA;=0A=
     468:	ae4200e4 	sw	v0,228(s2)=0A=
    }=0A=
#endif=0A=
=0A=
#ifdef IANS=0A=
    adapter->iANSdata =3D kmalloc(sizeof(iANSsupport_t), GFP_KERNEL);=0A=
    if(adapter->iANSdata =3D=3D NULL) {=0A=
        e1000_remove(pdev);=0A=
        return -ENOMEM;=0A=
    }=0A=
    memset(adapter->iANSdata, 0, sizeof(iANSsupport_t));=0A=
    bd_ans_drv_InitANS(adapter, adapter->iANSdata);=0A=
#endif=0A=
=0A=
    /* finally, we get around to setting up the hardware */=0A=
=0A=
    if(e1000_hw_init(adapter) < 0) {=0A=
     46c:	3c020000 	lui	v0,0x0=0A=
     470:	244217c4 	addiu	v0,v0,6084=0A=
     474:	0040f809 	jalr	v0=0A=
     478:	02202021 	move	a0,s1=0A=
     47c:	04430007 	bgezl	v0,49c <e1000_probe+0x36c>=0A=
     480:	26300008 	addiu	s0,s1,8=0A=
        e1000_remove(pdev);=0A=
     484:	3c020000 	lui	v0,0x0=0A=
     488:	24420000 	addiu	v0,v0,0=0A=
     48c:	0040f809 	jalr	v0=0A=
     490:	02002021 	move	a0,s0=0A=
        return -ENODEV;=0A=
     494:	0800018b 	j	62c <e1000_probe+0x4fc>=0A=
     498:	2402ffed 	li	v0,-19=0A=
    }=0A=
    cards_found++;=0A=
     49c:	3c020000 	lui	v0,0x0=0A=
     4a0:	8c42043c 	lw	v0,1084(v0)=0A=
     4a4:	24420001 	addiu	v0,v0,1=0A=
=0A=
    /* reset stats */=0A=
=0A=
    e1000_clear_hw_cntrs(&adapter->shared);=0A=
     4a8:	3c030000 	lui	v1,0x0=0A=
     4ac:	24630000 	addiu	v1,v1,0=0A=
     4b0:	3c010000 	lui	at,0x0=0A=
     4b4:	ac22043c 	sw	v0,1084(at)=0A=
     4b8:	0060f809 	jalr	v1=0A=
     4bc:	02002021 	move	a0,s0=0A=
    e1000_phy_get_info(&adapter->shared, &adapter->phy_info);=0A=
     4c0:	02002021 	move	a0,s0=0A=
     4c4:	3c020000 	lui	v0,0x0=0A=
     4c8:	24420000 	addiu	v0,v0,0=0A=
     4cc:	0040f809 	jalr	v0=0A=
     4d0:	262501b8 	addiu	a1,s1,440=0A=
=0A=
#ifdef CONFIG_PROC_FS=0A=
    /* set up the proc fs entry */=0A=
=0A=
    len =3D strlen(ADAPTERS_PROC_DIR);=0A=
=0A=
    for(e1000_proc_dir =3D proc_net->subdir; e1000_proc_dir;=0A=
     4d4:	3c030000 	lui	v1,0x0=0A=
     4d8:	8c630000 	lw	v1,0(v1)=0A=
     4dc:	24130010 	li	s3,16=0A=
     4e0:	3c100000 	lui	s0,0x0=0A=
     4e4:	26100000 	addiu	s0,s0,0=0A=
     4e8:	0800013f 	j	4fc <e1000_probe+0x3cc>=0A=
     4ec:	8c620034 	lw	v0,52(v1)=0A=
        e1000_proc_dir =3D e1000_proc_dir->next) {=0A=
     4f0:	3c040000 	lui	a0,0x0=0A=
     4f4:	8c840000 	lw	a0,0(a0)=0A=
     4f8:	8c82002c 	lw	v0,44(a0)=0A=
     4fc:	3c010000 	lui	at,0x0=0A=
     500:	ac220000 	sw	v0,0(at)=0A=
     504:	3c030000 	lui	v1,0x0=0A=
     508:	8c630000 	lw	v1,0(v1)=0A=
        if((e1000_proc_dir->namelen =3D=3D len) &&=0A=
     50c:	3c050000 	lui	a1,0x0=0A=
     510:	24a5016c 	addiu	a1,a1,364=0A=
     514:	24060010 	li	a2,16=0A=
     518:	1060000c 	beqz	v1,54c <e1000_probe+0x41c>=0A=
     51c:	00602021 	move	a0,v1=0A=
     520:	94620002 	lhu	v0,2(v1)=0A=
     524:	5453fff5 	bnel	v0,s3,4fc <e1000_probe+0x3cc>=0A=
     528:	8c82002c 	lw	v0,44(a0)=0A=
     52c:	0200f809 	jalr	s0=0A=
     530:	8c640004 	lw	a0,4(v1)=0A=
     534:	1440ffee 	bnez	v0,4f0 <e1000_probe+0x3c0>=0A=
     538:	00000000 	nop=0A=
           (memcmp(e1000_proc_dir->name, ADAPTERS_PROC_DIR, len) =3D=3D =
0))=0A=
            break;=0A=
    }=0A=
=0A=
    if(e1000_proc_dir =3D=3D NULL)=0A=
     53c:	3c020000 	lui	v0,0x0=0A=
     540:	8c420000 	lw	v0,0(v0)=0A=
     544:	1440000d 	bnez	v0,57c <e1000_probe+0x44c>=0A=
     548:	00000000 	nop=0A=
        e1000_proc_dir =3D=0A=
     54c:	3c060000 	lui	a2,0x0=0A=
     550:	8cc60000 	lw	a2,0(a2)=0A=
     554:	3c040000 	lui	a0,0x0=0A=
     558:	2484016c 	addiu	a0,a0,364=0A=
     55c:	3c020000 	lui	v0,0x0=0A=
     560:	24420000 	addiu	v0,v0,0=0A=
     564:	0040f809 	jalr	v0=0A=
     568:	24054000 	li	a1,16384=0A=
     56c:	3c010000 	lui	at,0x0=0A=
     570:	ac220000 	sw	v0,0(at)=0A=
            create_proc_entry(ADAPTERS_PROC_DIR, S_IFDIR, proc_net);=0A=
=0A=
    if(e1000_proc_dir !=3D NULL)=0A=
     574:	5040000c 	beqzl	v0,5a8 <e1000_probe+0x478>=0A=
     578:	8e2300b0 	lw	v1,176(s1)=0A=
        if(e1000_create_proc_dev(adapter) < 0) {=0A=
     57c:	3c020000 	lui	v0,0x0=0A=
     580:	24420000 	addiu	v0,v0,0=0A=
     584:	0040f809 	jalr	v0=0A=
     588:	02202021 	move	a0,s1=0A=
     58c:	04430006 	bgezl	v0,5a8 <e1000_probe+0x478>=0A=
     590:	8e2300b0 	lw	v1,176(s1)=0A=
            e1000_remove_proc_dev(adapter->netdev);=0A=
     594:	3c020000 	lui	v0,0x0=0A=
     598:	24420000 	addiu	v0,v0,0=0A=
     59c:	0040f809 	jalr	v0=0A=
     5a0:	8e240148 	lw	a0,328(s1)=0A=
        }=0A=
#endif=0A=
=0A=
    /* print the link status */=0A=
=0A=
    if(adapter->link_active =3D=3D 1)=0A=
     5a4:	8e2300b0 	lw	v1,176(s1)=0A=
     5a8:	24020001 	li	v0,1=0A=
     5ac:	14620017 	bne	v1,v0,60c <e1000_probe+0x4dc>=0A=
     5b0:	02402821 	move	a1,s2=0A=
        printk("%s:  Mem:0x%p  IRQ:%d  Speed:%d Mbps  Duplex:%s\n",=0A=
     5b4:	962200b4 	lhu	v0,180(s1)=0A=
     5b8:	24040002 	li	a0,2=0A=
     5bc:	afa20010 	sw	v0,16(sp)=0A=
     5c0:	962300b6 	lhu	v1,182(s1)=0A=
     5c4:	14640005 	bne	v1,a0,5dc <e1000_probe+0x4ac>=0A=
     5c8:	00000000 	nop=0A=
     5cc:	3c020000 	lui	v0,0x0=0A=
     5d0:	24420284 	addiu	v0,v0,644=0A=
     5d4:	0800017a 	j	5e8 <e1000_probe+0x4b8>=0A=
     5d8:	afa20014 	sw	v0,20(sp)=0A=
     5dc:	3c020000 	lui	v0,0x0=0A=
     5e0:	2442028c 	addiu	v0,v0,652=0A=
     5e4:	afa20014 	sw	v0,20(sp)=0A=
     5e8:	8ca6001c 	lw	a2,28(a1)=0A=
     5ec:	3c040000 	lui	a0,0x0=0A=
     5f0:	24840250 	addiu	a0,a0,592=0A=
     5f4:	3c020000 	lui	v0,0x0=0A=
     5f8:	24420000 	addiu	v0,v0,0=0A=
     5fc:	0040f809 	jalr	v0=0A=
     600:	8ca70024 	lw	a3,36(a1)=0A=
     604:	0800018b 	j	62c <e1000_probe+0x4fc>=0A=
     608:	00001021 	move	v0,zero=0A=
               netdev->name, (void *) netdev->mem_start, netdev->irq,=0A=
               adapter->link_speed,=0A=
               adapter->link_duplex =3D=3D FULL_DUPLEX ? "Full" : =
"Half");=0A=
    else=0A=
        printk("%s:  Mem:0x%p  IRQ:%d  Speed:N/A  Duplex:N/A\n", =
netdev->name,=0A=
     60c:	8ca6001c 	lw	a2,28(a1)=0A=
     610:	3c040000 	lui	a0,0x0=0A=
     614:	24840294 	addiu	a0,a0,660=0A=
     618:	3c020000 	lui	v0,0x0=0A=
     61c:	24420000 	addiu	v0,v0,0=0A=
     620:	0040f809 	jalr	v0=0A=
     624:	8ca70024 	lw	a3,36(a1)=0A=
               (void *) netdev->mem_start, netdev->irq);=0A=
=0A=
    return 0;=0A=
     628:	00001021 	move	v0,zero=0A=
}=0A=
     62c:	8fbf0028 	lw	ra,40(sp)=0A=
     630:	8fb30024 	lw	s3,36(sp)=0A=
     634:	8fb20020 	lw	s2,32(sp)=0A=
     638:	8fb1001c 	lw	s1,28(sp)=0A=
     63c:	8fb00018 	lw	s0,24(sp)=0A=
     640:	03e00008 	jr	ra=0A=
     644:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
00000648 <e1000_remove>:=0A=
     648:	27bdffd8 	addiu	sp,sp,-40=0A=
     64c:	afb00010 	sw	s0,16(sp)=0A=
=0A=
/**=0A=
 * e1000_remove - Device Removal Routine=0A=
 * @pdev: PCI device information struct=0A=
 *=0A=
 * e1000_remove is called by the PCI subsystem to alert the driver=0A=
 * that it should release a PCI device.  The could be caused by a=0A=
 * Hot-Plug event, or because the driver is going to be removed from=0A=
 * memory.=0A=
 *=0A=
 * This routine is also called to clean up from a failure in=0A=
 * e1000_probe.  The Adapter struct and netdev will always exist,=0A=
 * all other pointers must be checked for NULL before freeing.=0A=
 **/=0A=
=0A=
void=0A=
e1000_remove(struct pci_dev *pdev)=0A=
{=0A=
    struct net_device *netdev;=0A=
    struct e1000_adapter *adapter;=0A=
=0A=
    /* find the Adapter struct that matches this PCI device */=0A=
=0A=
    for(adapter =3D e1000_adapter_list; adapter !=3D NULL; adapter =3D =
adapter->next) {=0A=
     650:	3c100000 	lui	s0,0x0=0A=
     654:	8e100000 	lw	s0,0(s0)=0A=
     658:	afb10014 	sw	s1,20(sp)=0A=
     65c:	afbf0020 	sw	ra,32(sp)=0A=
     660:	afb3001c 	sw	s3,28(sp)=0A=
     664:	afb20018 	sw	s2,24(sp)=0A=
        if(adapter->pdev =3D=3D pdev)=0A=
     668:	00808821 	move	s1,a0=0A=
     66c:	12000043 	beqz	s0,77c <e1000_remove+0x134>=0A=
     670:	8fbf0020 	lw	ra,32(sp)=0A=
     674:	8e02014c 	lw	v0,332(s0)=0A=
     678:	5451fffc 	bnel	v0,s1,66c <e1000_remove+0x24>=0A=
     67c:	8e100000 	lw	s0,0(s0)=0A=
            break;=0A=
    }=0A=
    if(adapter =3D=3D NULL)=0A=
     680:	1200003e 	beqz	s0,77c <e1000_remove+0x134>=0A=
     684:	26120008 	addiu	s2,s0,8=0A=
        return;=0A=
=0A=
    netdev =3D adapter->netdev;=0A=
     688:	8e130148 	lw	s3,328(s0)=0A=
=0A=
    /* this must be called before freeing anything,=0A=
     * otherwise there is a case where the open entry point can be=0A=
     * running at the same time as remove. Calling unregister_netdev on =
an=0A=
     * open interface results in a call to dev_close, which locks=0A=
     * properly against the other netdev entry points, so this takes=0A=
     * care of the hotplug issue of removing an active interface as well.=0A=
     */=0A=
    unregister_netdev(netdev);=0A=
     68c:	3c020000 	lui	v0,0x0=0A=
     690:	24420000 	addiu	v0,v0,0=0A=
     694:	0040f809 	jalr	v0=0A=
     698:	02602021 	move	a0,s3=0A=
=0A=
    e1000_phy_hw_reset(&adapter->shared);=0A=
     69c:	3c020000 	lui	v0,0x0=0A=
     6a0:	24420000 	addiu	v0,v0,0=0A=
     6a4:	0040f809 	jalr	v0=0A=
     6a8:	02402021 	move	a0,s2=0A=
=0A=
#ifdef CONFIG_PROC_FS=0A=
    /* remove the proc nodes */=0A=
=0A=
    if(e1000_proc_dir !=3D NULL)=0A=
     6ac:	3c030000 	lui	v1,0x0=0A=
     6b0:	8c630000 	lw	v1,0(v1)=0A=
     6b4:	10600005 	beqz	v1,6cc <e1000_remove+0x84>=0A=
     6b8:	00000000 	nop=0A=
        e1000_remove_proc_dev(adapter->netdev);=0A=
     6bc:	3c020000 	lui	v0,0x0=0A=
     6c0:	24420000 	addiu	v0,v0,0=0A=
     6c4:	0040f809 	jalr	v0=0A=
     6c8:	8e040148 	lw	a0,328(s0)=0A=
#endif=0A=
=0A=
    /* remove from the adapter list */=0A=
=0A=
    if(e1000_adapter_list =3D=3D adapter)=0A=
     6cc:	3c020000 	lui	v0,0x0=0A=
     6d0:	8c420000 	lw	v0,0(v0)=0A=
     6d4:	54500005 	bnel	v0,s0,6ec <e1000_remove+0xa4>=0A=
     6d8:	8e030000 	lw	v1,0(s0)=0A=
        e1000_adapter_list =3D adapter->next;=0A=
     6dc:	8e020000 	lw	v0,0(s0)=0A=
     6e0:	3c010000 	lui	at,0x0=0A=
     6e4:	ac220000 	sw	v0,0(at)=0A=
    if(adapter->next !=3D NULL)=0A=
     6e8:	8e030000 	lw	v1,0(s0)=0A=
     6ec:	50600004 	beqzl	v1,700 <e1000_remove+0xb8>=0A=
     6f0:	8e030004 	lw	v1,4(s0)=0A=
        adapter->next->prev =3D adapter->prev;=0A=
     6f4:	8e020004 	lw	v0,4(s0)=0A=
     6f8:	ac620004 	sw	v0,4(v1)=0A=
    if(adapter->prev !=3D NULL)=0A=
     6fc:	8e030004 	lw	v1,4(s0)=0A=
     700:	50600004 	beqzl	v1,714 <e1000_remove+0xcc>=0A=
     704:	8e440000 	lw	a0,0(s2)=0A=
        adapter->prev->next =3D adapter->next;=0A=
     708:	8e020000 	lw	v0,0(s0)=0A=
     70c:	ac620000 	sw	v0,0(v1)=0A=
=0A=
    /* free system resources */=0A=
=0A=
#ifdef IANS=0A=
    if(adapter->iANSdata !=3D NULL)=0A=
        kfree(adapter->iANSdata);=0A=
#endif=0A=
=0A=
    if(adapter->shared.hw_addr !=3D NULL) {=0A=
     710:	8e440000 	lw	a0,0(s2)=0A=
     714:	10800014 	beqz	a0,768 <e1000_remove+0x120>=0A=
     718:	00000000 	nop=0A=
        iounmap((void *) adapter->shared.hw_addr);=0A=
     71c:	3c020000 	lui	v0,0x0=0A=
     720:	24420000 	addiu	v0,v0,0=0A=
     724:	0040f809 	jalr	v0=0A=
     728:	00000000 	nop=0A=
        release_mem_region(pci_resource_start(pdev, BAR_0),=0A=
     72c:	8e230064 	lw	v1,100(s1)=0A=
     730:	14600005 	bnez	v1,748 <e1000_remove+0x100>=0A=
     734:	8e220068 	lw	v0,104(s1)=0A=
     738:	10400005 	beqz	v0,750 <e1000_remove+0x108>=0A=
     73c:	00003021 	move	a2,zero=0A=
     740:	080001d3 	j	74c <e1000_remove+0x104>=0A=
     744:	00431023 	subu	v0,v0,v1=0A=
     748:	00431023 	subu	v0,v0,v1=0A=
     74c:	24460001 	addiu	a2,v0,1=0A=
     750:	3c040000 	lui	a0,0x0=0A=
     754:	24840000 	addiu	a0,a0,0=0A=
     758:	3c020000 	lui	v0,0x0=0A=
     75c:	24420000 	addiu	v0,v0,0=0A=
     760:	0040f809 	jalr	v0=0A=
     764:	8e250064 	lw	a1,100(s1)=0A=
                           pci_resource_len(pdev, BAR_0));=0A=
    }=0A=
=0A=
    /* free the net_device _and_ struct e1000_adapter memory */=0A=
=0A=
    kfree(netdev);=0A=
     768:	3c020000 	lui	v0,0x0=0A=
     76c:	24420000 	addiu	v0,v0,0=0A=
     770:	0040f809 	jalr	v0=0A=
     774:	02602021 	move	a0,s3=0A=
=0A=
    return;=0A=
}=0A=
     778:	8fbf0020 	lw	ra,32(sp)=0A=
     77c:	8fb3001c 	lw	s3,28(sp)=0A=
     780:	8fb20018 	lw	s2,24(sp)=0A=
     784:	8fb10014 	lw	s1,20(sp)=0A=
     788:	8fb00010 	lw	s0,16(sp)=0A=
     78c:	03e00008 	jr	ra=0A=
     790:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
00000794 <e1000_check_options>:=0A=
     794:	27bdffd8 	addiu	sp,sp,-40=0A=
     798:	afb10014 	sw	s1,20(sp)=0A=
     79c:	afbf0020 	sw	ra,32(sp)=0A=
     7a0:	afb3001c 	sw	s3,28(sp)=0A=
     7a4:	afb20018 	sw	s2,24(sp)=0A=
     7a8:	afb00010 	sw	s0,16(sp)=0A=
     7ac:	00808821 	move	s1,a0=0A=
=0A=
/**=0A=
 * e1000_check_options - Range Checking for Command Line Parameters=0A=
 * @adapter: board private structure=0A=
 *=0A=
 * This routine checks all command line paramters for valid user=0A=
 * input.  If an invalid value is given, or if no user specified=0A=
 * value exists, a default value is used.  The final value is stored=0A=
 * in a variable in the Adapter structure.=0A=
 **/=0A=
=0A=
static void=0A=
e1000_check_options(struct e1000_adapter *adapter)=0A=
{=0A=
    int board =3D adapter->bd_number;=0A=
     7b0:	8e250090 	lw	a1,144(s1)=0A=
=0A=
    if(board >=3D E1000_MAX_NIC) {=0A=
     7b4:	28a20008 	slti	v0,a1,8=0A=
     7b8:	5440000d 	bnezl	v0,7f0 <e1000_check_options+0x5c>=0A=
     7bc:	00059080 	sll	s2,a1,0x2=0A=
        printk("Warning: no configuration for board #%i\n", board);=0A=
     7c0:	3c040000 	lui	a0,0x0=0A=
     7c4:	248402c4 	addiu	a0,a0,708=0A=
     7c8:	3c130000 	lui	s3,0x0=0A=
     7cc:	26730000 	addiu	s3,s3,0=0A=
     7d0:	0260f809 	jalr	s3=0A=
     7d4:	00000000 	nop=0A=
        printk("Using defaults for all values\n");=0A=
     7d8:	3c040000 	lui	a0,0x0=0A=
     7dc:	248402f0 	addiu	a0,a0,752=0A=
     7e0:	0260f809 	jalr	s3=0A=
     7e4:	00000000 	nop=0A=
        board =3D E1000_MAX_NIC;=0A=
     7e8:	24050008 	li	a1,8=0A=
    }=0A=
=0A=
    E1000_DBG("e1000_check_options\n");=0A=
=0A=
    /* Transmit Descriptor Count */=0A=
=0A=
    if(TxDescriptors[board] =3D=3D OPTION_UNSET) {=0A=
     7ec:	00059080 	sll	s2,a1,0x2=0A=
     7f0:	3c030000 	lui	v1,0x0=0A=
     7f4:	246302b0 	addiu	v1,v1,688=0A=
     7f8:	00721821 	addu	v1,v1,s2=0A=
     7fc:	8c650000 	lw	a1,0(v1)=0A=
     800:	2402ffff 	li	v0,-1=0A=
     804:	14a20005 	bne	a1,v0,81c <e1000_check_options+0x88>=0A=
     808:	24a2ffb0 	addiu	v0,a1,-80=0A=
        adapter->tx_ring.count =3D DEFAULT_TXD;=0A=
     80c:	24020100 	li	v0,256=0A=
     810:	ae2200f0 	sw	v0,240(s1)=0A=
        TxDescriptors[board] =3D DEFAULT_TXD;=0A=
    } else=0A=
     814:	08000234 	j	8d0 <e1000_check_options+0x13c>=0A=
     818:	ac620000 	sw	v0,0(v1)=0A=
        if(((TxDescriptors[board] > MAX_TXD) ||=0A=
     81c:	2c4200b1 	sltiu	v0,v0,177=0A=
     820:	1440000d 	bnez	v0,858 <e1000_check_options+0xc4>=0A=
     824:	00000000 	nop=0A=
     828:	8e22000c 	lw	v0,12(s1)=0A=
     82c:	2c420003 	sltiu	v0,v0,3=0A=
     830:	10400009 	beqz	v0,858 <e1000_check_options+0xc4>=0A=
     834:	00000000 	nop=0A=
            (TxDescriptors[board] < MIN_TXD)) &&=0A=
           (adapter->shared.mac_type <=3D e1000_82543)) {=0A=
        printk("Invalid TxDescriptors specified (%i), using default =
%i\n",=0A=
     838:	3c040000 	lui	a0,0x0=0A=
     83c:	24840310 	addiu	a0,a0,784=0A=
     840:	3c130000 	lui	s3,0x0=0A=
     844:	26730000 	addiu	s3,s3,0=0A=
     848:	0260f809 	jalr	s3=0A=
     84c:	24060100 	li	a2,256=0A=
               TxDescriptors[board], DEFAULT_TXD);=0A=
        adapter->tx_ring.count =3D DEFAULT_TXD;=0A=
    } else=0A=
     850:	08000233 	j	8cc <e1000_check_options+0x138>=0A=
     854:	24030100 	li	v1,256=0A=
        if(((TxDescriptors[board] > MAX_82544_TXD) ||=0A=
     858:	3c050000 	lui	a1,0x0=0A=
     85c:	00b22821 	addu	a1,a1,s2=0A=
     860:	8ca502b0 	lw	a1,688(a1)=0A=
     864:	24a2ffb0 	addiu	v0,a1,-80=0A=
     868:	2c420fb1 	sltiu	v0,v0,4017=0A=
     86c:	1440000d 	bnez	v0,8a4 <e1000_check_options+0x110>=0A=
     870:	00000000 	nop=0A=
     874:	8e22000c 	lw	v0,12(s1)=0A=
     878:	2c420003 	sltiu	v0,v0,3=0A=
     87c:	14400009 	bnez	v0,8a4 <e1000_check_options+0x110>=0A=
     880:	00000000 	nop=0A=
            (TxDescriptors[board] < MIN_TXD)) &&=0A=
           (adapter->shared.mac_type > e1000_82543)) {=0A=
        printk("Invalid TxDescriptors specified (%i), using default =
%i\n",=0A=
     884:	3c040000 	lui	a0,0x0=0A=
     888:	24840310 	addiu	a0,a0,784=0A=
     88c:	3c130000 	lui	s3,0x0=0A=
     890:	26730000 	addiu	s3,s3,0=0A=
     894:	0260f809 	jalr	s3=0A=
     898:	24060100 	li	a2,256=0A=
               TxDescriptors[board], DEFAULT_TXD);=0A=
        adapter->tx_ring.count =3D DEFAULT_TXD;=0A=
    } else {=0A=
     89c:	08000233 	j	8cc <e1000_check_options+0x138>=0A=
     8a0:	24030100 	li	v1,256=0A=
        printk("Using specified value of %i TxDescriptors\n",=0A=
     8a4:	3c100000 	lui	s0,0x0=0A=
     8a8:	261002b0 	addiu	s0,s0,688=0A=
     8ac:	02128021 	addu	s0,s0,s2=0A=
     8b0:	3c040000 	lui	a0,0x0=0A=
     8b4:	24840348 	addiu	a0,a0,840=0A=
     8b8:	3c130000 	lui	s3,0x0=0A=
     8bc:	26730000 	addiu	s3,s3,0=0A=
     8c0:	0260f809 	jalr	s3=0A=
     8c4:	8e050000 	lw	a1,0(s0)=0A=
               TxDescriptors[board]);=0A=
        adapter->tx_ring.count =3D TxDescriptors[board];=0A=
     8c8:	8e030000 	lw	v1,0(s0)=0A=
     8cc:	ae2300f0 	sw	v1,240(s1)=0A=
    }=0A=
=0A=
    /* tx_ring.count must be a multiple of 8 */=0A=
=0A=
    adapter->tx_ring.count =3D E1000_ROUNDUP2(adapter->tx_ring.count,=0A=
     8d0:	8e2200f0 	lw	v0,240(s1)=0A=
     8d4:	2403fff8 	li	v1,-8=0A=
                                            REQ_TX_DESCRIPTOR_MULTIPLE);=0A=
=0A=
    /* Receive Descriptor Count */=0A=
=0A=
    if(RxDescriptors[board] =3D=3D OPTION_UNSET) {=0A=
     8d8:	3c040000 	lui	a0,0x0=0A=
     8dc:	248402d4 	addiu	a0,a0,724=0A=
     8e0:	00922021 	addu	a0,a0,s2=0A=
     8e4:	24420007 	addiu	v0,v0,7=0A=
     8e8:	00431024 	and	v0,v0,v1=0A=
     8ec:	ae2200f0 	sw	v0,240(s1)=0A=
     8f0:	8c850000 	lw	a1,0(a0)=0A=
     8f4:	2402ffff 	li	v0,-1=0A=
     8f8:	14a20005 	bne	a1,v0,910 <e1000_check_options+0x17c>=0A=
     8fc:	24a2ffb0 	addiu	v0,a1,-80=0A=
        adapter->rx_ring.count =3D DEFAULT_RXD;=0A=
     900:	24020100 	li	v0,256=0A=
     904:	ae22011c 	sw	v0,284(s1)=0A=
        RxDescriptors[board] =3D DEFAULT_RXD;=0A=
    } else=0A=
     908:	08000271 	j	9c4 <e1000_check_options+0x230>=0A=
     90c:	ac820000 	sw	v0,0(a0)=0A=
        if(((RxDescriptors[board] > MAX_RXD) ||=0A=
     910:	2c4200b1 	sltiu	v0,v0,177=0A=
     914:	1440000d 	bnez	v0,94c <e1000_check_options+0x1b8>=0A=
     918:	00000000 	nop=0A=
     91c:	8e22000c 	lw	v0,12(s1)=0A=
     920:	2c420003 	sltiu	v0,v0,3=0A=
     924:	10400009 	beqz	v0,94c <e1000_check_options+0x1b8>=0A=
     928:	00000000 	nop=0A=
            (RxDescriptors[board] < MIN_RXD)) &&=0A=
           (adapter->shared.mac_type <=3D e1000_82543)) {=0A=
        printk("Invalid RxDescriptors specified (%i), using default =
%i\n",=0A=
     92c:	3c040000 	lui	a0,0x0=0A=
     930:	24840374 	addiu	a0,a0,884=0A=
     934:	3c130000 	lui	s3,0x0=0A=
     938:	26730000 	addiu	s3,s3,0=0A=
     93c:	0260f809 	jalr	s3=0A=
     940:	24060100 	li	a2,256=0A=
               RxDescriptors[board], DEFAULT_RXD);=0A=
        adapter->rx_ring.count =3D DEFAULT_RXD;=0A=
    } else=0A=
     944:	08000270 	j	9c0 <e1000_check_options+0x22c>=0A=
     948:	24030100 	li	v1,256=0A=
        if(((RxDescriptors[board] > MAX_82544_RXD) ||=0A=
     94c:	3c050000 	lui	a1,0x0=0A=
     950:	00b22821 	addu	a1,a1,s2=0A=
     954:	8ca502d4 	lw	a1,724(a1)=0A=
     958:	24a2ffb0 	addiu	v0,a1,-80=0A=
     95c:	2c420fb1 	sltiu	v0,v0,4017=0A=
     960:	1440000d 	bnez	v0,998 <e1000_check_options+0x204>=0A=
     964:	00000000 	nop=0A=
     968:	8e22000c 	lw	v0,12(s1)=0A=
     96c:	2c420003 	sltiu	v0,v0,3=0A=
     970:	14400009 	bnez	v0,998 <e1000_check_options+0x204>=0A=
     974:	00000000 	nop=0A=
            (RxDescriptors[board] < MIN_RXD)) &&=0A=
           (adapter->shared.mac_type > e1000_82543)) {=0A=
        printk("Invalid RxDescriptors specified (%i), using default =
%i\n",=0A=
     978:	3c040000 	lui	a0,0x0=0A=
     97c:	24840374 	addiu	a0,a0,884=0A=
     980:	3c130000 	lui	s3,0x0=0A=
     984:	26730000 	addiu	s3,s3,0=0A=
     988:	0260f809 	jalr	s3=0A=
     98c:	24060100 	li	a2,256=0A=
               RxDescriptors[board], DEFAULT_RXD);=0A=
        adapter->rx_ring.count =3D DEFAULT_RXD;=0A=
    } else {=0A=
     990:	08000270 	j	9c0 <e1000_check_options+0x22c>=0A=
     994:	24030100 	li	v1,256=0A=
        printk("Using specified value of %i RxDescriptors\n",=0A=
     998:	3c100000 	lui	s0,0x0=0A=
     99c:	261002d4 	addiu	s0,s0,724=0A=
     9a0:	02128021 	addu	s0,s0,s2=0A=
     9a4:	3c040000 	lui	a0,0x0=0A=
     9a8:	248403ac 	addiu	a0,a0,940=0A=
     9ac:	3c130000 	lui	s3,0x0=0A=
     9b0:	26730000 	addiu	s3,s3,0=0A=
     9b4:	0260f809 	jalr	s3=0A=
     9b8:	8e050000 	lw	a1,0(s0)=0A=
               RxDescriptors[board]);=0A=
        adapter->rx_ring.count =3D RxDescriptors[board];=0A=
     9bc:	8e030000 	lw	v1,0(s0)=0A=
     9c0:	ae23011c 	sw	v1,284(s1)=0A=
    }=0A=
=0A=
    /* rx_ring.count must be a multiple of 8 */=0A=
=0A=
    adapter->rx_ring.count =3D=0A=
     9c4:	8e22011c 	lw	v0,284(s1)=0A=
     9c8:	2403fff8 	li	v1,-8=0A=
        E1000_ROUNDUP2(adapter->rx_ring.count, =
REQ_RX_DESCRIPTOR_MULTIPLE);=0A=
=0A=
    /* Receive Checksum Offload Enable */=0A=
=0A=
    if(XsumRX[board] =3D=3D OPTION_UNSET) {=0A=
     9cc:	3c040000 	lui	a0,0x0=0A=
     9d0:	24840388 	addiu	a0,a0,904=0A=
     9d4:	00922021 	addu	a0,a0,s2=0A=
     9d8:	24420007 	addiu	v0,v0,7=0A=
     9dc:	00431024 	and	v0,v0,v1=0A=
     9e0:	ae22011c 	sw	v0,284(s1)=0A=
     9e4:	8c850000 	lw	a1,0(a0)=0A=
     9e8:	2402ffff 	li	v0,-1=0A=
     9ec:	14a20005 	bne	a1,v0,a04 <e1000_check_options+0x270>=0A=
     9f0:	2ca20002 	sltiu	v0,a1,2=0A=
        adapter->RxChecksum =3D XSUMRX_DEFAULT;=0A=
     9f4:	24020001 	li	v0,1=0A=
     9f8:	ae2201b0 	sw	v0,432(s1)=0A=
        XsumRX[board] =3D XSUMRX_DEFAULT;=0A=
    } else if((XsumRX[board] !=3D OPTION_ENABLED) &&=0A=
     9fc:	0800029b 	j	a6c <e1000_check_options+0x2d8>=0A=
     a00:	ac820000 	sw	v0,0(a0)=0A=
     a04:	54400009 	bnezl	v0,a2c <e1000_check_options+0x298>=0A=
     a08:	24020001 	li	v0,1=0A=
              (XsumRX[board] !=3D OPTION_DISABLED)) {=0A=
        printk("Invalid XsumRX specified (%i), using default of %i\n",=0A=
     a0c:	3c040000 	lui	a0,0x0=0A=
     a10:	248403d8 	addiu	a0,a0,984=0A=
     a14:	3c130000 	lui	s3,0x0=0A=
     a18:	26730000 	addiu	s3,s3,0=0A=
     a1c:	0260f809 	jalr	s3=0A=
     a20:	24060001 	li	a2,1=0A=
               XsumRX[board], XSUMRX_DEFAULT);=0A=
        adapter->RxChecksum =3D XSUMRX_DEFAULT;=0A=
    } else {=0A=
     a24:	0800029a 	j	a68 <e1000_check_options+0x2d4>=0A=
     a28:	24030001 	li	v1,1=0A=
        printk("Receive Checksum Offload %s\n",=0A=
     a2c:	3c030000 	lui	v1,0x0=0A=
     a30:	2463042c 	addiu	v1,v1,1068=0A=
     a34:	10a20003 	beq	a1,v0,a44 <e1000_check_options+0x2b0>=0A=
     a38:	00000000 	nop=0A=
     a3c:	3c030000 	lui	v1,0x0=0A=
     a40:	24630434 	addiu	v1,v1,1076=0A=
     a44:	3c040000 	lui	a0,0x0=0A=
     a48:	2484040c 	addiu	a0,a0,1036=0A=
     a4c:	3c130000 	lui	s3,0x0=0A=
     a50:	26730000 	addiu	s3,s3,0=0A=
     a54:	0260f809 	jalr	s3=0A=
     a58:	00602821 	move	a1,v1=0A=
               XsumRX[board] =3D=3D OPTION_ENABLED ? "Enabled" : =
"Disabled");=0A=
        adapter->RxChecksum =3D XsumRX[board];=0A=
     a5c:	3c030000 	lui	v1,0x0=0A=
     a60:	00721821 	addu	v1,v1,s2=0A=
     a64:	8c630388 	lw	v1,904(v1)=0A=
     a68:	ae2301b0 	sw	v1,432(s1)=0A=
    }=0A=
=0A=
    /* Flow Control */=0A=
=0A=
    if(FlowControl[board] =3D=3D OPTION_UNSET) {=0A=
     a6c:	3c030000 	lui	v1,0x0=0A=
     a70:	24630364 	addiu	v1,v1,868=0A=
     a74:	00721821 	addu	v1,v1,s2=0A=
     a78:	8c650000 	lw	a1,0(v1)=0A=
     a7c:	2402ffff 	li	v0,-1=0A=
     a80:	14a20005 	bne	a1,v0,a98 <e1000_check_options+0x304>=0A=
     a84:	2ca20004 	sltiu	v0,a1,4=0A=
        adapter->shared.fc =3D e1000_fc_default;=0A=
     a88:	240200ff 	li	v0,255=0A=
     a8c:	ae220018 	sw	v0,24(s1)=0A=
        FlowControl[board] =3D e1000_fc_default;=0A=
    } else if((FlowControl[board] > e1000_fc_full) ||=0A=
     a90:	080002dc 	j	b70 <e1000_check_options+0x3dc>=0A=
     a94:	ac620000 	sw	v0,0(v1)=0A=
     a98:	1440000a 	bnez	v0,ac4 <e1000_check_options+0x330>=0A=
     a9c:	24020002 	li	v0,2=0A=
              (FlowControl[board] < e1000_fc_none)) {=0A=
        printk("Invalid FlowControl specified (%i), "=0A=
     aa0:	3c040000 	lui	a0,0x0=0A=
     aa4:	24840440 	addiu	a0,a0,1088=0A=
     aa8:	3c020000 	lui	v0,0x0=0A=
     aac:	24420000 	addiu	v0,v0,0=0A=
     ab0:	0040f809 	jalr	v0=0A=
     ab4:	00000000 	nop=0A=
               "reading default settings from the EEPROM\n",=0A=
               FlowControl[board]);=0A=
        adapter->shared.fc =3D e1000_fc_default;=0A=
     ab8:	240300ff 	li	v1,255=0A=
    } else {=0A=
     abc:	080002dc 	j	b70 <e1000_check_options+0x3dc>=0A=
     ac0:	ae230018 	sw	v1,24(s1)=0A=
        adapter->shared.fc =3D FlowControl[board];=0A=
        switch (adapter->shared.fc) {=0A=
     ac4:	10a20018 	beq	a1,v0,b28 <e1000_check_options+0x394>=0A=
     ac8:	ae250018 	sw	a1,24(s1)=0A=
     acc:	2ca20003 	sltiu	v0,a1,3=0A=
     ad0:	10400007 	beqz	v0,af0 <e1000_check_options+0x35c>=0A=
     ad4:	24020003 	li	v0,3=0A=
     ad8:	10a0000b 	beqz	a1,b08 <e1000_check_options+0x374>=0A=
     adc:	24020001 	li	v0,1=0A=
     ae0:	10a2000d 	beq	a1,v0,b18 <e1000_check_options+0x384>=0A=
     ae4:	00000000 	nop=0A=
     ae8:	080002dc 	j	b70 <e1000_check_options+0x3dc>=0A=
     aec:	00000000 	nop=0A=
     af0:	10a20015 	beq	a1,v0,b48 <e1000_check_options+0x3b4>=0A=
     af4:	240200ff 	li	v0,255=0A=
     af8:	10a20019 	beq	a1,v0,b60 <e1000_check_options+0x3cc>=0A=
     afc:	00000000 	nop=0A=
     b00:	080002dc 	j	b70 <e1000_check_options+0x3dc>=0A=
     b04:	00000000 	nop=0A=
        case e1000_fc_none:=0A=
            printk("Flow Control Disabled\n");=0A=
     b08:	3c040000 	lui	a0,0x0=0A=
     b0c:	24840490 	addiu	a0,a0,1168=0A=
            break;=0A=
     b10:	080002cc 	j	b30 <e1000_check_options+0x39c>=0A=
     b14:	00000000 	nop=0A=
        case e1000_fc_rx_pause:=0A=
            printk("Flow Control Receive Only\n");=0A=
     b18:	3c040000 	lui	a0,0x0=0A=
     b1c:	248404a8 	addiu	a0,a0,1192=0A=
            break;=0A=
     b20:	080002cc 	j	b30 <e1000_check_options+0x39c>=0A=
     b24:	00000000 	nop=0A=
        case e1000_fc_tx_pause:=0A=
            printk("Flow Control Transmit Only\n");=0A=
     b28:	3c040000 	lui	a0,0x0=0A=
     b2c:	248404c4 	addiu	a0,a0,1220=0A=
     b30:	3c020000 	lui	v0,0x0=0A=
     b34:	24420000 	addiu	v0,v0,0=0A=
     b38:	0040f809 	jalr	v0=0A=
     b3c:	00000000 	nop=0A=
            break;=0A=
     b40:	080002dc 	j	b70 <e1000_check_options+0x3dc>=0A=
     b44:	00000000 	nop=0A=
        case e1000_fc_full:=0A=
            printk("Flow Control Enabled\n");=0A=
     b48:	3c040000 	lui	a0,0x0=0A=
     b4c:	248404e0 	addiu	a0,a0,1248=0A=
     b50:	3c130000 	lui	s3,0x0=0A=
     b54:	26730000 	addiu	s3,s3,0=0A=
     b58:	0260f809 	jalr	s3=0A=
     b5c:	00000000 	nop=0A=
        case e1000_fc_default:=0A=
            printk("Flow Control Hardware Default\n");=0A=
     b60:	3c040000 	lui	a0,0x0=0A=
     b64:	248404f8 	addiu	a0,a0,1272=0A=
     b68:	0260f809 	jalr	s3=0A=
     b6c:	00000000 	nop=0A=
        }=0A=
    }=0A=
=0A=
    /* Transmit Interrupt Delay */=0A=
=0A=
    if(TxIntDelay[board] =3D=3D OPTION_UNSET) {=0A=
     b70:	3c100000 	lui	s0,0x0=0A=
     b74:	261003ac 	addiu	s0,s0,940=0A=
     b78:	02128021 	addu	s0,s0,s2=0A=
     b7c:	8e050000 	lw	a1,0(s0)=0A=
     b80:	2402ffff 	li	v0,-1=0A=
     b84:	14a20005 	bne	a1,v0,b9c <e1000_check_options+0x408>=0A=
     b88:	3402ffff 	li	v0,0xffff=0A=
        adapter->tx_int_delay =3D DEFAULT_TIDV;=0A=
     b8c:	24020040 	li	v0,64=0A=
     b90:	ae220104 	sw	v0,260(s1)=0A=
        TxIntDelay[board] =3D DEFAULT_TIDV;=0A=
    } else if((TxIntDelay[board] > MAX_TIDV) || (TxIntDelay[board] < =
MIN_TIDV)) {=0A=
     b94:	080002fa 	j	be8 <e1000_check_options+0x454>=0A=
     b98:	ae020000 	sw	v0,0(s0)=0A=
     b9c:	0045102b 	sltu	v0,v0,a1=0A=
     ba0:	10400009 	beqz	v0,bc8 <e1000_check_options+0x434>=0A=
     ba4:	00000000 	nop=0A=
        printk("Invalid TxIntDelay specified (%i), using default %i\n",=0A=
     ba8:	3c040000 	lui	a0,0x0=0A=
     bac:	24840518 	addiu	a0,a0,1304=0A=
     bb0:	3c020000 	lui	v0,0x0=0A=
     bb4:	24420000 	addiu	v0,v0,0=0A=
     bb8:	0040f809 	jalr	v0=0A=
     bbc:	24060040 	li	a2,64=0A=
               TxIntDelay[board], DEFAULT_TIDV);=0A=
        adapter->tx_int_delay =3D DEFAULT_TIDV;=0A=
    } else {=0A=
     bc0:	080002f9 	j	be4 <e1000_check_options+0x450>=0A=
     bc4:	24030040 	li	v1,64=0A=
        printk("Using specified TxIntDelay of %i\n", TxIntDelay[board]);=0A=
     bc8:	3c040000 	lui	a0,0x0=0A=
     bcc:	24840550 	addiu	a0,a0,1360=0A=
     bd0:	3c020000 	lui	v0,0x0=0A=
     bd4:	24420000 	addiu	v0,v0,0=0A=
     bd8:	0040f809 	jalr	v0=0A=
     bdc:	00000000 	nop=0A=
        adapter->tx_int_delay =3D TxIntDelay[board];=0A=
     be0:	8e030000 	lw	v1,0(s0)=0A=
     be4:	ae230104 	sw	v1,260(s1)=0A=
    }=0A=
=0A=
    /* Receive Interrupt Delay */=0A=
=0A=
    if(RxIntDelay[board] =3D=3D OPTION_UNSET) {=0A=
     be8:	3c100000 	lui	s0,0x0=0A=
     bec:	261003d0 	addiu	s0,s0,976=0A=
     bf0:	02128021 	addu	s0,s0,s2=0A=
     bf4:	8e050000 	lw	a1,0(s0)=0A=
     bf8:	2402ffff 	li	v0,-1=0A=
     bfc:	14a20005 	bne	a1,v0,c14 <e1000_check_options+0x480>=0A=
     c00:	3402ffff 	li	v0,0xffff=0A=
        adapter->rx_int_delay =3D DEFAULT_RIDV;=0A=
     c04:	24020040 	li	v0,64=0A=
     c08:	ae220130 	sw	v0,304(s1)=0A=
        RxIntDelay[board] =3D DEFAULT_RIDV;=0A=
    } else if((RxIntDelay[board] > MAX_RIDV) || (RxIntDelay[board] < =
MIN_RIDV)) {=0A=
     c0c:	08000318 	j	c60 <e1000_check_options+0x4cc>=0A=
     c10:	ae020000 	sw	v0,0(s0)=0A=
     c14:	0045102b 	sltu	v0,v0,a1=0A=
     c18:	10400009 	beqz	v0,c40 <e1000_check_options+0x4ac>=0A=
     c1c:	00000000 	nop=0A=
        printk("Invalid RxIntDelay specified (%i), using default %i\n",=0A=
     c20:	3c040000 	lui	a0,0x0=0A=
     c24:	24840574 	addiu	a0,a0,1396=0A=
     c28:	3c020000 	lui	v0,0x0=0A=
     c2c:	24420000 	addiu	v0,v0,0=0A=
     c30:	0040f809 	jalr	v0=0A=
     c34:	24060040 	li	a2,64=0A=
               RxIntDelay[board], DEFAULT_RIDV);=0A=
        adapter->rx_int_delay =3D DEFAULT_RIDV;=0A=
    } else {=0A=
     c38:	08000317 	j	c5c <e1000_check_options+0x4c8>=0A=
     c3c:	24030040 	li	v1,64=0A=
        printk("Using specified RxIntDelay of %i\n", RxIntDelay[board]);=0A=
     c40:	3c040000 	lui	a0,0x0=0A=
     c44:	248405ac 	addiu	a0,a0,1452=0A=
     c48:	3c020000 	lui	v0,0x0=0A=
     c4c:	24420000 	addiu	v0,v0,0=0A=
     c50:	0040f809 	jalr	v0=0A=
     c54:	00000000 	nop=0A=
        adapter->rx_int_delay =3D RxIntDelay[board];=0A=
     c58:	8e030000 	lw	v1,0(s0)=0A=
     c5c:	ae230130 	sw	v1,304(s1)=0A=
    }=0A=
=0A=
    if(adapter->shared.media_type =3D=3D e1000_media_type_copper) {=0A=
     c60:	8e330010 	lw	s3,16(s1)=0A=
     c64:	16600038 	bnez	s3,d48 <e1000_check_options+0x5b4>=0A=
     c68:	2402ffff 	li	v0,-1=0A=
        /* MDI/MDI-X Support */=0A=
=0A=
        if(MdiX[board] =3D=3D OPTION_UNSET) {=0A=
     c6c:	3c100000 	lui	s0,0x0=0A=
     c70:	261003f4 	addiu	s0,s0,1012=0A=
     c74:	02128021 	addu	s0,s0,s2=0A=
     c78:	8e050000 	lw	a1,0(s0)=0A=
     c7c:	14a20004 	bne	a1,v0,c90 <e1000_check_options+0x4fc>=0A=
     c80:	2ca20004 	sltiu	v0,a1,4=0A=
            adapter->shared.mdix =3D DEFAULT_MDIX;=0A=
     c84:	a2200079 	sb	zero,121(s1)=0A=
            MdiX[board] =3D DEFAULT_MDIX;=0A=
        } else if((MdiX[board] > MAX_MDIX) || (MdiX[board] < MIN_MDIX)) {=0A=
     c88:	08000336 	j	cd8 <e1000_check_options+0x544>=0A=
     c8c:	ae000000 	sw	zero,0(s0)=0A=
     c90:	14400009 	bnez	v0,cb8 <e1000_check_options+0x524>=0A=
     c94:	00000000 	nop=0A=
            printk("Invalid MDI/MDI-X specified (%i), using default =
%i\n",=0A=
     c98:	3c040000 	lui	a0,0x0=0A=
     c9c:	248405d0 	addiu	a0,a0,1488=0A=
     ca0:	3c020000 	lui	v0,0x0=0A=
     ca4:	24420000 	addiu	v0,v0,0=0A=
     ca8:	0040f809 	jalr	v0=0A=
     cac:	00003021 	move	a2,zero=0A=
                   MdiX[board], DEFAULT_MDIX);=0A=
            adapter->shared.mdix =3D DEFAULT_MDIX;=0A=
        } else {=0A=
     cb0:	08000336 	j	cd8 <e1000_check_options+0x544>=0A=
     cb4:	a2200079 	sb	zero,121(s1)=0A=
            printk("Using specified MDI/MDI-X of %i\n", MdiX[board]);=0A=
     cb8:	3c040000 	lui	a0,0x0=0A=
     cbc:	24840604 	addiu	a0,a0,1540=0A=
     cc0:	3c020000 	lui	v0,0x0=0A=
     cc4:	24420000 	addiu	v0,v0,0=0A=
     cc8:	0040f809 	jalr	v0=0A=
     ccc:	00000000 	nop=0A=
            adapter->shared.mdix =3D MdiX[board];=0A=
     cd0:	92030003 	lbu	v1,3(s0)=0A=
     cd4:	a2230079 	sb	v1,121(s1)=0A=
        }=0A=
=0A=
        /* Automatic Correction for Reverse Cable Polarity */=0A=
=0A=
        if(DisablePolarityCorrection[board] =3D=3D OPTION_UNSET) {=0A=
     cd8:	3c100000 	lui	s0,0x0=0A=
     cdc:	26100418 	addiu	s0,s0,1048=0A=
     ce0:	02128021 	addu	s0,s0,s2=0A=
     ce4:	8e050000 	lw	a1,0(s0)=0A=
     ce8:	2402ffff 	li	v0,-1=0A=
     cec:	14a20004 	bne	a1,v0,d00 <e1000_check_options+0x56c>=0A=
     cf0:	2ca20002 	sltiu	v0,a1,2=0A=
            adapter->shared.disable_polarity_correction =3D =
OPTION_DISABLED;=0A=
     cf4:	ae200054 	sw	zero,84(s1)=0A=
            DisablePolarityCorrection[board] =3D OPTION_DISABLED;=0A=
        } else if((DisablePolarityCorrection[board] !=3D OPTION_ENABLED) =
&&=0A=
     cf8:	08000352 	j	d48 <e1000_check_options+0x5b4>=0A=
     cfc:	ae000000 	sw	zero,0(s0)=0A=
     d00:	14400009 	bnez	v0,d28 <e1000_check_options+0x594>=0A=
     d04:	00000000 	nop=0A=
                  (DisablePolarityCorrection[board] !=3D =
OPTION_DISABLED)) {=0A=
            printk("Invalid polarity correction specified (%i),"=0A=
     d08:	3c040000 	lui	a0,0x0=0A=
     d0c:	24840628 	addiu	a0,a0,1576=0A=
     d10:	3c020000 	lui	v0,0x0=0A=
     d14:	24420000 	addiu	v0,v0,0=0A=
     d18:	0040f809 	jalr	v0=0A=
     d1c:	00003021 	move	a2,zero=0A=
                   "    using default %i\n", =
DisablePolarityCorrection[board],=0A=
                   OPTION_DISABLED);=0A=
            adapter->shared.disable_polarity_correction =3D =
OPTION_DISABLED;=0A=
        } else {=0A=
     d20:	08000352 	j	d48 <e1000_check_options+0x5b4>=0A=
     d24:	ae200054 	sw	zero,84(s1)=0A=
            printk("Using specified polarity correction of %i\n",=0A=
     d28:	3c040000 	lui	a0,0x0=0A=
     d2c:	2484066c 	addiu	a0,a0,1644=0A=
     d30:	3c020000 	lui	v0,0x0=0A=
     d34:	24420000 	addiu	v0,v0,0=0A=
     d38:	0040f809 	jalr	v0=0A=
     d3c:	00000000 	nop=0A=
                   DisablePolarityCorrection[board]);=0A=
            adapter->shared.disable_polarity_correction =3D=0A=
     d40:	8e030000 	lw	v1,0(s0)=0A=
     d44:	ae230054 	sw	v1,84(s1)=0A=
                DisablePolarityCorrection[board];=0A=
        }=0A=
    }=0A=
=0A=
    /* Speed, Duplex, and AutoNeg */=0A=
=0A=
    switch (adapter->shared.media_type) {=0A=
     d48:	12600009 	beqz	s3,d70 <e1000_check_options+0x5dc>=0A=
     d4c:	24020001 	li	v0,1=0A=
     d50:	1662000d 	bne	s3,v0,d88 <e1000_check_options+0x5f4>=0A=
     d54:	00000000 	nop=0A=
=0A=
    case e1000_media_type_fiber:=0A=
        e1000_check_fiber_options(adapter);=0A=
     d58:	3c020000 	lui	v0,0x0=0A=
     d5c:	24420dbc 	addiu	v0,v0,3516=0A=
     d60:	0040f809 	jalr	v0=0A=
     d64:	02202021 	move	a0,s1=0A=
        break;=0A=
     d68:	08000369 	j	da4 <e1000_check_options+0x610>=0A=
     d6c:	8fbf0020 	lw	ra,32(sp)=0A=
=0A=
    case e1000_media_type_copper:=0A=
        e1000_check_copper_options(adapter);=0A=
     d70:	3c020000 	lui	v0,0x0=0A=
     d74:	24420ecc 	addiu	v0,v0,3788=0A=
     d78:	0040f809 	jalr	v0=0A=
     d7c:	02202021 	move	a0,s1=0A=
        break;=0A=
     d80:	08000369 	j	da4 <e1000_check_options+0x610>=0A=
     d84:	8fbf0020 	lw	ra,32(sp)=0A=
=0A=
    default:=0A=
        printk("Unknown Media Type\n");=0A=
     d88:	3c040000 	lui	a0,0x0=0A=
     d8c:	24840698 	addiu	a0,a0,1688=0A=
     d90:	3c020000 	lui	v0,0x0=0A=
     d94:	24420000 	addiu	v0,v0,0=0A=
     d98:	0040f809 	jalr	v0=0A=
     d9c:	00000000 	nop=0A=
        break;=0A=
    }=0A=
=0A=
    return;=0A=
}=0A=
     da0:	8fbf0020 	lw	ra,32(sp)=0A=
     da4:	8fb3001c 	lw	s3,28(sp)=0A=
     da8:	8fb20018 	lw	s2,24(sp)=0A=
     dac:	8fb10014 	lw	s1,20(sp)=0A=
     db0:	8fb00010 	lw	s0,16(sp)=0A=
     db4:	03e00008 	jr	ra=0A=
     db8:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
00000dbc <e1000_check_fiber_options>:=0A=
     dbc:	27bdffd8 	addiu	sp,sp,-40=0A=
     dc0:	afb40020 	sw	s4,32(sp)=0A=
     dc4:	afb3001c 	sw	s3,28(sp)=0A=
     dc8:	afb20018 	sw	s2,24(sp)=0A=
     dcc:	afb10014 	sw	s1,20(sp)=0A=
     dd0:	afbf0024 	sw	ra,36(sp)=0A=
     dd4:	afb00010 	sw	s0,16(sp)=0A=
=0A=
/**=0A=
 * e1000_check_fiber_options - Range Checking for Link Options, Fiber =
Version=0A=
 * @adapter: board private structure=0A=
 *=0A=
 * Handles speed and duplex options on fiber based adapters=0A=
 **/=0A=
=0A=
static void=0A=
e1000_check_fiber_options(struct e1000_adapter *adapter)=0A=
{=0A=
    int board =3D=0A=
     dd8:	8c830090 	lw	v1,144(a0)=0A=
        adapter->bd_number > E1000_MAX_NIC ? E1000_MAX_NIC : =
adapter->bd_number;=0A=
=0A=
    E1000_DBG("CheckSpeedDuplexFiber\n");=0A=
=0A=
    /* Speed, Duplex, and AutoNeg are not valid on fiber NICs */=0A=
=0A=
    if((Speed[board] !=3D OPTION_UNSET)) {=0A=
        Speed[board] =3D 0;=0A=
        printk("Warning: Speed not valid for fiber adapters\n");=0A=
     ddc:	3c020000 	lui	v0,0x0=0A=
     de0:	244206ac 	addiu	v0,v0,1708=0A=
     de4:	3c120000 	lui	s2,0x0=0A=
     de8:	26520000 	addiu	s2,s2,0=0A=
     dec:	00402021 	move	a0,v0=0A=
        printk("Speed Parameter Ignored\n");=0A=
    }=0A=
    if((Duplex[board] !=3D OPTION_UNSET)) {=0A=
        Duplex[board] =3D 0;=0A=
        printk("Warning: Duplex not valid for fiber adapters\n");=0A=
     df0:	02409821 	move	s3,s2=0A=
     df4:	2c620009 	sltiu	v0,v1,9=0A=
        printk("Duplex Parameter Ignored\n");=0A=
    }=0A=
    if((AutoNeg[board] !=3D OPTION_UNSET)) {=0A=
        AutoNeg[board] =3D AUTONEG_ADV_DEFAULT;=0A=
        printk("Warning: AutoNeg not valid for fiber adapters\n");=0A=
     df8:	0260a021 	move	s4,s3=0A=
     dfc:	14400002 	bnez	v0,e08 <e1000_check_fiber_options+0x4c>=0A=
     e00:	2411ffff 	li	s1,-1=0A=
     e04:	24030008 	li	v1,8=0A=
     e08:	00038080 	sll	s0,v1,0x2=0A=
     e0c:	3c030000 	lui	v1,0x0=0A=
     e10:	246302f8 	addiu	v1,v1,760=0A=
     e14:	00701821 	addu	v1,v1,s0=0A=
     e18:	8c620000 	lw	v0,0(v1)=0A=
     e1c:	10510007 	beq	v0,s1,e3c <e1000_check_fiber_options+0x80>=0A=
     e20:	00000000 	nop=0A=
     e24:	0240f809 	jalr	s2=0A=
     e28:	ac600000 	sw	zero,0(v1)=0A=
     e2c:	3c040000 	lui	a0,0x0=0A=
     e30:	248406dc 	addiu	a0,a0,1756=0A=
     e34:	0240f809 	jalr	s2=0A=
     e38:	00000000 	nop=0A=
     e3c:	3c030000 	lui	v1,0x0=0A=
     e40:	2463031c 	addiu	v1,v1,796=0A=
     e44:	00701821 	addu	v1,v1,s0=0A=
     e48:	8c620000 	lw	v0,0(v1)=0A=
     e4c:	3c040000 	lui	a0,0x0=0A=
     e50:	248406f8 	addiu	a0,a0,1784=0A=
     e54:	10510007 	beq	v0,s1,e74 <e1000_check_fiber_options+0xb8>=0A=
     e58:	00000000 	nop=0A=
     e5c:	0260f809 	jalr	s3=0A=
     e60:	ac600000 	sw	zero,0(v1)=0A=
     e64:	3c040000 	lui	a0,0x0=0A=
     e68:	24840728 	addiu	a0,a0,1832=0A=
     e6c:	0260f809 	jalr	s3=0A=
     e70:	00000000 	nop=0A=
     e74:	3c030000 	lui	v1,0x0=0A=
     e78:	24630340 	addiu	v1,v1,832=0A=
     e7c:	00701821 	addu	v1,v1,s0=0A=
     e80:	8c620000 	lw	v0,0(v1)=0A=
     e84:	3c040000 	lui	a0,0x0=0A=
     e88:	24840744 	addiu	a0,a0,1860=0A=
     e8c:	10510007 	beq	v0,s1,eac <e1000_check_fiber_options+0xf0>=0A=
     e90:	2402002f 	li	v0,47=0A=
     e94:	0280f809 	jalr	s4=0A=
     e98:	ac620000 	sw	v0,0(v1)=0A=
        printk("AutoNeg Parameter Ignored\n");=0A=
     e9c:	3c040000 	lui	a0,0x0=0A=
     ea0:	24840774 	addiu	a0,a0,1908=0A=
     ea4:	0280f809 	jalr	s4=0A=
     ea8:	00000000 	nop=0A=
    }=0A=
=0A=
    return;=0A=
}=0A=
     eac:	8fbf0024 	lw	ra,36(sp)=0A=
     eb0:	8fb40020 	lw	s4,32(sp)=0A=
     eb4:	8fb3001c 	lw	s3,28(sp)=0A=
     eb8:	8fb20018 	lw	s2,24(sp)=0A=
     ebc:	8fb10014 	lw	s1,20(sp)=0A=
     ec0:	8fb00010 	lw	s0,16(sp)=0A=
     ec4:	03e00008 	jr	ra=0A=
     ec8:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
00000ecc <e1000_check_copper_options>:=0A=
     ecc:	27bdffd0 	addiu	sp,sp,-48=0A=
     ed0:	afb20018 	sw	s2,24(sp)=0A=
     ed4:	afbf0028 	sw	ra,40(sp)=0A=
     ed8:	afb50024 	sw	s5,36(sp)=0A=
     edc:	afb40020 	sw	s4,32(sp)=0A=
     ee0:	afb3001c 	sw	s3,28(sp)=0A=
     ee4:	afb10014 	sw	s1,20(sp)=0A=
     ee8:	afb00010 	sw	s0,16(sp)=0A=
     eec:	00809021 	move	s2,a0=0A=
=0A=
/**=0A=
 * e1000_check_copper_options - Range Checking for Link Options, Copper =
Version=0A=
 * @adapter: board private structure=0A=
 *=0A=
 * Handles speed and duplex options on copper based adapters=0A=
 **/=0A=
=0A=
static void=0A=
e1000_check_copper_options(struct e1000_adapter *adapter)=0A=
{=0A=
    int board =3D=0A=
     ef0:	8e430090 	lw	v1,144(s2)=0A=
     ef4:	2c620009 	sltiu	v0,v1,9=0A=
     ef8:	50400001 	beqzl	v0,f00 <e1000_check_copper_options+0x34>=0A=
     efc:	24030008 	li	v1,8=0A=
        adapter->bd_number > E1000_MAX_NIC ? E1000_MAX_NIC : =
adapter->bd_number;=0A=
    int speed, duplex;=0A=
    boolean_t all_default =3D TRUE;=0A=
=0A=
    E1000_DBG("CheckSpeedDuplexCopper\n");=0A=
=0A=
    /* User Specified Auto-negotiation Settings */=0A=
=0A=
    if(AutoNeg[board] =3D=3D OPTION_UNSET) {=0A=
     f00:	00038880 	sll	s1,v1,0x2=0A=
     f04:	3c040000 	lui	a0,0x0=0A=
     f08:	24840340 	addiu	a0,a0,832=0A=
     f0c:	00912021 	addu	a0,a0,s1=0A=
     f10:	8c850000 	lw	a1,0(a0)=0A=
     f14:	2402ffff 	li	v0,-1=0A=
     f18:	14a2000a 	bne	a1,v0,f44 <e1000_check_copper_options+0x78>=0A=
     f1c:	24140001 	li	s4,1=0A=
=0A=
        adapter->shared.autoneg_advertised =3D AUTONEG_ADV_DEFAULT;=0A=
     f20:	2402002f 	li	v0,47=0A=
        AutoNeg[board] =3D AUTONEG_ADV_DEFAULT;=0A=
     f24:	2403002f 	li	v1,47=0A=
     f28:	a6420048 	sh	v0,72(s2)=0A=
=0A=
    } else if((Speed[board] !=3D 0 && Speed[board] !=3D OPTION_UNSET) ||=0A=
     f2c:	3c130000 	lui	s3,0x0=0A=
     f30:	267302f8 	addiu	s3,s3,760=0A=
     f34:	3c150000 	lui	s5,0x0=0A=
     f38:	26b5031c 	addiu	s5,s5,796=0A=
     f3c:	08000463 	j	118c <e1000_check_copper_options+0x2c0>=0A=
     f40:	ac830000 	sw	v1,0(a0)=0A=
     f44:	3c020000 	lui	v0,0x0=0A=
     f48:	00511021 	addu	v0,v0,s1=0A=
     f4c:	8c4202f8 	lw	v0,760(v0)=0A=
     f50:	3c130000 	lui	s3,0x0=0A=
     f54:	267302f8 	addiu	s3,s3,760=0A=
     f58:	24420001 	addiu	v0,v0,1=0A=
     f5c:	2c420002 	sltiu	v0,v0,2=0A=
     f60:	1040000c 	beqz	v0,f94 <e1000_check_copper_options+0xc8>=0A=
     f64:	00000000 	nop=0A=
     f68:	3c020000 	lui	v0,0x0=0A=
     f6c:	00511021 	addu	v0,v0,s1=0A=
     f70:	8c42031c 	lw	v0,796(v0)=0A=
     f74:	3c150000 	lui	s5,0x0=0A=
     f78:	26b5031c 	addiu	s5,s5,796=0A=
     f7c:	24420001 	addiu	v0,v0,1=0A=
     f80:	2c420002 	sltiu	v0,v0,2=0A=
     f84:	14400012 	bnez	v0,fd0 <e1000_check_copper_options+0x104>=0A=
     f88:	2402ffd0 	li	v0,-48=0A=
     f8c:	080003e7 	j	f9c <e1000_check_copper_options+0xd0>=0A=
     f90:	00000000 	nop=0A=
     f94:	3c150000 	lui	s5,0x0=0A=
     f98:	26b5031c 	addiu	s5,s5,796=0A=
              (Duplex[board] !=3D 0 && Duplex[board] !=3D OPTION_UNSET)) =
{=0A=
=0A=
        printk("Warning: AutoNeg specified along with Speed or =
Duplex\n");=0A=
     f9c:	3c040000 	lui	a0,0x0=0A=
     fa0:	24840790 	addiu	a0,a0,1936=0A=
     fa4:	3c100000 	lui	s0,0x0=0A=
     fa8:	26100000 	addiu	s0,s0,0=0A=
     fac:	0200f809 	jalr	s0=0A=
     fb0:	00000000 	nop=0A=
        printk("AutoNeg Parameter Ignored\n");=0A=
     fb4:	3c040000 	lui	a0,0x0=0A=
     fb8:	24840774 	addiu	a0,a0,1908=0A=
     fbc:	0200f809 	jalr	s0=0A=
     fc0:	00000000 	nop=0A=
=0A=
        adapter->shared.autoneg_advertised =3D AUTONEG_ADV_DEFAULT;=0A=
     fc4:	2403002f 	li	v1,47=0A=
=0A=
    } else {=0A=
     fc8:	08000463 	j	118c <e1000_check_copper_options+0x2c0>=0A=
     fcc:	a6430048 	sh	v1,72(s2)=0A=
=0A=
        if(AutoNeg[board] & ~AUTONEG_ADV_MASK) {=0A=
     fd0:	00a21024 	and	v0,a1,v0=0A=
     fd4:	5040000a 	beqzl	v0,1000 <e1000_check_copper_options+0x134>=0A=
     fd8:	94820002 	lhu	v0,2(a0)=0A=
=0A=
            printk("Invalid AutoNeg Specified (0x%X), Parameter =
Ignored\n",=0A=
     fdc:	3c040000 	lui	a0,0x0=0A=
     fe0:	248407c8 	addiu	a0,a0,1992=0A=
     fe4:	3c100000 	lui	s0,0x0=0A=
     fe8:	26100000 	addiu	s0,s0,0=0A=
     fec:	0200f809 	jalr	s0=0A=
     ff0:	00000000 	nop=0A=
                   AutoNeg[board]);=0A=
=0A=
            adapter->shared.autoneg_advertised =3D AUTONEG_ADV_DEFAULT;=0A=
     ff4:	2403002f 	li	v1,47=0A=
=0A=
        } else {=0A=
     ff8:	08000403 	j	100c <e1000_check_copper_options+0x140>=0A=
     ffc:	a6430048 	sh	v1,72(s2)=0A=
=0A=
            adapter->shared.autoneg_advertised =3D AutoNeg[board];=0A=
    1000:	3c100000 	lui	s0,0x0=0A=
    1004:	26100000 	addiu	s0,s0,0=0A=
    1008:	a6420048 	sh	v0,72(s2)=0A=
        }=0A=
=0A=
        printk("AutoNeg Advertising ");=0A=
    100c:	3c040000 	lui	a0,0x0=0A=
    1010:	24840800 	addiu	a0,a0,2048=0A=
    1014:	0200f809 	jalr	s0=0A=
    1018:	00000000 	nop=0A=
        if(adapter->shared.autoneg_advertised & ADVERTISE_1000_FULL) {=0A=
    101c:	96430048 	lhu	v1,72(s2)=0A=
    1020:	30620020 	andi	v0,v1,0x20=0A=
    1024:	5040000f 	beqzl	v0,1064 <e1000_check_copper_options+0x198>=0A=
    1028:	30620010 	andi	v0,v1,0x10=0A=
            printk("1000/FD");=0A=
    102c:	3c040000 	lui	a0,0x0=0A=
    1030:	24840818 	addiu	a0,a0,2072=0A=
    1034:	0200f809 	jalr	s0=0A=
    1038:	00000000 	nop=0A=
            if(adapter->shared.autoneg_advertised & (ADVERTISE_1000_FULL =
- 1))=0A=
    103c:	96430048 	lhu	v1,72(s2)=0A=
    1040:	3062001f 	andi	v0,v1,0x1f=0A=
    1044:	50400007 	beqzl	v0,1064 <e1000_check_copper_options+0x198>=0A=
    1048:	30620010 	andi	v0,v1,0x10=0A=
                printk(", ");=0A=
    104c:	3c040000 	lui	a0,0x0=0A=
    1050:	24840820 	addiu	a0,a0,2080=0A=
    1054:	0200f809 	jalr	s0=0A=
    1058:	00000000 	nop=0A=
    105c:	96430048 	lhu	v1,72(s2)=0A=
        }=0A=
        if(adapter->shared.autoneg_advertised & ADVERTISE_1000_HALF) {=0A=
    1060:	30620010 	andi	v0,v1,0x10=0A=
    1064:	5040000f 	beqzl	v0,10a4 <e1000_check_copper_options+0x1d8>=0A=
    1068:	30620008 	andi	v0,v1,0x8=0A=
            printk("1000/HD");=0A=
    106c:	3c040000 	lui	a0,0x0=0A=
    1070:	24840824 	addiu	a0,a0,2084=0A=
    1074:	0200f809 	jalr	s0=0A=
    1078:	00000000 	nop=0A=
            if(adapter->shared.autoneg_advertised & (ADVERTISE_1000_HALF =
- 1))=0A=
    107c:	96430048 	lhu	v1,72(s2)=0A=
    1080:	3062000f 	andi	v0,v1,0xf=0A=
    1084:	50400007 	beqzl	v0,10a4 <e1000_check_copper_options+0x1d8>=0A=
    1088:	30620008 	andi	v0,v1,0x8=0A=
                printk(", ");=0A=
    108c:	3c040000 	lui	a0,0x0=0A=
    1090:	24840820 	addiu	a0,a0,2080=0A=
    1094:	0200f809 	jalr	s0=0A=
    1098:	00000000 	nop=0A=
    109c:	96430048 	lhu	v1,72(s2)=0A=
        }=0A=
        if(adapter->shared.autoneg_advertised & ADVERTISE_100_FULL) {=0A=
    10a0:	30620008 	andi	v0,v1,0x8=0A=
    10a4:	5040000f 	beqzl	v0,10e4 <e1000_check_copper_options+0x218>=0A=
    10a8:	30620004 	andi	v0,v1,0x4=0A=
            printk("100/FD");=0A=
    10ac:	3c040000 	lui	a0,0x0=0A=
    10b0:	2484082c 	addiu	a0,a0,2092=0A=
    10b4:	0200f809 	jalr	s0=0A=
    10b8:	00000000 	nop=0A=
            if(adapter->shared.autoneg_advertised & (ADVERTISE_100_FULL =
- 1))=0A=
    10bc:	96430048 	lhu	v1,72(s2)=0A=
    10c0:	30620007 	andi	v0,v1,0x7=0A=
    10c4:	50400007 	beqzl	v0,10e4 <e1000_check_copper_options+0x218>=0A=
    10c8:	30620004 	andi	v0,v1,0x4=0A=
                printk(", ");=0A=
    10cc:	3c040000 	lui	a0,0x0=0A=
    10d0:	24840820 	addiu	a0,a0,2080=0A=
    10d4:	0200f809 	jalr	s0=0A=
    10d8:	00000000 	nop=0A=
    10dc:	96430048 	lhu	v1,72(s2)=0A=
        }=0A=
        if(adapter->shared.autoneg_advertised & ADVERTISE_100_HALF) {=0A=
    10e0:	30620004 	andi	v0,v1,0x4=0A=
    10e4:	5040000f 	beqzl	v0,1124 <e1000_check_copper_options+0x258>=0A=
    10e8:	30620002 	andi	v0,v1,0x2=0A=
            printk("100/HD");=0A=
    10ec:	3c040000 	lui	a0,0x0=0A=
    10f0:	24840834 	addiu	a0,a0,2100=0A=
    10f4:	0200f809 	jalr	s0=0A=
    10f8:	00000000 	nop=0A=
            if(adapter->shared.autoneg_advertised & (ADVERTISE_100_HALF =
- 1))=0A=
    10fc:	96430048 	lhu	v1,72(s2)=0A=
    1100:	30620003 	andi	v0,v1,0x3=0A=
    1104:	50400007 	beqzl	v0,1124 <e1000_check_copper_options+0x258>=0A=
    1108:	30620002 	andi	v0,v1,0x2=0A=
                printk(", ");=0A=
    110c:	3c040000 	lui	a0,0x0=0A=
    1110:	24840820 	addiu	a0,a0,2080=0A=
    1114:	0200f809 	jalr	s0=0A=
    1118:	00000000 	nop=0A=
    111c:	96430048 	lhu	v1,72(s2)=0A=
        }=0A=
        if(adapter->shared.autoneg_advertised & ADVERTISE_10_FULL) {=0A=
    1120:	30620002 	andi	v0,v1,0x2=0A=
    1124:	5040000f 	beqzl	v0,1164 <e1000_check_copper_options+0x298>=0A=
    1128:	30620001 	andi	v0,v1,0x1=0A=
            printk("10/FD");=0A=
    112c:	3c040000 	lui	a0,0x0=0A=
    1130:	2484083c 	addiu	a0,a0,2108=0A=
    1134:	0200f809 	jalr	s0=0A=
    1138:	00000000 	nop=0A=
            if(adapter->shared.autoneg_advertised & (ADVERTISE_10_FULL - =
1))=0A=
    113c:	96430048 	lhu	v1,72(s2)=0A=
    1140:	30630001 	andi	v1,v1,0x1=0A=
    1144:	1060000d 	beqz	v1,117c <e1000_check_copper_options+0x2b0>=0A=
    1148:	00000000 	nop=0A=
                printk(", ");=0A=
    114c:	3c040000 	lui	a0,0x0=0A=
    1150:	24840820 	addiu	a0,a0,2080=0A=
    1154:	0200f809 	jalr	s0=0A=
    1158:	00000000 	nop=0A=
    115c:	96430048 	lhu	v1,72(s2)=0A=
        }=0A=
        if(adapter->shared.autoneg_advertised & ADVERTISE_10_HALF)=0A=
    1160:	30620001 	andi	v0,v1,0x1=0A=
    1164:	10400005 	beqz	v0,117c <e1000_check_copper_options+0x2b0>=0A=
    1168:	00000000 	nop=0A=
            printk("10/HD");=0A=
    116c:	3c040000 	lui	a0,0x0=0A=
    1170:	24840844 	addiu	a0,a0,2116=0A=
    1174:	0200f809 	jalr	s0=0A=
    1178:	00000000 	nop=0A=
        printk("\n");=0A=
    117c:	3c040000 	lui	a0,0x0=0A=
    1180:	2484084c 	addiu	a0,a0,2124=0A=
    1184:	0200f809 	jalr	s0=0A=
    1188:	00000000 	nop=0A=
    }=0A=
=0A=
    /* Forced Speed and Duplex */=0A=
=0A=
    switch (Speed[board]) {=0A=
    118c:	02331021 	addu	v0,s1,s3=0A=
    1190:	8c440000 	lw	a0,0(v0)=0A=
    1194:	2403000a 	li	v1,10=0A=
    1198:	10830019 	beq	a0,v1,1200 <e1000_check_copper_options+0x334>=0A=
    119c:	2882000b 	slti	v0,a0,11=0A=
    11a0:	10400008 	beqz	v0,11c4 <e1000_check_copper_options+0x2f8>=0A=
    11a4:	24020064 	li	v0,100=0A=
    11a8:	2402ffff 	li	v0,-1=0A=
    11ac:	10820011 	beq	a0,v0,11f4 <e1000_check_copper_options+0x328>=0A=
    11b0:	02331021 	addu	v0,s1,s3=0A=
    11b4:	50800014 	beqzl	a0,1208 <e1000_check_copper_options+0x33c>=0A=
    11b8:	8c500000 	lw	s0,0(v0)=0A=
    11bc:	08000476 	j	11d8 <e1000_check_copper_options+0x30c>=0A=
    11c0:	8c450000 	lw	a1,0(v0)=0A=
    11c4:	1082000e 	beq	a0,v0,1200 <e1000_check_copper_options+0x334>=0A=
    11c8:	240203e8 	li	v0,1000=0A=
    11cc:	1082000c 	beq	a0,v0,1200 <e1000_check_copper_options+0x334>=0A=
    11d0:	02331021 	addu	v0,s1,s3=0A=
    default:=0A=
        printk("Invalid Speed Specified (%i), Parameter Ignored\n",=0A=
    11d4:	8c450000 	lw	a1,0(v0)=0A=
    11d8:	3c040000 	lui	a0,0x0=0A=
    11dc:	24840850 	addiu	a0,a0,2128=0A=
    11e0:	3c020000 	lui	v0,0x0=0A=
    11e4:	24420000 	addiu	v0,v0,0=0A=
    11e8:	0040f809 	jalr	v0=0A=
    11ec:	0000a021 	move	s4,zero=0A=
               Speed[board]);=0A=
        all_default =3D FALSE;=0A=
    case OPTION_UNSET:=0A=
        speed =3D 0;=0A=
        Speed[board] =3D 0;=0A=
    11f0:	02331021 	addu	v0,s1,s3=0A=
    11f4:	ac400000 	sw	zero,0(v0)=0A=
        break;=0A=
    11f8:	08000483 	j	120c <e1000_check_copper_options+0x340>=0A=
    11fc:	00008021 	move	s0,zero=0A=
    case 0:=0A=
    case 10:=0A=
    case 100:=0A=
    case 1000:=0A=
        speed =3D Speed[board];=0A=
    1200:	02331021 	addu	v0,s1,s3=0A=
    1204:	8c500000 	lw	s0,0(v0)=0A=
        all_default =3D FALSE;=0A=
    1208:	0000a021 	move	s4,zero=0A=
        break;=0A=
    }=0A=
=0A=
    switch (Duplex[board]) {=0A=
    120c:	02351021 	addu	v0,s1,s5=0A=
    1210:	8c450000 	lw	a1,0(v0)=0A=
    1214:	2403ffff 	li	v1,-1=0A=
    1218:	10a3000b 	beq	a1,v1,1248 <e1000_check_copper_options+0x37c>=0A=
    121c:	28a2ffff 	slti	v0,a1,-1=0A=
    1220:	14400003 	bnez	v0,1230 <e1000_check_copper_options+0x364>=0A=
    1224:	28a20003 	slti	v0,a1,3=0A=
    1228:	5440000a 	bnezl	v0,1254 <e1000_check_copper_options+0x388>=0A=
    122c:	0000a021 	move	s4,zero=0A=
    default:=0A=
        printk("Invalid Duplex Specified (%i), Parameter Ignored\n",=0A=
    1230:	3c040000 	lui	a0,0x0=0A=
    1234:	24840884 	addiu	a0,a0,2180=0A=
    1238:	3c020000 	lui	v0,0x0=0A=
    123c:	24420000 	addiu	v0,v0,0=0A=
    1240:	0040f809 	jalr	v0=0A=
    1244:	0000a021 	move	s4,zero=0A=
               Duplex[board]);=0A=
        all_default =3D FALSE;=0A=
    case OPTION_UNSET:=0A=
        duplex =3D 0;=0A=
        Duplex[board] =3D 0;=0A=
    1248:	02351021 	addu	v0,s1,s5=0A=
    124c:	ac400000 	sw	zero,0(v0)=0A=
        break;=0A=
    1250:	00002821 	move	a1,zero=0A=
    case 0:=0A=
    case 1:=0A=
    case 2:=0A=
        duplex =3D Duplex[board];=0A=
        all_default =3D FALSE;=0A=
        break;=0A=
    }=0A=
=0A=
    switch (speed + duplex) {=0A=
    1254:	02058821 	addu	s1,s0,a1=0A=
    1258:	2413000c 	li	s3,12=0A=
    125c:	12330069 	beq	s1,s3,1404 <e1000_check_copper_options+0x538>=0A=
    1260:	2a22000d 	slti	v0,s1,13=0A=
    1264:	10400012 	beqz	v0,12b0 <e1000_check_copper_options+0x3e4>=0A=
    1268:	24020066 	li	v0,102=0A=
    126c:	24020002 	li	v0,2=0A=
    1270:	12220040 	beq	s1,v0,1374 <e1000_check_copper_options+0x4a8>=0A=
    1274:	2a220003 	slti	v0,s1,3=0A=
    1278:	10400007 	beqz	v0,1298 <e1000_check_copper_options+0x3cc>=0A=
    127c:	2402000a 	li	v0,10=0A=
    1280:	12200023 	beqz	s1,1310 <e1000_check_copper_options+0x444>=0A=
    1284:	24020001 	li	v0,1=0A=
    1288:	1222002c 	beq	s1,v0,133c <e1000_check_copper_options+0x470>=0A=
    128c:	00000000 	nop=0A=
    1290:	0800054d 	j	1534 <e1000_check_copper_options+0x668>=0A=
    1294:	00000000 	nop=0A=
    1298:	12220043 	beq	s1,v0,13a8 <e1000_check_copper_options+0x4dc>=0A=
    129c:	2402000b 	li	v0,11=0A=
    12a0:	1222004e 	beq	s1,v0,13dc <e1000_check_copper_options+0x510>=0A=
    12a4:	00000000 	nop=0A=
    12a8:	0800054d 	j	1534 <e1000_check_copper_options+0x668>=0A=
    12ac:	00000000 	nop=0A=
    12b0:	12220072 	beq	s1,v0,147c <e1000_check_copper_options+0x5b0>=0A=
    12b4:	2a220067 	slti	v0,s1,103=0A=
    12b8:	10400008 	beqz	v0,12dc <e1000_check_copper_options+0x410>=0A=
    12bc:	240203e9 	li	v0,1001=0A=
    12c0:	24020064 	li	v0,100=0A=
    12c4:	12220057 	beq	s1,v0,1424 <e1000_check_copper_options+0x558>=0A=
    12c8:	24020065 	li	v0,101=0A=
    12cc:	12220063 	beq	s1,v0,145c <e1000_check_copper_options+0x590>=0A=
    12d0:	00000000 	nop=0A=
    12d4:	0800054d 	j	1534 <e1000_check_copper_options+0x668>=0A=
    12d8:	00000000 	nop=0A=
    12dc:	1222007e 	beq	s1,v0,14d8 <e1000_check_copper_options+0x60c>=0A=
    12e0:	2a2203ea 	slti	v0,s1,1002=0A=
    12e4:	10400006 	beqz	v0,1300 <e1000_check_copper_options+0x434>=0A=
    12e8:	240203ea 	li	v0,1002=0A=
    12ec:	240203e8 	li	v0,1000=0A=
    12f0:	1222006d 	beq	s1,v0,14a8 <e1000_check_copper_options+0x5dc>=0A=
    12f4:	00000000 	nop=0A=
    12f8:	0800054d 	j	1534 <e1000_check_copper_options+0x668>=0A=
    12fc:	00000000 	nop=0A=
    1300:	12220081 	beq	s1,v0,1508 <e1000_check_copper_options+0x63c>=0A=
    1304:	00000000 	nop=0A=
    1308:	0800054d 	j	1534 <e1000_check_copper_options+0x668>=0A=
    130c:	00000000 	nop=0A=
    case 0:=0A=
        if(all_default =3D=3D FALSE)=0A=
    1310:	16800008 	bnez	s4,1334 <e1000_check_copper_options+0x468>=0A=
    1314:	24020001 	li	v0,1=0A=
            printk("Speed and Duplex Auto-negotiation Enabled\n");=0A=
    1318:	3c040000 	lui	a0,0x0=0A=
    131c:	248408b8 	addiu	a0,a0,2232=0A=
    1320:	3c020000 	lui	v0,0x0=0A=
    1324:	24420000 	addiu	v0,v0,0=0A=
    1328:	0040f809 	jalr	v0=0A=
    132c:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 1;=0A=
    1330:	24020001 	li	v0,1=0A=
        break;=0A=
    1334:	08000553 	j	154c <e1000_check_copper_options+0x680>=0A=
    1338:	a2420078 	sb	v0,120(s2)=0A=
    case 1:=0A=
        printk("Warning: Half Duplex specified without Speed\n");=0A=
    133c:	3c040000 	lui	a0,0x0=0A=
    1340:	248408e4 	addiu	a0,a0,2276=0A=
    1344:	3c100000 	lui	s0,0x0=0A=
    1348:	26100000 	addiu	s0,s0,0=0A=
    134c:	0200f809 	jalr	s0=0A=
    1350:	00000000 	nop=0A=
        printk("Using Auto-negotiation at Half Duplex only\n");=0A=
    1354:	3c040000 	lui	a0,0x0=0A=
    1358:	24840914 	addiu	a0,a0,2324=0A=
    135c:	0200f809 	jalr	s0=0A=
    1360:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 1;=0A=
        adapter->shared.autoneg_advertised =3D=0A=
    1364:	24030005 	li	v1,5=0A=
    1368:	a2510078 	sb	s1,120(s2)=0A=
            ADVERTISE_10_HALF | ADVERTISE_100_HALF;=0A=
        break;=0A=
    136c:	08000553 	j	154c <e1000_check_copper_options+0x680>=0A=
    1370:	a6430048 	sh	v1,72(s2)=0A=
    case 2:=0A=
        printk("Warning: Full Duplex specified without Speed\n");=0A=
    1374:	3c040000 	lui	a0,0x0=0A=
    1378:	24840940 	addiu	a0,a0,2368=0A=
    137c:	3c100000 	lui	s0,0x0=0A=
    1380:	26100000 	addiu	s0,s0,0=0A=
    1384:	0200f809 	jalr	s0=0A=
    1388:	00000000 	nop=0A=
        printk("Using Auto-negotiation at Full Duplex only\n");=0A=
    138c:	3c040000 	lui	a0,0x0=0A=
    1390:	24840970 	addiu	a0,a0,2416=0A=
    1394:	0200f809 	jalr	s0=0A=
    1398:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 1;=0A=
    139c:	24030001 	li	v1,1=0A=
        adapter->shared.autoneg_advertised =3D=0A=
            ADVERTISE_10_FULL | ADVERTISE_100_FULL | ADVERTISE_1000_FULL;=0A=
        break;=0A=
    13a0:	0800054a 	j	1528 <e1000_check_copper_options+0x65c>=0A=
    13a4:	2402002a 	li	v0,42=0A=
    case 10:=0A=
        printk("Warning: 10 Mbps Speed specified without Duplex\n");=0A=
    13a8:	3c040000 	lui	a0,0x0=0A=
    13ac:	2484099c 	addiu	a0,a0,2460=0A=
    13b0:	3c100000 	lui	s0,0x0=0A=
    13b4:	26100000 	addiu	s0,s0,0=0A=
    13b8:	0200f809 	jalr	s0=0A=
    13bc:	00000000 	nop=0A=
        printk("Using Auto-negotiation at 10 Mbps only\n");=0A=
    13c0:	3c040000 	lui	a0,0x0=0A=
    13c4:	248409d0 	addiu	a0,a0,2512=0A=
    13c8:	0200f809 	jalr	s0=0A=
    13cc:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 1;=0A=
    13d0:	24030001 	li	v1,1=0A=
        adapter->shared.autoneg_advertised =3D=0A=
            ADVERTISE_10_HALF | ADVERTISE_10_FULL;=0A=
        break;=0A=
    13d4:	0800054a 	j	1528 <e1000_check_copper_options+0x65c>=0A=
    13d8:	24020003 	li	v0,3=0A=
    case 11:=0A=
        printk("Forcing to 10 Mbps Half Duplex\n");=0A=
    13dc:	3c040000 	lui	a0,0x0=0A=
    13e0:	248409f8 	addiu	a0,a0,2552=0A=
    13e4:	3c020000 	lui	v0,0x0=0A=
    13e8:	24420000 	addiu	v0,v0,0=0A=
    13ec:	0040f809 	jalr	v0=0A=
    13f0:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 0;=0A=
    13f4:	a2400078 	sb	zero,120(s2)=0A=
        adapter->shared.forced_speed_duplex =3D e1000_10_half;=0A=
    13f8:	a240007a 	sb	zero,122(s2)=0A=
        adapter->shared.autoneg_advertised =3D 0;=0A=
        break;=0A=
    13fc:	08000553 	j	154c <e1000_check_copper_options+0x680>=0A=
    1400:	a6400048 	sh	zero,72(s2)=0A=
    case 12:=0A=
        printk("Forcing to 10 Mbps Full Duplex\n");=0A=
    1404:	3c040000 	lui	a0,0x0=0A=
    1408:	24840a18 	addiu	a0,a0,2584=0A=
    140c:	3c020000 	lui	v0,0x0=0A=
    1410:	24420000 	addiu	v0,v0,0=0A=
    1414:	0040f809 	jalr	v0=0A=
    1418:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 0;=0A=
        adapter->shared.forced_speed_duplex =3D e1000_10_full;=0A=
        adapter->shared.autoneg_advertised =3D 0;=0A=
        break;=0A=
    141c:	08000526 	j	1498 <e1000_check_copper_options+0x5cc>=0A=
    1420:	24030001 	li	v1,1=0A=
    case 100:=0A=
        printk("Warning: 100 Mbps Speed specified without Duplex\n");=0A=
    1424:	3c040000 	lui	a0,0x0=0A=
    1428:	24840a38 	addiu	a0,a0,2616=0A=
    142c:	3c100000 	lui	s0,0x0=0A=
    1430:	26100000 	addiu	s0,s0,0=0A=
    1434:	0200f809 	jalr	s0=0A=
    1438:	00000000 	nop=0A=
        printk("Using Auto-negotiation at 100 Mbps only\n");=0A=
    143c:	3c040000 	lui	a0,0x0=0A=
    1440:	24840a6c 	addiu	a0,a0,2668=0A=
    1444:	0200f809 	jalr	s0=0A=
    1448:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 1;=0A=
    144c:	24030001 	li	v1,1=0A=
    1450:	a2430078 	sb	v1,120(s2)=0A=
        adapter->shared.autoneg_advertised =3D=0A=
            ADVERTISE_100_HALF | ADVERTISE_100_FULL;=0A=
        break;=0A=
    1454:	08000553 	j	154c <e1000_check_copper_options+0x680>=0A=
    1458:	a6530048 	sh	s3,72(s2)=0A=
    case 101:=0A=
        printk("Forcing to 100 Mbps Half Duplex\n");=0A=
    145c:	3c040000 	lui	a0,0x0=0A=
    1460:	24840a98 	addiu	a0,a0,2712=0A=
    1464:	3c020000 	lui	v0,0x0=0A=
    1468:	24420000 	addiu	v0,v0,0=0A=
    146c:	0040f809 	jalr	v0=0A=
    1470:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 0;=0A=
        adapter->shared.forced_speed_duplex =3D e1000_100_half;=0A=
        adapter->shared.autoneg_advertised =3D 0;=0A=
        break;=0A=
    1474:	08000526 	j	1498 <e1000_check_copper_options+0x5cc>=0A=
    1478:	24030002 	li	v1,2=0A=
    case 102:=0A=
        printk("Forcing to 100 Mbps Full Duplex\n");=0A=
    147c:	3c040000 	lui	a0,0x0=0A=
    1480:	24840abc 	addiu	a0,a0,2748=0A=
    1484:	3c020000 	lui	v0,0x0=0A=
    1488:	24420000 	addiu	v0,v0,0=0A=
    148c:	0040f809 	jalr	v0=0A=
    1490:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 0;=0A=
        adapter->shared.forced_speed_duplex =3D e1000_100_full;=0A=
    1494:	24030003 	li	v1,3=0A=
    1498:	a243007a 	sb	v1,122(s2)=0A=
    149c:	a2400078 	sb	zero,120(s2)=0A=
        adapter->shared.autoneg_advertised =3D 0;=0A=
        break;=0A=
    14a0:	08000553 	j	154c <e1000_check_copper_options+0x680>=0A=
    14a4:	a6400048 	sh	zero,72(s2)=0A=
    case 1000:=0A=
        printk("Warning: 1000 Mbps Speed specified without Duplex\n");=0A=
    14a8:	3c040000 	lui	a0,0x0=0A=
    14ac:	24840ae0 	addiu	a0,a0,2784=0A=
    14b0:	3c100000 	lui	s0,0x0=0A=
    14b4:	26100000 	addiu	s0,s0,0=0A=
    14b8:	0200f809 	jalr	s0=0A=
    14bc:	00000000 	nop=0A=
        printk("Using Auto-negotiation at 1000 Mbps Full Duplex only\n");=0A=
    14c0:	3c040000 	lui	a0,0x0=0A=
    14c4:	24840b14 	addiu	a0,a0,2836=0A=
    14c8:	0200f809 	jalr	s0=0A=
    14cc:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 1;=0A=
        adapter->shared.autoneg_advertised =3D ADVERTISE_1000_FULL;=0A=
        break;=0A=
    14d0:	08000549 	j	1524 <e1000_check_copper_options+0x658>=0A=
    14d4:	24030001 	li	v1,1=0A=
    case 1001:=0A=
        printk("Warning: Half Duplex is not supported at 1000 Mbps\n");=0A=
    14d8:	3c040000 	lui	a0,0x0=0A=
    14dc:	24840b4c 	addiu	a0,a0,2892=0A=
    14e0:	3c100000 	lui	s0,0x0=0A=
    14e4:	26100000 	addiu	s0,s0,0=0A=
    14e8:	0200f809 	jalr	s0=0A=
    14ec:	00000000 	nop=0A=
        printk("Using Auto-negotiation at 1000 Mbps Full Duplex only\n");=0A=
    14f0:	3c040000 	lui	a0,0x0=0A=
    14f4:	24840b14 	addiu	a0,a0,2836=0A=
    14f8:	0200f809 	jalr	s0=0A=
    14fc:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 1;=0A=
        adapter->shared.autoneg_advertised =3D ADVERTISE_1000_FULL;=0A=
        break;=0A=
    1500:	08000549 	j	1524 <e1000_check_copper_options+0x658>=0A=
    1504:	24030001 	li	v1,1=0A=
    case 1002:=0A=
        printk("Using Auto-negotiation at 1000 Mbps Full Duplex only\n");=0A=
    1508:	3c040000 	lui	a0,0x0=0A=
    150c:	24840b14 	addiu	a0,a0,2836=0A=
    1510:	3c020000 	lui	v0,0x0=0A=
    1514:	24420000 	addiu	v0,v0,0=0A=
    1518:	0040f809 	jalr	v0=0A=
    151c:	00000000 	nop=0A=
        adapter->shared.autoneg =3D 1;=0A=
    1520:	24030001 	li	v1,1=0A=
        adapter->shared.autoneg_advertised =3D ADVERTISE_1000_FULL;=0A=
    1524:	24020020 	li	v0,32=0A=
    1528:	a2430078 	sb	v1,120(s2)=0A=
        break;=0A=
    152c:	08000553 	j	154c <e1000_check_copper_options+0x680>=0A=
    1530:	a6420048 	sh	v0,72(s2)=0A=
    default:=0A=
        panic("something is wrong in e1000_check_copper_options");=0A=
    1534:	3c040000 	lui	a0,0x0=0A=
    1538:	24840b80 	addiu	a0,a0,2944=0A=
    153c:	3c020000 	lui	v0,0x0=0A=
    1540:	24420000 	addiu	v0,v0,0=0A=
    1544:	0040f809 	jalr	v0=0A=
    1548:	00000000 	nop=0A=
    }=0A=
=0A=
    /* Speed, AutoNeg and MDI/MDI-X */=0A=
    if (!e1000_validate_mdi_setting(&(adapter->shared))) {=0A=
    154c:	3c020000 	lui	v0,0x0=0A=
    1550:	24420000 	addiu	v0,v0,0=0A=
    1554:	0040f809 	jalr	v0=0A=
    1558:	26440008 	addiu	a0,s2,8=0A=
    155c:	14400008 	bnez	v0,1580 <e1000_check_copper_options+0x6b4>=0A=
    1560:	8fbf0028 	lw	ra,40(sp)=0A=
        printk ("Speed, AutoNeg and MDI-X specifications are =
incompatible."=0A=
    1564:	3c040000 	lui	a0,0x0=0A=
    1568:	24840bb4 	addiu	a0,a0,2996=0A=
    156c:	3c020000 	lui	v0,0x0=0A=
    1570:	24420000 	addiu	v0,v0,0=0A=
    1574:	0040f809 	jalr	v0=0A=
    1578:	00000000 	nop=0A=
                " Setting MDI-X to a compatible value.\n");=0A=
    }=0A=
=0A=
    return;=0A=
}=0A=
    157c:	8fbf0028 	lw	ra,40(sp)=0A=
    1580:	8fb50024 	lw	s5,36(sp)=0A=
    1584:	8fb40020 	lw	s4,32(sp)=0A=
    1588:	8fb3001c 	lw	s3,28(sp)=0A=
    158c:	8fb20018 	lw	s2,24(sp)=0A=
    1590:	8fb10014 	lw	s1,20(sp)=0A=
    1594:	8fb00010 	lw	s0,16(sp)=0A=
    1598:	03e00008 	jr	ra=0A=
    159c:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
000015a0 <e1000_sw_init>:=0A=
    15a0:	27bdffd8 	addiu	sp,sp,-40=0A=
    15a4:	afb20018 	sw	s2,24(sp)=0A=
    15a8:	afb10014 	sw	s1,20(sp)=0A=
    15ac:	00809021 	move	s2,a0=0A=
    15b0:	afbf0020 	sw	ra,32(sp)=0A=
    15b4:	afb3001c 	sw	s3,28(sp)=0A=
    15b8:	afb00010 	sw	s0,16(sp)=0A=
=0A=
/**=0A=
 * e1000_sw_init - Initialize general software structures (struct =
e1000_adapter)=0A=
 * @adapter: board private structure to initialize=0A=
 *=0A=
 * Returns 0 on success, negative on failure=0A=
 *=0A=
 * e1000_sw_init initializes the Adapter private data structure.=0A=
 * Fields are initialized based on PCI device information and=0A=
 * OS network device settings (MTU size).=0A=
 **/=0A=
=0A=
static int=0A=
e1000_sw_init(struct e1000_adapter *adapter)=0A=
{=0A=
    struct net_device *netdev =3D adapter->netdev;=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    15bc:	8e50014c 	lw	s0,332(s2)=0A=
    uint32_t status;=0A=
=0A=
    E1000_DBG("e1000_sw_init\n");=0A=
=0A=
    /* PCI config space info */=0A=
=0A=
    pci_read_config_word(pdev, PCI_VENDOR_ID, &adapter->vendor_id);=0A=
    15c0:	3c110000 	lui	s1,0x0=0A=
    15c4:	26310000 	addiu	s1,s1,0=0A=
    15c8:	264600bc 	addiu	a2,s2,188=0A=
    15cc:	02002021 	move	a0,s0=0A=
    15d0:	00002821 	move	a1,zero=0A=
    15d4:	0220f809 	jalr	s1=0A=
    15d8:	8e530148 	lw	s3,328(s2)=0A=
    pci_read_config_word(pdev, PCI_DEVICE_ID, &adapter->device_id);=0A=
    15dc:	264600be 	addiu	a2,s2,190=0A=
    15e0:	02002021 	move	a0,s0=0A=
    15e4:	0220f809 	jalr	s1=0A=
    15e8:	24050002 	li	a1,2=0A=
    pci_read_config_byte(pdev, PCI_REVISION_ID, &adapter->rev_id);=0A=
    15ec:	264600c0 	addiu	a2,s2,192=0A=
    15f0:	02002021 	move	a0,s0=0A=
    15f4:	3c020000 	lui	v0,0x0=0A=
    15f8:	24420000 	addiu	v0,v0,0=0A=
    15fc:	0040f809 	jalr	v0=0A=
    1600:	24050008 	li	a1,8=0A=
    pci_read_config_word(pdev, PCI_SUBSYSTEM_VENDOR_ID, =
&adapter->subven_id);=0A=
    1604:	264600c2 	addiu	a2,s2,194=0A=
    1608:	02002021 	move	a0,s0=0A=
    160c:	0220f809 	jalr	s1=0A=
    1610:	2405002c 	li	a1,44=0A=
    pci_read_config_word(pdev, PCI_SUBSYSTEM_ID, &adapter->subsys_id);=0A=
    1614:	264600c4 	addiu	a2,s2,196=0A=
    1618:	02002021 	move	a0,s0=0A=
    161c:	0220f809 	jalr	s1=0A=
    1620:	2405002e 	li	a1,46=0A=
    pci_read_config_word(pdev, PCI_COMMAND, =
&adapter->shared.pci_cmd_word);=0A=
    1624:	2646004a 	addiu	a2,s2,74=0A=
    1628:	02002021 	move	a0,s0=0A=
    162c:	0220f809 	jalr	s1=0A=
    1630:	24050004 	li	a1,4=0A=
=0A=
    /* Initial Receive Buffer Length */=0A=
=0A=
    if((netdev->mtu + ENET_HEADER_SIZE + CRC_LENGTH) < =
E1000_RXBUFFER_2048)=0A=
    1634:	8e63005c 	lw	v1,92(s3)=0A=
    1638:	24630012 	addiu	v1,v1,18=0A=
    163c:	2c620800 	sltiu	v0,v1,2048=0A=
    1640:	50400003 	beqzl	v0,1650 <e1000_sw_init+0xb0>=0A=
    1644:	2c621000 	sltiu	v0,v1,4096=0A=
        adapter->rx_buffer_len =3D E1000_RXBUFFER_2048;=0A=
    1648:	0800059b 	j	166c <e1000_sw_init+0xcc>=0A=
    164c:	24020800 	li	v0,2048=0A=
    else if((netdev->mtu + ENET_HEADER_SIZE + CRC_LENGTH) < =
E1000_RXBUFFER_4096)=0A=
    1650:	50400003 	beqzl	v0,1660 <e1000_sw_init+0xc0>=0A=
    1654:	2c622000 	sltiu	v0,v1,8192=0A=
        adapter->rx_buffer_len =3D E1000_RXBUFFER_4096;=0A=
    1658:	0800059b 	j	166c <e1000_sw_init+0xcc>=0A=
    165c:	24021000 	li	v0,4096=0A=
    else if((netdev->mtu + ENET_HEADER_SIZE + CRC_LENGTH) < =
E1000_RXBUFFER_8192)=0A=
    1660:	50400002 	beqzl	v0,166c <e1000_sw_init+0xcc>=0A=
    1664:	24024000 	li	v0,16384=0A=
        adapter->rx_buffer_len =3D E1000_RXBUFFER_8192;=0A=
    1668:	24022000 	li	v0,8192=0A=
    else=0A=
        adapter->rx_buffer_len =3D E1000_RXBUFFER_16384;=0A=
    166c:	ae4200b8 	sw	v0,184(s2)=0A=
=0A=
    adapter->shared.max_frame_size =3D=0A=
        netdev->mtu + ENET_HEADER_SIZE + CRC_LENGTH;=0A=
=0A=
    /* MAC and Phy settings */=0A=
=0A=
    switch (adapter->device_id) {=0A=
    1670:	964200be 	lhu	v0,190(s2)=0A=
    1674:	8e63005c 	lw	v1,92(s3)=0A=
    1678:	2444f000 	addiu	a0,v0,-4096=0A=
    167c:	24630012 	addiu	v1,v1,18=0A=
    1680:	2c82000e 	sltiu	v0,a0,14=0A=
    1684:	1040001f 	beqz	v0,1704 <e1000_sw_init+0x164>=0A=
    1688:	ae43003c 	sw	v1,60(s2)=0A=
    168c:	00041080 	sll	v0,a0,0x2=0A=
    1690:	3c030000 	lui	v1,0x0=0A=
    1694:	00621821 	addu	v1,v1,v0=0A=
    1698:	8c630c70 	lw	v1,3184(v1)=0A=
    169c:	00600008 	jr	v1=0A=
    16a0:	00000000 	nop=0A=
    case E1000_DEV_ID_82542:=0A=
        switch (adapter->rev_id) {=0A=
    16a4:	924300c0 	lbu	v1,192(s2)=0A=
    16a8:	24020002 	li	v0,2=0A=
    16ac:	1062000b 	beq	v1,v0,16dc <e1000_sw_init+0x13c>=0A=
    16b0:	24020003 	li	v0,3=0A=
    16b4:	1062000b 	beq	v1,v0,16e4 <e1000_sw_init+0x144>=0A=
    16b8:	24020001 	li	v0,1=0A=
        case E1000_82542_2_0_REV_ID:=0A=
            adapter->shared.mac_type =3D e1000_82542_rev2_0;=0A=
            break;=0A=
        case E1000_82542_2_1_REV_ID:=0A=
            adapter->shared.mac_type =3D e1000_82542_rev2_1;=0A=
            break;=0A=
        default:=0A=
            adapter->shared.mac_type =3D e1000_82542_rev2_0;=0A=
            E1000_ERR("Could not identify 82542 revision\n");=0A=
    16bc:	3c040000 	lui	a0,0x0=0A=
    16c0:	24840c14 	addiu	a0,a0,3092=0A=
    16c4:	3c020000 	lui	v0,0x0=0A=
    16c8:	24420000 	addiu	v0,v0,0=0A=
    16cc:	0040f809 	jalr	v0=0A=
    16d0:	ae40000c 	sw	zero,12(s2)=0A=
        }=0A=
        break;=0A=
    16d4:	080005ca 	j	1728 <e1000_sw_init+0x188>=0A=
    16d8:	8e42000c 	lw	v0,12(s2)=0A=
    16dc:	080005c9 	j	1724 <e1000_sw_init+0x184>=0A=
    16e0:	ae40000c 	sw	zero,12(s2)=0A=
    16e4:	080005c9 	j	1724 <e1000_sw_init+0x184>=0A=
    16e8:	ae42000c 	sw	v0,12(s2)=0A=
    case E1000_DEV_ID_82543GC_FIBER:=0A=
    case E1000_DEV_ID_82543GC_COPPER:=0A=
        adapter->shared.mac_type =3D e1000_82543;=0A=
    16ec:	24020002 	li	v0,2=0A=
        break;=0A=
    16f0:	080005c9 	j	1724 <e1000_sw_init+0x184>=0A=
    16f4:	ae42000c 	sw	v0,12(s2)=0A=
    case E1000_DEV_ID_82544EI_COPPER:=0A=
    case E1000_DEV_ID_82544EI_FIBER:=0A=
    case E1000_DEV_ID_82544GC_COPPER:=0A=
    case E1000_DEV_ID_82544GC_LOM:=0A=
        adapter->shared.mac_type =3D e1000_82544;=0A=
    16f8:	24020003 	li	v0,3=0A=
        break;=0A=
    16fc:	080005c9 	j	1724 <e1000_sw_init+0x184>=0A=
    1700:	ae42000c 	sw	v0,12(s2)=0A=
    default:=0A=
        E1000_ERR("Could not identify hardware\n");=0A=
    1704:	3c040000 	lui	a0,0x0=0A=
    1708:	24840c44 	addiu	a0,a0,3140=0A=
    170c:	3c020000 	lui	v0,0x0=0A=
    1710:	24420000 	addiu	v0,v0,0=0A=
    1714:	0040f809 	jalr	v0=0A=
    1718:	00000000 	nop=0A=
        return -ENODEV;=0A=
    171c:	080005ea 	j	17a8 <e1000_sw_init+0x208>=0A=
    1720:	2402ffed 	li	v0,-19=0A=
    }=0A=
=0A=
    adapter->shared.fc_high_water =3D FC_DEFAULT_HI_THRESH;=0A=
    adapter->shared.fc_low_water =3D FC_DEFAULT_LO_THRESH;=0A=
    adapter->shared.fc_pause_time =3D FC_DEFAULT_TX_TIMER;=0A=
    adapter->shared.fc_send_xon =3D 1;=0A=
=0A=
    /* Identify the Hardware - this is done by the gigabit shared code=0A=
     * in e1000_init_hw, but it would help to identify the NIC=0A=
     * before bringing the hardware online for use in =
e1000_check_options.=0A=
     */=0A=
    if(adapter->shared.mac_type >=3D e1000_82543) {=0A=
    1724:	8e42000c 	lw	v0,12(s2)=0A=
    1728:	34048000 	li	a0,0x8000=0A=
    172c:	24054000 	li	a1,16384=0A=
    1730:	24030100 	li	v1,256=0A=
    1734:	24060001 	li	a2,1=0A=
    1738:	2c420002 	sltiu	v0,v0,2=0A=
    173c:	a644004c 	sh	a0,76(s2)=0A=
    1740:	a645004e 	sh	a1,78(s2)=0A=
    1744:	a6430050 	sh	v1,80(s2)=0A=
    1748:	14400009 	bnez	v0,1770 <e1000_sw_init+0x1d0>=0A=
    174c:	ae460068 	sw	a2,104(s2)=0A=
        status =3D E1000_READ_REG(&adapter->shared, STATUS);=0A=
    1750:	8e430008 	lw	v1,8(s2)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    1754:	8c620008 	lw	v0,8(v1)=0A=
	return __arch__swab32(x);=0A=
    1758:	00021602 	srl	v0,v0,0x18=0A=
        if(status & E1000_STATUS_TBIMODE) {=0A=
    175c:	30420020 	andi	v0,v0,0x20=0A=
    1760:	54400004 	bnezl	v0,1774 <e1000_sw_init+0x1d4>=0A=
    1764:	ae460010 	sw	a2,16(s2)=0A=
            adapter->shared.media_type =3D e1000_media_type_fiber;=0A=
        } else {=0A=
            adapter->shared.media_type =3D e1000_media_type_copper;=0A=
        }=0A=
    } else {=0A=
    1768:	080005dd 	j	1774 <e1000_sw_init+0x1d4>=0A=
    176c:	ae400010 	sw	zero,16(s2)=0A=
        adapter->shared.media_type =3D e1000_media_type_fiber;=0A=
    1770:	ae460010 	sw	a2,16(s2)=0A=
    }=0A=
=0A=
    if((E1000_REPORT_TX_EARLY =3D=3D 0) || (E1000_REPORT_TX_EARLY =3D=3D =
1)) {=0A=
        adapter->shared.report_tx_early =3D E1000_REPORT_TX_EARLY;=0A=
    } else {=0A=
        if(adapter->shared.mac_type < e1000_82543) {=0A=
    1774:	8e42000c 	lw	v0,12(s2)=0A=
    1778:	2c420002 	sltiu	v0,v0,2=0A=
    177c:	10400003 	beqz	v0,178c <e1000_sw_init+0x1ec>=0A=
    1780:	24020001 	li	v0,1=0A=
=0A=
            adapter->shared.report_tx_early =3D 0;=0A=
        } else {=0A=
    1784:	080005e4 	j	1790 <e1000_sw_init+0x1f0>=0A=
    1788:	ae40006c 	sw	zero,108(s2)=0A=
            adapter->shared.report_tx_early =3D 1;=0A=
    178c:	ae42006c 	sw	v0,108(s2)=0A=
        }=0A=
    }=0A=
=0A=
    adapter->shared.wait_autoneg_complete =3D WAITFORLINK_DEFAULT;=0A=
    1790:	24020001 	li	v0,1=0A=
=0A=
    adapter->shared.tbi_compatibility_en =3D 1;=0A=
    1794:	24030001 	li	v1,1=0A=
    1798:	a242007b 	sb	v0,123(s2)=0A=
    179c:	ae43005c 	sw	v1,92(s2)=0A=
=0A=
    atomic_set(&adapter->tx_timeout, 0);=0A=
    17a0:	ae40010c 	sw	zero,268(s2)=0A=
=0A=
    spin_lock_init(&adapter->stats_lock);=0A=
    spin_lock_init(&adapter->rx_fill_lock);=0A=
=0A=
    return 0;=0A=
    17a4:	00001021 	move	v0,zero=0A=
}=0A=
    17a8:	8fbf0020 	lw	ra,32(sp)=0A=
    17ac:	8fb3001c 	lw	s3,28(sp)=0A=
    17b0:	8fb20018 	lw	s2,24(sp)=0A=
    17b4:	8fb10014 	lw	s1,20(sp)=0A=
    17b8:	8fb00010 	lw	s0,16(sp)=0A=
    17bc:	03e00008 	jr	ra=0A=
    17c0:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
000017c4 <e1000_hw_init>:=0A=
    17c4:	27bdffd8 	addiu	sp,sp,-40=0A=
    17c8:	afb20018 	sw	s2,24(sp)=0A=
    17cc:	afbf0024 	sw	ra,36(sp)=0A=
    17d0:	afb40020 	sw	s4,32(sp)=0A=
    17d4:	afb3001c 	sw	s3,28(sp)=0A=
    17d8:	afb10014 	sw	s1,20(sp)=0A=
    17dc:	afb00010 	sw	s0,16(sp)=0A=
    17e0:	00809021 	move	s2,a0=0A=
=0A=
/**=0A=
 * e1000_hw_init - prepare the hardware=0A=
 * @adapter: board private struct containing configuration=0A=
 *=0A=
 * Returns 0 on success, negative on failure=0A=
 *=0A=
 * Initialize the hardware to a configuration as specified by the=0A=
 * Adapter structure.  The controler is reset, the EEPROM is=0A=
 * verified, the MAC address is set, then the shared initilization=0A=
 * routines are called.=0A=
 **/=0A=
=0A=
static int=0A=
e1000_hw_init(struct e1000_adapter *adapter)=0A=
{=0A=
    struct net_device *netdev =3D adapter->netdev;=0A=
=0A=
    E1000_DBG("e1000_hw_init\n");=0A=
=0A=
    /* Repartition Pba for greater than 9k mtu=0A=
     * To take effect Ctrl_Rst is required.=0A=
     */=0A=
    if(adapter->rx_buffer_len > E1000_RXBUFFER_8192)=0A=
    17e4:	8e4200b8 	lw	v0,184(s2)=0A=
    17e8:	2c422001 	sltiu	v0,v0,8193=0A=
    17ec:	14400009 	bnez	v0,1814 <e1000_hw_init+0x50>=0A=
    17f0:	8e540148 	lw	s4,328(s2)=0A=
    17f4:	8e42000c 	lw	v0,12(s2)=0A=
    17f8:	2c420002 	sltiu	v0,v0,2=0A=
    17fc:	14400003 	bnez	v0,180c <e1000_hw_init+0x48>=0A=
    1800:	8e430008 	lw	v1,8(s2)=0A=
        E1000_WRITE_REG(&adapter->shared, PBA, E1000_JUMBO_PBA);=0A=
    1804:	08000609 	j	1824 <e1000_hw_init+0x60>=0A=
    1808:	3c022800 	lui	v0,0x2800=0A=
    180c:	08000609 	j	1824 <e1000_hw_init+0x60>=0A=
    1810:	3c022800 	lui	v0,0x2800=0A=
    1814:	8e42000c 	lw	v0,12(s2)=0A=
    1818:	2c420002 	sltiu	v0,v0,2=0A=
    else=0A=
        E1000_WRITE_REG(&adapter->shared, PBA, E1000_DEFAULT_PBA);=0A=
    181c:	8e430008 	lw	v1,8(s2)=0A=
    1820:	3c023000 	lui	v0,0x3000=0A=
    1824:	ac621000 	sw	v0,4096(v1)=0A=
=0A=
    /* Issue a global reset */=0A=
=0A=
    E1000_DBG("about to global reset\n");=0A=
    adapter->shared.adapter_stopped =3D 0;=0A=
    e1000_adapter_stop(&adapter->shared);=0A=
    1828:	26530008 	addiu	s3,s2,8=0A=
    182c:	02602021 	move	a0,s3=0A=
    1830:	3c020000 	lui	v0,0x0=0A=
    1834:	24420000 	addiu	v0,v0,0=0A=
    1838:	0040f809 	jalr	v0=0A=
    183c:	ae400064 	sw	zero,100(s2)=0A=
    adapter->shared.adapter_stopped =3D 0;=0A=
    1840:	ae400064 	sw	zero,100(s2)=0A=
=0A=
    /* make sure the EEPROM is good */=0A=
=0A=
    E1000_DBG("about to validate eeprom\n");=0A=
    if(!e1000_validate_eeprom_checksum(&adapter->shared)) {=0A=
    1844:	3c020000 	lui	v0,0x0=0A=
    1848:	24420000 	addiu	v0,v0,0=0A=
    184c:	0040f809 	jalr	v0=0A=
    1850:	02602021 	move	a0,s3=0A=
    1854:	14400005 	bnez	v0,186c <e1000_hw_init+0xa8>=0A=
    1858:	265000a8 	addiu	s0,s2,168=0A=
        E1000_ERR("The EEPROM Checksum Is Not Valid\n");=0A=
    185c:	3c040000 	lui	a0,0x0=0A=
    1860:	24840ca8 	addiu	a0,a0,3240=0A=
        return -1;=0A=
    1864:	08000638 	j	18e0 <e1000_hw_init+0x11c>=0A=
    1868:	00000000 	nop=0A=
    }=0A=
=0A=
    /* copy the MAC address out of the EEPROM */=0A=
=0A=
    E1000_DBG("about to get mac address\n");=0A=
    e1000_read_address(adapter, adapter->perm_net_addr);=0A=
    186c:	3c020000 	lui	v0,0x0=0A=
    1870:	244219d4 	addiu	v0,v0,6612=0A=
    1874:	02002821 	move	a1,s0=0A=
    1878:	0040f809 	jalr	v0=0A=
    187c:	02402021 	move	a0,s2=0A=
    memcpy(netdev->dev_addr, adapter->perm_net_addr, netdev->addr_len);=0A=
    1880:	9286007c 	lbu	a2,124(s4)=0A=
    1884:	26910074 	addiu	s1,s4,116=0A=
    1888:	02002821 	move	a1,s0=0A=
    188c:	3c100000 	lui	s0,0x0=0A=
    1890:	26100000 	addiu	s0,s0,0=0A=
    1894:	0200f809 	jalr	s0=0A=
    1898:	02202021 	move	a0,s1=0A=
    memcpy(adapter->shared.mac_addr, netdev->dev_addr, netdev->addr_len);=0A=
    189c:	9286007c 	lbu	a2,124(s4)=0A=
    18a0:	2644007d 	addiu	a0,s2,125=0A=
    18a4:	0200f809 	jalr	s0=0A=
    18a8:	02202821 	move	a1,s1=0A=
=0A=
    E1000_DBG("about to read part number\n");=0A=
    e1000_read_part_num(&adapter->shared, &(adapter->part_num));=0A=
    18ac:	02602021 	move	a0,s3=0A=
    18b0:	3c020000 	lui	v0,0x0=0A=
    18b4:	24420000 	addiu	v0,v0,0=0A=
    18b8:	0040f809 	jalr	v0=0A=
    18bc:	264500c8 	addiu	a1,s2,200=0A=
=0A=
    if(!e1000_init_hw(&adapter->shared)) {=0A=
    18c0:	3c020000 	lui	v0,0x0=0A=
    18c4:	24420000 	addiu	v0,v0,0=0A=
    18c8:	0040f809 	jalr	v0=0A=
    18cc:	02602021 	move	a0,s3=0A=
    18d0:	14400009 	bnez	v0,18f8 <e1000_hw_init+0x134>=0A=
    18d4:	00000000 	nop=0A=
        E1000_ERR("Hardware Initialization Failed\n");=0A=
    18d8:	3c040000 	lui	a0,0x0=0A=
    18dc:	24840cd4 	addiu	a0,a0,3284=0A=
    18e0:	3c020000 	lui	v0,0x0=0A=
    18e4:	24420000 	addiu	v0,v0,0=0A=
    18e8:	0040f809 	jalr	v0=0A=
    18ec:	00000000 	nop=0A=
        return -1;=0A=
    18f0:	0800066d 	j	19b4 <e1000_hw_init+0x1f0>=0A=
    18f4:	2402ffff 	li	v0,-1=0A=
    }=0A=
=0A=
    E1000_DBG("about to enable WOL\n");=0A=
    e1000_enable_WOL(adapter);=0A=
    18f8:	3c020000 	lui	v0,0x0=0A=
    18fc:	244273ec 	addiu	v0,v0,29676=0A=
    1900:	0040f809 	jalr	v0=0A=
    1904:	02402021 	move	a0,s2=0A=
=0A=
    E1000_DBG("about to check for link\n");=0A=
    adapter->shared.get_link_status =3D 1;=0A=
    1908:	24030001 	li	v1,1=0A=
    190c:	ae430058 	sw	v1,88(s2)=0A=
    e1000_check_for_link(&adapter->shared);=0A=
    1910:	3c030000 	lui	v1,0x0=0A=
    1914:	24630000 	addiu	v1,v1,0=0A=
    1918:	0060f809 	jalr	v1=0A=
    191c:	02602021 	move	a0,s3=0A=
    1920:	8e42000c 	lw	v0,12(s2)=0A=
    1924:	2c420002 	sltiu	v0,v0,2=0A=
    1928:	14400008 	bnez	v0,194c <e1000_hw_init+0x188>=0A=
    192c:	8e630000 	lw	v1,0(s3)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    1930:	8c620008 	lw	v0,8(v1)=0A=
	return __arch__swab32(x);=0A=
    1934:	00021602 	srl	v0,v0,0x18=0A=
=0A=
    if(E1000_READ_REG(&adapter->shared, STATUS) & E1000_STATUS_LU)=0A=
    1938:	30420002 	andi	v0,v0,0x2=0A=
    193c:	14400008 	bnez	v0,1960 <e1000_hw_init+0x19c>=0A=
    1940:	24020001 	li	v0,1=0A=
    1944:	0800065b 	j	196c <e1000_hw_init+0x1a8>=0A=
    1948:	ae4000b0 	sw	zero,176(s2)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    194c:	8c620008 	lw	v0,8(v1)=0A=
	return __arch__swab32(x);=0A=
    1950:	00021602 	srl	v0,v0,0x18=0A=
    1954:	30420002 	andi	v0,v0,0x2=0A=
    1958:	10400003 	beqz	v0,1968 <e1000_hw_init+0x1a4>=0A=
    195c:	24020001 	li	v0,1=0A=
        adapter->link_active =3D TRUE;=0A=
    1960:	0800065b 	j	196c <e1000_hw_init+0x1a8>=0A=
    1964:	ae4200b0 	sw	v0,176(s2)=0A=
    else=0A=
        adapter->link_active =3D FALSE;=0A=
    1968:	ae4000b0 	sw	zero,176(s2)=0A=
=0A=
    if(adapter->link_active =3D=3D TRUE) {=0A=
    196c:	8e4300b0 	lw	v1,176(s2)=0A=
    1970:	24020001 	li	v0,1=0A=
    1974:	54620009 	bnel	v1,v0,199c <e1000_hw_init+0x1d8>=0A=
    1978:	a64000b6 	sh	zero,182(s2)=0A=
        e1000_get_speed_and_duplex(&adapter->shared, =
&adapter->link_speed,=0A=
    197c:	264600b6 	addiu	a2,s2,182=0A=
    1980:	264500b4 	addiu	a1,s2,180=0A=
    1984:	3c020000 	lui	v0,0x0=0A=
    1988:	24420000 	addiu	v0,v0,0=0A=
    198c:	0040f809 	jalr	v0=0A=
    1990:	02602021 	move	a0,s3=0A=
                                   &adapter->link_duplex);=0A=
    } else {=0A=
    1994:	08000668 	j	19a0 <e1000_hw_init+0x1dc>=0A=
    1998:	00000000 	nop=0A=
        adapter->link_speed =3D 0;=0A=
    199c:	a64000b4 	sh	zero,180(s2)=0A=
        adapter->link_duplex =3D 0;=0A=
    }=0A=
=0A=
    E1000_DBG("about to get bus info\n");=0A=
    e1000_get_bus_info(&adapter->shared);=0A=
    19a0:	3c020000 	lui	v0,0x0=0A=
    19a4:	24420000 	addiu	v0,v0,0=0A=
    19a8:	0040f809 	jalr	v0=0A=
    19ac:	02602021 	move	a0,s3=0A=
=0A=
    E1000_DBG("e1000_hw_init done\n");=0A=
    return 0;=0A=
    19b0:	00001021 	move	v0,zero=0A=
}=0A=
    19b4:	8fbf0024 	lw	ra,36(sp)=0A=
    19b8:	8fb40020 	lw	s4,32(sp)=0A=
    19bc:	8fb3001c 	lw	s3,28(sp)=0A=
    19c0:	8fb20018 	lw	s2,24(sp)=0A=
    19c4:	8fb10014 	lw	s1,20(sp)=0A=
    19c8:	8fb00010 	lw	s0,16(sp)=0A=
    19cc:	03e00008 	jr	ra=0A=
    19d0:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
000019d4 <e1000_read_address>:=0A=
    19d4:	27bdffd8 	addiu	sp,sp,-40=0A=
    19d8:	afb3001c 	sw	s3,28(sp)=0A=
    19dc:	afb20018 	sw	s2,24(sp)=0A=
    19e0:	afb10014 	sw	s1,20(sp)=0A=
    19e4:	afb00010 	sw	s0,16(sp)=0A=
    19e8:	afbf0020 	sw	ra,32(sp)=0A=
=0A=
/**=0A=
 * e1000_read_address - Reads the MAC address from the EEPROM=0A=
 * @adapter: board private structure=0A=
 * @addr: pointer to an array of bytes=0A=
 **/=0A=
=0A=
static void=0A=
e1000_read_address(struct e1000_adapter *adapter,=0A=
                   uint8_t *addr)=0A=
{=0A=
    uint16_t eeprom_word;=0A=
    int i;=0A=
=0A=
    E1000_DBG("e1000_read_address\n");=0A=
=0A=
    for(i =3D 0; i < NODE_ADDRESS_SIZE; i +=3D 2) {=0A=
    19ec:	24920008 	addiu	s2,a0,8=0A=
    19f0:	00a08021 	move	s0,a1=0A=
    19f4:	00008821 	move	s1,zero=0A=
    19f8:	3c130000 	lui	s3,0x0=0A=
    19fc:	26730000 	addiu	s3,s3,0=0A=
        eeprom_word =3D=0A=
    1a00:	00112fc2 	srl	a1,s1,0x1f=0A=
    1a04:	02252821 	addu	a1,s1,a1=0A=
    1a08:	00052843 	sra	a1,a1,0x1=0A=
    1a0c:	02402021 	move	a0,s2=0A=
    1a10:	0260f809 	jalr	s3=0A=
    1a14:	30a5ffff 	andi	a1,a1,0xffff=0A=
    1a18:	26310002 	addiu	s1,s1,2=0A=
            e1000_read_eeprom(&adapter->shared,=0A=
                              EEPROM_NODE_ADDRESS_BYTE_0 + (i / 2));=0A=
        addr[i] =3D (uint8_t) (eeprom_word & 0x00FF);=0A=
        addr[i + 1] =3D (uint8_t) (eeprom_word >> 8);=0A=
    1a1c:	00021a02 	srl	v1,v0,0x8=0A=
    1a20:	2a240006 	slti	a0,s1,6=0A=
    1a24:	a2030001 	sb	v1,1(s0)=0A=
    1a28:	a2020000 	sb	v0,0(s0)=0A=
    1a2c:	1480fff4 	bnez	a0,1a00 <e1000_read_address+0x2c>=0A=
    1a30:	26100002 	addiu	s0,s0,2=0A=
    }=0A=
=0A=
    return;=0A=
}=0A=
    1a34:	8fbf0020 	lw	ra,32(sp)=0A=
    1a38:	8fb3001c 	lw	s3,28(sp)=0A=
    1a3c:	8fb20018 	lw	s2,24(sp)=0A=
    1a40:	8fb10014 	lw	s1,20(sp)=0A=
    1a44:	8fb00010 	lw	s0,16(sp)=0A=
    1a48:	03e00008 	jr	ra=0A=
    1a4c:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
00001a50 <e1000_open>:=0A=
    1a50:	27bdffd0 	addiu	sp,sp,-48=0A=
    1a54:	afb30024 	sw	s3,36(sp)=0A=
    1a58:	afb20020 	sw	s2,32(sp)=0A=
    1a5c:	afb00018 	sw	s0,24(sp)=0A=
    1a60:	afbf0028 	sw	ra,40(sp)=0A=
    1a64:	afb1001c 	sw	s1,28(sp)=0A=
    1a68:	00809821 	move	s3,a0=0A=
=0A=
/**=0A=
 * e1000_open - Called when a network interface is made active=0A=
 * @netdev: network interface device structure=0A=
 *=0A=
 * Returns 0 on success, negative value on failure=0A=
 *=0A=
 * The open entry point is called when a network interface is made=0A=
 * active by the system (IFF_UP).  At this point all resources needed=0A=
 * for transmit and receive operations are allocated, the interrupt=0A=
 * handler is registered with the OS, the watchdog timer is started,=0A=
 * and the stack is notified that the interface is ready.=0A=
 **/=0A=
=0A=
int=0A=
e1000_open(struct net_device *netdev)=0A=
{=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    1a6c:	8e710064 	lw	s1,100(s3)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1a70:	24120001 	li	s2,1=0A=
    1a74:	2630008c 	addiu	s0,s1,140=0A=
    1a78:	c2020000 	ll	v0,0(s0)=0A=
    1a7c:	00521825 	or	v1,v0,s2=0A=
    1a80:	e2030000 	sc	v1,0(s0)=0A=
    1a84:	1060fffc 	beqz	v1,1a78 <e1000_open+0x28>=0A=
    1a88:	00521824 	and	v1,v0,s2=0A=
=0A=
    E1000_DBG("e1000_open\n");=0A=
=0A=
    /* prevent multiple opens when dealing with iANS */=0A=
=0A=
    if(test_and_set_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    1a8c:	1460009f 	bnez	v1,1d0c <e1000_open+0x2bc>=0A=
    1a90:	2402fff0 	li	v0,-16=0A=
        return -EBUSY;=0A=
    }=0A=
=0A=
    adapter->shared.fc =3D adapter->shared.original_fc;=0A=
    1a94:	8e230030 	lw	v1,48(s1)=0A=
=0A=
    /* e1000_close issues a global reset (e1000_adapter_stop)=0A=
     * so e1000_hw_init must be called again or the hardware=0A=
     * will resume in it's default state=0A=
     */=0A=
    if(e1000_hw_init(adapter) < 0) {=0A=
    1a98:	02202021 	move	a0,s1=0A=
    1a9c:	3c020000 	lui	v0,0x0=0A=
    1aa0:	244217c4 	addiu	v0,v0,6084=0A=
    1aa4:	0040f809 	jalr	v0=0A=
    1aa8:	ae230018 	sw	v1,24(s1)=0A=
    1aac:	04430009 	bgezl	v0,1ad4 <e1000_open+0x84>=0A=
    1ab0:	ae200064 	sw	zero,100(s1)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1ab4:	c2020000 	ll	v0,0(s0)=0A=
    1ab8:	2401fffe 	li	at,-2=0A=
    1abc:	00411024 	and	v0,v0,at=0A=
    1ac0:	e2020000 	sc	v0,0(s0)=0A=
    1ac4:	1040fffb 	beqz	v0,1ab4 <e1000_open+0x64>=0A=
    1ac8:	00000000 	nop=0A=
        clear_bit(E1000_BOARD_OPEN, &adapter->flags);=0A=
        return -EBUSY;=0A=
    1acc:	08000743 	j	1d0c <e1000_open+0x2bc>=0A=
    1ad0:	2402fff0 	li	v0,-16=0A=
    }=0A=
#ifdef IANS=0A=
    /* restore VLAN settings */=0A=
    if((IANS_BD_TAGGING_MODE) =
(ANS_PRIVATE_DATA_FIELD(adapter)->tag_mode) !=3D=0A=
       IANS_BD_TAGGING_NONE)=0A=
        bd_ans_hw_EnableVLAN(adapter);=0A=
#endif=0A=
=0A=
    adapter->shared.adapter_stopped =3D 0;=0A=
=0A=
    /* allocate transmit descriptors */=0A=
=0A=
    if(e1000_setup_tx_resources(adapter) !=3D 0) {=0A=
    1ad4:	3c020000 	lui	v0,0x0=0A=
    1ad8:	24421e60 	addiu	v0,v0,7776=0A=
    1adc:	0040f809 	jalr	v0=0A=
    1ae0:	02202021 	move	a0,s1=0A=
    1ae4:	10400005 	beqz	v0,1afc <e1000_open+0xac>=0A=
    1ae8:	00000000 	nop=0A=
        e1000_adapter_stop(&adapter->shared);=0A=
    1aec:	3c020000 	lui	v0,0x0=0A=
    1af0:	24420000 	addiu	v0,v0,0=0A=
        clear_bit(E1000_BOARD_OPEN, &adapter->flags);=0A=
        return -ENOMEM;=0A=
    1af4:	080006d0 	j	1b40 <e1000_open+0xf0>=0A=
    1af8:	26240008 	addiu	a0,s1,8=0A=
    }=0A=
    e1000_configure_tx(adapter);=0A=
    1afc:	3c020000 	lui	v0,0x0=0A=
    1b00:	24421f60 	addiu	v0,v0,8032=0A=
    1b04:	0040f809 	jalr	v0=0A=
    1b08:	02202021 	move	a0,s1=0A=
=0A=
    /* allocate receive descriptors and buffers */=0A=
=0A=
    if(e1000_setup_rx_resources(adapter) !=3D 0) {=0A=
    1b0c:	3c020000 	lui	v0,0x0=0A=
    1b10:	24422208 	addiu	v0,v0,8712=0A=
    1b14:	0040f809 	jalr	v0=0A=
    1b18:	02202021 	move	a0,s1=0A=
    1b1c:	10400012 	beqz	v0,1b68 <e1000_open+0x118>=0A=
    1b20:	00000000 	nop=0A=
        e1000_adapter_stop(&adapter->shared);=0A=
    1b24:	3c020000 	lui	v0,0x0=0A=
    1b28:	24420000 	addiu	v0,v0,0=0A=
    1b2c:	0040f809 	jalr	v0=0A=
    1b30:	26240008 	addiu	a0,s1,8=0A=
        e1000_free_tx_resources(adapter);=0A=
    1b34:	02202021 	move	a0,s1=0A=
    1b38:	3c020000 	lui	v0,0x0=0A=
    1b3c:	244226b4 	addiu	v0,v0,9908=0A=
    1b40:	0040f809 	jalr	v0=0A=
    1b44:	00000000 	nop=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1b48:	c2030000 	ll	v1,0(s0)=0A=
    1b4c:	2401fffe 	li	at,-2=0A=
    1b50:	00611824 	and	v1,v1,at=0A=
    1b54:	e2030000 	sc	v1,0(s0)=0A=
    1b58:	1060fffb 	beqz	v1,1b48 <e1000_open+0xf8>=0A=
    1b5c:	00000000 	nop=0A=
        clear_bit(E1000_BOARD_OPEN, &adapter->flags);=0A=
        return -ENOMEM;=0A=
    1b60:	08000743 	j	1d0c <e1000_open+0x2bc>=0A=
    1b64:	2402fff4 	li	v0,-12=0A=
    }=0A=
    e1000_setup_rctl(adapter);=0A=
    1b68:	3c020000 	lui	v0,0x0=0A=
    1b6c:	24422308 	addiu	v0,v0,8968=0A=
    1b70:	0040f809 	jalr	v0=0A=
    1b74:	02202021 	move	a0,s1=0A=
    e1000_configure_rx(adapter);=0A=
    1b78:	3c020000 	lui	v0,0x0=0A=
    1b7c:	244223a8 	addiu	v0,v0,9128=0A=
    1b80:	0040f809 	jalr	v0=0A=
    1b84:	02202021 	move	a0,s1=0A=
=0A=
    /* hook the interrupt */=0A=
=0A=
    if(request_irq(netdev->irq, &e1000_intr,=0A=
    1b88:	8e640024 	lw	a0,36(s3)=0A=
    1b8c:	3c050000 	lui	a1,0x0=0A=
    1b90:	24a50000 	addiu	a1,a1,0=0A=
    1b94:	3c070000 	lui	a3,0x0=0A=
    1b98:	24e70000 	addiu	a3,a3,0=0A=
    1b9c:	3c060200 	lui	a2,0x200=0A=
    1ba0:	3c020000 	lui	v0,0x0=0A=
    1ba4:	24420000 	addiu	v0,v0,0=0A=
    1ba8:	0040f809 	jalr	v0=0A=
    1bac:	afb30010 	sw	s3,16(sp)=0A=
    1bb0:	5040001b 	beqzl	v0,1c20 <e1000_open+0x1d0>=0A=
    1bb4:	263000d0 	addiu	s0,s1,208=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1bb8:	c2020000 	ll	v0,0(s0)=0A=
    1bbc:	2401fffe 	li	at,-2=0A=
    1bc0:	00411024 	and	v0,v0,at=0A=
    1bc4:	e2020000 	sc	v0,0(s0)=0A=
    1bc8:	1040fffb 	beqz	v0,1bb8 <e1000_open+0x168>=0A=
    1bcc:	00000000 	nop=0A=
                   SA_SHIRQ, e1000_driver_name, netdev) !=3D 0) {=0A=
        clear_bit(E1000_BOARD_OPEN, &adapter->flags);=0A=
        e1000_adapter_stop(&adapter->shared);=0A=
    1bd0:	3c020000 	lui	v0,0x0=0A=
    1bd4:	24420000 	addiu	v0,v0,0=0A=
    1bd8:	0040f809 	jalr	v0=0A=
    1bdc:	26240008 	addiu	a0,s1,8=0A=
        e1000_free_tx_resources(adapter);=0A=
    1be0:	3c020000 	lui	v0,0x0=0A=
    1be4:	244226b4 	addiu	v0,v0,9908=0A=
    1be8:	0040f809 	jalr	v0=0A=
    1bec:	02202021 	move	a0,s1=0A=
        e1000_free_rx_resources(adapter);=0A=
    1bf0:	3c020000 	lui	v0,0x0=0A=
    1bf4:	2442284c 	addiu	v0,v0,10316=0A=
    1bf8:	0040f809 	jalr	v0=0A=
    1bfc:	02202021 	move	a0,s1=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1c00:	c2030000 	ll	v1,0(s0)=0A=
    1c04:	2401fffe 	li	at,-2=0A=
    1c08:	00611824 	and	v1,v1,at=0A=
    1c0c:	e2030000 	sc	v1,0(s0)=0A=
    1c10:	1060fffb 	beqz	v1,1c00 <e1000_open+0x1b0>=0A=
    1c14:	00000000 	nop=0A=
        clear_bit(E1000_BOARD_OPEN, &adapter->flags);=0A=
        return -EBUSY;=0A=
    1c18:	08000743 	j	1d0c <e1000_open+0x2bc>=0A=
    1c1c:	2402fff0 	li	v0,-16=0A=
    }=0A=
=0A=
    /* fill Rx ring with sk_buffs */=0A=
=0A=
    tasklet_init(&adapter->rx_fill_tasklet, e1000_alloc_rx_buffers,=0A=
    1c20:	3c050000 	lui	a1,0x0=0A=
    1c24:	24a55e30 	addiu	a1,a1,24112=0A=
    1c28:	02002021 	move	a0,s0=0A=
    1c2c:	3c020000 	lui	v0,0x0=0A=
    1c30:	24420000 	addiu	v0,v0,0=0A=
    1c34:	0040f809 	jalr	v0=0A=
    1c38:	02203021 	move	a2,s1=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1c3c:	c22400d4 	ll	a0,212(s1)=0A=
    1c40:	00921825 	or	v1,a0,s2=0A=
    1c44:	e22300d4 	sc	v1,212(s1)=0A=
    1c48:	1060fffc 	beqz	v1,1c3c <e1000_open+0x1ec>=0A=
    1c4c:	00921824 	and	v1,a0,s2=0A=
extern void FASTCALL(__tasklet_schedule(struct tasklet_struct *t));=0A=
=0A=
static inline void tasklet_schedule(struct tasklet_struct *t)=0A=
{=0A=
	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))=0A=
    1c50:	54600006 	bnezl	v1,1c6c <e1000_open+0x21c>=0A=
    1c54:	26240094 	addiu	a0,s1,148=0A=
		__tasklet_schedule(t);=0A=
    1c58:	3c020000 	lui	v0,0x0=0A=
    1c5c:	24420000 	addiu	v0,v0,0=0A=
    1c60:	0040f809 	jalr	v0=0A=
    1c64:	02002021 	move	a0,s0=0A=
=0A=
extern void it_real_fn(unsigned long);=0A=
=0A=
static inline void init_timer(struct timer_list * timer)=0A=
{=0A=
    1c68:	26240094 	addiu	a0,s1,148=0A=
                 (unsigned long) adapter);=0A=
=0A=
    tasklet_schedule(&adapter->rx_fill_tasklet);=0A=
=0A=
    /* Set the watchdog timer for 2 seconds */=0A=
=0A=
    init_timer(&adapter->timer_id);=0A=
    adapter->timer_id.function =3D &e1000_watchdog;=0A=
    1c6c:	3c020000 	lui	v0,0x0=0A=
    1c70:	24420000 	addiu	v0,v0,0=0A=
extern void it_real_fn(unsigned long);=0A=
=0A=
static inline void init_timer(struct timer_list * timer)=0A=
{=0A=
	timer->list.next =3D timer->list.prev =3D NULL;=0A=
    1c74:	ac800004 	sw	zero,4(a0)=0A=
    1c78:	ac800000 	sw	zero,0(a0)=0A=
    1c7c:	ae2200a4 	sw	v0,164(s1)=0A=
    adapter->timer_id.data =3D (unsigned long) netdev;=0A=
    1c80:	ae3300a0 	sw	s3,160(s1)=0A=
    mod_timer(&adapter->timer_id, (jiffies + 2 * HZ));=0A=
    1c84:	3c050000 	lui	a1,0x0=0A=
    1c88:	8ca50000 	lw	a1,0(a1)=0A=
    1c8c:	3c020000 	lui	v0,0x0=0A=
    1c90:	24420000 	addiu	v0,v0,0=0A=
    1c94:	0040f809 	jalr	v0=0A=
    1c98:	24a500c8 	addiu	a1,a1,200=0A=
=0A=
    /* stats accumulated while down are dropped=0A=
     * this does not clear the running total=0A=
     */=0A=
=0A=
    e1000_clear_hw_cntrs(&adapter->shared);=0A=
    1c9c:	3c020000 	lui	v0,0x0=0A=
    1ca0:	24420000 	addiu	v0,v0,0=0A=
    1ca4:	0040f809 	jalr	v0=0A=
    1ca8:	26240008 	addiu	a0,s1,8=0A=
=0A=
    adapter->int_mask =3D IMS_ENABLE_MASK;=0A=
    1cac:	2403009d 	li	v1,157=0A=
    1cb0:	ae2300cc 	sw	v1,204(s1)=0A=
    e1000_irq_enable(adapter);=0A=
    1cb4:	3c020000 	lui	v0,0x0=0A=
    1cb8:	244274ac 	addiu	v0,v0,29868=0A=
    1cbc:	0040f809 	jalr	v0=0A=
    1cc0:	02202021 	move	a0,s1=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1cc4:	c264002c 	ll	a0,44(s3)=0A=
    1cc8:	2401fffe 	li	at,-2=0A=
    1ccc:	00812024 	and	a0,a0,at=0A=
    1cd0:	e264002c 	sc	a0,44(s3)=0A=
    1cd4:	1080fffb 	beqz	a0,1cc4 <e1000_open+0x274>=0A=
    1cd8:	00000000 	nop=0A=
 * Atomically adds @i to @v.  Note that the guaranteed useful range=0A=
 * of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
    1cdc:	3c030000 	lui	v1,0x0=0A=
    1ce0:	24630010 	addiu	v1,v1,16=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1ce4:	c0620000 	ll	v0,0(v1)=0A=
    1ce8:	00521021 	addu	v0,v0,s2=0A=
    1cec:	e0620000 	sc	v0,0(v1)=0A=
    1cf0:	1040fffc 	beqz	v0,1ce4 <e1000_open+0x294>=0A=
    1cf4:	00000000 	nop=0A=
    netif_start_queue(netdev);=0A=
=0A=
#ifdef MODULE=0A=
=0A=
    /* Incrementing the module use count prevents a driver from being=0A=
     * unloaded while an active network interface is using it.=0A=
     */=0A=
    MOD_INC_USE_COUNT;=0A=
    1cf8:	24630004 	addiu	v1,v1,4=0A=
    1cfc:	8c640000 	lw	a0,0(v1)=0A=
=0A=
#endif=0A=
=0A=
    return 0;=0A=
    1d00:	00001021 	move	v0,zero=0A=
    1d04:	34840018 	ori	a0,a0,0x18=0A=
    1d08:	ac640000 	sw	a0,0(v1)=0A=
}=0A=
    1d0c:	8fbf0028 	lw	ra,40(sp)=0A=
    1d10:	8fb30024 	lw	s3,36(sp)=0A=
    1d14:	8fb20020 	lw	s2,32(sp)=0A=
    1d18:	8fb1001c 	lw	s1,28(sp)=0A=
    1d1c:	8fb00018 	lw	s0,24(sp)=0A=
    1d20:	03e00008 	jr	ra=0A=
    1d24:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
00001d28 <e1000_close>:=0A=
    1d28:	27bdffd8 	addiu	sp,sp,-40=0A=
    1d2c:	afb3001c 	sw	s3,28(sp)=0A=
    1d30:	afb20018 	sw	s2,24(sp)=0A=
    1d34:	afb10014 	sw	s1,20(sp)=0A=
    1d38:	afbf0020 	sw	ra,32(sp)=0A=
    1d3c:	afb00010 	sw	s0,16(sp)=0A=
    1d40:	00808821 	move	s1,a0=0A=
=0A=
/**=0A=
 * e1000_close - Disables a network interface=0A=
 * @netdev: network interface device structure=0A=
 *=0A=
 * Returns 0, this is not allowed to fail=0A=
 *=0A=
 * The close entry point is called when an interface is de-activated=0A=
 * by the OS.  The hardware is still under the drivers control, but=0A=
 * needs to be disabled.  A global MAC reset is issued to stop the=0A=
 * hardware, and all transmit and receive resources are freed.=0A=
 **/=0A=
=0A=
int=0A=
e1000_close(struct net_device *netdev)=0A=
{=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    1d44:	8e300064 	lw	s0,100(s1)=0A=
=0A=
    E1000_DBG("e1000_close\n");=0A=
=0A=
    if(!test_bit(E1000_BOARD_OPEN, &adapter->flags))=0A=
        return 0;=0A=
=0A=
    /* Issue a global reset */=0A=
=0A=
    e1000_adapter_stop((&adapter->shared));=0A=
    1d48:	3c050000 	lui	a1,0x0=0A=
    1d4c:	24a50000 	addiu	a1,a1,0=0A=
    1d50:	00001021 	move	v0,zero=0A=
 * @nr: bit number to test=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
    1d54:	2613008c 	addiu	s3,s0,140=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    1d58:	8e630000 	lw	v1,0(s3)=0A=
    1d5c:	26120008 	addiu	s2,s0,8=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    1d60:	30630001 	andi	v1,v1,0x1=0A=
    1d64:	10600037 	beqz	v1,1e44 <e1000_close+0x11c>=0A=
    1d68:	02402021 	move	a0,s2=0A=
    1d6c:	00a0f809 	jalr	a1=0A=
    1d70:	00000000 	nop=0A=
=0A=
    /* Enable receiver unit after Global reset=0A=
     * for WOL, so that receiver can still recive=0A=
     * wake up packet and will not drop it.=0A=
     */=0A=
    if(adapter->shared.mac_type > e1000_82543)=0A=
    1d74:	8e02000c 	lw	v0,12(s0)=0A=
    1d78:	2c430002 	sltiu	v1,v0,2=0A=
    1d7c:	2c420003 	sltiu	v0,v0,3=0A=
    1d80:	14400003 	bnez	v0,1d90 <e1000_close+0x68>=0A=
    1d84:	3c020200 	lui	v0,0x200=0A=
        E1000_WRITE_REG(&adapter->shared, RCTL, E1000_RCTL_EN);=0A=
    1d88:	8e430000 	lw	v1,0(s2)=0A=
    1d8c:	ac620100 	sw	v0,256(v1)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1d90:	c222002c 	ll	v0,44(s1)=0A=
    1d94:	34420001 	ori	v0,v0,0x1=0A=
    1d98:	e222002c 	sc	v0,44(s1)=0A=
    1d9c:	1040fffc 	beqz	v0,1d90 <e1000_close+0x68>=0A=
    1da0:	00000000 	nop=0A=
=0A=
    /* free OS resources */=0A=
=0A=
    netif_stop_queue(netdev);=0A=
    free_irq(netdev->irq, netdev);=0A=
    1da4:	8e240024 	lw	a0,36(s1)=0A=
    1da8:	3c020000 	lui	v0,0x0=0A=
    1dac:	24420000 	addiu	v0,v0,0=0A=
    1db0:	0040f809 	jalr	v0=0A=
    1db4:	02202821 	move	a1,s1=0A=
    del_timer_sync(&adapter->timer_id);=0A=
    1db8:	3c020000 	lui	v0,0x0=0A=
    1dbc:	24420000 	addiu	v0,v0,0=0A=
    1dc0:	0040f809 	jalr	v0=0A=
    1dc4:	26040094 	addiu	a0,s0,148=0A=
=0A=
    /* Make sure the tasklet won't be left after ifconfig down */=0A=
=0A=
    /*=0A=
     * Assumption: tasklet is ALREADY enabled, ie, t->count =3D=3D 0.=0A=
     * Otherwise, tasklet is still left in the tasklet list, and,=0A=
     * tasklet_kill will not be able to return (hang).=0A=
     */=0A=
    tasklet_kill(&adapter->rx_fill_tasklet);=0A=
    1dc8:	3c020000 	lui	v0,0x0=0A=
    1dcc:	24420000 	addiu	v0,v0,0=0A=
    1dd0:	0040f809 	jalr	v0=0A=
    1dd4:	260400d0 	addiu	a0,s0,208=0A=
=0A=
    /* free software resources */=0A=
=0A=
    e1000_free_tx_resources(adapter);=0A=
    1dd8:	3c020000 	lui	v0,0x0=0A=
    1ddc:	244226b4 	addiu	v0,v0,9908=0A=
    1de0:	0040f809 	jalr	v0=0A=
    1de4:	02002021 	move	a0,s0=0A=
    e1000_free_rx_resources(adapter);=0A=
    1de8:	3c020000 	lui	v0,0x0=0A=
    1dec:	2442284c 	addiu	v0,v0,10316=0A=
    1df0:	0040f809 	jalr	v0=0A=
    1df4:	02002021 	move	a0,s0=0A=
 * Atomically subtracts @i from @v.  Note that the guaranteed=0A=
 * useful range of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
    1df8:	24030001 	li	v1,1=0A=
    1dfc:	3c020000 	lui	v0,0x0=0A=
    1e00:	24420010 	addiu	v0,v0,16=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1e04:	c0440000 	ll	a0,0(v0)=0A=
    1e08:	00832023 	subu	a0,a0,v1=0A=
    1e0c:	e0440000 	sc	a0,0(v0)=0A=
    1e10:	1080fffc 	beqz	a0,1e04 <e1000_close+0xdc>=0A=
    1e14:	00000000 	nop=0A=
=0A=
#ifdef MODULE=0A=
=0A=
    /* decrement the module usage count=0A=
     * so that the driver can be unloaded=0A=
     */=0A=
    MOD_DEC_USE_COUNT;=0A=
    1e18:	24420004 	addiu	v0,v0,4=0A=
    1e1c:	8c430000 	lw	v1,0(v0)=0A=
    1e20:	34630008 	ori	v1,v1,0x8=0A=
    1e24:	ac430000 	sw	v1,0(v0)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    1e28:	c2640000 	ll	a0,0(s3)=0A=
    1e2c:	2401fffe 	li	at,-2=0A=
    1e30:	00812024 	and	a0,a0,at=0A=
    1e34:	e2640000 	sc	a0,0(s3)=0A=
    1e38:	1080fffb 	beqz	a0,1e28 <e1000_close+0x100>=0A=
    1e3c:	00000000 	nop=0A=
=0A=
#endif=0A=
=0A=
    clear_bit(E1000_BOARD_OPEN, &adapter->flags);=0A=
    return 0;=0A=
    1e40:	00001021 	move	v0,zero=0A=
}=0A=
    1e44:	8fbf0020 	lw	ra,32(sp)=0A=
    1e48:	8fb3001c 	lw	s3,28(sp)=0A=
    1e4c:	8fb20018 	lw	s2,24(sp)=0A=
    1e50:	8fb10014 	lw	s1,20(sp)=0A=
    1e54:	8fb00010 	lw	s0,16(sp)=0A=
    1e58:	03e00008 	jr	ra=0A=
    1e5c:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
00001e60 <e1000_setup_tx_resources>:=0A=
    1e60:	27bdffd8 	addiu	sp,sp,-40=0A=
    1e64:	afb3001c 	sw	s3,28(sp)=0A=
    1e68:	afb10014 	sw	s1,20(sp)=0A=
    1e6c:	afb00010 	sw	s0,16(sp)=0A=
    1e70:	00808821 	move	s1,a0=0A=
    1e74:	afbf0020 	sw	ra,32(sp)=0A=
    1e78:	afb20018 	sw	s2,24(sp)=0A=
=0A=
/**=0A=
 * e1000_setup_tx_resources - allocate Tx resources (Descriptors)=0A=
 * @adapter: board private structure=0A=
 *=0A=
 * Return 0 on success, negative on failure=0A=
 *=0A=
 * e1000_setup_tx_resources allocates all software transmit resources=0A=
 * and enabled the Tx unit of the MAC.=0A=
 **/=0A=
=0A=
static int=0A=
e1000_setup_tx_resources(struct e1000_adapter *adapter)=0A=
{=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    int size;=0A=
=0A=
    E1000_DBG("e1000_setup_tx_resources\n");=0A=
=0A=
    size =3D sizeof(struct e1000_buffer) * adapter->tx_ring.count;=0A=
    1e7c:	8e2300f0 	lw	v1,240(s1)=0A=
    adapter->tx_ring.buffer_info =3D kmalloc(size, GFP_KERNEL);=0A=
    1e80:	240501f0 	li	a1,496=0A=
    1e84:	3c020000 	lui	v0,0x0=0A=
    1e88:	24420000 	addiu	v0,v0,0=0A=
    1e8c:	00038040 	sll	s0,v1,0x1=0A=
    1e90:	02038021 	addu	s0,s0,v1=0A=
    1e94:	001080c0 	sll	s0,s0,0x3=0A=
    1e98:	02002021 	move	a0,s0=0A=
    1e9c:	0040f809 	jalr	v0=0A=
    1ea0:	8e32014c 	lw	s2,332(s1)=0A=
    1ea4:	00401821 	move	v1,v0=0A=
    if(adapter->tx_ring.buffer_info =3D=3D NULL) {=0A=
        return -ENOMEM;=0A=
    }=0A=
    memset(adapter->tx_ring.buffer_info, 0, size);=0A=
    1ea8:	3c130000 	lui	s3,0x0=0A=
    1eac:	26730000 	addiu	s3,s3,0=0A=
    1eb0:	00602021 	move	a0,v1=0A=
    1eb4:	02003021 	move	a2,s0=0A=
    1eb8:	00002821 	move	a1,zero=0A=
    1ebc:	ae230100 	sw	v1,256(s1)=0A=
    1ec0:	10600020 	beqz	v1,1f44 <e1000_setup_tx_resources+0xe4>=0A=
    1ec4:	2402fff4 	li	v0,-12=0A=
    1ec8:	0260f809 	jalr	s3=0A=
    1ecc:	00000000 	nop=0A=
=0A=
    /* round up to nearest 4K */=0A=
=0A=
    adapter->tx_ring.size =3D E1000_ROUNDUP2(adapter->tx_ring.count *=0A=
    1ed0:	8e2300f0 	lw	v1,240(s1)=0A=
    1ed4:	2405f000 	li	a1,-4096=0A=
                                           sizeof(struct e1000_tx_desc),=0A=
                                           4096);=0A=
=0A=
    adapter->tx_ring.desc =3D pci_alloc_consistent(pdev, =
adapter->tx_ring.size,=0A=
    1ed8:	02402021 	move	a0,s2=0A=
    1edc:	00031900 	sll	v1,v1,0x4=0A=
    1ee0:	24630fff 	addiu	v1,v1,4095=0A=
    1ee4:	00651824 	and	v1,v1,a1=0A=
    1ee8:	00602821 	move	a1,v1=0A=
    1eec:	ae2300ec 	sw	v1,236(s1)=0A=
    1ef0:	3c020000 	lui	v0,0x0=0A=
    1ef4:	24420000 	addiu	v0,v0,0=0A=
    1ef8:	0040f809 	jalr	v0=0A=
    1efc:	262600e8 	addiu	a2,s1,232=0A=
                                                 &adapter->tx_ring.dma);=0A=
    if(adapter->tx_ring.desc =3D=3D NULL) {=0A=
        kfree(adapter->tx_ring.buffer_info);=0A=
        return -ENOMEM;=0A=
    }=0A=
    memset(adapter->tx_ring.desc, 0, adapter->tx_ring.size);=0A=
    1f00:	00402021 	move	a0,v0=0A=
    1f04:	00002821 	move	a1,zero=0A=
    1f08:	3c030000 	lui	v1,0x0=0A=
    1f0c:	24630000 	addiu	v1,v1,0=0A=
    1f10:	14400005 	bnez	v0,1f28 <e1000_setup_tx_resources+0xc8>=0A=
    1f14:	ae2200e4 	sw	v0,228(s1)=0A=
    1f18:	0060f809 	jalr	v1=0A=
    1f1c:	8e240100 	lw	a0,256(s1)=0A=
    1f20:	080007d1 	j	1f44 <e1000_setup_tx_resources+0xe4>=0A=
    1f24:	2402fff4 	li	v0,-12=0A=
    1f28:	0260f809 	jalr	s3=0A=
    1f2c:	8e2600ec 	lw	a2,236(s1)=0A=
=0A=
    atomic_set(&adapter->tx_ring.unused, adapter->tx_ring.count);=0A=
    1f30:	8e2300f0 	lw	v1,240(s1)=0A=
    adapter->tx_ring.next_to_use =3D 0;=0A=
    adapter->tx_ring.next_to_clean =3D 0;=0A=
    1f34:	ae2000fc 	sw	zero,252(s1)=0A=
    1f38:	ae2000f8 	sw	zero,248(s1)=0A=
    1f3c:	ae2300f4 	sw	v1,244(s1)=0A=
=0A=
    return 0;=0A=
    1f40:	00001021 	move	v0,zero=0A=
}=0A=
    1f44:	8fbf0020 	lw	ra,32(sp)=0A=
    1f48:	8fb3001c 	lw	s3,28(sp)=0A=
    1f4c:	8fb20018 	lw	s2,24(sp)=0A=
    1f50:	8fb10014 	lw	s1,20(sp)=0A=
    1f54:	8fb00010 	lw	s0,16(sp)=0A=
    1f58:	03e00008 	jr	ra=0A=
    1f5c:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
00001f60 <e1000_configure_tx>:=0A=
    1f60:	00803821 	move	a3,a0=0A=
=0A=
/**=0A=
 * e1000_configure_tx - Configure 8254x Transmit Unit after Reset=0A=
 * @adapter: board private structure=0A=
 *=0A=
 * Configure the Tx unit of the MAC after a reset.=0A=
 **/=0A=
=0A=
static void=0A=
e1000_configure_tx(struct e1000_adapter *adapter)=0A=
{=0A=
    uint32_t tctl, tipg;=0A=
    1f64:	8ce2000c 	lw	v0,12(a3)=0A=
    1f68:	2c420002 	sltiu	v0,v0,2=0A=
    1f6c:	1440000e 	bnez	v0,1fa8 <e1000_configure_tx+0x48>=0A=
    1f70:	8ce500e8 	lw	a1,232(a3)=0A=
    1f74:	8ce60008 	lw	a2,8(a3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    1f78:	30a4ff00 	andi	a0,a1,0xff00=0A=
    1f7c:	00051600 	sll	v0,a1,0x18=0A=
    1f80:	00051a02 	srl	v1,a1,0x8=0A=
    1f84:	00042200 	sll	a0,a0,0x8=0A=
    1f88:	00441025 	or	v0,v0,a0=0A=
    1f8c:	3063ff00 	andi	v1,v1,0xff00=0A=
    1f90:	00431025 	or	v0,v0,v1=0A=
    1f94:	00052e02 	srl	a1,a1,0x18=0A=
    1f98:	00451025 	or	v0,v0,a1=0A=
=0A=
    /* Setup the Base and Length of the Rx Descriptor Ring */=0A=
    /* tx_ring.dma can be either a 32 or 64 bit value */=0A=
=0A=
#if (BITS_PER_LONG =3D=3D 32)=0A=
    E1000_WRITE_REG(&adapter->shared, TDBAL, adapter->tx_ring.dma);=0A=
    1f9c:	acc23800 	sw	v0,14336(a2)=0A=
    1fa0:	080007f6 	j	1fd8 <e1000_configure_tx+0x78>=0A=
    1fa4:	8ce2000c 	lw	v0,12(a3)=0A=
    1fa8:	8ce60008 	lw	a2,8(a3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    1fac:	30a4ff00 	andi	a0,a1,0xff00=0A=
    1fb0:	00051600 	sll	v0,a1,0x18=0A=
    1fb4:	00051a02 	srl	v1,a1,0x8=0A=
    1fb8:	00042200 	sll	a0,a0,0x8=0A=
    1fbc:	00441025 	or	v0,v0,a0=0A=
    1fc0:	3063ff00 	andi	v1,v1,0xff00=0A=
    1fc4:	00431025 	or	v0,v0,v1=0A=
    1fc8:	00052e02 	srl	a1,a1,0x18=0A=
    1fcc:	00451025 	or	v0,v0,a1=0A=
    1fd0:	acc20420 	sw	v0,1056(a2)=0A=
    1fd4:	8ce2000c 	lw	v0,12(a3)=0A=
    1fd8:	2c420002 	sltiu	v0,v0,2=0A=
    1fdc:	14400004 	bnez	v0,1ff0 <e1000_configure_tx+0x90>=0A=
    1fe0:	8ce20008 	lw	v0,8(a3)=0A=
    E1000_WRITE_REG(&adapter->shared, TDBAH, 0);=0A=
    1fe4:	ac403804 	sw	zero,14340(v0)=0A=
    1fe8:	080007fe 	j	1ff8 <e1000_configure_tx+0x98>=0A=
    1fec:	8ce2000c 	lw	v0,12(a3)=0A=
    1ff0:	ac400424 	sw	zero,1060(v0)=0A=
    1ff4:	8ce2000c 	lw	v0,12(a3)=0A=
    1ff8:	2c420002 	sltiu	v0,v0,2=0A=
    1ffc:	1440000f 	bnez	v0,203c <e1000_configure_tx+0xdc>=0A=
    2000:	8ce400f0 	lw	a0,240(a3)=0A=
    2004:	8ce60008 	lw	a2,8(a3)=0A=
    2008:	00042100 	sll	a0,a0,0x4=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    200c:	3085ff00 	andi	a1,a0,0xff00=0A=
    2010:	00041600 	sll	v0,a0,0x18=0A=
    2014:	00041a02 	srl	v1,a0,0x8=0A=
    2018:	00052a00 	sll	a1,a1,0x8=0A=
    201c:	00451025 	or	v0,v0,a1=0A=
    2020:	3063ff00 	andi	v1,v1,0xff00=0A=
    2024:	00431025 	or	v0,v0,v1=0A=
    2028:	00042602 	srl	a0,a0,0x18=0A=
    202c:	00441025 	or	v0,v0,a0=0A=
#elif ( BITS_PER_LONG =3D=3D 64)=0A=
    E1000_WRITE_REG(&adapter->shared, TDBAL,=0A=
                    (uint32_t) (adapter->tx_ring.dma & =
0x00000000FFFFFFFF));=0A=
    E1000_WRITE_REG(&adapter->shared, TDBAH,=0A=
                    (uint32_t) (adapter->tx_ring.dma >> 32));=0A=
#else=0A=
#error "Unsupported System - does not use 32 or 64 bit pointers!"=0A=
#endif=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, TDLEN,=0A=
    2030:	acc23808 	sw	v0,14344(a2)=0A=
    2034:	0800081c 	j	2070 <e1000_configure_tx+0x110>=0A=
    2038:	8ce2000c 	lw	v0,12(a3)=0A=
    203c:	8ce60008 	lw	a2,8(a3)=0A=
    2040:	00042100 	sll	a0,a0,0x4=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2044:	3085ff00 	andi	a1,a0,0xff00=0A=
    2048:	00041600 	sll	v0,a0,0x18=0A=
    204c:	00041a02 	srl	v1,a0,0x8=0A=
    2050:	00052a00 	sll	a1,a1,0x8=0A=
    2054:	00451025 	or	v0,v0,a1=0A=
    2058:	3063ff00 	andi	v1,v1,0xff00=0A=
    205c:	00431025 	or	v0,v0,v1=0A=
    2060:	00042602 	srl	a0,a0,0x18=0A=
    2064:	00441025 	or	v0,v0,a0=0A=
    2068:	acc20428 	sw	v0,1064(a2)=0A=
    206c:	8ce2000c 	lw	v0,12(a3)=0A=
    2070:	2c420002 	sltiu	v0,v0,2=0A=
    2074:	14400004 	bnez	v0,2088 <e1000_configure_tx+0x128>=0A=
    2078:	8ce20008 	lw	v0,8(a3)=0A=
                    adapter->tx_ring.count * sizeof(struct =
e1000_tx_desc));=0A=
=0A=
    /* Setup the HW Tx Head and Tail descriptor pointers */=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, TDH, 0);=0A=
    207c:	ac403810 	sw	zero,14352(v0)=0A=
    2080:	08000824 	j	2090 <e1000_configure_tx+0x130>=0A=
    2084:	8ce2000c 	lw	v0,12(a3)=0A=
    2088:	ac400430 	sw	zero,1072(v0)=0A=
    208c:	8ce2000c 	lw	v0,12(a3)=0A=
    2090:	2c420002 	sltiu	v0,v0,2=0A=
    2094:	14400004 	bnez	v0,20a8 <e1000_configure_tx+0x148>=0A=
    2098:	8ce20008 	lw	v0,8(a3)=0A=
    E1000_WRITE_REG(&adapter->shared, TDT, 0);=0A=
    209c:	ac403818 	sw	zero,14360(v0)=0A=
    20a0:	0800082c 	j	20b0 <e1000_configure_tx+0x150>=0A=
    20a4:	8ce4000c 	lw	a0,12(a3)=0A=
    20a8:	ac400438 	sw	zero,1080(v0)=0A=
=0A=
    /* Set the default values for the Tx Inter Packet Gap timer */=0A=
=0A=
    switch (adapter->shared.mac_type) {=0A=
    20ac:	8ce4000c 	lw	a0,12(a3)=0A=
    20b0:	2c820002 	sltiu	v0,a0,2=0A=
    20b4:	1440000d 	bnez	v0,20ec <e1000_configure_tx+0x18c>=0A=
    20b8:	3c0600a0 	lui	a2,0xa0=0A=
    20bc:	2c820004 	sltiu	v0,a0,4=0A=
    20c0:	5040000b 	beqzl	v0,20f0 <e1000_configure_tx+0x190>=0A=
    20c4:	34c6080a 	ori	a2,a2,0x80a=0A=
    case e1000_82543:=0A=
    case e1000_82544:=0A=
        if(adapter->shared.media_type =3D=3D e1000_media_type_fiber)=0A=
    20c8:	8ce30010 	lw	v1,16(a3)=0A=
    20cc:	24020001 	li	v0,1=0A=
    20d0:	10620002 	beq	v1,v0,20dc <e1000_configure_tx+0x17c>=0A=
    20d4:	24060006 	li	a2,6=0A=
            tipg =3D DEFAULT_82543_TIPG_IPGT_FIBER;=0A=
        else=0A=
            tipg =3D DEFAULT_82543_TIPG_IPGT_COPPER;=0A=
    20d8:	24060008 	li	a2,8=0A=
        tipg |=3D DEFAULT_82543_TIPG_IPGR1 << E1000_TIPG_IPGR1_SHIFT;=0A=
        tipg |=3D DEFAULT_82543_TIPG_IPGR2 << E1000_TIPG_IPGR2_SHIFT;=0A=
    20dc:	3c020060 	lui	v0,0x60=0A=
    20e0:	34422000 	ori	v0,v0,0x2000=0A=
        break;=0A=
    20e4:	0800083c 	j	20f0 <e1000_configure_tx+0x190>=0A=
    20e8:	00c23025 	or	a2,a2,v0=0A=
    case e1000_82542_rev2_0:=0A=
    case e1000_82542_rev2_1:=0A=
    default:=0A=
        tipg =3D DEFAULT_82542_TIPG_IPGT;=0A=
        tipg |=3D DEFAULT_82542_TIPG_IPGR1 << E1000_TIPG_IPGR1_SHIFT;=0A=
        tipg |=3D DEFAULT_82542_TIPG_IPGR2 << E1000_TIPG_IPGR2_SHIFT;=0A=
    20ec:	34c6080a 	ori	a2,a2,0x80a=0A=
        break;=0A=
    }=0A=
    20f0:	2c820002 	sltiu	v0,a0,2=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    20f4:	30c3ff00 	andi	v1,a2,0xff00=0A=
    20f8:	00031a00 	sll	v1,v1,0x8=0A=
    20fc:	00061600 	sll	v0,a2,0x18=0A=
    2100:	00062202 	srl	a0,a2,0x8=0A=
    2104:	00431025 	or	v0,v0,v1=0A=
    2108:	3084ff00 	andi	a0,a0,0xff00=0A=
    E1000_WRITE_REG(&adapter->shared, TIPG, tipg);=0A=
    210c:	8ce50008 	lw	a1,8(a3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2110:	00441025 	or	v0,v0,a0=0A=
    2114:	00061e02 	srl	v1,a2,0x18=0A=
    2118:	00431025 	or	v0,v0,v1=0A=
    211c:	aca20410 	sw	v0,1040(a1)=0A=
    2120:	8ce2000c 	lw	v0,12(a3)=0A=
    2124:	2c420002 	sltiu	v0,v0,2=0A=
    2128:	1440000e 	bnez	v0,2164 <e1000_configure_tx+0x204>=0A=
    212c:	8ce50104 	lw	a1,260(a3)=0A=
    2130:	8ce60008 	lw	a2,8(a3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2134:	30a4ff00 	andi	a0,a1,0xff00=0A=
    2138:	00051600 	sll	v0,a1,0x18=0A=
    213c:	00051a02 	srl	v1,a1,0x8=0A=
    2140:	00042200 	sll	a0,a0,0x8=0A=
    2144:	00441025 	or	v0,v0,a0=0A=
    2148:	3063ff00 	andi	v1,v1,0xff00=0A=
    214c:	00431025 	or	v0,v0,v1=0A=
    2150:	00052e02 	srl	a1,a1,0x18=0A=
    2154:	00451025 	or	v0,v0,a1=0A=
=0A=
    /* Set the Tx Interrupt Delay register */=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, TIDV, adapter->tx_int_delay);=0A=
    2158:	acc23820 	sw	v0,14368(a2)=0A=
    215c:	08000865 	j	2194 <e1000_configure_tx+0x234>=0A=
    2160:	8ce2000c 	lw	v0,12(a3)=0A=
    2164:	8ce60008 	lw	a2,8(a3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2168:	30a4ff00 	andi	a0,a1,0xff00=0A=
    216c:	00051600 	sll	v0,a1,0x18=0A=
    2170:	00051a02 	srl	v1,a1,0x8=0A=
    2174:	00042200 	sll	a0,a0,0x8=0A=
    2178:	00441025 	or	v0,v0,a0=0A=
    217c:	3063ff00 	andi	v1,v1,0xff00=0A=
    2180:	00431025 	or	v0,v0,v1=0A=
    2184:	00052e02 	srl	a1,a1,0x18=0A=
    2188:	00451025 	or	v0,v0,a1=0A=
    218c:	acc20440 	sw	v0,1088(a2)=0A=
=0A=
    /* Program the Transmit Control Register */=0A=
=0A=
    tctl =3D=0A=
        E1000_TCTL_PSP | E1000_TCTL_EN | (E1000_COLLISION_THRESHOLD <<=0A=
                                          E1000_CT_SHIFT);=0A=
    if(adapter->link_duplex =3D=3D FULL_DUPLEX) {=0A=
        tctl |=3D E1000_FDX_COLLISION_DISTANCE << E1000_COLD_SHIFT;=0A=
    } else {=0A=
        tctl |=3D E1000_HDX_COLLISION_DISTANCE << E1000_COLD_SHIFT;=0A=
    }=0A=
    2190:	8ce2000c 	lw	v0,12(a3)=0A=
    2194:	2c420002 	sltiu	v0,v0,2=0A=
    E1000_WRITE_REG(&adapter->shared, TCTL, tctl);=0A=
    2198:	8ce30008 	lw	v1,8(a3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    219c:	3c020a01 	lui	v0,0xa01=0A=
    21a0:	34420400 	ori	v0,v0,0x400=0A=
    21a4:	ac620400 	sw	v0,1024(v1)=0A=
=0A=
#if defined(CONFIG_PPC) || defined(CONFIG_MIPS)=0A=
    if(adapter->shared.mac_type >=3D e1000_82543) {=0A=
    21a8:	8ce2000c 	lw	v0,12(a3)=0A=
    21ac:	2c420002 	sltiu	v0,v0,2=0A=
    21b0:	54400005 	bnezl	v0,21c8 <e1000_configure_tx+0x268>=0A=
    21b4:	8ce30104 	lw	v1,260(a3)=0A=
        E1000_WRITE_REG(&adapter->shared, TXDCTL, 0x00020000);=0A=
    21b8:	8ce30008 	lw	v1,8(a3)=0A=
    21bc:	24020200 	li	v0,512=0A=
    21c0:	ac623828 	sw	v0,14376(v1)=0A=
    }=0A=
#endif=0A=
=0A=
    /* Setup Transmit Descriptor Settings for this adapter */=0A=
    adapter->TxdCmd =3D E1000_TXD_CMD_IFCS;=0A=
=0A=
    if(adapter->tx_int_delay > 0)=0A=
    21c4:	8ce30104 	lw	v1,260(a3)=0A=
    21c8:	3c020200 	lui	v0,0x200=0A=
    21cc:	10600003 	beqz	v1,21dc <e1000_configure_tx+0x27c>=0A=
    21d0:	ace20108 	sw	v0,264(a3)=0A=
        adapter->TxdCmd |=3D E1000_TXD_CMD_IDE;=0A=
    21d4:	3c028200 	lui	v0,0x8200=0A=
    21d8:	ace20108 	sw	v0,264(a3)=0A=
    if(adapter->shared.report_tx_early =3D=3D 1)=0A=
    21dc:	8ce3006c 	lw	v1,108(a3)=0A=
    21e0:	24020001 	li	v0,1=0A=
    21e4:	14620003 	bne	v1,v0,21f4 <e1000_configure_tx+0x294>=0A=
    21e8:	8ce20108 	lw	v0,264(a3)=0A=
        adapter->TxdCmd |=3D E1000_TXD_CMD_RS;=0A=
    21ec:	0800087e 	j	21f8 <e1000_configure_tx+0x298>=0A=
    21f0:	3c030800 	lui	v1,0x800=0A=
    else=0A=
        adapter->TxdCmd |=3D E1000_TXD_CMD_RPS;=0A=
    21f4:	3c031000 	lui	v1,0x1000=0A=
    21f8:	00431025 	or	v0,v0,v1=0A=
    21fc:	ace20108 	sw	v0,264(a3)=0A=
=0A=
    adapter->ActiveChecksumContext =3D OFFLOAD_NONE;=0A=
=0A=
    return;=0A=
}=0A=
    2200:	03e00008 	jr	ra=0A=
    2204:	ace001b4 	sw	zero,436(a3)=0A=
=0A=
00002208 <e1000_setup_rx_resources>:=0A=
    2208:	27bdffd8 	addiu	sp,sp,-40=0A=
    220c:	afb3001c 	sw	s3,28(sp)=0A=
    2210:	afb10014 	sw	s1,20(sp)=0A=
    2214:	afb00010 	sw	s0,16(sp)=0A=
    2218:	00808821 	move	s1,a0=0A=
    221c:	afbf0020 	sw	ra,32(sp)=0A=
    2220:	afb20018 	sw	s2,24(sp)=0A=
=0A=
/**=0A=
 * e1000_setup_rx_resources - allocate Rx resources (Descriptors, =
receive SKBs)=0A=
 * @adapter: board private structure=0A=
 * =0A=
 * Returns 0 on success, negative on failure=0A=
 *=0A=
 * e1000_setup_rx_resources allocates all software receive resources=0A=
 * and network buffers, and enables the Rx unit of the MAC.=0A=
 **/=0A=
=0A=
static int=0A=
e1000_setup_rx_resources(struct e1000_adapter *adapter)=0A=
{=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    int size;=0A=
=0A=
    E1000_DBG("e1000_setup_rx_resources\n");=0A=
=0A=
    size =3D sizeof(struct e1000_buffer) * adapter->rx_ring.count;=0A=
    2224:	8e23011c 	lw	v1,284(s1)=0A=
    adapter->rx_ring.buffer_info =3D kmalloc(size, GFP_KERNEL);=0A=
    2228:	240501f0 	li	a1,496=0A=
    222c:	3c020000 	lui	v0,0x0=0A=
    2230:	24420000 	addiu	v0,v0,0=0A=
    2234:	00038040 	sll	s0,v1,0x1=0A=
    2238:	02038021 	addu	s0,s0,v1=0A=
    223c:	001080c0 	sll	s0,s0,0x3=0A=
    2240:	02002021 	move	a0,s0=0A=
    2244:	0040f809 	jalr	v0=0A=
    2248:	8e32014c 	lw	s2,332(s1)=0A=
    224c:	00401821 	move	v1,v0=0A=
    if(adapter->rx_ring.buffer_info =3D=3D NULL) {=0A=
        return -ENOMEM;=0A=
    }=0A=
    memset(adapter->rx_ring.buffer_info, 0, size);=0A=
    2250:	3c130000 	lui	s3,0x0=0A=
    2254:	26730000 	addiu	s3,s3,0=0A=
    2258:	00602021 	move	a0,v1=0A=
    225c:	02003021 	move	a2,s0=0A=
    2260:	00002821 	move	a1,zero=0A=
    2264:	ae23012c 	sw	v1,300(s1)=0A=
    2268:	10600020 	beqz	v1,22ec <e1000_setup_rx_resources+0xe4>=0A=
    226c:	2402fff4 	li	v0,-12=0A=
    2270:	0260f809 	jalr	s3=0A=
    2274:	00000000 	nop=0A=
=0A=
    /* Round up to nearest 4K */=0A=
=0A=
    adapter->rx_ring.size =3D E1000_ROUNDUP2(adapter->rx_ring.count *=0A=
    2278:	8e23011c 	lw	v1,284(s1)=0A=
    227c:	2405f000 	li	a1,-4096=0A=
                                           sizeof(struct e1000_rx_desc),=0A=
                                           4096);=0A=
=0A=
    adapter->rx_ring.desc =3D pci_alloc_consistent(pdev, =
adapter->rx_ring.size, =0A=
    2280:	02402021 	move	a0,s2=0A=
    2284:	00031900 	sll	v1,v1,0x4=0A=
    2288:	24630fff 	addiu	v1,v1,4095=0A=
    228c:	00651824 	and	v1,v1,a1=0A=
    2290:	00602821 	move	a1,v1=0A=
    2294:	ae230118 	sw	v1,280(s1)=0A=
    2298:	3c020000 	lui	v0,0x0=0A=
    229c:	24420000 	addiu	v0,v0,0=0A=
    22a0:	0040f809 	jalr	v0=0A=
    22a4:	26260114 	addiu	a2,s1,276=0A=
                                                 &adapter->rx_ring.dma);=0A=
=0A=
    if(adapter->rx_ring.desc =3D=3D NULL) {=0A=
        kfree(adapter->rx_ring.buffer_info);=0A=
        return -ENOMEM;=0A=
    }=0A=
    memset(adapter->rx_ring.desc, 0, adapter->rx_ring.size);=0A=
    22a8:	00402021 	move	a0,v0=0A=
    22ac:	00002821 	move	a1,zero=0A=
    22b0:	3c030000 	lui	v1,0x0=0A=
    22b4:	24630000 	addiu	v1,v1,0=0A=
    22b8:	14400005 	bnez	v0,22d0 <e1000_setup_rx_resources+0xc8>=0A=
    22bc:	ae220110 	sw	v0,272(s1)=0A=
    22c0:	0060f809 	jalr	v1=0A=
    22c4:	8e24012c 	lw	a0,300(s1)=0A=
    22c8:	080008bb 	j	22ec <e1000_setup_rx_resources+0xe4>=0A=
    22cc:	2402fff4 	li	v0,-12=0A=
    22d0:	0260f809 	jalr	s3=0A=
    22d4:	8e260118 	lw	a2,280(s1)=0A=
=0A=
    adapter->rx_ring.next_to_clean =3D 0;=0A=
    atomic_set(&adapter->rx_ring.unused, adapter->rx_ring.count);=0A=
    22d8:	8e23011c 	lw	v1,284(s1)=0A=
=0A=
    adapter->rx_ring.next_to_use =3D 0;=0A=
    22dc:	ae200124 	sw	zero,292(s1)=0A=
    22e0:	ae200128 	sw	zero,296(s1)=0A=
    22e4:	ae230120 	sw	v1,288(s1)=0A=
=0A=
    return 0;=0A=
    22e8:	00001021 	move	v0,zero=0A=
}=0A=
    22ec:	8fbf0020 	lw	ra,32(sp)=0A=
    22f0:	8fb3001c 	lw	s3,28(sp)=0A=
    22f4:	8fb20018 	lw	s2,24(sp)=0A=
    22f8:	8fb10014 	lw	s1,20(sp)=0A=
    22fc:	8fb00010 	lw	s0,16(sp)=0A=
    2300:	03e00008 	jr	ra=0A=
    2304:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
00002308 <e1000_setup_rctl>:=0A=
    2308:	00802821 	move	a1,a0=0A=
=0A=
/**=0A=
 * e1000_setup_rctl - configure the receive control register=0A=
 * @adapter: Board private structure=0A=
 **/=0A=
=0A=
static void=0A=
e1000_setup_rctl(struct e1000_adapter *adapter)=0A=
{=0A=
    uint32_t rctl;=0A=
=0A=
    /* Setup the Receive Control Register */=0A=
    rctl =3D=0A=
    230c:	8ca20040 	lw	v0,64(a1)=0A=
        E1000_RCTL_EN | E1000_RCTL_BAM | E1000_RCTL_LBM_NO |=0A=
        E1000_RCTL_RDMTS_HALF | (adapter->shared.=0A=
                                 mc_filter_type << E1000_RCTL_MO_SHIFT);=0A=
=0A=
    if(adapter->shared.tbi_compatibility_on =3D=3D 1)=0A=
    2310:	8ca40060 	lw	a0,96(a1)=0A=
    2314:	24030001 	li	v1,1=0A=
    2318:	00021300 	sll	v0,v0,0xc=0A=
    231c:	14830002 	bne	a0,v1,2328 <e1000_setup_rctl+0x20>=0A=
    2320:	34468002 	ori	a2,v0,0x8002=0A=
        rctl |=3D E1000_RCTL_SBP;=0A=
    2324:	34468006 	ori	a2,v0,0x8006=0A=
=0A=
    switch (adapter->rx_buffer_len) {=0A=
    2328:	8ca300b8 	lw	v1,184(a1)=0A=
    232c:	24021000 	li	v0,4096=0A=
    2330:	1062000c 	beq	v1,v0,2364 <e1000_setup_rctl+0x5c>=0A=
    2334:	3c020203 	lui	v0,0x203=0A=
    2338:	2c621001 	sltiu	v0,v1,4097=0A=
    233c:	5440000c 	bnezl	v0,2370 <e1000_setup_rctl+0x68>=0A=
    2340:	8ca2000c 	lw	v0,12(a1)=0A=
    2344:	24022000 	li	v0,8192=0A=
    2348:	10620006 	beq	v1,v0,2364 <e1000_setup_rctl+0x5c>=0A=
    234c:	3c020202 	lui	v0,0x202=0A=
    2350:	24024000 	li	v0,16384=0A=
    2354:	50620003 	beql	v1,v0,2364 <e1000_setup_rctl+0x5c>=0A=
    2358:	3c020201 	lui	v0,0x201=0A=
    235c:	080008dc 	j	2370 <e1000_setup_rctl+0x68>=0A=
    2360:	8ca2000c 	lw	v0,12(a1)=0A=
    case E1000_RXBUFFER_2048:=0A=
    default:=0A=
        rctl |=3D E1000_RCTL_SZ_2048;=0A=
        break;=0A=
    case E1000_RXBUFFER_4096:=0A=
        rctl |=3D E1000_RCTL_SZ_4096 | E1000_RCTL_BSEX | E1000_RCTL_LPE;=0A=
        break;=0A=
    case E1000_RXBUFFER_8192:=0A=
        rctl |=3D E1000_RCTL_SZ_8192 | E1000_RCTL_BSEX | E1000_RCTL_LPE;=0A=
        break;=0A=
    case E1000_RXBUFFER_16384:=0A=
        rctl |=3D E1000_RCTL_SZ_16384 | E1000_RCTL_BSEX | E1000_RCTL_LPE;=0A=
    2364:	34420020 	ori	v0,v0,0x20=0A=
    2368:	00c23025 	or	a2,a2,v0=0A=
        break;=0A=
    }=0A=
    236c:	8ca2000c 	lw	v0,12(a1)=0A=
    2370:	2c420002 	sltiu	v0,v0,2=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2374:	30c3ff00 	andi	v1,a2,0xff00=0A=
    2378:	00031a00 	sll	v1,v1,0x8=0A=
    237c:	00061600 	sll	v0,a2,0x18=0A=
    2380:	00062202 	srl	a0,a2,0x8=0A=
    2384:	00431025 	or	v0,v0,v1=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, RCTL, rctl);=0A=
    2388:	8ca50008 	lw	a1,8(a1)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    238c:	3084ff00 	andi	a0,a0,0xff00=0A=
    2390:	00441025 	or	v0,v0,a0=0A=
    2394:	00061e02 	srl	v1,a2,0x18=0A=
    2398:	00431025 	or	v0,v0,v1=0A=
    239c:	aca20100 	sw	v0,256(a1)=0A=
}=0A=
    23a0:	03e00008 	jr	ra=0A=
    23a4:	00000000 	nop=0A=
=0A=
000023a8 <e1000_configure_rx>:=0A=
    23a8:	00804021 	move	t0,a0=0A=
=0A=
/**=0A=
 * e1000_configure_rx - Configure 8254x Receive Unit after Reset=0A=
 * @adapter: board private structure=0A=
 *=0A=
 * Configure the Rx unit of the MAC after a reset.=0A=
 **/=0A=
=0A=
static void=0A=
e1000_configure_rx(struct e1000_adapter *adapter)=0A=
{=0A=
    uint32_t rctl;=0A=
    23ac:	8d04000c 	lw	a0,12(t0)=0A=
    23b0:	00803821 	move	a3,a0=0A=
    23b4:	2ce20002 	sltiu	v0,a3,2=0A=
    uint32_t rxcsum;=0A=
=0A=
    /* make sure receives are disabled while setting up the descriptor =
ring */=0A=
    rctl =3D E1000_READ_REG(&adapter->shared, RCTL);=0A=
    23b8:	8d060008 	lw	a2,8(t0)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    23bc:	8cc50100 	lw	a1,256(a2)=0A=
	return __arch__swab32(x);=0A=
    23c0:	30a3ff00 	andi	v1,a1,0xff00=0A=
    23c4:	00052600 	sll	a0,a1,0x18=0A=
    23c8:	00051202 	srl	v0,a1,0x8=0A=
    23cc:	00031a00 	sll	v1,v1,0x8=0A=
    23d0:	00832025 	or	a0,a0,v1=0A=
    23d4:	3042ff00 	andi	v0,v0,0xff00=0A=
    23d8:	00822025 	or	a0,a0,v0=0A=
    23dc:	00052e02 	srl	a1,a1,0x18=0A=
    23e0:	00854825 	or	t1,a0,a1=0A=
    23e4:	2ce20002 	sltiu	v0,a3,2=0A=
    E1000_WRITE_REG(&adapter->shared, RCTL, rctl & ~E1000_RCTL_EN);=0A=
    23e8:	2404fffd 	li	a0,-3=0A=
    23ec:	01242024 	and	a0,t1,a0=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    23f0:	312200fd 	andi	v0,t1,0xfd=0A=
    23f4:	312aff00 	andi	t2,t1,0xff00=0A=
    23f8:	00041a02 	srl	v1,a0,0x8=0A=
    23fc:	00021600 	sll	v0,v0,0x18=0A=
    2400:	000a2a00 	sll	a1,t2,0x8=0A=
    2404:	00451025 	or	v0,v0,a1=0A=
    2408:	3063ff00 	andi	v1,v1,0xff00=0A=
    240c:	00431025 	or	v0,v0,v1=0A=
    2410:	00042602 	srl	a0,a0,0x18=0A=
    2414:	00441025 	or	v0,v0,a0=0A=
    2418:	acc20100 	sw	v0,256(a2)=0A=
    241c:	8d02000c 	lw	v0,12(t0)=0A=
    2420:	2c420002 	sltiu	v0,v0,2=0A=
    2424:	14400010 	bnez	v0,2468 <e1000_configure_rx+0xc0>=0A=
    2428:	8d040130 	lw	a0,304(t0)=0A=
    242c:	3c028000 	lui	v0,0x8000=0A=
    2430:	8d060008 	lw	a2,8(t0)=0A=
    2434:	00822025 	or	a0,a0,v0=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2438:	3085ff00 	andi	a1,a0,0xff00=0A=
    243c:	00041600 	sll	v0,a0,0x18=0A=
    2440:	00041a02 	srl	v1,a0,0x8=0A=
    2444:	00052a00 	sll	a1,a1,0x8=0A=
    2448:	00451025 	or	v0,v0,a1=0A=
    244c:	3063ff00 	andi	v1,v1,0xff00=0A=
    2450:	00431025 	or	v0,v0,v1=0A=
    2454:	00042602 	srl	a0,a0,0x18=0A=
    2458:	00441025 	or	v0,v0,a0=0A=
=0A=
    /* set the Receive Delay Timer Register */=0A=
    E1000_WRITE_REG(&adapter->shared, RDTR,=0A=
    245c:	acc22820 	sw	v0,10272(a2)=0A=
    2460:	08000928 	j	24a0 <e1000_configure_rx+0xf8>=0A=
    2464:	8d02000c 	lw	v0,12(t0)=0A=
    2468:	3c028000 	lui	v0,0x8000=0A=
    246c:	8d060008 	lw	a2,8(t0)=0A=
    2470:	00822025 	or	a0,a0,v0=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2474:	3085ff00 	andi	a1,a0,0xff00=0A=
    2478:	00041600 	sll	v0,a0,0x18=0A=
    247c:	00041a02 	srl	v1,a0,0x8=0A=
    2480:	00052a00 	sll	a1,a1,0x8=0A=
    2484:	00451025 	or	v0,v0,a1=0A=
    2488:	3063ff00 	andi	v1,v1,0xff00=0A=
    248c:	00431025 	or	v0,v0,v1=0A=
    2490:	00042602 	srl	a0,a0,0x18=0A=
    2494:	00441025 	or	v0,v0,a0=0A=
    2498:	acc20108 	sw	v0,264(a2)=0A=
    249c:	8d02000c 	lw	v0,12(t0)=0A=
    24a0:	2c420002 	sltiu	v0,v0,2=0A=
    24a4:	1440000e 	bnez	v0,24e0 <e1000_configure_rx+0x138>=0A=
    24a8:	8d050114 	lw	a1,276(t0)=0A=
    24ac:	8d060008 	lw	a2,8(t0)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    24b0:	30a4ff00 	andi	a0,a1,0xff00=0A=
    24b4:	00051600 	sll	v0,a1,0x18=0A=
    24b8:	00051a02 	srl	v1,a1,0x8=0A=
    24bc:	00042200 	sll	a0,a0,0x8=0A=
    24c0:	00441025 	or	v0,v0,a0=0A=
    24c4:	3063ff00 	andi	v1,v1,0xff00=0A=
    24c8:	00431025 	or	v0,v0,v1=0A=
    24cc:	00052e02 	srl	a1,a1,0x18=0A=
    24d0:	00451025 	or	v0,v0,a1=0A=
                    adapter->rx_int_delay | E1000_RDT_FPDB);=0A=
=0A=
    /* Setup the Base and Length of the Rx Descriptor Ring */=0A=
    /* rx_ring.dma can be either a 32 or 64 bit value */=0A=
=0A=
#if (BITS_PER_LONG =3D=3D 32)=0A=
    E1000_WRITE_REG(&adapter->shared, RDBAL, adapter->rx_ring.dma);=0A=
    24d4:	acc22800 	sw	v0,10240(a2)=0A=
    24d8:	08000944 	j	2510 <e1000_configure_rx+0x168>=0A=
    24dc:	8d02000c 	lw	v0,12(t0)=0A=
    24e0:	8d060008 	lw	a2,8(t0)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    24e4:	30a4ff00 	andi	a0,a1,0xff00=0A=
    24e8:	00051600 	sll	v0,a1,0x18=0A=
    24ec:	00051a02 	srl	v1,a1,0x8=0A=
    24f0:	00042200 	sll	a0,a0,0x8=0A=
    24f4:	00441025 	or	v0,v0,a0=0A=
    24f8:	3063ff00 	andi	v1,v1,0xff00=0A=
    24fc:	00431025 	or	v0,v0,v1=0A=
    2500:	00052e02 	srl	a1,a1,0x18=0A=
    2504:	00451025 	or	v0,v0,a1=0A=
    2508:	acc20110 	sw	v0,272(a2)=0A=
    250c:	8d02000c 	lw	v0,12(t0)=0A=
    2510:	2c420002 	sltiu	v0,v0,2=0A=
    2514:	14400004 	bnez	v0,2528 <e1000_configure_rx+0x180>=0A=
    2518:	8d020008 	lw	v0,8(t0)=0A=
    E1000_WRITE_REG(&adapter->shared, RDBAH, 0);=0A=
    251c:	ac402804 	sw	zero,10244(v0)=0A=
    2520:	0800094c 	j	2530 <e1000_configure_rx+0x188>=0A=
    2524:	8d02000c 	lw	v0,12(t0)=0A=
    2528:	ac400114 	sw	zero,276(v0)=0A=
    252c:	8d02000c 	lw	v0,12(t0)=0A=
    2530:	2c420002 	sltiu	v0,v0,2=0A=
    2534:	1440000f 	bnez	v0,2574 <e1000_configure_rx+0x1cc>=0A=
    2538:	8d04011c 	lw	a0,284(t0)=0A=
    253c:	8d060008 	lw	a2,8(t0)=0A=
    2540:	00042100 	sll	a0,a0,0x4=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2544:	3085ff00 	andi	a1,a0,0xff00=0A=
    2548:	00041600 	sll	v0,a0,0x18=0A=
    254c:	00041a02 	srl	v1,a0,0x8=0A=
    2550:	00052a00 	sll	a1,a1,0x8=0A=
    2554:	00451025 	or	v0,v0,a1=0A=
    2558:	3063ff00 	andi	v1,v1,0xff00=0A=
    255c:	00431025 	or	v0,v0,v1=0A=
    2560:	00042602 	srl	a0,a0,0x18=0A=
    2564:	00441025 	or	v0,v0,a0=0A=
#elif ( BITS_PER_LONG =3D=3D 64)=0A=
    E1000_WRITE_REG(&adapter->shared, RDBAL,=0A=
                    (uint32_t) (adapter->rx_ring.dma & =
0x00000000FFFFFFFF));=0A=
    E1000_WRITE_REG(&adapter->shared, RDBAH,=0A=
                    (uint32_t) (adapter->rx_ring.dma >> 32));=0A=
#else=0A=
#error "Unsupported System - does not use 32 or 64 bit pointers!"=0A=
#endif=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, RDLEN,=0A=
    2568:	acc22808 	sw	v0,10248(a2)=0A=
    256c:	0800096a 	j	25a8 <e1000_configure_rx+0x200>=0A=
    2570:	8d02000c 	lw	v0,12(t0)=0A=
    2574:	8d060008 	lw	a2,8(t0)=0A=
    2578:	00042100 	sll	a0,a0,0x4=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    257c:	3085ff00 	andi	a1,a0,0xff00=0A=
    2580:	00041600 	sll	v0,a0,0x18=0A=
    2584:	00041a02 	srl	v1,a0,0x8=0A=
    2588:	00052a00 	sll	a1,a1,0x8=0A=
    258c:	00451025 	or	v0,v0,a1=0A=
    2590:	3063ff00 	andi	v1,v1,0xff00=0A=
    2594:	00431025 	or	v0,v0,v1=0A=
    2598:	00042602 	srl	a0,a0,0x18=0A=
    259c:	00441025 	or	v0,v0,a0=0A=
    25a0:	acc20118 	sw	v0,280(a2)=0A=
    25a4:	8d02000c 	lw	v0,12(t0)=0A=
    25a8:	2c420002 	sltiu	v0,v0,2=0A=
    25ac:	14400004 	bnez	v0,25c0 <e1000_configure_rx+0x218>=0A=
    25b0:	8d020008 	lw	v0,8(t0)=0A=
                    adapter->rx_ring.count * sizeof(struct =
e1000_rx_desc));=0A=
=0A=
    /* Setup the HW Rx Head and Tail Descriptor Pointers */=0A=
    E1000_WRITE_REG(&adapter->shared, RDH, 0);=0A=
    25b4:	ac402810 	sw	zero,10256(v0)=0A=
    25b8:	08000972 	j	25c8 <e1000_configure_rx+0x220>=0A=
    25bc:	8d02000c 	lw	v0,12(t0)=0A=
    25c0:	ac400120 	sw	zero,288(v0)=0A=
    25c4:	8d02000c 	lw	v0,12(t0)=0A=
    25c8:	2c420002 	sltiu	v0,v0,2=0A=
    25cc:	14400004 	bnez	v0,25e0 <e1000_configure_rx+0x238>=0A=
    25d0:	8d020008 	lw	v0,8(t0)=0A=
    E1000_WRITE_REG(&adapter->shared, RDT, 0);=0A=
    25d4:	ac402818 	sw	zero,10264(v0)=0A=
    25d8:	0800097a 	j	25e8 <e1000_configure_rx+0x240>=0A=
    25dc:	8d04000c 	lw	a0,12(t0)=0A=
    25e0:	ac400128 	sw	zero,296(v0)=0A=
=0A=
    /* Enable 82543 Receive Checksum Offload for TCP and UDP */=0A=
    if((adapter->shared.mac_type >=3D e1000_82543) &&=0A=
    25e4:	8d04000c 	lw	a0,12(t0)=0A=
    25e8:	2c820002 	sltiu	v0,a0,2=0A=
    25ec:	54400026 	bnezl	v0,2688 <e1000_configure_rx+0x2e0>=0A=
    25f0:	000a2200 	sll	a0,t2,0x8=0A=
    25f4:	8d0301b0 	lw	v1,432(t0)=0A=
    25f8:	24020001 	li	v0,1=0A=
    25fc:	1462001a 	bne	v1,v0,2668 <e1000_configure_rx+0x2c0>=0A=
    2600:	2c820002 	sltiu	v0,a0,2=0A=
       (adapter->RxChecksum =3D=3D TRUE)) {=0A=
        rxcsum =3D E1000_READ_REG(&adapter->shared, RXCSUM);=0A=
    2604:	8d070008 	lw	a3,8(t0)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2608:	3c0600ff 	lui	a2,0xff=0A=
    260c:	8ce55000 	lw	a1,20480(a3)=0A=
    2610:	30a4ff00 	andi	a0,a1,0xff00=0A=
    2614:	00a61024 	and	v0,a1,a2=0A=
    2618:	00042200 	sll	a0,a0,0x8=0A=
    261c:	00051e00 	sll	v1,a1,0x18=0A=
    2620:	00641825 	or	v1,v1,a0=0A=
    2624:	00021202 	srl	v0,v0,0x8=0A=
    2628:	00621825 	or	v1,v1,v0=0A=
    262c:	00052e02 	srl	a1,a1,0x18=0A=
    2630:	00651825 	or	v1,v1,a1=0A=
        rxcsum |=3D E1000_RXCSUM_TUOFL;=0A=
    2634:	34630200 	ori	v1,v1,0x200=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2638:	3064ff00 	andi	a0,v1,0xff00=0A=
    263c:	00042200 	sll	a0,a0,0x8=0A=
    2640:	00663024 	and	a2,v1,a2=0A=
    2644:	00031600 	sll	v0,v1,0x18=0A=
    2648:	00441025 	or	v0,v0,a0=0A=
    264c:	00063202 	srl	a2,a2,0x8=0A=
    2650:	00461025 	or	v0,v0,a2=0A=
    2654:	00031e02 	srl	v1,v1,0x18=0A=
    2658:	00431025 	or	v0,v0,v1=0A=
        E1000_WRITE_REG(&adapter->shared, RXCSUM, rxcsum);=0A=
    265c:	ace25000 	sw	v0,20480(a3)=0A=
    2660:	8d04000c 	lw	a0,12(t0)=0A=
    }=0A=
#if defined(CONFIG_PPC) || defined(CONFIG_MIPS)=0A=
    if(adapter->shared.mac_type >=3D e1000_82543) {=0A=
    2664:	2c820002 	sltiu	v0,a0,2=0A=
    2668:	14400007 	bnez	v0,2688 <e1000_configure_rx+0x2e0>=0A=
    266c:	000a2200 	sll	a0,t2,0x8=0A=
        E1000_WRITE_REG(&adapter->shared, RXDCTL, 0x00020000);=0A=
    2670:	8d040008 	lw	a0,8(t0)=0A=
    2674:	24030200 	li	v1,512=0A=
    2678:	ac832828 	sw	v1,10280(a0)=0A=
    }=0A=
    267c:	8d02000c 	lw	v0,12(t0)=0A=
    2680:	2c420002 	sltiu	v0,v0,2=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2684:	000a2200 	sll	a0,t2,0x8=0A=
    2688:	00091600 	sll	v0,t1,0x18=0A=
    268c:	00091a02 	srl	v1,t1,0x8=0A=
    2690:	00441025 	or	v0,v0,a0=0A=
#endif=0A=
=0A=
    /* Enable Receives */=0A=
    E1000_WRITE_REG(&adapter->shared, RCTL, rctl);=0A=
    2694:	8d050008 	lw	a1,8(t0)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2698:	3063ff00 	andi	v1,v1,0xff00=0A=
    269c:	00431025 	or	v0,v0,v1=0A=
    26a0:	00092602 	srl	a0,t1,0x18=0A=
    26a4:	00441025 	or	v0,v0,a0=0A=
    26a8:	aca20100 	sw	v0,256(a1)=0A=
=0A=
    return;=0A=
}=0A=
    26ac:	03e00008 	jr	ra=0A=
    26b0:	00000000 	nop=0A=
=0A=
000026b4 <e1000_free_tx_resources>:=0A=
    26b4:	27bdffe0 	addiu	sp,sp,-32=0A=
    26b8:	afbf0018 	sw	ra,24(sp)=0A=
    26bc:	afb00010 	sw	s0,16(sp)=0A=
    26c0:	afb10014 	sw	s1,20(sp)=0A=
    26c4:	00808021 	move	s0,a0=0A=
=0A=
/**=0A=
 * e1000_free_tx_resources - Free Tx Resources=0A=
 * @adapter: board private structure=0A=
 *=0A=
 * Free all transmit software resources=0A=
 **/=0A=
=0A=
static void=0A=
e1000_free_tx_resources(struct e1000_adapter *adapter)=0A=
{=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
=0A=
    E1000_DBG("e1000_free_tx_resources\n");=0A=
=0A=
    e1000_clean_tx_ring(adapter);=0A=
    26c8:	3c020000 	lui	v0,0x0=0A=
    26cc:	24422720 	addiu	v0,v0,10016=0A=
    26d0:	0040f809 	jalr	v0=0A=
    26d4:	8e11014c 	lw	s1,332(s0)=0A=
=0A=
    kfree(adapter->tx_ring.buffer_info);=0A=
    26d8:	3c020000 	lui	v0,0x0=0A=
    26dc:	24420000 	addiu	v0,v0,0=0A=
    26e0:	0040f809 	jalr	v0=0A=
    26e4:	8e040100 	lw	a0,256(s0)=0A=
    adapter->tx_ring.buffer_info =3D NULL;=0A=
=0A=
    pci_free_consistent(pdev, adapter->tx_ring.size, =
adapter->tx_ring.desc,=0A=
    26e8:	8e0500ec 	lw	a1,236(s0)=0A=
    26ec:	8e0600e4 	lw	a2,228(s0)=0A=
    26f0:	8e0700e8 	lw	a3,232(s0)=0A=
    26f4:	02202021 	move	a0,s1=0A=
    26f8:	3c020000 	lui	v0,0x0=0A=
    26fc:	24420000 	addiu	v0,v0,0=0A=
    2700:	0040f809 	jalr	v0=0A=
    2704:	ae000100 	sw	zero,256(s0)=0A=
                        adapter->tx_ring.dma);=0A=
=0A=
    adapter->tx_ring.desc =3D NULL;=0A=
=0A=
    return;=0A=
}=0A=
    2708:	8fbf0018 	lw	ra,24(sp)=0A=
    270c:	ae0000e4 	sw	zero,228(s0)=0A=
    2710:	8fb10014 	lw	s1,20(sp)=0A=
    2714:	8fb00010 	lw	s0,16(sp)=0A=
    2718:	03e00008 	jr	ra=0A=
    271c:	27bd0020 	addiu	sp,sp,32=0A=
=0A=
00002720 <e1000_clean_tx_ring>:=0A=
    2720:	27bdffd0 	addiu	sp,sp,-48=0A=
    2724:	afb10014 	sw	s1,20(sp)=0A=
    2728:	afb00010 	sw	s0,16(sp)=0A=
    272c:	afbf0028 	sw	ra,40(sp)=0A=
    2730:	afb50024 	sw	s5,36(sp)=0A=
    2734:	afb40020 	sw	s4,32(sp)=0A=
    2738:	afb3001c 	sw	s3,28(sp)=0A=
    273c:	afb20018 	sw	s2,24(sp)=0A=
    2740:	00808821 	move	s1,a0=0A=
=0A=
/**=0A=
 * e1000_clean_tx_ring - Free Tx Buffers=0A=
 * @adapter: board private structure=0A=
 **/=0A=
=0A=
static void=0A=
e1000_clean_tx_ring(struct e1000_adapter *adapter)=0A=
{=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    unsigned long size;=0A=
    int i;=0A=
=0A=
    /* Free all the Tx ring sk_buffs */=0A=
=0A=
    for(i =3D 0; i < adapter->tx_ring.count; i++) {=0A=
    2744:	8e2700f0 	lw	a3,240(s1)=0A=
    2748:	10e00026 	beqz	a3,27e4 <e1000_clean_tx_ring+0xc4>=0A=
    274c:	00008021 	move	s0,zero=0A=
    2750:	8e250100 	lw	a1,256(s1)=0A=
    2754:	3c150000 	lui	s5,0x0=0A=
    2758:	26b50000 	addiu	s5,s5,0=0A=
    275c:	0000a021 	move	s4,zero=0A=
    2760:	00009821 	move	s3,zero=0A=
    2764:	00009021 	move	s2,zero=0A=
        if(adapter->tx_ring.buffer_info[i].skb !=3D NULL) {=0A=
    2768:	02451021 	addu	v0,s2,a1=0A=
    276c:	8c430000 	lw	v1,0(v0)=0A=
=0A=
            pci_unmap_page(pdev, adapter->tx_ring.buffer_info[i].dma,=0A=
                           adapter->tx_ring.buffer_info[i].length,=0A=
                           PCI_DMA_TODEVICE);=0A=
=0A=
            dev_kfree_skb(adapter->tx_ring.buffer_info[i].skb);=0A=
    2770:	02652021 	addu	a0,s3,a1=0A=
    2774:	10600013 	beqz	v1,27c4 <e1000_clean_tx_ring+0xa4>=0A=
    2778:	24060001 	li	a2,1=0A=
 *	hit zero.=0A=
 */=0A=
 =0A=
static inline void kfree_skb(struct sk_buff *skb)=0A=
{=0A=
    277c:	8c840000 	lw	a0,0(a0)=0A=
	if (atomic_read(&skb->users) =3D=3D 1 || =
atomic_dec_and_test(&skb->users))=0A=
    2780:	8c820070 	lw	v0,112(a0)=0A=
    2784:	10460008 	beq	v0,a2,27a8 <e1000_clean_tx_ring+0x88>=0A=
    2788:	24850070 	addiu	a1,a0,112=0A=
extern __inline__ int atomic_sub_return(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp, result;=0A=
=0A=
	__asm__ __volatile__(=0A=
    278c:	c0a30000 	ll	v1,0(a1)=0A=
    2790:	00661023 	subu	v0,v1,a2=0A=
    2794:	e0a20000 	sc	v0,0(a1)=0A=
    2798:	1040fffc 	beqz	v0,278c <e1000_clean_tx_ring+0x6c>=0A=
    279c:	00661023 	subu	v0,v1,a2=0A=
 */=0A=
 =0A=
static inline void kfree_skb(struct sk_buff *skb)=0A=
{=0A=
	if (atomic_read(&skb->users) =3D=3D 1 || =
atomic_dec_and_test(&skb->users))=0A=
    27a0:	54400004 	bnezl	v0,27b4 <e1000_clean_tx_ring+0x94>=0A=
    27a4:	8e220100 	lw	v0,256(s1)=0A=
		__kfree_skb(skb);=0A=
    27a8:	02a0f809 	jalr	s5=0A=
    27ac:	00000000 	nop=0A=
=0A=
            adapter->tx_ring.buffer_info[i].skb =3D NULL;=0A=
    27b0:	8e220100 	lw	v0,256(s1)=0A=
    27b4:	02821021 	addu	v0,s4,v0=0A=
    27b8:	ac400000 	sw	zero,0(v0)=0A=
    27bc:	8e250100 	lw	a1,256(s1)=0A=
    27c0:	8e2700f0 	lw	a3,240(s1)=0A=
    27c4:	26100001 	addiu	s0,s0,1=0A=
    27c8:	0207102b 	sltu	v0,s0,a3=0A=
    27cc:	26940018 	addiu	s4,s4,24=0A=
    27d0:	26730018 	addiu	s3,s3,24=0A=
    27d4:	1440ffe4 	bnez	v0,2768 <e1000_clean_tx_ring+0x48>=0A=
    27d8:	26520018 	addiu	s2,s2,24=0A=
    27dc:	080009fb 	j	27ec <e1000_clean_tx_ring+0xcc>=0A=
    27e0:	00073040 	sll	a2,a3,0x1=0A=
    27e4:	8e250100 	lw	a1,256(s1)=0A=
        }=0A=
    }=0A=
=0A=
    size =3D sizeof(struct e1000_buffer) * adapter->tx_ring.count;=0A=
    27e8:	00073040 	sll	a2,a3,0x1=0A=
    27ec:	00c73021 	addu	a2,a2,a3=0A=
    memset(adapter->tx_ring.buffer_info, 0, size);=0A=
    27f0:	00a02021 	move	a0,a1=0A=
    27f4:	3c100000 	lui	s0,0x0=0A=
    27f8:	26100000 	addiu	s0,s0,0=0A=
    27fc:	000630c0 	sll	a2,a2,0x3=0A=
    2800:	0200f809 	jalr	s0=0A=
    2804:	00002821 	move	a1,zero=0A=
=0A=
    /* Zero out the descriptor ring */=0A=
=0A=
    memset(adapter->tx_ring.desc, 0, adapter->tx_ring.size);=0A=
    2808:	8e2400e4 	lw	a0,228(s1)=0A=
    280c:	8e2600ec 	lw	a2,236(s1)=0A=
    2810:	0200f809 	jalr	s0=0A=
    2814:	00002821 	move	a1,zero=0A=
=0A=
    atomic_set(&adapter->tx_ring.unused, adapter->tx_ring.count);=0A=
    2818:	8e2300f0 	lw	v1,240(s1)=0A=
    adapter->tx_ring.next_to_use =3D 0;=0A=
    adapter->tx_ring.next_to_clean =3D 0;=0A=
    281c:	ae2000fc 	sw	zero,252(s1)=0A=
    2820:	ae2000f8 	sw	zero,248(s1)=0A=
    2824:	ae2300f4 	sw	v1,244(s1)=0A=
=0A=
    return;=0A=
}=0A=
    2828:	8fbf0028 	lw	ra,40(sp)=0A=
    282c:	8fb50024 	lw	s5,36(sp)=0A=
    2830:	8fb40020 	lw	s4,32(sp)=0A=
    2834:	8fb3001c 	lw	s3,28(sp)=0A=
    2838:	8fb20018 	lw	s2,24(sp)=0A=
    283c:	8fb10014 	lw	s1,20(sp)=0A=
    2840:	8fb00010 	lw	s0,16(sp)=0A=
    2844:	03e00008 	jr	ra=0A=
    2848:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
0000284c <e1000_free_rx_resources>:=0A=
    284c:	27bdffe0 	addiu	sp,sp,-32=0A=
    2850:	afb00010 	sw	s0,16(sp)=0A=
    2854:	afbf0018 	sw	ra,24(sp)=0A=
    2858:	00808021 	move	s0,a0=0A=
    285c:	afb10014 	sw	s1,20(sp)=0A=
=0A=
/**=0A=
 * e1000_free_rx_resources - Free Rx Resources=0A=
 * @adapter: board private structure=0A=
 *=0A=
 * Free all receive software resources=0A=
 **/=0A=
=0A=
static void=0A=
e1000_free_rx_resources(struct e1000_adapter *adapter)=0A=
{=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    2860:	8e11014c 	lw	s1,332(s0)=0A=
 * Atomically adds @i to @v.  Note that the guaranteed useful range=0A=
 * of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
    2864:	24030001 	li	v1,1=0A=
    2868:	260200d8 	addiu	v0,s0,216=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    286c:	c0440000 	ll	a0,0(v0)=0A=
    2870:	00832021 	addu	a0,a0,v1=0A=
    2874:	e0440000 	sc	a0,0(v0)=0A=
    2878:	1080fffc 	beqz	a0,286c <e1000_free_rx_resources+0x20>=0A=
    287c:	00000000 	nop=0A=
=0A=
    E1000_DBG("e1000_free_rx_resources\n");=0A=
=0A=
    tasklet_disable(&adapter->rx_fill_tasklet);=0A=
=0A=
    e1000_clean_rx_ring(adapter);=0A=
    2880:	3c020000 	lui	v0,0x0=0A=
    2884:	244228d8 	addiu	v0,v0,10456=0A=
    2888:	0040f809 	jalr	v0=0A=
    288c:	02002021 	move	a0,s0=0A=
=0A=
    kfree(adapter->rx_ring.buffer_info);=0A=
    2890:	3c020000 	lui	v0,0x0=0A=
    2894:	24420000 	addiu	v0,v0,0=0A=
    2898:	0040f809 	jalr	v0=0A=
    289c:	8e04012c 	lw	a0,300(s0)=0A=
    adapter->rx_ring.buffer_info =3D NULL;=0A=
=0A=
    pci_free_consistent(pdev, adapter->rx_ring.size, =
adapter->rx_ring.desc,=0A=
    28a0:	8e050118 	lw	a1,280(s0)=0A=
    28a4:	8e060110 	lw	a2,272(s0)=0A=
    28a8:	8e070114 	lw	a3,276(s0)=0A=
    28ac:	02202021 	move	a0,s1=0A=
    28b0:	3c020000 	lui	v0,0x0=0A=
    28b4:	24420000 	addiu	v0,v0,0=0A=
    28b8:	0040f809 	jalr	v0=0A=
    28bc:	ae00012c 	sw	zero,300(s0)=0A=
                        adapter->rx_ring.dma);=0A=
=0A=
    adapter->rx_ring.desc =3D NULL;=0A=
=0A=
    return;=0A=
}=0A=
    28c0:	8fbf0018 	lw	ra,24(sp)=0A=
    28c4:	ae000110 	sw	zero,272(s0)=0A=
    28c8:	8fb10014 	lw	s1,20(sp)=0A=
    28cc:	8fb00010 	lw	s0,16(sp)=0A=
    28d0:	03e00008 	jr	ra=0A=
    28d4:	27bd0020 	addiu	sp,sp,32=0A=
=0A=
000028d8 <e1000_clean_rx_ring>:=0A=
    28d8:	27bdffd0 	addiu	sp,sp,-48=0A=
    28dc:	afb10014 	sw	s1,20(sp)=0A=
    28e0:	afb00010 	sw	s0,16(sp)=0A=
    28e4:	afbf0028 	sw	ra,40(sp)=0A=
    28e8:	afb50024 	sw	s5,36(sp)=0A=
    28ec:	afb40020 	sw	s4,32(sp)=0A=
    28f0:	afb3001c 	sw	s3,28(sp)=0A=
    28f4:	afb20018 	sw	s2,24(sp)=0A=
    28f8:	00808821 	move	s1,a0=0A=
=0A=
/**=0A=
 * e1000_clean_rx_ring - Free Rx Buffers=0A=
 * @adapter: board private structure=0A=
 **/=0A=
=0A=
static void=0A=
e1000_clean_rx_ring(struct e1000_adapter *adapter)=0A=
{=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    unsigned long size;=0A=
    int i;=0A=
=0A=
    /* Free all the Rx ring sk_buffs */=0A=
=0A=
    for(i =3D 0; i < adapter->rx_ring.count; i++) {=0A=
    28fc:	8e27011c 	lw	a3,284(s1)=0A=
    2900:	10e00026 	beqz	a3,299c <e1000_clean_rx_ring+0xc4>=0A=
    2904:	00008021 	move	s0,zero=0A=
    2908:	8e25012c 	lw	a1,300(s1)=0A=
    290c:	3c150000 	lui	s5,0x0=0A=
    2910:	26b50000 	addiu	s5,s5,0=0A=
    2914:	0000a021 	move	s4,zero=0A=
    2918:	00009821 	move	s3,zero=0A=
    291c:	00009021 	move	s2,zero=0A=
        if(adapter->rx_ring.buffer_info[i].skb !=3D NULL) {=0A=
    2920:	02451021 	addu	v0,s2,a1=0A=
    2924:	8c430000 	lw	v1,0(v0)=0A=
=0A=
            pci_unmap_single(pdev, adapter->rx_ring.buffer_info[i].dma,=0A=
                             adapter->rx_ring.buffer_info[i].length,=0A=
                             PCI_DMA_FROMDEVICE);=0A=
=0A=
            dev_kfree_skb(adapter->rx_ring.buffer_info[i].skb);=0A=
    2928:	02652021 	addu	a0,s3,a1=0A=
    292c:	10600013 	beqz	v1,297c <e1000_clean_rx_ring+0xa4>=0A=
    2930:	24060001 	li	a2,1=0A=
 *	hit zero.=0A=
 */=0A=
 =0A=
static inline void kfree_skb(struct sk_buff *skb)=0A=
{=0A=
    2934:	8c840000 	lw	a0,0(a0)=0A=
	if (atomic_read(&skb->users) =3D=3D 1 || =
atomic_dec_and_test(&skb->users))=0A=
    2938:	8c820070 	lw	v0,112(a0)=0A=
    293c:	10460008 	beq	v0,a2,2960 <e1000_clean_rx_ring+0x88>=0A=
    2940:	24850070 	addiu	a1,a0,112=0A=
extern __inline__ int atomic_sub_return(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp, result;=0A=
=0A=
	__asm__ __volatile__(=0A=
    2944:	c0a30000 	ll	v1,0(a1)=0A=
    2948:	00661023 	subu	v0,v1,a2=0A=
    294c:	e0a20000 	sc	v0,0(a1)=0A=
    2950:	1040fffc 	beqz	v0,2944 <e1000_clean_rx_ring+0x6c>=0A=
    2954:	00661023 	subu	v0,v1,a2=0A=
 */=0A=
 =0A=
static inline void kfree_skb(struct sk_buff *skb)=0A=
{=0A=
	if (atomic_read(&skb->users) =3D=3D 1 || =
atomic_dec_and_test(&skb->users))=0A=
    2958:	54400004 	bnezl	v0,296c <e1000_clean_rx_ring+0x94>=0A=
    295c:	8e22012c 	lw	v0,300(s1)=0A=
		__kfree_skb(skb);=0A=
    2960:	02a0f809 	jalr	s5=0A=
    2964:	00000000 	nop=0A=
=0A=
            adapter->rx_ring.buffer_info[i].skb =3D NULL;=0A=
    2968:	8e22012c 	lw	v0,300(s1)=0A=
    296c:	02821021 	addu	v0,s4,v0=0A=
    2970:	ac400000 	sw	zero,0(v0)=0A=
    2974:	8e25012c 	lw	a1,300(s1)=0A=
    2978:	8e27011c 	lw	a3,284(s1)=0A=
    297c:	26100001 	addiu	s0,s0,1=0A=
    2980:	0207102b 	sltu	v0,s0,a3=0A=
    2984:	26940018 	addiu	s4,s4,24=0A=
    2988:	26730018 	addiu	s3,s3,24=0A=
    298c:	1440ffe4 	bnez	v0,2920 <e1000_clean_rx_ring+0x48>=0A=
    2990:	26520018 	addiu	s2,s2,24=0A=
    2994:	08000a69 	j	29a4 <e1000_clean_rx_ring+0xcc>=0A=
    2998:	00073040 	sll	a2,a3,0x1=0A=
    299c:	8e25012c 	lw	a1,300(s1)=0A=
        }=0A=
    }=0A=
=0A=
    size =3D sizeof(struct e1000_buffer) * adapter->rx_ring.count;=0A=
    29a0:	00073040 	sll	a2,a3,0x1=0A=
    29a4:	00c73021 	addu	a2,a2,a3=0A=
    memset(adapter->rx_ring.buffer_info, 0, size);=0A=
    29a8:	00a02021 	move	a0,a1=0A=
    29ac:	3c100000 	lui	s0,0x0=0A=
    29b0:	26100000 	addiu	s0,s0,0=0A=
    29b4:	000630c0 	sll	a2,a2,0x3=0A=
    29b8:	0200f809 	jalr	s0=0A=
    29bc:	00002821 	move	a1,zero=0A=
=0A=
    /* Zero out the descriptor ring */=0A=
=0A=
    memset(adapter->rx_ring.desc, 0, adapter->rx_ring.size);=0A=
    29c0:	8e240110 	lw	a0,272(s1)=0A=
    29c4:	8e260118 	lw	a2,280(s1)=0A=
    29c8:	0200f809 	jalr	s0=0A=
    29cc:	00002821 	move	a1,zero=0A=
=0A=
    atomic_set(&adapter->rx_ring.unused, adapter->rx_ring.count);=0A=
    29d0:	8e23011c 	lw	v1,284(s1)=0A=
    adapter->rx_ring.next_to_clean =3D 0;=0A=
    adapter->rx_ring.next_to_use =3D 0;=0A=
    29d4:	ae200124 	sw	zero,292(s1)=0A=
    29d8:	ae200128 	sw	zero,296(s1)=0A=
    29dc:	ae230120 	sw	v1,288(s1)=0A=
=0A=
    return;=0A=
}=0A=
    29e0:	8fbf0028 	lw	ra,40(sp)=0A=
    29e4:	8fb50024 	lw	s5,36(sp)=0A=
    29e8:	8fb40020 	lw	s4,32(sp)=0A=
    29ec:	8fb3001c 	lw	s3,28(sp)=0A=
    29f0:	8fb20018 	lw	s2,24(sp)=0A=
    29f4:	8fb10014 	lw	s1,20(sp)=0A=
    29f8:	8fb00010 	lw	s0,16(sp)=0A=
    29fc:	03e00008 	jr	ra=0A=
    2a00:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
00002a04 <e1000_set_multi>:=0A=
    2a04:	27bdfcd0 	addiu	sp,sp,-816=0A=
    2a08:	afb40320 	sw	s4,800(sp)=0A=
    2a0c:	afbf032c 	sw	ra,812(sp)=0A=
    2a10:	afb60328 	sw	s6,808(sp)=0A=
    2a14:	afb50324 	sw	s5,804(sp)=0A=
    2a18:	afb3031c 	sw	s3,796(sp)=0A=
    2a1c:	afb20318 	sw	s2,792(sp)=0A=
    2a20:	afb10314 	sw	s1,788(sp)=0A=
    2a24:	afb00310 	sw	s0,784(sp)=0A=
    2a28:	0080a021 	move	s4,a0=0A=
=0A=
/**=0A=
 * e1000_set_multi - Multicast and Promiscuous mode set=0A=
 * @netdev: network interface device structure=0A=
 *=0A=
 * The set_multi entry point is called whenever the multicast address=0A=
 * list or the network interface flags are updated.  This routine is=0A=
 * resposible for configuring the hardware for proper multicast,=0A=
 * promiscuous mode, and all-multi behavior.=0A=
 **/=0A=
=0A=
void=0A=
e1000_set_multi(struct net_device *netdev)=0A=
{=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    2a2c:	8e910064 	lw	s1,100(s4)=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    2a30:	8e33000c 	lw	s3,12(s1)=0A=
    2a34:	8e35014c 	lw	s5,332(s1)=0A=
    2a38:	2e620002 	sltiu	v0,s3,2=0A=
    uint32_t rctl;=0A=
    uint8_t mta[MAX_NUM_MULTICAST_ADDRESSES * ETH_LENGTH_OF_ADDRESS];=0A=
    uint16_t pci_command_word;=0A=
    struct dev_mc_list *mc_ptr;=0A=
    int i;=0A=
=0A=
    E1000_DBG("e1000_set_multi\n");=0A=
=0A=
    rctl =3D E1000_READ_REG(&adapter->shared, RCTL);=0A=
    2a3c:	8e320008 	lw	s2,8(s1)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    2a40:	8e450100 	lw	a1,256(s2)=0A=
	return __arch__swab32(x);=0A=
    2a44:	30a3ff00 	andi	v1,a1,0xff00=0A=
    2a48:	00052600 	sll	a0,a1,0x18=0A=
    2a4c:	00051202 	srl	v0,a1,0x8=0A=
    2a50:	00031a00 	sll	v1,v1,0x8=0A=
    2a54:	00832025 	or	a0,a0,v1=0A=
    2a58:	3042ff00 	andi	v0,v0,0xff00=0A=
    2a5c:	00822025 	or	a0,a0,v0=0A=
    2a60:	00052e02 	srl	a1,a1,0x18=0A=
=0A=
    if(adapter->shared.mac_type =3D=3D e1000_82542_rev2_0) {=0A=
    2a64:	1660002d 	bnez	s3,2b1c <e1000_set_multi+0x118>=0A=
    2a68:	00858025 	or	s0,a0,a1=0A=
        if(adapter->shared.pci_cmd_word & PCI_COMMAND_INVALIDATE) {=0A=
    2a6c:	9626004a 	lhu	a2,74(s1)=0A=
    2a70:	30c20010 	andi	v0,a2,0x10=0A=
    2a74:	10400006 	beqz	v0,2a90 <e1000_set_multi+0x8c>=0A=
    2a78:	30c6ffef 	andi	a2,a2,0xffef=0A=
            pci_command_word =3D=0A=
                adapter->shared.pci_cmd_word & ~PCI_COMMAND_INVALIDATE;=0A=
            pci_write_config_word(pdev, PCI_COMMAND, pci_command_word);=0A=
    2a7c:	02a02021 	move	a0,s5=0A=
    2a80:	3c020000 	lui	v0,0x0=0A=
    2a84:	24420000 	addiu	v0,v0,0=0A=
    2a88:	0040f809 	jalr	v0=0A=
    2a8c:	24050004 	li	a1,4=0A=
        }=0A=
        rctl |=3D E1000_RCTL_RST;=0A=
    2a90:	36100001 	ori	s0,s0,0x1=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2a94:	3204ff00 	andi	a0,s0,0xff00=0A=
    2a98:	00042200 	sll	a0,a0,0x8=0A=
    2a9c:	00101e00 	sll	v1,s0,0x18=0A=
    2aa0:	00101202 	srl	v0,s0,0x8=0A=
    2aa4:	00641825 	or	v1,v1,a0=0A=
    2aa8:	3042ff00 	andi	v0,v0,0xff00=0A=
    2aac:	00621825 	or	v1,v1,v0=0A=
    2ab0:	00102602 	srl	a0,s0,0x18=0A=
    2ab4:	00641825 	or	v1,v1,a0=0A=
        E1000_WRITE_REG(&adapter->shared, RCTL, rctl);=0A=
    2ab8:	ae430100 	sw	v1,256(s2)=0A=
extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)=0A=
{=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
    2abc:	3c027fff 	lui	v0,0x7fff=0A=
    2ac0:	3c030000 	lui	v1,0x0=0A=
    2ac4:	8c630000 	lw	v1,0(v1)=0A=
    2ac8:	3442f1c0 	ori	v0,v0,0xf1c0=0A=
	__asm__("multu\t%2,%3"=0A=
    2acc:	00430019 	multu	v0,v1=0A=
    2ad0:	00001010 	mfhi	v0=0A=
	...=0A=
    2adc:	1440ffff 	bnez	v0,2adc <e1000_set_multi+0xd8>=0A=
    2ae0:	2442ffff 	addiu	v0,v0,-1=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    2ae4:	8e23008c 	lw	v1,140(s1)=0A=
    2ae8:	30630001 	andi	v1,v1,0x1=0A=
        mdelay(5);=0A=
        if(test_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    2aec:	1060000b 	beqz	v1,2b1c <e1000_set_multi+0x118>=0A=
    2af0:	24030001 	li	v1,1=0A=
 * Atomically adds @i to @v.  Note that the guaranteed useful range=0A=
 * of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
    2af4:	262200d8 	addiu	v0,s1,216=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    2af8:	c0440000 	ll	a0,0(v0)=0A=
    2afc:	00832021 	addu	a0,a0,v1=0A=
    2b00:	e0440000 	sc	a0,0(v0)=0A=
    2b04:	1080fffc 	beqz	a0,2af8 <e1000_set_multi+0xf4>=0A=
    2b08:	00000000 	nop=0A=
            tasklet_disable(&adapter->rx_fill_tasklet);=0A=
            e1000_clean_rx_ring(adapter);=0A=
    2b0c:	3c020000 	lui	v0,0x0=0A=
    2b10:	244228d8 	addiu	v0,v0,10456=0A=
    2b14:	0040f809 	jalr	v0=0A=
    2b18:	02202021 	move	a0,s1=0A=
        }=0A=
    }=0A=
=0A=
    /* Check for Promiscuous and All Multicast modes */=0A=
=0A=
    if(netdev->flags & IFF_PROMISC) {=0A=
    2b1c:	96830054 	lhu	v1,84(s4)=0A=
    2b20:	30620100 	andi	v0,v1,0x100=0A=
    2b24:	10400003 	beqz	v0,2b34 <e1000_set_multi+0x130>=0A=
    2b28:	30620200 	andi	v0,v1,0x200=0A=
        rctl |=3D (E1000_RCTL_UPE | E1000_RCTL_MPE);=0A=
    } else if(netdev->flags & IFF_ALLMULTI) {=0A=
    2b2c:	08000ad3 	j	2b4c <e1000_set_multi+0x148>=0A=
    2b30:	36100018 	ori	s0,s0,0x18=0A=
    2b34:	10400003 	beqz	v0,2b44 <e1000_set_multi+0x140>=0A=
    2b38:	2402fff7 	li	v0,-9=0A=
        rctl |=3D E1000_RCTL_MPE;=0A=
        rctl &=3D ~E1000_RCTL_UPE;=0A=
    } else {=0A=
    2b3c:	08000ad2 	j	2b48 <e1000_set_multi+0x144>=0A=
    2b40:	36100010 	ori	s0,s0,0x10=0A=
        rctl &=3D ~(E1000_RCTL_UPE | E1000_RCTL_MPE);=0A=
    2b44:	2402ffe7 	li	v0,-25=0A=
    2b48:	02028024 	and	s0,s0,v0=0A=
    }=0A=
=0A=
    if(netdev->mc_count > MAX_NUM_MULTICAST_ADDRESSES) {=0A=
    2b4c:	8e820084 	lw	v0,132(s4)=0A=
    2b50:	28420081 	slti	v0,v0,129=0A=
    2b54:	1440000e 	bnez	v0,2b90 <e1000_set_multi+0x18c>=0A=
    2b58:	2e620002 	sltiu	v0,s3,2=0A=
        rctl |=3D E1000_RCTL_MPE;=0A=
    2b5c:	36100010 	ori	s0,s0,0x10=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2b60:	3204ff00 	andi	a0,s0,0xff00=0A=
    2b64:	00042200 	sll	a0,a0,0x8=0A=
    2b68:	00101600 	sll	v0,s0,0x18=0A=
    2b6c:	00101a02 	srl	v1,s0,0x8=0A=
    2b70:	00441025 	or	v0,v0,a0=0A=
    2b74:	3063ff00 	andi	v1,v1,0xff00=0A=
    2b78:	00431025 	or	v0,v0,v1=0A=
    2b7c:	00102602 	srl	a0,s0,0x18=0A=
    2b80:	00441025 	or	v0,v0,a0=0A=
        E1000_WRITE_REG(&adapter->shared, RCTL, rctl);=0A=
    2b84:	ae420100 	sw	v0,256(s2)=0A=
    } else {=0A=
    2b88:	08000b05 	j	2c14 <e1000_set_multi+0x210>=0A=
    2b8c:	8e22000c 	lw	v0,12(s1)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2b90:	3204ff00 	andi	a0,s0,0xff00=0A=
    2b94:	00042200 	sll	a0,a0,0x8=0A=
    2b98:	00101600 	sll	v0,s0,0x18=0A=
    2b9c:	00101a02 	srl	v1,s0,0x8=0A=
    2ba0:	00441025 	or	v0,v0,a0=0A=
    2ba4:	3063ff00 	andi	v1,v1,0xff00=0A=
    2ba8:	00431025 	or	v0,v0,v1=0A=
    2bac:	00102602 	srl	a0,s0,0x18=0A=
    2bb0:	00441025 	or	v0,v0,a0=0A=
        E1000_WRITE_REG(&adapter->shared, RCTL, rctl);=0A=
    2bb4:	ae420100 	sw	v0,256(s2)=0A=
        for(i =3D 0, mc_ptr =3D netdev->mc_list; mc_ptr; i++, mc_ptr =3D =
mc_ptr->next)=0A=
    2bb8:	8e820080 	lw	v0,128(s4)=0A=
    2bbc:	5040000e 	beqzl	v0,2bf8 <e1000_set_multi+0x1f4>=0A=
    2bc0:	8e860084 	lw	a2,132(s4)=0A=
    2bc4:	02c01821 	move	v1,s6=0A=
            memcpy(&mta[i * ETH_LENGTH_OF_ADDRESS], mc_ptr->dmi_addr,=0A=
    2bc8:	88440004 	lwl	a0,4(v0)=0A=
    2bcc:	98440007 	lwr	a0,7(v0)=0A=
    2bd0:	80450008 	lb	a1,8(v0)=0A=
    2bd4:	80460009 	lb	a2,9(v0)=0A=
    2bd8:	a8640000 	swl	a0,0(v1)=0A=
    2bdc:	b8640003 	swr	a0,3(v1)=0A=
    2be0:	a0650004 	sb	a1,4(v1)=0A=
    2be4:	a0660005 	sb	a2,5(v1)=0A=
    2be8:	8c420000 	lw	v0,0(v0)=0A=
    2bec:	1440fff6 	bnez	v0,2bc8 <e1000_set_multi+0x1c4>=0A=
    2bf0:	24630006 	addiu	v1,v1,6=0A=
                   ETH_LENGTH_OF_ADDRESS);=0A=
        e1000_mc_addr_list_update(&adapter->shared, mta, =
netdev->mc_count, 0);=0A=
    2bf4:	8e860084 	lw	a2,132(s4)=0A=
    2bf8:	26240008 	addiu	a0,s1,8=0A=
    2bfc:	27a50010 	addiu	a1,sp,16=0A=
    2c00:	3c020000 	lui	v0,0x0=0A=
    2c04:	24420000 	addiu	v0,v0,0=0A=
    2c08:	0040f809 	jalr	v0=0A=
    2c0c:	00003821 	move	a3,zero=0A=
    }=0A=
=0A=
    if(adapter->shared.mac_type =3D=3D e1000_82542_rev2_0) {=0A=
    2c10:	8e22000c 	lw	v0,12(s1)=0A=
    2c14:	1440003b 	bnez	v0,2d04 <e1000_set_multi+0x300>=0A=
    2c18:	8fbf032c 	lw	ra,812(sp)=0A=
        rctl =3D E1000_READ_REG(&adapter->shared, RCTL);=0A=
    2c1c:	8e280008 	lw	t0,8(s1)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2c20:	3c0700ff 	lui	a3,0xff=0A=
extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)=0A=
{=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
    2c24:	3c067fff 	lui	a2,0x7fff=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    2c28:	8d020100 	lw	v0,256(t0)=0A=
extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)=0A=
{=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
    2c2c:	34c6f1c0 	ori	a2,a2,0xf1c0=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2c30:	3043ff00 	andi	v1,v0,0xff00=0A=
    2c34:	00472024 	and	a0,v0,a3=0A=
    2c38:	00031a00 	sll	v1,v1,0x8=0A=
    2c3c:	00022e00 	sll	a1,v0,0x18=0A=
    2c40:	00a32825 	or	a1,a1,v1=0A=
    2c44:	00042202 	srl	a0,a0,0x8=0A=
    2c48:	00021602 	srl	v0,v0,0x18=0A=
    2c4c:	00a42825 	or	a1,a1,a0=0A=
        rctl &=3D ~E1000_RCTL_RST;=0A=
    2c50:	304200fe 	andi	v0,v0,0xfe=0A=
    2c54:	00458025 	or	s0,v0,a1=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    2c58:	3204ff00 	andi	a0,s0,0xff00=0A=
    2c5c:	00042200 	sll	a0,a0,0x8=0A=
    2c60:	02073824 	and	a3,s0,a3=0A=
    2c64:	00101e00 	sll	v1,s0,0x18=0A=
    2c68:	00641825 	or	v1,v1,a0=0A=
    2c6c:	00073a02 	srl	a3,a3,0x8=0A=
    2c70:	00101602 	srl	v0,s0,0x18=0A=
    2c74:	00671825 	or	v1,v1,a3=0A=
    2c78:	00621825 	or	v1,v1,v0=0A=
        E1000_WRITE_REG(&adapter->shared, RCTL, rctl);=0A=
    2c7c:	ad030100 	sw	v1,256(t0)=0A=
 * first constant multiplications gets optimized away if the delay is=0A=
 * a constant)=0A=
 */=0A=
extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)=0A=
{=0A=
    2c80:	3c020000 	lui	v0,0x0=0A=
    2c84:	8c420000 	lw	v0,0(v0)=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
	__asm__("multu\t%2,%3"=0A=
    2c88:	00c20019 	multu	a2,v0=0A=
    2c8c:	00003010 	mfhi	a2=0A=
	...=0A=
    2c98:	14c0ffff 	bnez	a2,2c98 <e1000_set_multi+0x294>=0A=
    2c9c:	24c6ffff 	addiu	a2,a2,-1=0A=
        mdelay(5);=0A=
        if(adapter->shared.pci_cmd_word & PCI_COMMAND_INVALIDATE) {=0A=
    2ca0:	9622004a 	lhu	v0,74(s1)=0A=
    2ca4:	30420010 	andi	v0,v0,0x10=0A=
    2ca8:	10400006 	beqz	v0,2cc4 <e1000_set_multi+0x2c0>=0A=
    2cac:	02a02021 	move	a0,s5=0A=
            pci_write_config_word(pdev, PCI_COMMAND,=0A=
    2cb0:	9626004a 	lhu	a2,74(s1)=0A=
    2cb4:	3c020000 	lui	v0,0x0=0A=
    2cb8:	24420000 	addiu	v0,v0,0=0A=
    2cbc:	0040f809 	jalr	v0=0A=
    2cc0:	24050004 	li	a1,4=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    2cc4:	8e22008c 	lw	v0,140(s1)=0A=
    2cc8:	30420001 	andi	v0,v0,0x1=0A=
                                  adapter->shared.pci_cmd_word);=0A=
        }=0A=
        if(test_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    2ccc:	1040000d 	beqz	v0,2d04 <e1000_set_multi+0x300>=0A=
    2cd0:	8fbf032c 	lw	ra,812(sp)=0A=
            e1000_configure_rx(adapter);=0A=
    2cd4:	3c020000 	lui	v0,0x0=0A=
    2cd8:	244223a8 	addiu	v0,v0,9128=0A=
    2cdc:	0040f809 	jalr	v0=0A=
    2ce0:	02202021 	move	a0,s1=0A=
 * Atomically subtracts @i from @v.  Note that the guaranteed=0A=
 * useful range of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
    2ce4:	262300d8 	addiu	v1,s1,216=0A=
    2ce8:	24020001 	li	v0,1=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    2cec:	c0640000 	ll	a0,0(v1)=0A=
    2cf0:	00822023 	subu	a0,a0,v0=0A=
    2cf4:	e0640000 	sc	a0,0(v1)=0A=
    2cf8:	1080fffc 	beqz	a0,2cec <e1000_set_multi+0x2e8>=0A=
    2cfc:	00000000 	nop=0A=
            tasklet_enable(&adapter->rx_fill_tasklet);=0A=
        }=0A=
    }=0A=
=0A=
    return;=0A=
}=0A=
    2d00:	8fbf032c 	lw	ra,812(sp)=0A=
    2d04:	8fb60328 	lw	s6,808(sp)=0A=
    2d08:	8fb50324 	lw	s5,804(sp)=0A=
    2d0c:	8fb40320 	lw	s4,800(sp)=0A=
    2d10:	8fb3031c 	lw	s3,796(sp)=0A=
    2d14:	8fb20318 	lw	s2,792(sp)=0A=
    2d18:	8fb10314 	lw	s1,788(sp)=0A=
    2d1c:	8fb00310 	lw	s0,784(sp)=0A=
    2d20:	03e00008 	jr	ra=0A=
    2d24:	27bd0330 	addiu	sp,sp,816=0A=
=0A=
00002d28 <e1000_watchdog>:=0A=
    2d28:	27bdffd0 	addiu	sp,sp,-48=0A=
    2d2c:	afb50024 	sw	s5,36(sp)=0A=
    2d30:	afb40020 	sw	s4,32(sp)=0A=
    2d34:	afb3001c 	sw	s3,28(sp)=0A=
    2d38:	afbf0028 	sw	ra,40(sp)=0A=
    2d3c:	afb20018 	sw	s2,24(sp)=0A=
    2d40:	afb10014 	sw	s1,20(sp)=0A=
    2d44:	afb00010 	sw	s0,16(sp)=0A=
    2d48:	0080a821 	move	s5,a0=0A=
=0A=
#ifdef IANS=0A=
=0A=
/* flush Tx queue without link */=0A=
static void=0A=
e1000_tx_flush(struct e1000_adapter *adapter)=0A=
{=0A=
    uint32_t ctrl, txcw, icr;=0A=
=0A=
    adapter->int_mask =3D 0;=0A=
    e1000_irq_disable(adapter);=0A=
    synchronize_irq();=0A=
=0A=
    if(adapter->shared.mac_type < e1000_82543) {=0A=
        /* Transmit Unit Reset */=0A=
        E1000_WRITE_REG(&adapter->shared, TCTL, E1000_TCTL_RST);=0A=
        E1000_WRITE_REG(&adapter->shared, TCTL, 0);=0A=
        e1000_clean_tx_ring(adapter);=0A=
        e1000_configure_tx(adapter);=0A=
    } else {=0A=
        /* turn off autoneg, set link up, and invert loss of signal */=0A=
        txcw =3D E1000_READ_REG(&adapter->shared, TXCW);=0A=
        ctrl =3D E1000_READ_REG(&adapter->shared, CTRL);=0A=
        E1000_WRITE_REG(&adapter->shared, TXCW, txcw & ~E1000_TXCW_ANE);=0A=
        E1000_WRITE_REG(&adapter->shared, CTRL,=0A=
                        (ctrl | E1000_CTRL_SLU | E1000_CTRL_ILOS));=0A=
        /* delay to flush queue, then clean up */=0A=
        mdelay(20);=0A=
        e1000_clean_tx_irq(adapter);=0A=
        E1000_WRITE_REG(&adapter->shared, CTRL, ctrl);=0A=
        E1000_WRITE_REG(&adapter->shared, TXCW, txcw);=0A=
        /* clear the link status change interrupts this caused */=0A=
        icr =3D E1000_READ_REG(&adapter->shared, ICR);=0A=
    }=0A=
=0A=
    adapter->int_mask =3D IMS_ENABLE_MASK;=0A=
    e1000_irq_enable(adapter);=0A=
    return;=0A=
}=0A=
#endif=0A=
=0A=
/**=0A=
 * e1000_watchdog - Timer Call-back=0A=
 * @data: pointer to netdev cast into an unsigned long=0A=
 **/=0A=
=0A=
void=0A=
e1000_watchdog(unsigned long data)=0A=
{=0A=
    struct net_device *netdev =3D (struct net_device *) data;=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    2d4c:	8eb20064 	lw	s2,100(s5)=0A=
=0A=
#ifdef IANS=0A=
#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,4,0))=0A=
    int flags;=0A=
#endif=0A=
#endif=0A=
=0A=
    e1000_check_for_link(&adapter->shared);=0A=
    2d50:	3c020000 	lui	v0,0x0=0A=
    2d54:	24420000 	addiu	v0,v0,0=0A=
    2d58:	26540008 	addiu	s4,s2,8=0A=
    2d5c:	0040f809 	jalr	v0=0A=
    2d60:	02802021 	move	a0,s4=0A=
 * It also implies a memory barrier.=0A=
 */=0A=
extern __inline__ int=0A=
test_and_clear_bit(int nr, volatile void *addr)=0A=
{=0A=
    2d64:	2653008c 	addiu	s3,s2,140=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    2d68:	24020008 	li	v0,8=0A=
    2d6c:	c2640000 	ll	a0,0(s3)=0A=
    2d70:	00821825 	or	v1,a0,v0=0A=
    2d74:	00621826 	xor	v1,v1,v0=0A=
    2d78:	e2630000 	sc	v1,0(s3)=0A=
    2d7c:	1060fffb 	beqz	v1,2d6c <e1000_watchdog+0x44>=0A=
    2d80:	00821824 	and	v1,a0,v0=0A=
=0A=
    if (test_and_clear_bit(E1000_LINK_STATUS_CHANGED, &adapter->flags))=0A=
    2d84:	50600007 	beqzl	v1,2da4 <e1000_watchdog+0x7c>=0A=
    2d88:	8e42000c 	lw	v0,12(s2)=0A=
        e1000_phy_get_info(&adapter->shared, &adapter->phy_info);=0A=
    2d8c:	264501b8 	addiu	a1,s2,440=0A=
    2d90:	3c020000 	lui	v0,0x0=0A=
    2d94:	24420000 	addiu	v0,v0,0=0A=
    2d98:	0040f809 	jalr	v0=0A=
    2d9c:	02802021 	move	a0,s4=0A=
    2da0:	8e42000c 	lw	v0,12(s2)=0A=
    2da4:	2c420002 	sltiu	v0,v0,2=0A=
    2da8:	14400008 	bnez	v0,2dcc <e1000_watchdog+0xa4>=0A=
    2dac:	8e830000 	lw	v1,0(s4)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    2db0:	8c620008 	lw	v0,8(v1)=0A=
	return __arch__swab32(x);=0A=
    2db4:	00021602 	srl	v0,v0,0x18=0A=
=0A=
    if(E1000_READ_REG(&adapter->shared, STATUS) & E1000_STATUS_LU) {=0A=
    2db8:	30420002 	andi	v0,v0,0x2=0A=
    2dbc:	14400008 	bnez	v0,2de0 <e1000_watchdog+0xb8>=0A=
    2dc0:	8e4200b0 	lw	v0,176(s2)=0A=
    2dc4:	08000bc6 	j	2f18 <e1000_watchdog+0x1f0>=0A=
    2dc8:	00000000 	nop=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    2dcc:	8c620008 	lw	v0,8(v1)=0A=
	return __arch__swab32(x);=0A=
    2dd0:	00021602 	srl	v0,v0,0x18=0A=
    2dd4:	30420002 	andi	v0,v0,0x2=0A=
    2dd8:	1040004f 	beqz	v0,2f18 <e1000_watchdog+0x1f0>=0A=
    2ddc:	8e4200b0 	lw	v0,176(s2)=0A=
        if(adapter->link_active !=3D TRUE) {=0A=
    2de0:	24030001 	li	v1,1=0A=
    2de4:	10430058 	beq	v0,v1,2f48 <e1000_watchdog+0x220>=0A=
    2de8:	00000000 	nop=0A=
 * It also implies a memory barrier.=0A=
 */=0A=
extern __inline__ int=0A=
test_and_clear_bit(int nr, volatile void *addr)=0A=
{=0A=
    2dec:	26a5002c 	addiu	a1,s5,44=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    2df0:	c0a40000 	ll	a0,0(a1)=0A=
    2df4:	00831025 	or	v0,a0,v1=0A=
    2df8:	00431026 	xor	v0,v0,v1=0A=
    2dfc:	e0a20000 	sc	v0,0(a1)=0A=
    2e00:	1040fffb 	beqz	v0,2df0 <e1000_watchdog+0xc8>=0A=
    2e04:	00831024 	and	v0,a0,v1=0A=
}=0A=
=0A=
static inline void netif_wake_queue(struct net_device *dev)=0A=
{=0A=
	if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))=0A=
    2e08:	10400025 	beqz	v0,2ea0 <e1000_watchdog+0x178>=0A=
    2e0c:	265100b4 	addiu	s1,s2,180=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    2e10:	24020008 	li	v0,8=0A=
    2e14:	c0a40000 	ll	a0,0(a1)=0A=
    2e18:	00821825 	or	v1,a0,v0=0A=
    2e1c:	e0a30000 	sc	v1,0(a1)=0A=
    2e20:	1060fffc 	beqz	v1,2e14 <e1000_watchdog+0xec>=0A=
    2e24:	00821824 	and	v1,a0,v0=0A=
#define HAVE_NETIF_QUEUE=0A=
=0A=
static inline void __netif_schedule(struct net_device *dev)=0A=
{=0A=
	if (!test_and_set_bit(__LINK_STATE_SCHED, &dev->state)) {=0A=
    2e28:	1460001d 	bnez	v1,2ea0 <e1000_watchdog+0x178>=0A=
    2e2c:	265100b4 	addiu	s1,s2,180=0A=
		unsigned long flags;=0A=
		int cpu =3D smp_processor_id();=0A=
=0A=
		local_irq_save(flags);=0A=
    2e30:	40106000 	mfc0	s0,$12=0A=
    2e34:	00000000 	nop=0A=
    2e38:	36010001 	ori	at,s0,0x1=0A=
    2e3c:	38210001 	xori	at,at,0x1=0A=
    2e40:	40816000 	mtc0	at,$12=0A=
    2e44:	00000040 	sll	zero,zero,0x1=0A=
    2e48:	00000040 	sll	zero,zero,0x1=0A=
    2e4c:	00000040 	sll	zero,zero,0x1=0A=
		dev->next_sched =3D softnet_data[cpu].output_queue;=0A=
    2e50:	3c030000 	lui	v1,0x0=0A=
    2e54:	8c63001c 	lw	v1,28(v1)=0A=
		softnet_data[cpu].output_queue =3D dev;=0A=
		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);=0A=
    2e58:	00002021 	move	a0,zero=0A=
    2e5c:	aea30038 	sw	v1,56(s5)=0A=
    2e60:	3c020000 	lui	v0,0x0=0A=
    2e64:	24420000 	addiu	v0,v0,0=0A=
    2e68:	3c010000 	lui	at,0x0=0A=
    2e6c:	ac35001c 	sw	s5,28(at)=0A=
    2e70:	0040f809 	jalr	v0=0A=
    2e74:	24050001 	li	a1,1=0A=
		local_irq_restore(flags);=0A=
    2e78:	40016000 	mfc0	at,$12=0A=
    2e7c:	32100001 	andi	s0,s0,0x1=0A=
    2e80:	34210001 	ori	at,at,0x1=0A=
    2e84:	38210001 	xori	at,at,0x1=0A=
    2e88:	02018025 	or	s0,s0,at=0A=
    2e8c:	40906000 	mtc0	s0,$12=0A=
	...=0A=
=0A=
#ifdef IANS=0A=
            if((adapter->iANSdata->iANS_status =3D=3D =
IANS_COMMUNICATION_UP) &&=0A=
               (adapter->iANSdata->reporting_mode =3D=3D =
IANS_STATUS_REPORTING_ON))=0A=
                if(ans_notify)=0A=
                    ans_notify(netdev, IANS_IND_XMIT_QUEUE_READY);=0A=
#endif=0A=
            netif_wake_queue(netdev);=0A=
=0A=
            e1000_get_speed_and_duplex(&adapter->shared, =
&adapter->link_speed,=0A=
    2e9c:	265100b4 	addiu	s1,s2,180=0A=
    2ea0:	265000b6 	addiu	s0,s2,182=0A=
    2ea4:	02003021 	move	a2,s0=0A=
    2ea8:	3c020000 	lui	v0,0x0=0A=
    2eac:	24420000 	addiu	v0,v0,0=0A=
    2eb0:	02802021 	move	a0,s4=0A=
    2eb4:	0040f809 	jalr	v0=0A=
    2eb8:	02202821 	move	a1,s1=0A=
                                       &adapter->link_duplex);=0A=
            printk(KERN_ERR "e1000: %s NIC Link is Up %d Mbps %s\n",=0A=
    2ebc:	96030000 	lhu	v1,0(s0)=0A=
    2ec0:	24020002 	li	v0,2=0A=
    2ec4:	3c070000 	lui	a3,0x0=0A=
    2ec8:	24e70d28 	addiu	a3,a3,3368=0A=
    2ecc:	10620003 	beq	v1,v0,2edc <e1000_watchdog+0x1b4>=0A=
    2ed0:	96260000 	lhu	a2,0(s1)=0A=
    2ed4:	3c070000 	lui	a3,0x0=0A=
    2ed8:	24e70d34 	addiu	a3,a3,3380=0A=
    2edc:	3c040000 	lui	a0,0x0=0A=
    2ee0:	24840d00 	addiu	a0,a0,3328=0A=
    2ee4:	3c020000 	lui	v0,0x0=0A=
    2ee8:	24420000 	addiu	v0,v0,0=0A=
    2eec:	0040f809 	jalr	v0=0A=
    2ef0:	02a02821 	move	a1,s5=0A=
                   netdev->name, adapter->link_speed,=0A=
                   adapter->link_duplex =3D=3D=0A=
                   FULL_DUPLEX ? "Full Duplex" : "Half Duplex");=0A=
=0A=
            adapter->link_active =3D TRUE;=0A=
    2ef4:	24030001 	li	v1,1=0A=
    2ef8:	ae4300b0 	sw	v1,176(s2)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    2efc:	c2620000 	ll	v0,0(s3)=0A=
    2f00:	34420008 	ori	v0,v0,0x8=0A=
    2f04:	e2620000 	sc	v0,0(s3)=0A=
    2f08:	1040fffc 	beqz	v0,2efc <e1000_watchdog+0x1d4>=0A=
    2f0c:	00000000 	nop=0A=
            set_bit(E1000_LINK_STATUS_CHANGED, &adapter->flags);=0A=
        }=0A=
    } else {=0A=
    2f10:	08000bd2 	j	2f48 <e1000_watchdog+0x220>=0A=
    2f14:	00000000 	nop=0A=
        if(adapter->link_active !=3D FALSE) {=0A=
    2f18:	1040000b 	beqz	v0,2f48 <e1000_watchdog+0x220>=0A=
    2f1c:	00000000 	nop=0A=
            adapter->link_speed =3D 0;=0A=
            adapter->link_duplex =3D 0;=0A=
            printk(KERN_ERR "e1000: %s NIC Link is Down\n", =
netdev->name);=0A=
    2f20:	3c040000 	lui	a0,0x0=0A=
    2f24:	24840d40 	addiu	a0,a0,3392=0A=
    2f28:	a64000b4 	sh	zero,180(s2)=0A=
    2f2c:	a64000b6 	sh	zero,182(s2)=0A=
    2f30:	3c020000 	lui	v0,0x0=0A=
    2f34:	24420000 	addiu	v0,v0,0=0A=
    2f38:	0040f809 	jalr	v0=0A=
    2f3c:	02a02821 	move	a1,s5=0A=
            adapter->link_active =3D FALSE;=0A=
    2f40:	ae4000b0 	sw	zero,176(s2)=0A=
            atomic_set(&adapter->tx_timeout, 0);=0A=
    2f44:	ae40010c 	sw	zero,268(s2)=0A=
        }=0A=
    }=0A=
=0A=
    e1000_update_stats(adapter);=0A=
    2f48:	3c030000 	lui	v1,0x0=0A=
    2f4c:	24634044 	addiu	v1,v1,16452=0A=
    2f50:	0060f809 	jalr	v1=0A=
    2f54:	02402021 	move	a0,s2=0A=
=0A=
    if(atomic_read(&adapter->tx_timeout) > 1)=0A=
    2f58:	8e42010c 	lw	v0,268(s2)=0A=
    2f5c:	28420002 	slti	v0,v0,2=0A=
    2f60:	54400009 	bnezl	v0,2f88 <e1000_watchdog+0x260>=0A=
    2f64:	8e4300b0 	lw	v1,176(s2)=0A=
 * Atomically subtracts @i from @v.  Note that the guaranteed=0A=
 * useful range of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
    2f68:	24020001 	li	v0,1=0A=
    2f6c:	2643010c 	addiu	v1,s2,268=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    2f70:	c0640000 	ll	a0,0(v1)=0A=
    2f74:	00822023 	subu	a0,a0,v0=0A=
    2f78:	e0640000 	sc	a0,0(v1)=0A=
    2f7c:	1080fffc 	beqz	a0,2f70 <e1000_watchdog+0x248>=0A=
    2f80:	00000000 	nop=0A=
        atomic_dec(&adapter->tx_timeout);=0A=
=0A=
    if((adapter->link_active =3D=3D TRUE) && =0A=
    2f84:	8e4300b0 	lw	v1,176(s2)=0A=
    2f88:	24020001 	li	v0,1=0A=
    2f8c:	54620021 	bnel	v1,v0,3014 <e1000_watchdog+0x2ec>=0A=
    2f90:	8e620000 	lw	v0,0(s3)=0A=
    2f94:	8e42010c 	lw	v0,268(s2)=0A=
    2f98:	5443001e 	bnel	v0,v1,3014 <e1000_watchdog+0x2ec>=0A=
    2f9c:	8e620000 	lw	v0,0(s3)=0A=
       (atomic_read(&adapter->tx_timeout) =3D=3D 1)) {=0A=
=0A=
        if(E1000_READ_REG(&adapter->shared, STATUS) & =
E1000_STATUS_TXOFF) {=0A=
    2fa0:	8e42000c 	lw	v0,12(s2)=0A=
    2fa4:	2c420002 	sltiu	v0,v0,2=0A=
    2fa8:	14400008 	bnez	v0,2fcc <e1000_watchdog+0x2a4>=0A=
    2fac:	8e430008 	lw	v1,8(s2)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    2fb0:	8c620008 	lw	v0,8(v1)=0A=
	return __arch__swab32(x);=0A=
    2fb4:	00021602 	srl	v0,v0,0x18=0A=
    2fb8:	30420010 	andi	v0,v0,0x10=0A=
    2fbc:	14400008 	bnez	v0,2fe0 <e1000_watchdog+0x2b8>=0A=
    2fc0:	24020003 	li	v0,3=0A=
    2fc4:	08000bfb 	j	2fec <e1000_watchdog+0x2c4>=0A=
    2fc8:	00000000 	nop=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    2fcc:	8c620008 	lw	v0,8(v1)=0A=
	return __arch__swab32(x);=0A=
    2fd0:	00021602 	srl	v0,v0,0x18=0A=
    2fd4:	30420010 	andi	v0,v0,0x10=0A=
    2fd8:	10400004 	beqz	v0,2fec <e1000_watchdog+0x2c4>=0A=
    2fdc:	24020003 	li	v0,3=0A=
            atomic_set(&adapter->tx_timeout, 3);=0A=
    2fe0:	ae42010c 	sw	v0,268(s2)=0A=
        } else {=0A=
    2fe4:	08000c05 	j	3014 <e1000_watchdog+0x2ec>=0A=
    2fe8:	8e620000 	lw	v0,0(s3)=0A=
=0A=
            e1000_hibernate_adapter(netdev);=0A=
    2fec:	3c020000 	lui	v0,0x0=0A=
    2ff0:	24420000 	addiu	v0,v0,0=0A=
    2ff4:	0040f809 	jalr	v0=0A=
    2ff8:	02a02021 	move	a0,s5=0A=
=0A=
#ifdef IANS=0A=
        if((adapter->iANSdata->iANS_status =3D=3D IANS_COMMUNICATION_UP) =
&&=0A=
           (adapter->iANSdata->reporting_mode =3D=3D =
IANS_STATUS_REPORTING_ON)) {=0A=
                adapter->link_active =3D FALSE;=0A=
                bd_ans_os_Watchdog(netdev, adapter);=0A=
                adapter->link_active =3D TRUE;=0A=
            }=0A=
#endif=0A=
            atomic_set(&adapter->tx_timeout, 0);=0A=
    2ffc:	ae40010c 	sw	zero,268(s2)=0A=
            e1000_wakeup_adapter(netdev);=0A=
    3000:	3c020000 	lui	v0,0x0=0A=
    3004:	24420000 	addiu	v0,v0,0=0A=
    3008:	0040f809 	jalr	v0=0A=
    300c:	02a02021 	move	a0,s5=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    3010:	8e620000 	lw	v0,0(s3)=0A=
    3014:	00021042 	srl	v0,v0,0x1=0A=
    3018:	30420001 	andi	v0,v0,0x1=0A=
        }=0A=
    }=0A=
#ifdef IANS=0A=
    if(adapter->iANSdata->iANS_status =3D=3D IANS_COMMUNICATION_UP) {=0A=
=0A=
        if(adapter->iANSdata->reporting_mode =3D=3D =
IANS_STATUS_REPORTING_ON)=0A=
            bd_ans_os_Watchdog(netdev, adapter);=0A=
=0A=
        if(adapter->link_active =3D=3D FALSE) {=0A=
            /* don't sit on SKBs while link is down */=0A=
=0A=
            if(atomic_read(&adapter->tx_ring.unused) < =
adapter->tx_ring.count) {=0A=
=0A=
#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,4,0))=0A=
                spin_lock_irqsave(&netdev->xmit_lock, flags);=0A=
                e1000_tx_flush(adapter);=0A=
                spin_unlock_irqrestore(&netdev->xmit_lock, flags);=0A=
#else=0A=
                e1000_tx_flush(adapter);=0A=
#endif=0A=
            }=0A=
#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,4,0))=0A=
            spin_lock_irqsave(&netdev->queue_lock, flags);=0A=
            qdisc_reset(netdev->qdisc);=0A=
            spin_unlock_irqrestore(&netdev->queue_lock, flags);=0A=
#else=0A=
            qdisc_reset(netdev->qdisc);=0A=
#endif=0A=
        }=0A=
    }=0A=
#endif=0A=
=0A=
    if(test_bit(E1000_RX_REFILL, &adapter->flags)) {=0A=
    301c:	1040000d 	beqz	v0,3054 <e1000_watchdog+0x32c>=0A=
    3020:	24020001 	li	v0,1=0A=
=0A=
extern void FASTCALL(__tasklet_schedule(struct tasklet_struct *t));=0A=
=0A=
static inline void tasklet_schedule(struct tasklet_struct *t)=0A=
{=0A=
    3024:	264500d0 	addiu	a1,s2,208=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3028:	c24400d4 	ll	a0,212(s2)=0A=
    302c:	00821825 	or	v1,a0,v0=0A=
    3030:	e24300d4 	sc	v1,212(s2)=0A=
    3034:	1060fffc 	beqz	v1,3028 <e1000_watchdog+0x300>=0A=
    3038:	00821824 	and	v1,a0,v0=0A=
extern void FASTCALL(__tasklet_schedule(struct tasklet_struct *t));=0A=
=0A=
static inline void tasklet_schedule(struct tasklet_struct *t)=0A=
{=0A=
	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))=0A=
    303c:	14600005 	bnez	v1,3054 <e1000_watchdog+0x32c>=0A=
    3040:	00000000 	nop=0A=
		__tasklet_schedule(t);=0A=
    3044:	3c020000 	lui	v0,0x0=0A=
    3048:	24420000 	addiu	v0,v0,0=0A=
    304c:	0040f809 	jalr	v0=0A=
    3050:	00a02021 	move	a0,a1=0A=
        tasklet_schedule(&adapter->rx_fill_tasklet);=0A=
    }=0A=
=0A=
    /* Reset the timer */=0A=
    mod_timer(&adapter->timer_id, jiffies + 2 * HZ);=0A=
    3054:	3c050000 	lui	a1,0x0=0A=
    3058:	8ca50000 	lw	a1,0(a1)=0A=
    305c:	26440094 	addiu	a0,s2,148=0A=
    3060:	3c020000 	lui	v0,0x0=0A=
    3064:	24420000 	addiu	v0,v0,0=0A=
    3068:	0040f809 	jalr	v0=0A=
    306c:	24a500c8 	addiu	a1,a1,200=0A=
=0A=
    return;=0A=
}=0A=
    3070:	8fbf0028 	lw	ra,40(sp)=0A=
    3074:	8fb50024 	lw	s5,36(sp)=0A=
    3078:	8fb40020 	lw	s4,32(sp)=0A=
    307c:	8fb3001c 	lw	s3,28(sp)=0A=
    3080:	8fb20018 	lw	s2,24(sp)=0A=
    3084:	8fb10014 	lw	s1,20(sp)=0A=
    3088:	8fb00010 	lw	s0,16(sp)=0A=
    308c:	03e00008 	jr	ra=0A=
    3090:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
00003094 <e1000_xmit_frame>:=0A=
    3094:	27bdff80 	addiu	sp,sp,-128=0A=
    3098:	afbf007c 	sw	ra,124(sp)=0A=
    309c:	afbe0078 	sw	s8,120(sp)=0A=
    30a0:	afb70074 	sw	s7,116(sp)=0A=
    30a4:	afb60070 	sw	s6,112(sp)=0A=
    30a8:	afb5006c 	sw	s5,108(sp)=0A=
    30ac:	afb40068 	sw	s4,104(sp)=0A=
    30b0:	afb30064 	sw	s3,100(sp)=0A=
    30b4:	afb20060 	sw	s2,96(sp)=0A=
    30b8:	afb1005c 	sw	s1,92(sp)=0A=
    30bc:	afb00058 	sw	s0,88(sp)=0A=
    30c0:	afa50084 	sw	a1,132(sp)=0A=
=0A=
/**=0A=
 * e1000_tx_checksum_setup=0A=
 * @adapter:=0A=
 * @skb:=0A=
 * @txd_upper:=0A=
 * @txd_lower:=0A=
 **/=0A=
=0A=
static inline void=0A=
e1000_tx_checksum_setup(struct e1000_adapter *adapter,=0A=
                        struct sk_buff *skb,=0A=
                        uint32_t *txd_upper,=0A=
                        uint32_t *txd_lower)=0A=
{=0A=
=0A=
    struct e1000_context_desc *desc;=0A=
    int i;=0A=
=0A=
    if(skb->protocol !=3D __constant_htons(ETH_P_IP)) {=0A=
        *txd_upper =3D 0;=0A=
        *txd_lower =3D adapter->TxdCmd;=0A=
        return;=0A=
    }=0A=
=0A=
    switch (skb->nh.iph->protocol) {=0A=
    case IPPROTO_TCP:=0A=
        /* Offload TCP checksum */=0A=
        *txd_upper =3D E1000_TXD_POPTS_TXSM << 8;=0A=
        *txd_lower =3D adapter->TxdCmd | E1000_TXD_CMD_DEXT | =
E1000_TXD_DTYP_D;=0A=
        if(adapter->ActiveChecksumContext =3D=3D OFFLOAD_TCP_IP)=0A=
            return;=0A=
        else=0A=
            adapter->ActiveChecksumContext =3D OFFLOAD_TCP_IP;=0A=
        break;=0A=
    case IPPROTO_UDP:=0A=
        /* Offload UDP checksum */=0A=
        *txd_upper =3D E1000_TXD_POPTS_TXSM << 8;=0A=
        *txd_lower =3D adapter->TxdCmd | E1000_TXD_CMD_DEXT | =
E1000_TXD_DTYP_D;=0A=
        if(adapter->ActiveChecksumContext =3D=3D OFFLOAD_UDP_IP)=0A=
            return;=0A=
        else=0A=
            adapter->ActiveChecksumContext =3D OFFLOAD_UDP_IP;=0A=
        break;=0A=
    default:=0A=
        /* no checksum to offload */=0A=
        *txd_upper =3D 0;=0A=
        *txd_lower =3D adapter->TxdCmd;=0A=
        return;=0A=
    }=0A=
=0A=
    /* If we reach this point, the checksum offload context=0A=
     * needs to be reset=0A=
     */=0A=
=0A=
    i =3D adapter->tx_ring.next_to_use;=0A=
    desc =3D E1000_CONTEXT_DESC(adapter->tx_ring, i);=0A=
=0A=
    desc->lower_setup.ip_fields.ipcss =3D skb->nh.raw - skb->data;=0A=
    desc->lower_setup.ip_fields.ipcso =3D=0A=
        ((skb->nh.raw + offsetof(struct iphdr, check)) - skb->data);=0A=
    desc->lower_setup.ip_fields.ipcse =3D cpu_to_le16(skb->h.raw - =
skb->data - 1);=0A=
=0A=
    desc->upper_setup.tcp_fields.tucss =3D (skb->h.raw - skb->data);=0A=
    desc->upper_setup.tcp_fields.tucso =3D ((skb->h.raw + skb->csum) - =
skb->data);=0A=
    desc->upper_setup.tcp_fields.tucse =3D 0;=0A=
=0A=
    desc->tcp_seg_setup.data =3D 0;=0A=
    desc->cmd_and_length =3D cpu_to_le32(E1000_TXD_CMD_DEXT) | =
adapter->TxdCmd;=0A=
=0A=
    i =3D (i + 1) % adapter->tx_ring.count;=0A=
    atomic_dec(&adapter->tx_ring.unused);=0A=
    adapter->tx_ring.next_to_use =3D i;=0A=
    E1000_WRITE_REG(&adapter->shared, TDT, adapter->tx_ring.next_to_use);=0A=
    return;=0A=
}=0A=
=0A=
/**=0A=
 * e1000_xmit_frame - Transmit entry point=0A=
 * @skb: buffer with frame data to transmit=0A=
 * @netdev: network interface device structure=0A=
 *=0A=
 * Returns 0 on success, negative on error=0A=
 *=0A=
 * e1000_xmit_frame is called by the stack to initiate a transmit.=0A=
 * The out of resource condition is checked after each successful Tx=0A=
 * so that the stack can be notified, preventing the driver from=0A=
 * ever needing to drop a frame.  The atomic operations on=0A=
 * tx_ring.unused are used to syncronize with the transmit=0A=
 * interrupt processing code without the need for a spinlock.=0A=
 **/=0A=
=0A=
int=0A=
e1000_xmit_frame(struct sk_buff *skb,=0A=
                 struct net_device *netdev)=0A=
{=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    30c4:	8cb30064 	lw	s3,100(a1)=0A=
    30c8:	afa40080 	sw	a0,128(sp)=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    struct e1000_tx_desc *tx_desc;=0A=
    int i, len, offset, txd_needed;=0A=
    uint32_t txd_upper, txd_lower;=0A=
=0A=
#define TXD_USE_COUNT(x) (((x) >> 12) + ((x) & 0x0fff ? 1 : 0))=0A=
=0A=
#ifdef MAX_SKB_FRAGS=0A=
    int f;=0A=
    skb_frag_t *frag;=0A=
#endif=0A=
=0A=
    E1000_DBG("e1000_xmit_frame\n");=0A=
=0A=
    if(adapter->link_active =3D=3D FALSE) {=0A=
    30cc:	8e6200b0 	lw	v0,176(s3)=0A=
    30d0:	54400008 	bnezl	v0,30f4 <e1000_xmit_frame+0x60>=0A=
    30d4:	8fa20080 	lw	v0,128(sp)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    30d8:	c0a2002c 	ll	v0,44(a1)=0A=
    30dc:	34420001 	ori	v0,v0,0x1=0A=
    30e0:	e0a2002c 	sc	v0,44(a1)=0A=
    30e4:	1040fffc 	beqz	v0,30d8 <e1000_xmit_frame+0x44>=0A=
    30e8:	00000000 	nop=0A=
#ifdef IANS=0A=
        if((adapter->iANSdata->iANS_status =3D=3D IANS_COMMUNICATION_UP) =
&&=0A=
           (adapter->iANSdata->reporting_mode =3D=3D =
IANS_STATUS_REPORTING_ON))=0A=
            if(ans_notify)=0A=
                ans_notify(netdev, IANS_IND_XMIT_QUEUE_FULL);=0A=
#endif=0A=
        netif_stop_queue(netdev);=0A=
        return 1;=0A=
    30ec:	08000ee6 	j	3b98 <e1000_xmit_frame+0xb04>=0A=
    30f0:	24020001 	li	v0,1=0A=
    }=0A=
=0A=
#ifdef MAX_SKB_FRAGS=0A=
    txd_needed =3D TXD_USE_COUNT(skb->len - skb->data_len);=0A=
    for(f =3D 0; f < skb_shinfo(skb)->nr_frags; f++) {=0A=
    30f4:	00006821 	move	t5,zero=0A=
    30f8:	8c470088 	lw	a3,136(v0)=0A=
    30fc:	8c48005c 	lw	t0,92(v0)=0A=
    3100:	8c450060 	lw	a1,96(v0)=0A=
    3104:	8ce40004 	lw	a0,4(a3)=0A=
    3108:	01051023 	subu	v0,t0,a1=0A=
    310c:	30430fff 	andi	v1,v0,0xfff=0A=
    3110:	0003182b 	sltu	v1,zero,v1=0A=
    3114:	00021302 	srl	v0,v0,0xc=0A=
    3118:	1080000d 	beqz	a0,3150 <e1000_xmit_frame+0xbc>=0A=
    311c:	00433021 	addu	a2,v0,v1=0A=
        frag =3D &skb_shinfo(skb)->frags[f];=0A=
    3120:	000d10c0 	sll	v0,t5,0x3=0A=
    3124:	00e21021 	addu	v0,a3,v0=0A=
        txd_needed +=3D TXD_USE_COUNT(frag->size);=0A=
    3128:	94430012 	lhu	v1,18(v0)=0A=
    312c:	8ce40004 	lw	a0,4(a3)=0A=
    3130:	25ad0001 	addiu	t5,t5,1=0A=
    3134:	30620fff 	andi	v0,v1,0xfff=0A=
    3138:	00031b02 	srl	v1,v1,0xc=0A=
    313c:	00c31821 	addu	v1,a2,v1=0A=
    3140:	0002102b 	sltu	v0,zero,v0=0A=
    3144:	01a4202b 	sltu	a0,t5,a0=0A=
    3148:	1480fff5 	bnez	a0,3120 <e1000_xmit_frame+0x8c>=0A=
    314c:	00623021 	addu	a2,v1,v0=0A=
    }=0A=
#else=0A=
    txd_needed =3D TXD_USE_COUNT(skb->len);=0A=
#endif=0A=
=0A=
    /* make sure there are enough Tx descriptors available in the ring */=0A=
    if(atomic_read(&adapter->tx_ring.unused) <=3D (txd_needed + 1)) {=0A=
    3150:	8e6300f4 	lw	v1,244(s3)=0A=
    3154:	24c20001 	addiu	v0,a2,1=0A=
    3158:	0043102a 	slt	v0,v0,v1=0A=
    315c:	5440000c 	bnezl	v0,3190 <e1000_xmit_frame+0xfc>=0A=
    3160:	8fa70080 	lw	a3,128(sp)=0A=
        adapter->net_stats.tx_dropped++;=0A=
    3164:	8e62016c 	lw	v0,364(s3)=0A=
    3168:	24420001 	addiu	v0,v0,1=0A=
    316c:	ae62016c 	sw	v0,364(s3)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3170:	8fa40084 	lw	a0,132(sp)=0A=
    3174:	c083002c 	ll	v1,44(a0)=0A=
    3178:	34630001 	ori	v1,v1,0x1=0A=
    317c:	e083002c 	sc	v1,44(a0)=0A=
    3180:	1060fffc 	beqz	v1,3174 <e1000_xmit_frame+0xe0>=0A=
    3184:	00000000 	nop=0A=
#ifdef IANS=0A=
        if((adapter->iANSdata->iANS_status =3D=3D IANS_COMMUNICATION_UP) =
&&=0A=
           (adapter->iANSdata->reporting_mode =3D=3D =
IANS_STATUS_REPORTING_ON))=0A=
            if(ans_notify)=0A=
                ans_notify(netdev, IANS_IND_XMIT_QUEUE_FULL);=0A=
#endif=0A=
        netif_stop_queue(netdev);=0A=
=0A=
        return 1;=0A=
    3188:	08000ee6 	j	3b98 <e1000_xmit_frame+0xb04>=0A=
    318c:	24020001 	li	v0,1=0A=
    }=0A=
=0A=
    if(skb->ip_summed =3D=3D CHECKSUM_HW) {=0A=
    3190:	24020001 	li	v0,1=0A=
    3194:	90e6006b 	lbu	a2,107(a3)=0A=
    3198:	54c20084 	bnel	a2,v0,33ac <e1000_xmit_frame+0x318>=0A=
    319c:	afa00010 	sw	zero,16(sp)=0A=
    31a0:	94e30074 	lhu	v1,116(a3)=0A=
    31a4:	24020800 	li	v0,2048=0A=
    31a8:	10620006 	beq	v1,v0,31c4 <e1000_xmit_frame+0x130>=0A=
    31ac:	266300f4 	addiu	v1,s3,244=0A=
    31b0:	afa00010 	sw	zero,16(sp)=0A=
    31b4:	8e620108 	lw	v0,264(s3)=0A=
    31b8:	afa30040 	sw	v1,64(sp)=0A=
    31bc:	08000cef 	j	33bc <e1000_xmit_frame+0x328>=0A=
    31c0:	afa20014 	sw	v0,20(sp)=0A=
    31c4:	8fa40080 	lw	a0,128(sp)=0A=
    31c8:	24030006 	li	v1,6=0A=
    31cc:	8c820020 	lw	v0,32(a0)=0A=
    31d0:	90440009 	lbu	a0,9(v0)=0A=
    31d4:	10830005 	beq	a0,v1,31ec <e1000_xmit_frame+0x158>=0A=
    31d8:	24020011 	li	v0,17=0A=
    31dc:	5082000d 	beql	a0,v0,3214 <e1000_xmit_frame+0x180>=0A=
    31e0:	8e620108 	lw	v0,264(s3)=0A=
    31e4:	08000ceb 	j	33ac <e1000_xmit_frame+0x318>=0A=
    31e8:	afa00010 	sw	zero,16(sp)=0A=
    31ec:	8e620108 	lw	v0,264(s3)=0A=
    31f0:	8e6401b4 	lw	a0,436(s3)=0A=
    31f4:	3c032010 	lui	v1,0x2010=0A=
    31f8:	00431025 	or	v0,v0,v1=0A=
    31fc:	266700f4 	addiu	a3,s3,244=0A=
    3200:	24030200 	li	v1,512=0A=
    3204:	afa20014 	sw	v0,20(sp)=0A=
    3208:	afa30010 	sw	v1,16(sp)=0A=
    320c:	08000c8e 	j	3238 <e1000_xmit_frame+0x1a4>=0A=
    3210:	afa70040 	sw	a3,64(sp)=0A=
    3214:	8e6401b4 	lw	a0,436(s3)=0A=
    3218:	3c032010 	lui	v1,0x2010=0A=
    321c:	00431025 	or	v0,v0,v1=0A=
    3220:	afa20014 	sw	v0,20(sp)=0A=
    3224:	266300f4 	addiu	v1,s3,244=0A=
    3228:	24020200 	li	v0,512=0A=
    322c:	24060002 	li	a2,2=0A=
    3230:	afa20010 	sw	v0,16(sp)=0A=
    3234:	afa30040 	sw	v1,64(sp)=0A=
    3238:	50860061 	beql	a0,a2,33c0 <e1000_xmit_frame+0x32c>=0A=
    323c:	8e7500f8 	lw	s5,248(s3)=0A=
    3240:	ae6601b4 	sw	a2,436(s3)=0A=
    3244:	8fa80080 	lw	t0,128(sp)=0A=
    3248:	8e6700f8 	lw	a3,248(s3)=0A=
    324c:	8e6500e4 	lw	a1,228(s3)=0A=
    3250:	91030083 	lbu	v1,131(t0)=0A=
    3254:	91040023 	lbu	a0,35(t0)=0A=
    3258:	00071100 	sll	v0,a3,0x4=0A=
    325c:	00a22821 	addu	a1,a1,v0=0A=
    3260:	00832023 	subu	a0,a0,v1=0A=
    3264:	a0a40000 	sb	a0,0(a1)=0A=
    3268:	91020083 	lbu	v0,131(t0)=0A=
    326c:	91030023 	lbu	v1,35(t0)=0A=
 * Atomically subtracts @i from @v.  Note that the guaranteed=0A=
 * useful range of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
    3270:	266400f4 	addiu	a0,s3,244=0A=
    3274:	24e70001 	addiu	a3,a3,1=0A=
    3278:	00621823 	subu	v1,v1,v0=0A=
    327c:	2463000a 	addiu	v1,v1,10=0A=
    3280:	a0a30001 	sb	v1,1(a1)=0A=
    3284:	95030082 	lhu	v1,130(t0)=0A=
    3288:	9502001e 	lhu	v0,30(t0)=0A=
 * Atomically subtracts @i from @v.  Note that the guaranteed=0A=
 * useful range of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
    328c:	afa40040 	sw	a0,64(sp)=0A=
    3290:	24060001 	li	a2,1=0A=
    3294:	00431023 	subu	v0,v0,v1=0A=
    3298:	2442ffff 	addiu	v0,v0,-1=0A=
    329c:	3042ffff 	andi	v0,v0,0xffff=0A=
=0A=
=0A=
static __inline__ __const__ __u16 __fswab16(__u16 x)=0A=
{=0A=
	return __arch__swab16(x);=0A=
    32a0:	304300ff 	andi	v1,v0,0xff=0A=
    32a4:	00031a00 	sll	v1,v1,0x8=0A=
    32a8:	00021202 	srl	v0,v0,0x8=0A=
    32ac:	00621825 	or	v1,v1,v0=0A=
    32b0:	a4a30002 	sh	v1,2(a1)=0A=
    32b4:	91030083 	lbu	v1,131(t0)=0A=
    32b8:	9102001f 	lbu	v0,31(t0)=0A=
    32bc:	00431023 	subu	v0,v0,v1=0A=
    32c0:	a0a20004 	sb	v0,4(a1)=0A=
    32c4:	8d020064 	lw	v0,100(t0)=0A=
    32c8:	8d03001c 	lw	v1,28(t0)=0A=
    32cc:	91040083 	lbu	a0,131(t0)=0A=
    32d0:	a4a00006 	sh	zero,6(a1)=0A=
    32d4:	00621821 	addu	v1,v1,v0=0A=
    32d8:	00641823 	subu	v1,v1,a0=0A=
    32dc:	a0a30005 	sb	v1,5(a1)=0A=
    32e0:	aca0000c 	sw	zero,12(a1)=0A=
    32e4:	8e620108 	lw	v0,264(s3)=0A=
    32e8:	34420020 	ori	v0,v0,0x20=0A=
    32ec:	aca20008 	sw	v0,8(a1)=0A=
    32f0:	8e6300f0 	lw	v1,240(s3)=0A=
    32f4:	00e3001b 	divu	zero,a3,v1=0A=
    32f8:	50600001 	beqzl	v1,3300 <e1000_xmit_frame+0x26c>=0A=
    32fc:	0007000d 	break	0x7=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3300:	8fa20040 	lw	v0,64(sp)=0A=
    3304:	00003810 	mfhi	a3=0A=
	...=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3310:	c0440000 	ll	a0,0(v0)=0A=
    3314:	00862023 	subu	a0,a0,a2=0A=
    3318:	e0440000 	sc	a0,0(v0)=0A=
    331c:	1080fffc 	beqz	a0,3310 <e1000_xmit_frame+0x27c>=0A=
    3320:	00000000 	nop=0A=
    3324:	8e62000c 	lw	v0,12(s3)=0A=
    3328:	2c420002 	sltiu	v0,v0,2=0A=
    332c:	14400010 	bnez	v0,3370 <e1000_xmit_frame+0x2dc>=0A=
    3330:	ae6700f8 	sw	a3,248(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3334:	30e3ff00 	andi	v1,a3,0xff00=0A=
    3338:	00031a00 	sll	v1,v1,0x8=0A=
    333c:	00071600 	sll	v0,a3,0x18=0A=
    3340:	00072202 	srl	a0,a3,0x8=0A=
    3344:	00431025 	or	v0,v0,v1=0A=
    3348:	8e650008 	lw	a1,8(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    334c:	3084ff00 	andi	a0,a0,0xff00=0A=
    3350:	00071e02 	srl	v1,a3,0x18=0A=
    3354:	00441025 	or	v0,v0,a0=0A=
    3358:	00431025 	or	v0,v0,v1=0A=
    335c:	aca23818 	sw	v0,14360(a1)=0A=
    3360:	8fa30080 	lw	v1,128(sp)=0A=
    3364:	8c68005c 	lw	t0,92(v1)=0A=
    3368:	08000cef 	j	33bc <e1000_xmit_frame+0x328>=0A=
    336c:	8c650060 	lw	a1,96(v1)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3370:	30e3ff00 	andi	v1,a3,0xff00=0A=
    3374:	00031a00 	sll	v1,v1,0x8=0A=
    3378:	00071600 	sll	v0,a3,0x18=0A=
    337c:	00072202 	srl	a0,a3,0x8=0A=
    3380:	00431025 	or	v0,v0,v1=0A=
    3384:	3084ff00 	andi	a0,a0,0xff00=0A=
    3388:	8e650008 	lw	a1,8(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    338c:	00441025 	or	v0,v0,a0=0A=
    3390:	00071e02 	srl	v1,a3,0x18=0A=
    3394:	00431025 	or	v0,v0,v1=0A=
    3398:	aca20438 	sw	v0,1080(a1)=0A=
    339c:	8fa40080 	lw	a0,128(sp)=0A=
    33a0:	8c88005c 	lw	t0,92(a0)=0A=
    33a4:	08000cef 	j	33bc <e1000_xmit_frame+0x328>=0A=
    33a8:	8c850060 	lw	a1,96(a0)=0A=
        e1000_tx_checksum_setup(adapter, skb, &txd_upper, &txd_lower);=0A=
    } else {=0A=
        txd_upper =3D 0;=0A=
        txd_lower =3D adapter->TxdCmd;=0A=
    33ac:	8e670108 	lw	a3,264(s3)=0A=
    33b0:	266200f4 	addiu	v0,s3,244=0A=
    33b4:	afa20040 	sw	v0,64(sp)=0A=
    33b8:	afa70014 	sw	a3,20(sp)=0A=
    }=0A=
=0A=
    i =3D adapter->tx_ring.next_to_use;=0A=
    33bc:	8e7500f8 	lw	s5,248(s3)=0A=
    tx_desc =3D E1000_TX_DESC(adapter->tx_ring, i);=0A=
    33c0:	8e6200e4 	lw	v0,228(s3)=0A=
=0A=
#ifdef IANS=0A=
    if(adapter->iANSdata->iANS_status =3D=3D IANS_COMMUNICATION_UP) {=0A=
        tx_desc->lower.data =3D cpu_to_le32(txd_lower);=0A=
        tx_desc->upper.data =3D cpu_to_le32(txd_upper);=0A=
        if(bd_ans_os_Transmit(adapter, tx_desc, &skb) =3D=3D =
BD_ANS_FAILURE) {=0A=
            return 1;=0A=
        }=0A=
        txd_lower =3D le32_to_cpu(tx_desc->lower.data);=0A=
        txd_upper =3D le32_to_cpu(tx_desc->upper.data);=0A=
    }=0A=
#endif=0A=
=0A=
#ifdef MAX_SKB_FRAGS=0A=
    len =3D skb->len - skb->data_len;=0A=
    33c4:	0105b823 	subu	s7,t0,a1=0A=
    33c8:	00151900 	sll	v1,s5,0x4=0A=
#else=0A=
    len =3D skb->len;=0A=
#endif=0A=
    offset =3D 0;=0A=
=0A=
    while(len > 4096) {=0A=
    33cc:	2ae41001 	slti	a0,s7,4097=0A=
    33d0:	0043b021 	addu	s6,v0,v1=0A=
    33d4:	14800070 	bnez	a0,3598 <e1000_xmit_frame+0x504>=0A=
    33d8:	00007821 	move	t7,zero=0A=
    33dc:	8fa30014 	lw	v1,20(sp)=0A=
    33e0:	3c0d00ff 	lui	t5,0xff=0A=
    33e4:	8fb20040 	lw	s2,64(sp)=0A=
    33e8:	34651000 	ori	a1,v1,0x1000=0A=
    33ec:	30a3ff00 	andi	v1,a1,0xff00=0A=
    33f0:	00052600 	sll	a0,a1,0x18=0A=
    33f4:	00ad1024 	and	v0,a1,t5=0A=
    33f8:	00031a00 	sll	v1,v1,0x8=0A=
    33fc:	00832025 	or	a0,a0,v1=0A=
    3400:	00021202 	srl	v0,v0,0x8=0A=
    3404:	00822025 	or	a0,a0,v0=0A=
    3408:	00052e02 	srl	a1,a1,0x18=0A=
    340c:	00852025 	or	a0,a0,a1=0A=
    3410:	afa40018 	sw	a0,24(sp)=0A=
    3414:	8fa40010 	lw	a0,16(sp)=0A=
    3418:	3c1eff00 	lui	s8,0xff00=0A=
    341c:	24140001 	li	s4,1=0A=
    3420:	00042200 	sll	a0,a0,0x8=0A=
    3424:	afa4001c 	sw	a0,28(sp)=0A=
        adapter->tx_ring.buffer_info[i].length =3D 4096;=0A=
    3428:	8e630100 	lw	v1,256(s3)=0A=
    342c:	00158840 	sll	s1,s5,0x1=0A=
    3430:	02358821 	addu	s1,s1,s5=0A=
    3434:	001188c0 	sll	s1,s1,0x3=0A=
    3438:	02231821 	addu	v1,s1,v1=0A=
    343c:	24021000 	li	v0,4096=0A=
    3440:	ac620010 	sw	v0,16(v1)=0A=
        adapter->tx_ring.buffer_info[i].dma =3D=0A=
    3444:	8fa50080 	lw	a1,128(sp)=0A=
 */=0A=
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page =
*page,=0A=
				      unsigned long offset, size_t size,=0A=
                                      int direction)=0A=
{=0A=
    3448:	3c030000 	lui	v1,0x0=0A=
    344c:	8c630000 	lw	v1,0(v1)=0A=
    3450:	8ca40080 	lw	a0,128(a1)=0A=
    3454:	008f2021 	addu	a0,a0,t7=0A=
    3458:	3c028000 	lui	v0,0x8000=0A=
    345c:	00441021 	addu	v0,v0,a0=0A=
    3460:	00021302 	srl	v0,v0,0xc=0A=
 */=0A=
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page =
*page,=0A=
				      unsigned long offset, size_t size,=0A=
                                      int direction)=0A=
{=0A=
    3464:	00021180 	sll	v0,v0,0x6=0A=
    3468:	00431021 	addu	v0,v0,v1=0A=
    346c:	30840fff 	andi	a0,a0,0xfff=0A=
=0A=
	if (direction =3D=3D PCI_DMA_NONE)=0A=
		BUG();=0A=
=0A=
	addr =3D (unsigned long) page_address(page);=0A=
    3470:	8c500038 	lw	s0,56(v0)=0A=
	addr +=3D offset;=0A=
#ifdef CONFIG_NONCOHERENT_IO=0A=
	dma_cache_wback_inv(addr, size);=0A=
    3474:	3c030000 	lui	v1,0x0=0A=
    3478:	8c630000 	lw	v1,0(v1)=0A=
    347c:	24051000 	li	a1,4096=0A=
    3480:	02048021 	addu	s0,s0,a0=0A=
    3484:	02002021 	move	a0,s0=0A=
    3488:	afad0048 	sw	t5,72(sp)=0A=
    348c:	0060f809 	jalr	v1=0A=
    3490:	afaf0050 	sw	t7,80(sp)=0A=
            pci_map_page(pdev, virt_to_page(skb->data + offset),=0A=
                         (unsigned long) (skb->data + offset) & =
~~PAGE_MASK,=0A=
                         4096, PCI_DMA_TODEVICE);=0A=
    3494:	8e650100 	lw	a1,256(s3)=0A=
 * IO bus memory addresses are also 1:1 with the physical address=0A=
 */=0A=
static inline unsigned long virt_to_bus(volatile void * address)=0A=
{=0A=
	return PHYSADDR(address);=0A=
    3498:	3c041fff 	lui	a0,0x1fff=0A=
    349c:	3484ffff 	ori	a0,a0,0xffff=0A=
    34a0:	02041824 	and	v1,s0,a0=0A=
    34a4:	02252821 	addu	a1,s1,a1=0A=
    34a8:	00001021 	move	v0,zero=0A=
    34ac:	aca20008 	sw	v0,8(a1)=0A=
    34b0:	aca3000c 	sw	v1,12(a1)=0A=
    34b4:	8e640100 	lw	a0,256(s3)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
        return (((__u64)__swab32(l)) << 32) | ((__u64)(__swab32(h)));=0A=
    34b8:	00003021 	move	a2,zero=0A=
=0A=
        tx_desc->buffer_addr =3D =
cpu_to_le64(adapter->tx_ring.buffer_info[i].dma);=0A=
        tx_desc->lower.data =3D cpu_to_le32(txd_lower | 4096);=0A=
        tx_desc->upper.data =3D cpu_to_le32(txd_upper);=0A=
=0A=
        len -=3D 4096;=0A=
    34bc:	26f7f000 	addiu	s7,s7,-4096=0A=
    34c0:	02248821 	addu	s1,s1,a0=0A=
    34c4:	8fa4001c 	lw	a0,28(sp)=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
    34c8:	8e25000c 	lw	a1,12(s1)=0A=
    34cc:	8e280008 	lw	t0,8(s1)=0A=
    34d0:	aec4000c 	sw	a0,12(s6)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    34d4:	8fad0048 	lw	t5,72(sp)=0A=
    34d8:	30a4ff00 	andi	a0,a1,0xff00=0A=
    34dc:	00042200 	sll	a0,a0,0x8=0A=
    34e0:	00ad5024 	and	t2,a1,t5=0A=
    34e4:	00056600 	sll	t4,a1,0x18=0A=
    34e8:	310bff00 	andi	t3,t0,0xff00=0A=
    34ec:	01846025 	or	t4,t4,a0=0A=
    34f0:	000a5202 	srl	t2,t2,0x8=0A=
    34f4:	010d2024 	and	a0,t0,t5=0A=
    34f8:	00be2824 	and	a1,a1,s8=0A=
    34fc:	000b5a00 	sll	t3,t3,0x8=0A=
    3500:	00084e00 	sll	t1,t0,0x18=0A=
    3504:	018a6025 	or	t4,t4,t2=0A=
    3508:	012b4825 	or	t1,t1,t3=0A=
    350c:	00052e02 	srl	a1,a1,0x18=0A=
    3510:	00042202 	srl	a0,a0,0x8=0A=
    3514:	011e4024 	and	t0,t0,s8=0A=
}=0A=
static __inline__ __u32 __swab32p(__u32 *x)=0A=
{=0A=
	return __arch__swab32p(x);=0A=
}=0A=
static __inline__ void __swab32s(__u32 *addr)=0A=
{=0A=
	__arch__swab32s(addr);=0A=
}=0A=
=0A=
#ifdef __BYTEORDER_HAS_U64__=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
        return (((__u64)__swab32(l)) << 32) | ((__u64)(__swab32(h)));=0A=
    3518:	01851825 	or	v1,t4,a1=0A=
    351c:	01244825 	or	t1,t1,a0=0A=
    3520:	00084602 	srl	t0,t0,0x18=0A=
    3524:	01283825 	or	a3,t1,t0=0A=
    3528:	00031000 	sll	v0,v1,0x0=0A=
    352c:	00001821 	move	v1,zero=0A=
    3530:	00461025 	or	v0,v0,a2=0A=
    3534:	00671825 	or	v1,v1,a3=0A=
    3538:	aec20000 	sw	v0,0(s6)=0A=
    353c:	aec30004 	sw	v1,4(s6)=0A=
    3540:	8fa50018 	lw	a1,24(sp)=0A=
        offset +=3D 4096;=0A=
        i =3D (i + 1) % adapter->tx_ring.count;=0A=
    3544:	26a30001 	addiu	v1,s5,1=0A=
    3548:	aec50008 	sw	a1,8(s6)=0A=
    354c:	8e6200f0 	lw	v0,240(s3)=0A=
    3550:	0062001b 	divu	zero,v1,v0=0A=
    3554:	50400001 	beqzl	v0,355c <e1000_xmit_frame+0x4c8>=0A=
    3558:	0007000d 	break	0x7=0A=
    355c:	8faf0050 	lw	t7,80(sp)=0A=
    3560:	25ef1000 	addiu	t7,t7,4096=0A=
    3564:	00002010 	mfhi	a0=0A=
    3568:	0080a821 	move	s5,a0=0A=
    356c:	00000000 	nop=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3570:	c2420000 	ll	v0,0(s2)=0A=
    3574:	00541023 	subu	v0,v0,s4=0A=
    3578:	e2420000 	sc	v0,0(s2)=0A=
    357c:	1040fffc 	beqz	v0,3570 <e1000_xmit_frame+0x4dc>=0A=
    3580:	00000000 	nop=0A=
        atomic_dec(&adapter->tx_ring.unused);=0A=
        tx_desc =3D E1000_TX_DESC(adapter->tx_ring, i);=0A=
    3584:	8e6400e4 	lw	a0,228(s3)=0A=
    3588:	00151100 	sll	v0,s5,0x4=0A=
    }=0A=
    358c:	2ae31001 	slti	v1,s7,4097=0A=
    3590:	1060ffa5 	beqz	v1,3428 <e1000_xmit_frame+0x394>=0A=
    3594:	0082b021 	addu	s6,a0,v0=0A=
    adapter->tx_ring.buffer_info[i].length =3D len;=0A=
    3598:	8e620100 	lw	v0,256(s3)=0A=
    359c:	00159040 	sll	s2,s5,0x1=0A=
    35a0:	02558821 	addu	s1,s2,s5=0A=
    35a4:	001188c0 	sll	s1,s1,0x3=0A=
    35a8:	02221021 	addu	v0,s1,v0=0A=
    35ac:	ac570010 	sw	s7,16(v0)=0A=
    adapter->tx_ring.buffer_info[i].dma =3D=0A=
    35b0:	8fa20080 	lw	v0,128(sp)=0A=
 */=0A=
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page =
*page,=0A=
				      unsigned long offset, size_t size,=0A=
                                      int direction)=0A=
{=0A=
    35b4:	3c040000 	lui	a0,0x0=0A=
    35b8:	8c840000 	lw	a0,0(a0)=0A=
    35bc:	8c430080 	lw	v1,128(v0)=0A=
    35c0:	006f1821 	addu	v1,v1,t7=0A=
    35c4:	3c028000 	lui	v0,0x8000=0A=
    35c8:	00431021 	addu	v0,v0,v1=0A=
    35cc:	00021302 	srl	v0,v0,0xc=0A=
 */=0A=
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page =
*page,=0A=
				      unsigned long offset, size_t size,=0A=
                                      int direction)=0A=
{=0A=
    35d0:	00021180 	sll	v0,v0,0x6=0A=
    35d4:	00441021 	addu	v0,v0,a0=0A=
    35d8:	30630fff 	andi	v1,v1,0xfff=0A=
=0A=
	if (direction =3D=3D PCI_DMA_NONE)=0A=
		BUG();=0A=
=0A=
	addr =3D (unsigned long) page_address(page);=0A=
    35dc:	8c500038 	lw	s0,56(v0)=0A=
	addr +=3D offset;=0A=
#ifdef CONFIG_NONCOHERENT_IO=0A=
	dma_cache_wback_inv(addr, size);=0A=
    35e0:	3c060000 	lui	a2,0x0=0A=
    35e4:	8cc60000 	lw	a2,0(a2)=0A=
    35e8:	02038021 	addu	s0,s0,v1=0A=
    35ec:	02002021 	move	a0,s0=0A=
    35f0:	00c0f809 	jalr	a2=0A=
    35f4:	02e02821 	move	a1,s7=0A=
        pci_map_page(pdev, virt_to_page(skb->data + offset),=0A=
                     (unsigned long) (skb->data + offset) & ~PAGE_MASK, =
len,=0A=
                     PCI_DMA_TODEVICE);=0A=
    35f8:	8e650100 	lw	a1,256(s3)=0A=
 * IO bus memory addresses are also 1:1 with the physical address=0A=
 */=0A=
static inline unsigned long virt_to_bus(volatile void * address)=0A=
{=0A=
	return PHYSADDR(address);=0A=
    35fc:	3c041fff 	lui	a0,0x1fff=0A=
    3600:	3484ffff 	ori	a0,a0,0xffff=0A=
    3604:	02041824 	and	v1,s0,a0=0A=
    3608:	02252821 	addu	a1,s1,a1=0A=
    360c:	00001021 	move	v0,zero=0A=
    3610:	aca20008 	sw	v0,8(a1)=0A=
    3614:	aca3000c 	sw	v1,12(a1)=0A=
    3618:	8e640100 	lw	a0,256(s3)=0A=
=0A=
    tx_desc->buffer_addr =3D =
cpu_to_le64(adapter->tx_ring.buffer_info[i].dma);=0A=
    361c:	8fa30014 	lw	v1,20(sp)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3620:	3c0700ff 	lui	a3,0xff=0A=
    3624:	02248821 	addu	s1,s1,a0=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
    3628:	8e2a000c 	lw	t2,12(s1)=0A=
    362c:	8e2b0008 	lw	t3,8(s1)=0A=
    3630:	00776025 	or	t4,v1,s7=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3634:	3142ff00 	andi	v0,t2,0xff00=0A=
    3638:	01471824 	and	v1,t2,a3=0A=
    363c:	318dff00 	andi	t5,t4,0xff00=0A=
    3640:	00021200 	sll	v0,v0,0x8=0A=
    3644:	000a4600 	sll	t0,t2,0x18=0A=
    3648:	3164ff00 	andi	a0,t3,0xff00=0A=
    364c:	01024025 	or	t0,t0,v0=0A=
    3650:	00031a02 	srl	v1,v1,0x8=0A=
    3654:	01671024 	and	v0,t3,a3=0A=
    3658:	00042200 	sll	a0,a0,0x8=0A=
    365c:	000b4e00 	sll	t1,t3,0x18=0A=
    3660:	01873824 	and	a3,t4,a3=0A=
    3664:	000c3600 	sll	a2,t4,0x18=0A=
    3668:	000d6a00 	sll	t5,t5,0x8=0A=
    366c:	01034025 	or	t0,t0,v1=0A=
    3670:	01244825 	or	t1,t1,a0=0A=
    3674:	00021202 	srl	v0,v0,0x8=0A=
    3678:	00073a02 	srl	a3,a3,0x8=0A=
    367c:	000a5602 	srl	t2,t2,0x18=0A=
    3680:	00cd3025 	or	a2,a2,t5=0A=
    3684:	01224825 	or	t1,t1,v0=0A=
}=0A=
static __inline__ __u32 __swab32p(__u32 *x)=0A=
{=0A=
	return __arch__swab32p(x);=0A=
}=0A=
static __inline__ void __swab32s(__u32 *addr)=0A=
{=0A=
	__arch__swab32s(addr);=0A=
}=0A=
=0A=
#ifdef __BYTEORDER_HAS_U64__=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
        return (((__u64)__swab32(l)) << 32) | ((__u64)(__swab32(h)));=0A=
    3688:	010a2825 	or	a1,t0,t2=0A=
    368c:	00c73025 	or	a2,a2,a3=0A=
    3690:	000b5e02 	srl	t3,t3,0x18=0A=
    3694:	8fa70010 	lw	a3,16(sp)=0A=
    3698:	00002021 	move	a0,zero=0A=
    369c:	012b1825 	or	v1,t1,t3=0A=
    36a0:	00001021 	move	v0,zero=0A=
    36a4:	00052000 	sll	a0,a1,0x0=0A=
    36a8:	00002821 	move	a1,zero=0A=
    36ac:	00822025 	or	a0,a0,v0=0A=
    36b0:	000c6602 	srl	t4,t4,0x18=0A=
    36b4:	00a32825 	or	a1,a1,v1=0A=
    36b8:	00cc3025 	or	a2,a2,t4=0A=
    36bc:	00071200 	sll	v0,a3,0x8=0A=
    36c0:	aec40000 	sw	a0,0(s6)=0A=
    36c4:	aec50004 	sw	a1,4(s6)=0A=
    tx_desc->lower.data =3D cpu_to_le32(txd_lower | len);=0A=
    36c8:	aec60008 	sw	a2,8(s6)=0A=
    tx_desc->upper.data =3D cpu_to_le32(txd_upper);=0A=
    36cc:	aec2000c 	sw	v0,12(s6)=0A=
=0A=
#ifdef MAX_SKB_FRAGS=0A=
    if(skb_shinfo(skb)->nr_frags > 0) {=0A=
    36d0:	8fa80080 	lw	t0,128(sp)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    36d4:	00003021 	move	a2,zero=0A=
    36d8:	00001821 	move	v1,zero=0A=
    36dc:	8d070088 	lw	a3,136(t0)=0A=
    36e0:	8ce20004 	lw	v0,4(a3)=0A=
    36e4:	104000eb 	beqz	v0,3a94 <e1000_xmit_frame+0xa00>=0A=
    36e8:	00002021 	move	a0,zero=0A=
        for(f =3D 0; f < skb_shinfo(skb)->nr_frags; f++) {=0A=
    36ec:	104000e9 	beqz	v0,3a94 <e1000_xmit_frame+0xa00>=0A=
    36f0:	00006821 	move	t5,zero=0A=
    36f4:	8fa20014 	lw	v0,20(sp)=0A=
    36f8:	afa30038 	sw	v1,56(sp)=0A=
    36fc:	8fa30010 	lw	v1,16(sp)=0A=
    3700:	34421000 	ori	v0,v0,0x1000=0A=
    3704:	8fb40040 	lw	s4,64(sp)=0A=
    3708:	afa4003c 	sw	a0,60(sp)=0A=
    370c:	00022600 	sll	a0,v0,0x18=0A=
    3710:	afa20024 	sw	v0,36(sp)=0A=
    3714:	afa60034 	sw	a2,52(sp)=0A=
    3718:	240e0001 	li	t6,1=0A=
    371c:	afa30030 	sw	v1,48(sp)=0A=
    3720:	afa40028 	sw	a0,40(sp)=0A=
            frag =3D &skb_shinfo(skb)->frags[f];=0A=
            i =3D (i + 1) % adapter->tx_ring.count;=0A=
    3724:	8e6400f0 	lw	a0,240(s3)=0A=
    3728:	26a20001 	addiu	v0,s5,1=0A=
    372c:	000d18c0 	sll	v1,t5,0x3=0A=
    3730:	0044001b 	divu	zero,v0,a0=0A=
    3734:	00e31821 	addu	v1,a3,v1=0A=
    3738:	50800001 	beqzl	a0,3740 <e1000_xmit_frame+0x6ac>=0A=
    373c:	0007000d 	break	0x7=0A=
    3740:	247e000c 	addiu	s8,v1,12=0A=
    3744:	00002810 	mfhi	a1=0A=
    3748:	00a0a821 	move	s5,a1=0A=
    374c:	00000000 	nop=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3750:	c2820000 	ll	v0,0(s4)=0A=
    3754:	004e1023 	subu	v0,v0,t6=0A=
    3758:	e2820000 	sc	v0,0(s4)=0A=
    375c:	1040fffc 	beqz	v0,3750 <e1000_xmit_frame+0x6bc>=0A=
    3760:	00000000 	nop=0A=
            atomic_dec(&adapter->tx_ring.unused);=0A=
            tx_desc =3D E1000_TX_DESC(adapter->tx_ring, i);=0A=
=0A=
            len =3D frag->size;=0A=
    3764:	97d70006 	lhu	s7,6(s8)=0A=
    3768:	8e6300e4 	lw	v1,228(s3)=0A=
    376c:	00151100 	sll	v0,s5,0x4=0A=
            offset =3D 0;=0A=
=0A=
            while(len > 4096) {=0A=
    3770:	2ae41001 	slti	a0,s7,4097=0A=
    3774:	0062b021 	addu	s6,v1,v0=0A=
    3778:	1480006a 	bnez	a0,3924 <e1000_xmit_frame+0x890>=0A=
    377c:	00007821 	move	t7,zero=0A=
    3780:	8fa30024 	lw	v1,36(sp)=0A=
    3784:	8fa40028 	lw	a0,40(sp)=0A=
    3788:	3c1900ff 	lui	t9,0xff=0A=
    378c:	3062ff00 	andi	v0,v1,0xff00=0A=
    3790:	8fa50024 	lw	a1,36(sp)=0A=
    3794:	00021200 	sll	v0,v0,0x8=0A=
    3798:	00791824 	and	v1,v1,t9=0A=
    379c:	8fa70010 	lw	a3,16(sp)=0A=
    37a0:	00821025 	or	v0,a0,v0=0A=
    37a4:	00031a02 	srl	v1,v1,0x8=0A=
    37a8:	00431025 	or	v0,v0,v1=0A=
    37ac:	00052602 	srl	a0,a1,0x18=0A=
    37b0:	00441025 	or	v0,v0,a0=0A=
    37b4:	00073a00 	sll	a3,a3,0x8=0A=
    37b8:	afa20020 	sw	v0,32(sp)=0A=
    37bc:	3c12ff00 	lui	s2,0xff00=0A=
    37c0:	afa7002c 	sw	a3,44(sp)=0A=
                adapter->tx_ring.buffer_info[i].length =3D 4096;=0A=
    37c4:	8e630100 	lw	v1,256(s3)=0A=
    37c8:	00158040 	sll	s0,s5,0x1=0A=
    37cc:	02158021 	addu	s0,s0,s5=0A=
    37d0:	001080c0 	sll	s0,s0,0x3=0A=
    37d4:	02031821 	addu	v1,s0,v1=0A=
    37d8:	24021000 	li	v0,4096=0A=
    37dc:	ac620010 	sw	v0,16(v1)=0A=
                adapter->tx_ring.buffer_info[i].dma =3D=0A=
    37e0:	97c40004 	lhu	a0,4(s8)=0A=
 */=0A=
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page =
*page,=0A=
				      unsigned long offset, size_t size,=0A=
                                      int direction)=0A=
{=0A=
    37e4:	8fc20000 	lw	v0,0(s8)=0A=
    37e8:	008f2021 	addu	a0,a0,t7=0A=
	unsigned long addr;=0A=
=0A=
	if (direction =3D=3D PCI_DMA_NONE)=0A=
		BUG();=0A=
=0A=
	addr =3D (unsigned long) page_address(page);=0A=
    37ec:	8c510038 	lw	s1,56(v0)=0A=
	addr +=3D offset;=0A=
#ifdef CONFIG_NONCOHERENT_IO=0A=
	dma_cache_wback_inv(addr, size);=0A=
    37f0:	3c030000 	lui	v1,0x0=0A=
    37f4:	8c630000 	lw	v1,0(v1)=0A=
    37f8:	24051000 	li	a1,4096=0A=
    37fc:	02248821 	addu	s1,s1,a0=0A=
    3800:	02202021 	move	a0,s1=0A=
    3804:	afae004c 	sw	t6,76(sp)=0A=
    3808:	afaf0050 	sw	t7,80(sp)=0A=
    380c:	afb90054 	sw	t9,84(sp)=0A=
    3810:	0060f809 	jalr	v1=0A=
    3814:	afad0048 	sw	t5,72(sp)=0A=
                    pci_map_page(pdev, frag->page, frag->page_offset + =
offset,=0A=
                                 4096, PCI_DMA_TODEVICE);=0A=
    3818:	8e650100 	lw	a1,256(s3)=0A=
 * IO bus memory addresses are also 1:1 with the physical address=0A=
 */=0A=
static inline unsigned long virt_to_bus(volatile void * address)=0A=
{=0A=
	return PHYSADDR(address);=0A=
    381c:	3c041fff 	lui	a0,0x1fff=0A=
    3820:	3484ffff 	ori	a0,a0,0xffff=0A=
    3824:	02241824 	and	v1,s1,a0=0A=
    3828:	02052821 	addu	a1,s0,a1=0A=
    382c:	00001021 	move	v0,zero=0A=
    3830:	aca20008 	sw	v0,8(a1)=0A=
    3834:	aca3000c 	sw	v1,12(a1)=0A=
=0A=
                tx_desc->buffer_addr =3D=0A=
    3838:	8e640100 	lw	a0,256(s3)=0A=
                    cpu_to_le64(adapter->tx_ring.buffer_info[i].dma);=0A=
                tx_desc->lower.data =3D cpu_to_le32(txd_lower | 4096);=0A=
                tx_desc->upper.data =3D cpu_to_le32(txd_upper);=0A=
    383c:	8fa8002c 	lw	t0,44(sp)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
        return (((__u64)__swab32(l)) << 32) | ((__u64)(__swab32(h)));=0A=
    3840:	00003021 	move	a2,zero=0A=
    3844:	02048021 	addu	s0,s0,a0=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
    3848:	8e05000c 	lw	a1,12(s0)=0A=
    384c:	8e0a0008 	lw	t2,8(s0)=0A=
    3850:	aec8000c 	sw	t0,12(s6)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3854:	8fb90054 	lw	t9,84(sp)=0A=
    3858:	30a4ff00 	andi	a0,a1,0xff00=0A=
    385c:	00042200 	sll	a0,a0,0x8=0A=
    3860:	00b95824 	and	t3,a1,t9=0A=
    3864:	00054600 	sll	t0,a1,0x18=0A=
    3868:	314cff00 	andi	t4,t2,0xff00=0A=
    386c:	01594824 	and	t1,t2,t9=0A=
    3870:	01044025 	or	t0,t0,a0=0A=
    3874:	000b5a02 	srl	t3,t3,0x8=0A=
    3878:	00b22824 	and	a1,a1,s2=0A=
    387c:	000c6200 	sll	t4,t4,0x8=0A=
    3880:	000a2600 	sll	a0,t2,0x18=0A=
    3884:	010b4025 	or	t0,t0,t3=0A=
    3888:	008c2025 	or	a0,a0,t4=0A=
    388c:	00052e02 	srl	a1,a1,0x18=0A=
    3890:	00094a02 	srl	t1,t1,0x8=0A=
    3894:	01525024 	and	t2,t2,s2=0A=
    3898:	00892025 	or	a0,a0,t1=0A=
}=0A=
static __inline__ __u32 __swab32p(__u32 *x)=0A=
{=0A=
	return __arch__swab32p(x);=0A=
}=0A=
static __inline__ void __swab32s(__u32 *addr)=0A=
{=0A=
	__arch__swab32s(addr);=0A=
}=0A=
=0A=
#ifdef __BYTEORDER_HAS_U64__=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
        return (((__u64)__swab32(l)) << 32) | ((__u64)(__swab32(h)));=0A=
    389c:	01051825 	or	v1,t0,a1=0A=
    38a0:	000a5602 	srl	t2,t2,0x18=0A=
    38a4:	008a3825 	or	a3,a0,t2=0A=
    38a8:	00031000 	sll	v0,v1,0x0=0A=
    38ac:	00001821 	move	v1,zero=0A=
    38b0:	00461025 	or	v0,v0,a2=0A=
    38b4:	00671825 	or	v1,v1,a3=0A=
    38b8:	aec20000 	sw	v0,0(s6)=0A=
    38bc:	aec30004 	sw	v1,4(s6)=0A=
    38c0:	8fa20020 	lw	v0,32(sp)=0A=
=0A=
                len -=3D 4096;=0A=
    38c4:	26f7f000 	addiu	s7,s7,-4096=0A=
    38c8:	aec20008 	sw	v0,8(s6)=0A=
                offset +=3D 4096;=0A=
                i =3D (i + 1) % adapter->tx_ring.count;=0A=
    38cc:	8e6300f0 	lw	v1,240(s3)=0A=
    38d0:	26a20001 	addiu	v0,s5,1=0A=
    38d4:	0043001b 	divu	zero,v0,v1=0A=
    38d8:	50600001 	beqzl	v1,38e0 <e1000_xmit_frame+0x84c>=0A=
    38dc:	0007000d 	break	0x7=0A=
    38e0:	8faf0050 	lw	t7,80(sp)=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    38e4:	8fae004c 	lw	t6,76(sp)=0A=
    38e8:	25ef1000 	addiu	t7,t7,4096=0A=
    38ec:	00002010 	mfhi	a0=0A=
    38f0:	0080a821 	move	s5,a0=0A=
    38f4:	00000000 	nop=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    38f8:	c2820000 	ll	v0,0(s4)=0A=
    38fc:	004e1023 	subu	v0,v0,t6=0A=
    3900:	e2820000 	sc	v0,0(s4)=0A=
    3904:	1040fffc 	beqz	v0,38f8 <e1000_xmit_frame+0x864>=0A=
    3908:	00000000 	nop=0A=
                atomic_dec(&adapter->tx_ring.unused);=0A=
                tx_desc =3D E1000_TX_DESC(adapter->tx_ring, i);=0A=
    390c:	8e6400e4 	lw	a0,228(s3)=0A=
    3910:	00151100 	sll	v0,s5,0x4=0A=
            }=0A=
    3914:	2ae31001 	slti	v1,s7,4097=0A=
    3918:	0082b021 	addu	s6,a0,v0=0A=
    391c:	1060ffa9 	beqz	v1,37c4 <e1000_xmit_frame+0x730>=0A=
    3920:	8fad0048 	lw	t5,72(sp)=0A=
            adapter->tx_ring.buffer_info[i].length =3D len;=0A=
    3924:	8e620100 	lw	v0,256(s3)=0A=
    3928:	00159040 	sll	s2,s5,0x1=0A=
    392c:	02558821 	addu	s1,s2,s5=0A=
    3930:	001188c0 	sll	s1,s1,0x3=0A=
    3934:	02221021 	addu	v0,s1,v0=0A=
    3938:	ac570010 	sw	s7,16(v0)=0A=
            adapter->tx_ring.buffer_info[i].dma =3D=0A=
    393c:	97c30004 	lhu	v1,4(s8)=0A=
 */=0A=
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page =
*page,=0A=
				      unsigned long offset, size_t size,=0A=
                                      int direction)=0A=
{=0A=
    3940:	8fc20000 	lw	v0,0(s8)=0A=
    3944:	006f1821 	addu	v1,v1,t7=0A=
	unsigned long addr;=0A=
=0A=
	if (direction =3D=3D PCI_DMA_NONE)=0A=
		BUG();=0A=
=0A=
	addr =3D (unsigned long) page_address(page);=0A=
    3948:	8c500038 	lw	s0,56(v0)=0A=
	addr +=3D offset;=0A=
#ifdef CONFIG_NONCOHERENT_IO=0A=
	dma_cache_wback_inv(addr, size);=0A=
    394c:	3c060000 	lui	a2,0x0=0A=
    3950:	8cc60000 	lw	a2,0(a2)=0A=
    3954:	02038021 	addu	s0,s0,v1=0A=
    3958:	02002021 	move	a0,s0=0A=
    395c:	02e02821 	move	a1,s7=0A=
    3960:	afad0048 	sw	t5,72(sp)=0A=
    3964:	00c0f809 	jalr	a2=0A=
    3968:	afae004c 	sw	t6,76(sp)=0A=
                pci_map_page(pdev, frag->page, frag->page_offset + =
offset, len,=0A=
                             PCI_DMA_TODEVICE);=0A=
    396c:	8e650100 	lw	a1,256(s3)=0A=
 * IO bus memory addresses are also 1:1 with the physical address=0A=
 */=0A=
static inline unsigned long virt_to_bus(volatile void * address)=0A=
{=0A=
	return PHYSADDR(address);=0A=
    3970:	3c041fff 	lui	a0,0x1fff=0A=
    3974:	3484ffff 	ori	a0,a0,0xffff=0A=
    3978:	02041824 	and	v1,s0,a0=0A=
    397c:	02252821 	addu	a1,s1,a1=0A=
    3980:	00001021 	move	v0,zero=0A=
    3984:	aca20008 	sw	v0,8(a1)=0A=
    3988:	aca3000c 	sw	v1,12(a1)=0A=
            tx_desc->buffer_addr =3D=0A=
    398c:	8e640100 	lw	a0,256(s3)=0A=
                cpu_to_le64(adapter->tx_ring.buffer_info[i].dma);=0A=
    3990:	8fa20014 	lw	v0,20(sp)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3994:	3c0500ff 	lui	a1,0xff=0A=
    3998:	02248821 	addu	s1,s1,a0=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
    399c:	8e23000c 	lw	v1,12(s1)=0A=
    39a0:	8e290008 	lw	t1,8(s1)=0A=
    39a4:	00575825 	or	t3,v0,s7=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    39a8:	3062ff00 	andi	v0,v1,0xff00=0A=
    39ac:	00652024 	and	a0,v1,a1=0A=
    39b0:	00021200 	sll	v0,v0,0x8=0A=
    39b4:	00033600 	sll	a2,v1,0x18=0A=
    39b8:	3125ff00 	andi	a1,t1,0xff00=0A=
    39bc:	3c0800ff 	lui	t0,0xff=0A=
    39c0:	00c23025 	or	a2,a2,v0=0A=
    39c4:	00052a00 	sll	a1,a1,0x8=0A=
    39c8:	01281024 	and	v0,t1,t0=0A=
    39cc:	00095600 	sll	t2,t1,0x18=0A=
    39d0:	01455025 	or	t2,t2,a1=0A=
    39d4:	00021202 	srl	v0,v0,0x8=0A=
    39d8:	3c07ff00 	lui	a3,0xff00=0A=
    39dc:	01425025 	or	t2,t2,v0=0A=
    39e0:	8fa20030 	lw	v0,48(sp)=0A=
    39e4:	00042202 	srl	a0,a0,0x8=0A=
    39e8:	00671824 	and	v1,v1,a3=0A=
    39ec:	00c43025 	or	a2,a2,a0=0A=
    39f0:	00031e02 	srl	v1,v1,0x18=0A=
}=0A=
static __inline__ __u32 __swab32p(__u32 *x)=0A=
{=0A=
	return __arch__swab32p(x);=0A=
}=0A=
static __inline__ void __swab32s(__u32 *addr)=0A=
{=0A=
	__arch__swab32s(addr);=0A=
}=0A=
=0A=
#ifdef __BYTEORDER_HAS_U64__=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
        return (((__u64)__swab32(l)) << 32) | ((__u64)(__swab32(h)));=0A=
    39f4:	00c32825 	or	a1,a2,v1=0A=
    39f8:	00023200 	sll	a2,v0,0x8=0A=
    39fc:	8fa20034 	lw	v0,52(sp)=0A=
    3a00:	316cff00 	andi	t4,t3,0xff00=0A=
    3a04:	01274824 	and	t1,t1,a3=0A=
    3a08:	01684024 	and	t0,t3,t0=0A=
    3a0c:	000b3e00 	sll	a3,t3,0x18=0A=
    3a10:	3c03ff00 	lui	v1,0xff00=0A=
    3a14:	000c6200 	sll	t4,t4,0x8=0A=
    3a18:	00094e02 	srl	t1,t1,0x18=0A=
    3a1c:	00002021 	move	a0,zero=0A=
    3a20:	00084202 	srl	t0,t0,0x8=0A=
    3a24:	01635824 	and	t3,t3,v1=0A=
    3a28:	00463025 	or	a2,v0,a2=0A=
    3a2c:	01491825 	or	v1,t2,t1=0A=
    3a30:	00001021 	move	v0,zero=0A=
    3a34:	00ec3825 	or	a3,a3,t4=0A=
    3a38:	00052000 	sll	a0,a1,0x0=0A=
    3a3c:	00002821 	move	a1,zero=0A=
    3a40:	00822025 	or	a0,a0,v0=0A=
    3a44:	00e83825 	or	a3,a3,t0=0A=
    3a48:	8fa80038 	lw	t0,56(sp)=0A=
    3a4c:	00a32825 	or	a1,a1,v1=0A=
    3a50:	8fa2003c 	lw	v0,60(sp)=0A=
    3a54:	000b5e02 	srl	t3,t3,0x18=0A=
    3a58:	00c83025 	or	a2,a2,t0=0A=
    3a5c:	00eb3825 	or	a3,a3,t3=0A=
    3a60:	00c23025 	or	a2,a2,v0=0A=
    3a64:	aec40000 	sw	a0,0(s6)=0A=
    3a68:	aec50004 	sw	a1,4(s6)=0A=
            tx_desc->lower.data =3D cpu_to_le32(txd_lower | len);=0A=
    3a6c:	aec70008 	sw	a3,8(s6)=0A=
            tx_desc->upper.data =3D cpu_to_le32(txd_upper);=0A=
    3a70:	aec6000c 	sw	a2,12(s6)=0A=
    3a74:	8fa30080 	lw	v1,128(sp)=0A=
    3a78:	8fad0048 	lw	t5,72(sp)=0A=
    3a7c:	8c670088 	lw	a3,136(v1)=0A=
    3a80:	25ad0001 	addiu	t5,t5,1=0A=
    3a84:	8ce20004 	lw	v0,4(a3)=0A=
    3a88:	01a2102b 	sltu	v0,t5,v0=0A=
    3a8c:	1440ff25 	bnez	v0,3724 <e1000_xmit_frame+0x690>=0A=
    3a90:	8fae004c 	lw	t6,76(sp)=0A=
        }=0A=
    }=0A=
    3a94:	8ec20008 	lw	v0,8(s6)=0A=
#endif=0A=
    /* EOP and SKB pointer go with the last fragment */=0A=
    tx_desc->lower.data |=3D cpu_to_le32(E1000_TXD_CMD_EOP);=0A=
    adapter->tx_ring.buffer_info[i].skb =3D skb;=0A=
    3a98:	02552021 	addu	a0,s2,s5=0A=
    3a9c:	000420c0 	sll	a0,a0,0x3=0A=
    3aa0:	34420001 	ori	v0,v0,0x1=0A=
    3aa4:	aec20008 	sw	v0,8(s6)=0A=
    3aa8:	8e630100 	lw	v1,256(s3)=0A=
    3aac:	8fa70080 	lw	a3,128(sp)=0A=
=0A=
    i =3D (i + 1) % adapter->tx_ring.count;=0A=
    3ab0:	26a50001 	addiu	a1,s5,1=0A=
    3ab4:	00832021 	addu	a0,a0,v1=0A=
    3ab8:	ac870000 	sw	a3,0(a0)=0A=
    3abc:	8e6300f0 	lw	v1,240(s3)=0A=
    3ac0:	3c0600ff 	lui	a2,0xff=0A=
    3ac4:	3c11ff00 	lui	s1,0xff00=0A=
    3ac8:	00a3001b 	divu	zero,a1,v1=0A=
    3acc:	50600001 	beqzl	v1,3ad4 <e1000_xmit_frame+0xa40>=0A=
    3ad0:	0007000d 	break	0x7=0A=
    3ad4:	24020001 	li	v0,1=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3ad8:	8fa30040 	lw	v1,64(sp)=0A=
    3adc:	00008010 	mfhi	s0=0A=
	...=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3ae8:	c0640000 	ll	a0,0(v1)=0A=
    3aec:	00822023 	subu	a0,a0,v0=0A=
    3af0:	e0640000 	sc	a0,0(v1)=0A=
    3af4:	1080fffc 	beqz	a0,3ae8 <e1000_xmit_frame+0xa54>=0A=
    3af8:	00000000 	nop=0A=
    atomic_dec(&adapter->tx_ring.unused);=0A=
=0A=
    /* Move the HW Tx Tail Pointer */=0A=
    adapter->tx_ring.next_to_use =3D i;=0A=
    3afc:	8e63000c 	lw	v1,12(s3)=0A=
    3b00:	2c630002 	sltiu	v1,v1,2=0A=
    3b04:	1460000f 	bnez	v1,3b44 <e1000_xmit_frame+0xab0>=0A=
    3b08:	ae7000f8 	sw	s0,248(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3b0c:	3203ff00 	andi	v1,s0,0xff00=0A=
    3b10:	00031a00 	sll	v1,v1,0x8=0A=
    3b14:	02062824 	and	a1,s0,a2=0A=
    3b18:	00101600 	sll	v0,s0,0x18=0A=
    3b1c:	00431025 	or	v0,v0,v1=0A=
    3b20:	02112024 	and	a0,s0,s1=0A=
    3b24:	00052a02 	srl	a1,a1,0x8=0A=
    3b28:	8e630008 	lw	v1,8(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3b2c:	00451025 	or	v0,v0,a1=0A=
    3b30:	00042602 	srl	a0,a0,0x18=0A=
    3b34:	00441025 	or	v0,v0,a0=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, TDT, adapter->tx_ring.next_to_use);=0A=
    3b38:	ac623818 	sw	v0,14360(v1)=0A=
    3b3c:	08000edd 	j	3b74 <e1000_xmit_frame+0xae0>=0A=
    3b40:	00000000 	nop=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3b44:	3203ff00 	andi	v1,s0,0xff00=0A=
    3b48:	00031a00 	sll	v1,v1,0x8=0A=
    3b4c:	02062824 	and	a1,s0,a2=0A=
    3b50:	00101600 	sll	v0,s0,0x18=0A=
    3b54:	00431025 	or	v0,v0,v1=0A=
    3b58:	02112024 	and	a0,s0,s1=0A=
    3b5c:	00052a02 	srl	a1,a1,0x8=0A=
    3b60:	8e630008 	lw	v1,8(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3b64:	00451025 	or	v0,v0,a1=0A=
    3b68:	00042602 	srl	a0,a0,0x18=0A=
    3b6c:	00441025 	or	v0,v0,a0=0A=
    3b70:	ac620438 	sw	v0,1080(v1)=0A=
=0A=
    if(atomic_read(&adapter->tx_timeout) =3D=3D 0)=0A=
    3b74:	8e62010c 	lw	v0,268(s3)=0A=
    3b78:	14400002 	bnez	v0,3b84 <e1000_xmit_frame+0xaf0>=0A=
    3b7c:	24020003 	li	v0,3=0A=
        atomic_set(&adapter->tx_timeout, 3);=0A=
    3b80:	ae62010c 	sw	v0,268(s3)=0A=
=0A=
    netdev->trans_start =3D jiffies;=0A=
    3b84:	3c030000 	lui	v1,0x0=0A=
    3b88:	8c630000 	lw	v1,0(v1)=0A=
    3b8c:	8fa40084 	lw	a0,132(sp)=0A=
=0A=
    return 0;=0A=
    3b90:	00001021 	move	v0,zero=0A=
    3b94:	ac83004c 	sw	v1,76(a0)=0A=
}=0A=
    3b98:	8fbf007c 	lw	ra,124(sp)=0A=
    3b9c:	8fbe0078 	lw	s8,120(sp)=0A=
    3ba0:	8fb70074 	lw	s7,116(sp)=0A=
    3ba4:	8fb60070 	lw	s6,112(sp)=0A=
    3ba8:	8fb5006c 	lw	s5,108(sp)=0A=
    3bac:	8fb40068 	lw	s4,104(sp)=0A=
    3bb0:	8fb30064 	lw	s3,100(sp)=0A=
    3bb4:	8fb20060 	lw	s2,96(sp)=0A=
    3bb8:	8fb1005c 	lw	s1,92(sp)=0A=
    3bbc:	8fb00058 	lw	s0,88(sp)=0A=
    3bc0:	03e00008 	jr	ra=0A=
    3bc4:	27bd0080 	addiu	sp,sp,128=0A=
=0A=
00003bc8 <e1000_get_stats>:=0A=
=0A=
/**=0A=
 * e1000_get_stats - Get System Network Statistics=0A=
 * @netdev: network interface device structure=0A=
 *=0A=
 * Returns the address of the device statistics structure.=0A=
 * The statistics are actually updated from the timer callback.=0A=
 **/=0A=
=0A=
struct net_device_stats *=0A=
e1000_get_stats(struct net_device *netdev)=0A=
{=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    3bc8:	8c820064 	lw	v0,100(a0)=0A=
=0A=
    E1000_DBG("e1000_get_stats\n");=0A=
=0A=
    return &adapter->net_stats;=0A=
    3bcc:	03e00008 	jr	ra=0A=
    3bd0:	24420150 	addiu	v0,v0,336=0A=
=0A=
00003bd4 <e1000_change_mtu>:=0A=
    3bd4:	27bdffd0 	addiu	sp,sp,-48=0A=
    3bd8:	afb50024 	sw	s5,36(sp)=0A=
    3bdc:	afb40020 	sw	s4,32(sp)=0A=
    3be0:	afbf0028 	sw	ra,40(sp)=0A=
    3be4:	afb3001c 	sw	s3,28(sp)=0A=
    3be8:	afb20018 	sw	s2,24(sp)=0A=
    3bec:	afb10014 	sw	s1,20(sp)=0A=
    3bf0:	afb00010 	sw	s0,16(sp)=0A=
    3bf4:	0080a821 	move	s5,a0=0A=
    3bf8:	00a0a021 	move	s4,a1=0A=
}=0A=
=0A=
/**=0A=
 * e1000_change_mtu - Change the Maximum Transfer Unit=0A=
 * @netdev: network interface device structure=0A=
 * @new_mtu: new value for maximum frame size=0A=
 *=0A=
 * Returns 0 on success, negative on failure=0A=
 **/=0A=
=0A=
int=0A=
e1000_change_mtu(struct net_device *netdev,=0A=
                 int new_mtu)=0A=
{=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    3bfc:	8eb20064 	lw	s2,100(s5)=0A=
    uint32_t old_mtu =3D adapter->rx_buffer_len;=0A=
=0A=
    E1000_DBG("e1000_change_mtu\n");=0A=
    if((new_mtu < MINIMUM_ETHERNET_PACKET_SIZE - ENET_HEADER_SIZE) ||=0A=
    3c00:	2682ffd2 	addiu	v0,s4,-46=0A=
    3c04:	2c423ec5 	sltiu	v0,v0,16069=0A=
    3c08:	14400005 	bnez	v0,3c20 <e1000_change_mtu+0x4c>=0A=
    3c0c:	8e4300b8 	lw	v1,184(s2)=0A=
       (new_mtu > MAX_JUMBO_FRAME_SIZE - ENET_HEADER_SIZE)) {=0A=
        E1000_ERR("Invalid MTU setting\n");=0A=
    3c10:	3c040000 	lui	a0,0x0=0A=
    3c14:	24840d60 	addiu	a0,a0,3424=0A=
        return -EINVAL;=0A=
    3c18:	08000f12 	j	3c48 <e1000_change_mtu+0x74>=0A=
    3c1c:	00000000 	nop=0A=
    }=0A=
=0A=
    if(new_mtu <=3D MAXIMUM_ETHERNET_PACKET_SIZE - ENET_HEADER_SIZE) {=0A=
    3c20:	2a8205dd 	slti	v0,s4,1501=0A=
    3c24:	50400003 	beqzl	v0,3c34 <e1000_change_mtu+0x60>=0A=
    3c28:	8e42000c 	lw	v0,12(s2)=0A=
        /* 2k buffers */=0A=
        adapter->rx_buffer_len =3D E1000_RXBUFFER_2048;=0A=
=0A=
    } else if(adapter->shared.mac_type < e1000_82543) {=0A=
    3c2c:	08000f1f 	j	3c7c <e1000_change_mtu+0xa8>=0A=
    3c30:	24020800 	li	v0,2048=0A=
    3c34:	2c420002 	sltiu	v0,v0,2=0A=
    3c38:	10400009 	beqz	v0,3c60 <e1000_change_mtu+0x8c>=0A=
    3c3c:	2a820fef 	slti	v0,s4,4079=0A=
        E1000_ERR("Jumbo Frames not supported on 82542\n");=0A=
    3c40:	3c040000 	lui	a0,0x0=0A=
    3c44:	24840d80 	addiu	a0,a0,3456=0A=
    3c48:	3c020000 	lui	v0,0x0=0A=
    3c4c:	24420000 	addiu	v0,v0,0=0A=
    3c50:	0040f809 	jalr	v0=0A=
    3c54:	00000000 	nop=0A=
        return -EINVAL;=0A=
    3c58:	08000f70 	j	3dc0 <e1000_change_mtu+0x1ec>=0A=
    3c5c:	2402ffea 	li	v0,-22=0A=
=0A=
    } else if(new_mtu <=3D E1000_RXBUFFER_4096 - ENET_HEADER_SIZE - =
CRC_LENGTH) {=0A=
    3c60:	50400003 	beqzl	v0,3c70 <e1000_change_mtu+0x9c>=0A=
    3c64:	2a821fef 	slti	v0,s4,8175=0A=
        /* 4k buffers */=0A=
        adapter->rx_buffer_len =3D E1000_RXBUFFER_4096;=0A=
=0A=
    } else if(new_mtu <=3D E1000_RXBUFFER_8192 - ENET_HEADER_SIZE - =
CRC_LENGTH) {=0A=
    3c68:	08000f1f 	j	3c7c <e1000_change_mtu+0xa8>=0A=
    3c6c:	24021000 	li	v0,4096=0A=
    3c70:	50400002 	beqzl	v0,3c7c <e1000_change_mtu+0xa8>=0A=
    3c74:	24024000 	li	v0,16384=0A=
        /* 8k buffers */=0A=
        adapter->rx_buffer_len =3D E1000_RXBUFFER_8192;=0A=
=0A=
    } else {=0A=
    3c78:	24022000 	li	v0,8192=0A=
        /* 16k buffers */=0A=
        adapter->rx_buffer_len =3D E1000_RXBUFFER_16384;=0A=
    3c7c:	ae4200b8 	sw	v0,184(s2)=0A=
    }=0A=
=0A=
    if(old_mtu !=3D adapter->rx_buffer_len &&=0A=
    3c80:	8e4200b8 	lw	v0,184(s2)=0A=
    3c84:	1062004b 	beq	v1,v0,3db4 <e1000_change_mtu+0x1e0>=0A=
    3c88:	26820012 	addiu	v0,s4,18=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    3c8c:	8e42008c 	lw	v0,140(s2)=0A=
    3c90:	30420001 	andi	v0,v0,0x1=0A=
       test_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    3c94:	10400046 	beqz	v0,3db0 <e1000_change_mtu+0x1dc>=0A=
    3c98:	24100001 	li	s0,1=0A=
 * Atomically adds @i to @v.  Note that the guaranteed useful range=0A=
 * of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
    3c9c:	265100d8 	addiu	s1,s2,216=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3ca0:	c2220000 	ll	v0,0(s1)=0A=
    3ca4:	00501021 	addu	v0,v0,s0=0A=
    3ca8:	e2220000 	sc	v0,0(s1)=0A=
    3cac:	1040fffc 	beqz	v0,3ca0 <e1000_change_mtu+0xcc>=0A=
    3cb0:	00000000 	nop=0A=
 * restricted to acting on a single-word quantity.=0A=
 */=0A=
extern __inline__ void=0A=
set_bit(int nr, volatile void *addr)=0A=
{=0A=
    3cb4:	26b3002c 	addiu	s3,s5,44=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3cb8:	c2620000 	ll	v0,0(s3)=0A=
    3cbc:	34420001 	ori	v0,v0,0x1=0A=
    3cc0:	e2620000 	sc	v0,0(s3)=0A=
    3cc4:	1040fffc 	beqz	v0,3cb8 <e1000_change_mtu+0xe4>=0A=
    3cc8:	00000000 	nop=0A=
=0A=
        /* stop */=0A=
        tasklet_disable(&adapter->rx_fill_tasklet);=0A=
        netif_stop_queue(netdev);=0A=
        adapter->shared.adapter_stopped =3D 0;=0A=
        e1000_adapter_stop(&adapter->shared);=0A=
    3ccc:	26440008 	addiu	a0,s2,8=0A=
    3cd0:	3c020000 	lui	v0,0x0=0A=
    3cd4:	24420000 	addiu	v0,v0,0=0A=
    3cd8:	0040f809 	jalr	v0=0A=
    3cdc:	ae400064 	sw	zero,100(s2)=0A=
=0A=
        /* clean out old buffers */=0A=
        e1000_clean_rx_ring(adapter);=0A=
    3ce0:	3c020000 	lui	v0,0x0=0A=
    3ce4:	244228d8 	addiu	v0,v0,10456=0A=
    3ce8:	0040f809 	jalr	v0=0A=
    3cec:	02402021 	move	a0,s2=0A=
        e1000_clean_tx_ring(adapter);=0A=
    3cf0:	3c020000 	lui	v0,0x0=0A=
    3cf4:	24422720 	addiu	v0,v0,10016=0A=
    3cf8:	0040f809 	jalr	v0=0A=
    3cfc:	02402021 	move	a0,s2=0A=
=0A=
        /* reset hardware */=0A=
        adapter->shared.adapter_stopped =3D 0;=0A=
        e1000_hw_init(adapter);=0A=
    3d00:	02402021 	move	a0,s2=0A=
    3d04:	3c020000 	lui	v0,0x0=0A=
    3d08:	244217c4 	addiu	v0,v0,6084=0A=
    3d0c:	0040f809 	jalr	v0=0A=
    3d10:	ae400064 	sw	zero,100(s2)=0A=
=0A=
        /* go */=0A=
        e1000_setup_rctl(adapter);=0A=
    3d14:	3c020000 	lui	v0,0x0=0A=
    3d18:	24422308 	addiu	v0,v0,8968=0A=
    3d1c:	0040f809 	jalr	v0=0A=
    3d20:	02402021 	move	a0,s2=0A=
        e1000_configure_rx(adapter);=0A=
    3d24:	3c020000 	lui	v0,0x0=0A=
    3d28:	244223a8 	addiu	v0,v0,9128=0A=
    3d2c:	0040f809 	jalr	v0=0A=
    3d30:	02402021 	move	a0,s2=0A=
        e1000_configure_tx(adapter);=0A=
    3d34:	3c020000 	lui	v0,0x0=0A=
    3d38:	24421f60 	addiu	v0,v0,8032=0A=
    3d3c:	0040f809 	jalr	v0=0A=
    3d40:	02402021 	move	a0,s2=0A=
	smp_mb();=0A=
}=0A=
=0A=
static inline void tasklet_enable(struct tasklet_struct *t)=0A=
{=0A=
    3d44:	264500d0 	addiu	a1,s2,208=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3d48:	c2230000 	ll	v1,0(s1)=0A=
    3d4c:	00701823 	subu	v1,v1,s0=0A=
    3d50:	e2230000 	sc	v1,0(s1)=0A=
    3d54:	1060fffc 	beqz	v1,3d48 <e1000_change_mtu+0x174>=0A=
    3d58:	00000000 	nop=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3d5c:	c24400d4 	ll	a0,212(s2)=0A=
    3d60:	00901025 	or	v0,a0,s0=0A=
    3d64:	e24200d4 	sc	v0,212(s2)=0A=
    3d68:	1040fffc 	beqz	v0,3d5c <e1000_change_mtu+0x188>=0A=
    3d6c:	00901024 	and	v0,a0,s0=0A=
extern void FASTCALL(__tasklet_schedule(struct tasklet_struct *t));=0A=
=0A=
static inline void tasklet_schedule(struct tasklet_struct *t)=0A=
{=0A=
	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))=0A=
    3d70:	14400005 	bnez	v0,3d88 <e1000_change_mtu+0x1b4>=0A=
    3d74:	00000000 	nop=0A=
		__tasklet_schedule(t);=0A=
    3d78:	3c020000 	lui	v0,0x0=0A=
    3d7c:	24420000 	addiu	v0,v0,0=0A=
    3d80:	0040f809 	jalr	v0=0A=
    3d84:	00a02021 	move	a0,a1=0A=
#ifdef IANS=0A=
        /* restore VLAN settings */=0A=
        if((IANS_BD_TAGGING_MODE) =
(ANS_PRIVATE_DATA_FIELD(adapter)->tag_mode)=0A=
           !=3D IANS_BD_TAGGING_NONE)=0A=
            bd_ans_hw_EnableVLAN(adapter);=0A=
#endif=0A=
        tasklet_enable(&adapter->rx_fill_tasklet);=0A=
        tasklet_schedule(&adapter->rx_fill_tasklet);=0A=
        e1000_irq_enable(adapter);=0A=
    3d88:	3c020000 	lui	v0,0x0=0A=
    3d8c:	244274ac 	addiu	v0,v0,29868=0A=
    3d90:	0040f809 	jalr	v0=0A=
    3d94:	02402021 	move	a0,s2=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3d98:	c2630000 	ll	v1,0(s3)=0A=
    3d9c:	2401fffe 	li	at,-2=0A=
    3da0:	00611824 	and	v1,v1,at=0A=
    3da4:	e2630000 	sc	v1,0(s3)=0A=
    3da8:	1060fffb 	beqz	v1,3d98 <e1000_change_mtu+0x1c4>=0A=
    3dac:	00000000 	nop=0A=
        netif_start_queue(netdev);=0A=
    }=0A=
=0A=
    netdev->mtu =3D new_mtu;=0A=
    adapter->shared.max_frame_size =3D new_mtu + ENET_HEADER_SIZE + =
CRC_LENGTH;=0A=
    3db0:	26820012 	addiu	v0,s4,18=0A=
    3db4:	aeb4005c 	sw	s4,92(s5)=0A=
    3db8:	ae42003c 	sw	v0,60(s2)=0A=
=0A=
    return 0;=0A=
    3dbc:	00001021 	move	v0,zero=0A=
}=0A=
    3dc0:	8fbf0028 	lw	ra,40(sp)=0A=
    3dc4:	8fb50024 	lw	s5,36(sp)=0A=
    3dc8:	8fb40020 	lw	s4,32(sp)=0A=
    3dcc:	8fb3001c 	lw	s3,28(sp)=0A=
    3dd0:	8fb20018 	lw	s2,24(sp)=0A=
    3dd4:	8fb10014 	lw	s1,20(sp)=0A=
    3dd8:	8fb00010 	lw	s0,16(sp)=0A=
    3ddc:	03e00008 	jr	ra=0A=
    3de0:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
00003de4 <e1000_set_mac>:=0A=
    3de4:	27bdffd0 	addiu	sp,sp,-48=0A=
    3de8:	afb20018 	sw	s2,24(sp)=0A=
    3dec:	afb00010 	sw	s0,16(sp)=0A=
    3df0:	afbf0028 	sw	ra,40(sp)=0A=
    3df4:	afb50024 	sw	s5,36(sp)=0A=
    3df8:	afb40020 	sw	s4,32(sp)=0A=
    3dfc:	afb3001c 	sw	s3,28(sp)=0A=
    3e00:	afb10014 	sw	s1,20(sp)=0A=
    3e04:	00808021 	move	s0,a0=0A=
=0A=
/**=0A=
 * e1000_set_mac - Change the Ethernet Address of the NIC=0A=
 * @netdev: network interface device structure=0A=
 * @p: pointer to an address structure=0A=
 * =0A=
 * Returns 0 on success, negative on failure=0A=
 **/=0A=
=0A=
int=0A=
e1000_set_mac(struct net_device *netdev,=0A=
              void *p)=0A=
{=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    3e08:	8e130064 	lw	s3,100(s0)=0A=
    3e0c:	00a09021 	move	s2,a1=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    struct sockaddr *addr =3D (struct sockaddr *) p;=0A=
    3e10:	8e66000c 	lw	a2,12(s3)=0A=
    3e14:	8e75014c 	lw	s5,332(s3)=0A=
    3e18:	2cc20002 	sltiu	v0,a2,2=0A=
    3e1c:	00c04021 	move	t0,a2=0A=
    uint32_t pci_command;=0A=
    uint32_t rctl;=0A=
=0A=
    E1000_DBG("e1000_set_mac\n");=0A=
=0A=
    rctl =3D E1000_READ_REG(&adapter->shared, RCTL);=0A=
    3e20:	8e670008 	lw	a3,8(s3)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    3e24:	8ce50100 	lw	a1,256(a3)=0A=
	return __arch__swab32(x);=0A=
    3e28:	30a3ff00 	andi	v1,a1,0xff00=0A=
    3e2c:	00052600 	sll	a0,a1,0x18=0A=
    3e30:	00051202 	srl	v0,a1,0x8=0A=
    3e34:	00031a00 	sll	v1,v1,0x8=0A=
    3e38:	00832025 	or	a0,a0,v1=0A=
    3e3c:	3042ff00 	andi	v0,v0,0xff00=0A=
    3e40:	00822025 	or	a0,a0,v0=0A=
    3e44:	00052e02 	srl	a1,a1,0x18=0A=
=0A=
    if(adapter->shared.mac_type =3D=3D e1000_82542_rev2_0) {=0A=
    3e48:	15000031 	bnez	t0,3f10 <e1000_set_mac+0x12c>=0A=
    3e4c:	0085a025 	or	s4,a0,a1=0A=
        if(adapter->shared.pci_cmd_word & PCI_COMMAND_INVALIDATE) {=0A=
    3e50:	9662004a 	lhu	v0,74(s3)=0A=
    3e54:	30420010 	andi	v0,v0,0x10=0A=
    3e58:	10400009 	beqz	v0,3e80 <e1000_set_mac+0x9c>=0A=
    3e5c:	02a02021 	move	a0,s5=0A=
            pci_command =3D=0A=
    3e60:	9666004a 	lhu	a2,74(s3)=0A=
                adapter->shared.pci_cmd_word & ~PCI_COMMAND_INVALIDATE;=0A=
            pci_write_config_word(pdev, PCI_COMMAND, pci_command);=0A=
    3e64:	24050004 	li	a1,4=0A=
    3e68:	3c020000 	lui	v0,0x0=0A=
    3e6c:	24420000 	addiu	v0,v0,0=0A=
    3e70:	0040f809 	jalr	v0=0A=
    3e74:	30c6ffef 	andi	a2,a2,0xffef=0A=
    3e78:	8e66000c 	lw	a2,12(s3)=0A=
    3e7c:	8e670008 	lw	a3,8(s3)=0A=
        }=0A=
    3e80:	2cc20002 	sltiu	v0,a2,2=0A=
        E1000_WRITE_REG(&adapter->shared, RCTL, rctl | E1000_RCTL_RST);=0A=
    3e84:	36850001 	ori	a1,s4,0x1=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3e88:	30a4ff00 	andi	a0,a1,0xff00=0A=
    3e8c:	00051600 	sll	v0,a1,0x18=0A=
    3e90:	00051a02 	srl	v1,a1,0x8=0A=
    3e94:	00042200 	sll	a0,a0,0x8=0A=
    3e98:	00441025 	or	v0,v0,a0=0A=
    3e9c:	3063ff00 	andi	v1,v1,0xff00=0A=
    3ea0:	00431025 	or	v0,v0,v1=0A=
    3ea4:	00052e02 	srl	a1,a1,0x18=0A=
    3ea8:	00451025 	or	v0,v0,a1=0A=
    3eac:	ace20100 	sw	v0,256(a3)=0A=
extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)=0A=
{=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
    3eb0:	3c027fff 	lui	v0,0x7fff=0A=
    3eb4:	3c030000 	lui	v1,0x0=0A=
    3eb8:	8c630000 	lw	v1,0(v1)=0A=
    3ebc:	3442f1c0 	ori	v0,v0,0xf1c0=0A=
	__asm__("multu\t%2,%3"=0A=
    3ec0:	00430019 	multu	v0,v1=0A=
    3ec4:	00001010 	mfhi	v0=0A=
	...=0A=
    3ed0:	1440ffff 	bnez	v0,3ed0 <e1000_set_mac+0xec>=0A=
    3ed4:	2442ffff 	addiu	v0,v0,-1=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    3ed8:	8e63008c 	lw	v1,140(s3)=0A=
    3edc:	30630001 	andi	v1,v1,0x1=0A=
        mdelay(5);=0A=
        if(test_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    3ee0:	1060000b 	beqz	v1,3f10 <e1000_set_mac+0x12c>=0A=
    3ee4:	24030001 	li	v1,1=0A=
 * Atomically adds @i to @v.  Note that the guaranteed useful range=0A=
 * of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
    3ee8:	266200d8 	addiu	v0,s3,216=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    3eec:	c0440000 	ll	a0,0(v0)=0A=
    3ef0:	00832021 	addu	a0,a0,v1=0A=
    3ef4:	e0440000 	sc	a0,0(v0)=0A=
    3ef8:	1080fffc 	beqz	a0,3eec <e1000_set_mac+0x108>=0A=
    3efc:	00000000 	nop=0A=
            tasklet_disable(&adapter->rx_fill_tasklet);=0A=
            e1000_clean_rx_ring(adapter);=0A=
    3f00:	3c020000 	lui	v0,0x0=0A=
    3f04:	244228d8 	addiu	v0,v0,10456=0A=
    3f08:	0040f809 	jalr	v0=0A=
    3f0c:	02602021 	move	a0,s3=0A=
        }=0A=
    }=0A=
=0A=
    memcpy(netdev->dev_addr, addr->sa_data, netdev->addr_len);=0A=
    3f10:	9206007c 	lbu	a2,124(s0)=0A=
    3f14:	26520002 	addiu	s2,s2,2=0A=
    3f18:	26040074 	addiu	a0,s0,116=0A=
    3f1c:	3c110000 	lui	s1,0x0=0A=
    3f20:	26310000 	addiu	s1,s1,0=0A=
    3f24:	0220f809 	jalr	s1=0A=
    3f28:	02402821 	move	a1,s2=0A=
    memcpy(adapter->shared.mac_addr, addr->sa_data, netdev->addr_len);=0A=
    3f2c:	9206007c 	lbu	a2,124(s0)=0A=
    3f30:	2670007d 	addiu	s0,s3,125=0A=
    3f34:	02402821 	move	a1,s2=0A=
    3f38:	02002021 	move	a0,s0=0A=
    3f3c:	0220f809 	jalr	s1=0A=
    3f40:	26720008 	addiu	s2,s3,8=0A=
=0A=
    e1000_rar_set(&adapter->shared, adapter->shared.mac_addr, 0);=0A=
    3f44:	02002821 	move	a1,s0=0A=
    3f48:	02402021 	move	a0,s2=0A=
    3f4c:	3c020000 	lui	v0,0x0=0A=
    3f50:	24420000 	addiu	v0,v0,0=0A=
    3f54:	0040f809 	jalr	v0=0A=
    3f58:	00003021 	move	a2,zero=0A=
=0A=
    if(adapter->shared.mac_type =3D=3D e1000_82542_rev2_0) {=0A=
    3f5c:	8e63000c 	lw	v1,12(s3)=0A=
    3f60:	1460002f 	bnez	v1,4020 <e1000_set_mac+0x23c>=0A=
    3f64:	8fbf0028 	lw	ra,40(sp)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3f68:	3282ff00 	andi	v0,s4,0xff00=0A=
    3f6c:	00021200 	sll	v0,v0,0x8=0A=
    3f70:	00141e00 	sll	v1,s4,0x18=0A=
    3f74:	00142202 	srl	a0,s4,0x8=0A=
    3f78:	00621825 	or	v1,v1,v0=0A=
        E1000_WRITE_REG(&adapter->shared, RCTL, rctl);=0A=
    3f7c:	8e450000 	lw	a1,0(s2)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    3f80:	3084ff00 	andi	a0,a0,0xff00=0A=
    3f84:	00141602 	srl	v0,s4,0x18=0A=
    3f88:	00641825 	or	v1,v1,a0=0A=
    3f8c:	00621825 	or	v1,v1,v0=0A=
    3f90:	aca30100 	sw	v1,256(a1)=0A=
extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)=0A=
{=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
    3f94:	3c027fff 	lui	v0,0x7fff=0A=
    3f98:	3c030000 	lui	v1,0x0=0A=
    3f9c:	8c630000 	lw	v1,0(v1)=0A=
    3fa0:	3442f1c0 	ori	v0,v0,0xf1c0=0A=
	__asm__("multu\t%2,%3"=0A=
    3fa4:	00430019 	multu	v0,v1=0A=
    3fa8:	00001010 	mfhi	v0=0A=
	...=0A=
    3fb4:	1440ffff 	bnez	v0,3fb4 <e1000_set_mac+0x1d0>=0A=
    3fb8:	2442ffff 	addiu	v0,v0,-1=0A=
        mdelay(5);=0A=
        if(adapter->shared.pci_cmd_word & PCI_COMMAND_INVALIDATE) {=0A=
    3fbc:	9663004a 	lhu	v1,74(s3)=0A=
    3fc0:	30630010 	andi	v1,v1,0x10=0A=
    3fc4:	10600006 	beqz	v1,3fe0 <e1000_set_mac+0x1fc>=0A=
    3fc8:	02a02021 	move	a0,s5=0A=
            pci_write_config_word(pdev, PCI_COMMAND,=0A=
    3fcc:	9666004a 	lhu	a2,74(s3)=0A=
    3fd0:	3c020000 	lui	v0,0x0=0A=
    3fd4:	24420000 	addiu	v0,v0,0=0A=
    3fd8:	0040f809 	jalr	v0=0A=
    3fdc:	24050004 	li	a1,4=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    3fe0:	8e62008c 	lw	v0,140(s3)=0A=
    3fe4:	30420001 	andi	v0,v0,0x1=0A=
                                  adapter->shared.pci_cmd_word);=0A=
        }=0A=
        if(test_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    3fe8:	1040000d 	beqz	v0,4020 <e1000_set_mac+0x23c>=0A=
    3fec:	8fbf0028 	lw	ra,40(sp)=0A=
            e1000_configure_rx(adapter);=0A=
    3ff0:	3c020000 	lui	v0,0x0=0A=
    3ff4:	244223a8 	addiu	v0,v0,9128=0A=
    3ff8:	0040f809 	jalr	v0=0A=
    3ffc:	02602021 	move	a0,s3=0A=
 * Atomically subtracts @i from @v.  Note that the guaranteed=0A=
 * useful range of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
    4000:	266300d8 	addiu	v1,s3,216=0A=
    4004:	24020001 	li	v0,1=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    4008:	c0640000 	ll	a0,0(v1)=0A=
    400c:	00822023 	subu	a0,a0,v0=0A=
    4010:	e0640000 	sc	a0,0(v1)=0A=
    4014:	1080fffc 	beqz	a0,4008 <e1000_set_mac+0x224>=0A=
    4018:	00000000 	nop=0A=
            tasklet_enable(&adapter->rx_fill_tasklet);=0A=
        }=0A=
    }=0A=
=0A=
    return 0;=0A=
    401c:	8fbf0028 	lw	ra,40(sp)=0A=
    4020:	8fb50024 	lw	s5,36(sp)=0A=
    4024:	8fb40020 	lw	s4,32(sp)=0A=
    4028:	8fb3001c 	lw	s3,28(sp)=0A=
    402c:	8fb20018 	lw	s2,24(sp)=0A=
    4030:	8fb10014 	lw	s1,20(sp)=0A=
    4034:	8fb00010 	lw	s0,16(sp)=0A=
    4038:	00001021 	move	v0,zero=0A=
    403c:	03e00008 	jr	ra=0A=
    4040:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
00004044 <e1000_update_stats>:=0A=
    4044:	27bdffd8 	addiu	sp,sp,-40=0A=
    4048:	afb3001c 	sw	s3,28(sp)=0A=
    404c:	afbf0024 	sw	ra,36(sp)=0A=
    4050:	afb40020 	sw	s4,32(sp)=0A=
    4054:	afb20018 	sw	s2,24(sp)=0A=
    4058:	afb10014 	sw	s1,20(sp)=0A=
    405c:	afb00010 	sw	s0,16(sp)=0A=
    4060:	00809821 	move	s3,a0=0A=
}=0A=
=0A=
/**=0A=
 * e1000_update_stats - Update the board statistics counters=0A=
 * @adapter: board private structure=0A=
 **/=0A=
=0A=
static void=0A=
e1000_update_stats(struct e1000_adapter *adapter)=0A=
{=0A=
    unsigned long flags;=0A=
=0A=
#define PHY_IDLE_ERROR_COUNT_MASK 0x00FF=0A=
=0A=
    spin_lock_irqsave(&adapter->stats_lock, flags);=0A=
    4064:	40146000 	mfc0	s4,$12=0A=
    4068:	00000000 	nop=0A=
    406c:	36810001 	ori	at,s4,0x1=0A=
    4070:	38210001 	xori	at,at,0x1=0A=
    4074:	40816000 	mtc0	at,$12=0A=
    4078:	00000040 	sll	zero,zero,0x1=0A=
    407c:	00000040 	sll	zero,zero,0x1=0A=
    4080:	00000040 	sll	zero,zero,0x1=0A=
    4084:	8e6801d8 	lw	t0,472(s3)=0A=
    4088:	8e6901dc 	lw	t1,476(s3)=0A=
    408c:	8e62000c 	lw	v0,12(s3)=0A=
    4090:	2c420002 	sltiu	v0,v0,2=0A=
=0A=
    adapter->stats.crcerrs +=3D E1000_READ_REG(&adapter->shared, =
CRCERRS);=0A=
    4094:	8e640008 	lw	a0,8(s3)=0A=
    4098:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    409c:	8c874000 	lw	a3,16384(a0)=0A=
	return __arch__swab32(x);=0A=
    40a0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    40a4:	00073600 	sll	a2,a3,0x18=0A=
    40a8:	00072202 	srl	a0,a3,0x8=0A=
    40ac:	00052a00 	sll	a1,a1,0x8=0A=
    40b0:	3084ff00 	andi	a0,a0,0xff00=0A=
    40b4:	00c53025 	or	a2,a2,a1=0A=
    40b8:	00c43025 	or	a2,a2,a0=0A=
    40bc:	00073e02 	srl	a3,a3,0x18=0A=
    40c0:	00c71825 	or	v1,a2,a3=0A=
    40c4:	01233821 	addu	a3,t1,v1=0A=
    40c8:	00e3202b 	sltu	a0,a3,v1=0A=
    40cc:	01023021 	addu	a2,t0,v0=0A=
    40d0:	00c43021 	addu	a2,a2,a0=0A=
    40d4:	8e62000c 	lw	v0,12(s3)=0A=
    40d8:	ae6601d8 	sw	a2,472(s3)=0A=
    40dc:	ae6701dc 	sw	a3,476(s3)=0A=
    40e0:	8e6801e8 	lw	t0,488(s3)=0A=
    40e4:	8e6901ec 	lw	t1,492(s3)=0A=
    40e8:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.symerrs +=3D E1000_READ_REG(&adapter->shared, =
SYMERRS);=0A=
    40ec:	8e640008 	lw	a0,8(s3)=0A=
    40f0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    40f4:	8c874008 	lw	a3,16392(a0)=0A=
	return __arch__swab32(x);=0A=
    40f8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    40fc:	00073600 	sll	a2,a3,0x18=0A=
    4100:	00072202 	srl	a0,a3,0x8=0A=
    4104:	00052a00 	sll	a1,a1,0x8=0A=
    4108:	3084ff00 	andi	a0,a0,0xff00=0A=
    410c:	00c53025 	or	a2,a2,a1=0A=
    4110:	00c43025 	or	a2,a2,a0=0A=
    4114:	00073e02 	srl	a3,a3,0x18=0A=
    4118:	00c71825 	or	v1,a2,a3=0A=
    411c:	01233821 	addu	a3,t1,v1=0A=
    4120:	00e3202b 	sltu	a0,a3,v1=0A=
    4124:	01023021 	addu	a2,t0,v0=0A=
    4128:	00c43021 	addu	a2,a2,a0=0A=
    412c:	8e62000c 	lw	v0,12(s3)=0A=
    4130:	ae6601e8 	sw	a2,488(s3)=0A=
    4134:	ae6701ec 	sw	a3,492(s3)=0A=
    4138:	8e6801f8 	lw	t0,504(s3)=0A=
    413c:	8e6901fc 	lw	t1,508(s3)=0A=
    4140:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.mpc +=3D E1000_READ_REG(&adapter->shared, MPC);=0A=
    4144:	8e640008 	lw	a0,8(s3)=0A=
    4148:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    414c:	8c874010 	lw	a3,16400(a0)=0A=
	return __arch__swab32(x);=0A=
    4150:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4154:	00073600 	sll	a2,a3,0x18=0A=
    4158:	00072202 	srl	a0,a3,0x8=0A=
    415c:	00052a00 	sll	a1,a1,0x8=0A=
    4160:	3084ff00 	andi	a0,a0,0xff00=0A=
    4164:	00c53025 	or	a2,a2,a1=0A=
    4168:	00c43025 	or	a2,a2,a0=0A=
    416c:	00073e02 	srl	a3,a3,0x18=0A=
    4170:	00c71825 	or	v1,a2,a3=0A=
    4174:	01233821 	addu	a3,t1,v1=0A=
    4178:	00e3202b 	sltu	a0,a3,v1=0A=
    417c:	01023021 	addu	a2,t0,v0=0A=
    4180:	00c43021 	addu	a2,a2,a0=0A=
    4184:	8e62000c 	lw	v0,12(s3)=0A=
    4188:	ae6601f8 	sw	a2,504(s3)=0A=
    418c:	ae6701fc 	sw	a3,508(s3)=0A=
    4190:	8e680200 	lw	t0,512(s3)=0A=
    4194:	8e690204 	lw	t1,516(s3)=0A=
    4198:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.scc +=3D E1000_READ_REG(&adapter->shared, SCC);=0A=
    419c:	8e640008 	lw	a0,8(s3)=0A=
    41a0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    41a4:	8c874014 	lw	a3,16404(a0)=0A=
	return __arch__swab32(x);=0A=
    41a8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    41ac:	00073600 	sll	a2,a3,0x18=0A=
    41b0:	00072202 	srl	a0,a3,0x8=0A=
    41b4:	00052a00 	sll	a1,a1,0x8=0A=
    41b8:	3084ff00 	andi	a0,a0,0xff00=0A=
    41bc:	00c53025 	or	a2,a2,a1=0A=
    41c0:	00c43025 	or	a2,a2,a0=0A=
    41c4:	00073e02 	srl	a3,a3,0x18=0A=
    41c8:	00c71825 	or	v1,a2,a3=0A=
    41cc:	01233821 	addu	a3,t1,v1=0A=
    41d0:	00e3202b 	sltu	a0,a3,v1=0A=
    41d4:	01023021 	addu	a2,t0,v0=0A=
    41d8:	00c43021 	addu	a2,a2,a0=0A=
    41dc:	8e62000c 	lw	v0,12(s3)=0A=
    41e0:	ae660200 	sw	a2,512(s3)=0A=
    41e4:	ae670204 	sw	a3,516(s3)=0A=
    41e8:	8e680208 	lw	t0,520(s3)=0A=
    41ec:	8e69020c 	lw	t1,524(s3)=0A=
    41f0:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.ecol +=3D E1000_READ_REG(&adapter->shared, ECOL);=0A=
    41f4:	8e640008 	lw	a0,8(s3)=0A=
    41f8:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    41fc:	8c874018 	lw	a3,16408(a0)=0A=
	return __arch__swab32(x);=0A=
    4200:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4204:	00073600 	sll	a2,a3,0x18=0A=
    4208:	00072202 	srl	a0,a3,0x8=0A=
    420c:	00052a00 	sll	a1,a1,0x8=0A=
    4210:	3084ff00 	andi	a0,a0,0xff00=0A=
    4214:	00c53025 	or	a2,a2,a1=0A=
    4218:	00c43025 	or	a2,a2,a0=0A=
    421c:	00073e02 	srl	a3,a3,0x18=0A=
    4220:	00c71825 	or	v1,a2,a3=0A=
    4224:	01233821 	addu	a3,t1,v1=0A=
    4228:	00e3202b 	sltu	a0,a3,v1=0A=
    422c:	01023021 	addu	a2,t0,v0=0A=
    4230:	00c43021 	addu	a2,a2,a0=0A=
    4234:	8e62000c 	lw	v0,12(s3)=0A=
    4238:	ae660208 	sw	a2,520(s3)=0A=
    423c:	ae67020c 	sw	a3,524(s3)=0A=
    4240:	8e680210 	lw	t0,528(s3)=0A=
    4244:	8e690214 	lw	t1,532(s3)=0A=
    4248:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.mcc +=3D E1000_READ_REG(&adapter->shared, MCC);=0A=
    424c:	8e640008 	lw	a0,8(s3)=0A=
    4250:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4254:	8c87401c 	lw	a3,16412(a0)=0A=
	return __arch__swab32(x);=0A=
    4258:	30e5ff00 	andi	a1,a3,0xff00=0A=
    425c:	00073600 	sll	a2,a3,0x18=0A=
    4260:	00072202 	srl	a0,a3,0x8=0A=
    4264:	00052a00 	sll	a1,a1,0x8=0A=
    4268:	3084ff00 	andi	a0,a0,0xff00=0A=
    426c:	00c53025 	or	a2,a2,a1=0A=
    4270:	00c43025 	or	a2,a2,a0=0A=
    4274:	00073e02 	srl	a3,a3,0x18=0A=
    4278:	00c71825 	or	v1,a2,a3=0A=
    427c:	01233821 	addu	a3,t1,v1=0A=
    4280:	00e3202b 	sltu	a0,a3,v1=0A=
    4284:	01023021 	addu	a2,t0,v0=0A=
    4288:	00c43021 	addu	a2,a2,a0=0A=
    428c:	8e62000c 	lw	v0,12(s3)=0A=
    4290:	ae660210 	sw	a2,528(s3)=0A=
    4294:	ae670214 	sw	a3,532(s3)=0A=
    4298:	8e680218 	lw	t0,536(s3)=0A=
    429c:	8e69021c 	lw	t1,540(s3)=0A=
    42a0:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.latecol +=3D E1000_READ_REG(&adapter->shared, =
LATECOL);=0A=
    42a4:	8e640008 	lw	a0,8(s3)=0A=
    42a8:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    42ac:	8c874020 	lw	a3,16416(a0)=0A=
	return __arch__swab32(x);=0A=
    42b0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    42b4:	00073600 	sll	a2,a3,0x18=0A=
    42b8:	00072202 	srl	a0,a3,0x8=0A=
    42bc:	00052a00 	sll	a1,a1,0x8=0A=
    42c0:	3084ff00 	andi	a0,a0,0xff00=0A=
    42c4:	00c53025 	or	a2,a2,a1=0A=
    42c8:	00c43025 	or	a2,a2,a0=0A=
    42cc:	00073e02 	srl	a3,a3,0x18=0A=
    42d0:	00c71825 	or	v1,a2,a3=0A=
    42d4:	01233821 	addu	a3,t1,v1=0A=
    42d8:	00e3202b 	sltu	a0,a3,v1=0A=
    42dc:	01023021 	addu	a2,t0,v0=0A=
    42e0:	00c43021 	addu	a2,a2,a0=0A=
    42e4:	8e62000c 	lw	v0,12(s3)=0A=
    42e8:	ae660218 	sw	a2,536(s3)=0A=
    42ec:	ae67021c 	sw	a3,540(s3)=0A=
    42f0:	8e680220 	lw	t0,544(s3)=0A=
    42f4:	8e690224 	lw	t1,548(s3)=0A=
    42f8:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.colc +=3D E1000_READ_REG(&adapter->shared, COLC);=0A=
    42fc:	8e640008 	lw	a0,8(s3)=0A=
    4300:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4304:	8c874028 	lw	a3,16424(a0)=0A=
	return __arch__swab32(x);=0A=
    4308:	30e5ff00 	andi	a1,a3,0xff00=0A=
    430c:	00073600 	sll	a2,a3,0x18=0A=
    4310:	00072202 	srl	a0,a3,0x8=0A=
    4314:	00052a00 	sll	a1,a1,0x8=0A=
    4318:	3084ff00 	andi	a0,a0,0xff00=0A=
    431c:	00c53025 	or	a2,a2,a1=0A=
    4320:	00c43025 	or	a2,a2,a0=0A=
    4324:	00073e02 	srl	a3,a3,0x18=0A=
    4328:	00c71825 	or	v1,a2,a3=0A=
    432c:	01233821 	addu	a3,t1,v1=0A=
    4330:	00e3202b 	sltu	a0,a3,v1=0A=
    4334:	01023021 	addu	a2,t0,v0=0A=
    4338:	00c43021 	addu	a2,a2,a0=0A=
    433c:	8e62000c 	lw	v0,12(s3)=0A=
    4340:	ae660220 	sw	a2,544(s3)=0A=
    4344:	ae670224 	sw	a3,548(s3)=0A=
    4348:	8e680228 	lw	t0,552(s3)=0A=
    434c:	8e69022c 	lw	t1,556(s3)=0A=
    4350:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.dc +=3D E1000_READ_REG(&adapter->shared, DC);=0A=
    4354:	8e640008 	lw	a0,8(s3)=0A=
    4358:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    435c:	8c874030 	lw	a3,16432(a0)=0A=
	return __arch__swab32(x);=0A=
    4360:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4364:	00073600 	sll	a2,a3,0x18=0A=
    4368:	00072202 	srl	a0,a3,0x8=0A=
    436c:	00052a00 	sll	a1,a1,0x8=0A=
    4370:	3084ff00 	andi	a0,a0,0xff00=0A=
    4374:	00c53025 	or	a2,a2,a1=0A=
    4378:	00c43025 	or	a2,a2,a0=0A=
    437c:	00073e02 	srl	a3,a3,0x18=0A=
    4380:	00c71825 	or	v1,a2,a3=0A=
    4384:	01233821 	addu	a3,t1,v1=0A=
    4388:	00e3202b 	sltu	a0,a3,v1=0A=
    438c:	01023021 	addu	a2,t0,v0=0A=
    4390:	00c43021 	addu	a2,a2,a0=0A=
    4394:	8e62000c 	lw	v0,12(s3)=0A=
    4398:	ae660228 	sw	a2,552(s3)=0A=
    439c:	ae67022c 	sw	a3,556(s3)=0A=
    43a0:	8e680238 	lw	t0,568(s3)=0A=
    43a4:	8e69023c 	lw	t1,572(s3)=0A=
    43a8:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.sec +=3D E1000_READ_REG(&adapter->shared, SEC);=0A=
    43ac:	8e640008 	lw	a0,8(s3)=0A=
    43b0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    43b4:	8c874038 	lw	a3,16440(a0)=0A=
	return __arch__swab32(x);=0A=
    43b8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    43bc:	00073600 	sll	a2,a3,0x18=0A=
    43c0:	00072202 	srl	a0,a3,0x8=0A=
    43c4:	00052a00 	sll	a1,a1,0x8=0A=
    43c8:	3084ff00 	andi	a0,a0,0xff00=0A=
    43cc:	00c53025 	or	a2,a2,a1=0A=
    43d0:	00c43025 	or	a2,a2,a0=0A=
    43d4:	00073e02 	srl	a3,a3,0x18=0A=
    43d8:	00c71825 	or	v1,a2,a3=0A=
    43dc:	01233821 	addu	a3,t1,v1=0A=
    43e0:	00e3202b 	sltu	a0,a3,v1=0A=
    43e4:	01023021 	addu	a2,t0,v0=0A=
    43e8:	00c43021 	addu	a2,a2,a0=0A=
    43ec:	8e62000c 	lw	v0,12(s3)=0A=
    43f0:	ae660238 	sw	a2,568(s3)=0A=
    43f4:	ae67023c 	sw	a3,572(s3)=0A=
    43f8:	8e680248 	lw	t0,584(s3)=0A=
    43fc:	8e69024c 	lw	t1,588(s3)=0A=
    4400:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.rlec +=3D E1000_READ_REG(&adapter->shared, RLEC);=0A=
    4404:	8e640008 	lw	a0,8(s3)=0A=
    4408:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    440c:	8c874040 	lw	a3,16448(a0)=0A=
	return __arch__swab32(x);=0A=
    4410:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4414:	00073600 	sll	a2,a3,0x18=0A=
    4418:	00072202 	srl	a0,a3,0x8=0A=
    441c:	00052a00 	sll	a1,a1,0x8=0A=
    4420:	3084ff00 	andi	a0,a0,0xff00=0A=
    4424:	00c53025 	or	a2,a2,a1=0A=
    4428:	00c43025 	or	a2,a2,a0=0A=
    442c:	00073e02 	srl	a3,a3,0x18=0A=
    4430:	00c71825 	or	v1,a2,a3=0A=
    4434:	01233821 	addu	a3,t1,v1=0A=
    4438:	00e3202b 	sltu	a0,a3,v1=0A=
    443c:	01023021 	addu	a2,t0,v0=0A=
    4440:	00c43021 	addu	a2,a2,a0=0A=
    4444:	8e62000c 	lw	v0,12(s3)=0A=
    4448:	ae660248 	sw	a2,584(s3)=0A=
    444c:	ae67024c 	sw	a3,588(s3)=0A=
    4450:	8e680250 	lw	t0,592(s3)=0A=
    4454:	8e690254 	lw	t1,596(s3)=0A=
    4458:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.xonrxc +=3D E1000_READ_REG(&adapter->shared, XONRXC);=0A=
    445c:	8e640008 	lw	a0,8(s3)=0A=
    4460:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4464:	8c874048 	lw	a3,16456(a0)=0A=
	return __arch__swab32(x);=0A=
    4468:	30e5ff00 	andi	a1,a3,0xff00=0A=
    446c:	00073600 	sll	a2,a3,0x18=0A=
    4470:	00072202 	srl	a0,a3,0x8=0A=
    4474:	00052a00 	sll	a1,a1,0x8=0A=
    4478:	3084ff00 	andi	a0,a0,0xff00=0A=
    447c:	00c53025 	or	a2,a2,a1=0A=
    4480:	00c43025 	or	a2,a2,a0=0A=
    4484:	00073e02 	srl	a3,a3,0x18=0A=
    4488:	00c71825 	or	v1,a2,a3=0A=
    448c:	01233821 	addu	a3,t1,v1=0A=
    4490:	00e3202b 	sltu	a0,a3,v1=0A=
    4494:	01023021 	addu	a2,t0,v0=0A=
    4498:	00c43021 	addu	a2,a2,a0=0A=
    449c:	8e62000c 	lw	v0,12(s3)=0A=
    44a0:	ae660250 	sw	a2,592(s3)=0A=
    44a4:	ae670254 	sw	a3,596(s3)=0A=
    44a8:	8e680258 	lw	t0,600(s3)=0A=
    44ac:	8e69025c 	lw	t1,604(s3)=0A=
    44b0:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.xontxc +=3D E1000_READ_REG(&adapter->shared, XONTXC);=0A=
    44b4:	8e640008 	lw	a0,8(s3)=0A=
    44b8:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    44bc:	8c87404c 	lw	a3,16460(a0)=0A=
	return __arch__swab32(x);=0A=
    44c0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    44c4:	00073600 	sll	a2,a3,0x18=0A=
    44c8:	00072202 	srl	a0,a3,0x8=0A=
    44cc:	00052a00 	sll	a1,a1,0x8=0A=
    44d0:	3084ff00 	andi	a0,a0,0xff00=0A=
    44d4:	00c53025 	or	a2,a2,a1=0A=
    44d8:	00c43025 	or	a2,a2,a0=0A=
    44dc:	00073e02 	srl	a3,a3,0x18=0A=
    44e0:	00c71825 	or	v1,a2,a3=0A=
    44e4:	01233821 	addu	a3,t1,v1=0A=
    44e8:	00e3202b 	sltu	a0,a3,v1=0A=
    44ec:	01023021 	addu	a2,t0,v0=0A=
    44f0:	00c43021 	addu	a2,a2,a0=0A=
    44f4:	8e62000c 	lw	v0,12(s3)=0A=
    44f8:	ae660258 	sw	a2,600(s3)=0A=
    44fc:	ae67025c 	sw	a3,604(s3)=0A=
    4500:	8e680260 	lw	t0,608(s3)=0A=
    4504:	8e690264 	lw	t1,612(s3)=0A=
    4508:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.xoffrxc +=3D E1000_READ_REG(&adapter->shared, =
XOFFRXC);=0A=
    450c:	8e640008 	lw	a0,8(s3)=0A=
    4510:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4514:	8c874050 	lw	a3,16464(a0)=0A=
	return __arch__swab32(x);=0A=
    4518:	30e5ff00 	andi	a1,a3,0xff00=0A=
    451c:	00073600 	sll	a2,a3,0x18=0A=
    4520:	00072202 	srl	a0,a3,0x8=0A=
    4524:	00052a00 	sll	a1,a1,0x8=0A=
    4528:	3084ff00 	andi	a0,a0,0xff00=0A=
    452c:	00c53025 	or	a2,a2,a1=0A=
    4530:	00c43025 	or	a2,a2,a0=0A=
    4534:	00073e02 	srl	a3,a3,0x18=0A=
    4538:	00c71825 	or	v1,a2,a3=0A=
    453c:	01233821 	addu	a3,t1,v1=0A=
    4540:	00e3202b 	sltu	a0,a3,v1=0A=
    4544:	01023021 	addu	a2,t0,v0=0A=
    4548:	00c43021 	addu	a2,a2,a0=0A=
    454c:	8e62000c 	lw	v0,12(s3)=0A=
    4550:	ae660260 	sw	a2,608(s3)=0A=
    4554:	ae670264 	sw	a3,612(s3)=0A=
    4558:	8e680268 	lw	t0,616(s3)=0A=
    455c:	8e69026c 	lw	t1,620(s3)=0A=
    4560:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.xofftxc +=3D E1000_READ_REG(&adapter->shared, =
XOFFTXC);=0A=
    4564:	8e640008 	lw	a0,8(s3)=0A=
    4568:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    456c:	8c874054 	lw	a3,16468(a0)=0A=
	return __arch__swab32(x);=0A=
    4570:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4574:	00073600 	sll	a2,a3,0x18=0A=
    4578:	00072202 	srl	a0,a3,0x8=0A=
    457c:	00052a00 	sll	a1,a1,0x8=0A=
    4580:	3084ff00 	andi	a0,a0,0xff00=0A=
    4584:	00c53025 	or	a2,a2,a1=0A=
    4588:	00c43025 	or	a2,a2,a0=0A=
    458c:	00073e02 	srl	a3,a3,0x18=0A=
    4590:	00c71825 	or	v1,a2,a3=0A=
    4594:	01233821 	addu	a3,t1,v1=0A=
    4598:	00e3202b 	sltu	a0,a3,v1=0A=
    459c:	01023021 	addu	a2,t0,v0=0A=
    45a0:	00c43021 	addu	a2,a2,a0=0A=
    45a4:	8e62000c 	lw	v0,12(s3)=0A=
    45a8:	ae660268 	sw	a2,616(s3)=0A=
    45ac:	ae67026c 	sw	a3,620(s3)=0A=
    45b0:	8e680270 	lw	t0,624(s3)=0A=
    45b4:	8e690274 	lw	t1,628(s3)=0A=
    45b8:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.fcruc +=3D E1000_READ_REG(&adapter->shared, FCRUC);=0A=
    45bc:	8e640008 	lw	a0,8(s3)=0A=
    45c0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    45c4:	8c874058 	lw	a3,16472(a0)=0A=
	return __arch__swab32(x);=0A=
    45c8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    45cc:	00073600 	sll	a2,a3,0x18=0A=
    45d0:	00072202 	srl	a0,a3,0x8=0A=
    45d4:	00052a00 	sll	a1,a1,0x8=0A=
    45d8:	3084ff00 	andi	a0,a0,0xff00=0A=
    45dc:	00c53025 	or	a2,a2,a1=0A=
    45e0:	00c43025 	or	a2,a2,a0=0A=
    45e4:	00073e02 	srl	a3,a3,0x18=0A=
    45e8:	00c71825 	or	v1,a2,a3=0A=
    45ec:	01233821 	addu	a3,t1,v1=0A=
    45f0:	00e3202b 	sltu	a0,a3,v1=0A=
    45f4:	01023021 	addu	a2,t0,v0=0A=
    45f8:	00c43021 	addu	a2,a2,a0=0A=
    45fc:	8e62000c 	lw	v0,12(s3)=0A=
    4600:	ae660270 	sw	a2,624(s3)=0A=
    4604:	ae670274 	sw	a3,628(s3)=0A=
    4608:	8e680278 	lw	t0,632(s3)=0A=
    460c:	8e69027c 	lw	t1,636(s3)=0A=
    4610:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.prc64 +=3D E1000_READ_REG(&adapter->shared, PRC64);=0A=
    4614:	8e640008 	lw	a0,8(s3)=0A=
    4618:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    461c:	8c87405c 	lw	a3,16476(a0)=0A=
	return __arch__swab32(x);=0A=
    4620:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4624:	00073600 	sll	a2,a3,0x18=0A=
    4628:	00072202 	srl	a0,a3,0x8=0A=
    462c:	00052a00 	sll	a1,a1,0x8=0A=
    4630:	3084ff00 	andi	a0,a0,0xff00=0A=
    4634:	00c53025 	or	a2,a2,a1=0A=
    4638:	00c43025 	or	a2,a2,a0=0A=
    463c:	00073e02 	srl	a3,a3,0x18=0A=
    4640:	00c71825 	or	v1,a2,a3=0A=
    4644:	01233821 	addu	a3,t1,v1=0A=
    4648:	00e3202b 	sltu	a0,a3,v1=0A=
    464c:	01023021 	addu	a2,t0,v0=0A=
    4650:	00c43021 	addu	a2,a2,a0=0A=
    4654:	8e62000c 	lw	v0,12(s3)=0A=
    4658:	ae660278 	sw	a2,632(s3)=0A=
    465c:	ae67027c 	sw	a3,636(s3)=0A=
    4660:	8e680280 	lw	t0,640(s3)=0A=
    4664:	8e690284 	lw	t1,644(s3)=0A=
    4668:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.prc127 +=3D E1000_READ_REG(&adapter->shared, PRC127);=0A=
    466c:	8e640008 	lw	a0,8(s3)=0A=
    4670:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4674:	8c874060 	lw	a3,16480(a0)=0A=
	return __arch__swab32(x);=0A=
    4678:	30e5ff00 	andi	a1,a3,0xff00=0A=
    467c:	00073600 	sll	a2,a3,0x18=0A=
    4680:	00072202 	srl	a0,a3,0x8=0A=
    4684:	00052a00 	sll	a1,a1,0x8=0A=
    4688:	3084ff00 	andi	a0,a0,0xff00=0A=
    468c:	00c53025 	or	a2,a2,a1=0A=
    4690:	00c43025 	or	a2,a2,a0=0A=
    4694:	00073e02 	srl	a3,a3,0x18=0A=
    4698:	00c71825 	or	v1,a2,a3=0A=
    469c:	01233821 	addu	a3,t1,v1=0A=
    46a0:	00e3202b 	sltu	a0,a3,v1=0A=
    46a4:	01023021 	addu	a2,t0,v0=0A=
    46a8:	00c43021 	addu	a2,a2,a0=0A=
    46ac:	8e62000c 	lw	v0,12(s3)=0A=
    46b0:	ae660280 	sw	a2,640(s3)=0A=
    46b4:	ae670284 	sw	a3,644(s3)=0A=
    46b8:	8e680288 	lw	t0,648(s3)=0A=
    46bc:	8e69028c 	lw	t1,652(s3)=0A=
    46c0:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.prc255 +=3D E1000_READ_REG(&adapter->shared, PRC255);=0A=
    46c4:	8e640008 	lw	a0,8(s3)=0A=
    46c8:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    46cc:	8c874064 	lw	a3,16484(a0)=0A=
	return __arch__swab32(x);=0A=
    46d0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    46d4:	00073600 	sll	a2,a3,0x18=0A=
    46d8:	00072202 	srl	a0,a3,0x8=0A=
    46dc:	00052a00 	sll	a1,a1,0x8=0A=
    46e0:	3084ff00 	andi	a0,a0,0xff00=0A=
    46e4:	00c53025 	or	a2,a2,a1=0A=
    46e8:	00c43025 	or	a2,a2,a0=0A=
    46ec:	00073e02 	srl	a3,a3,0x18=0A=
    46f0:	00c71825 	or	v1,a2,a3=0A=
    46f4:	01233821 	addu	a3,t1,v1=0A=
    46f8:	00e3202b 	sltu	a0,a3,v1=0A=
    46fc:	01023021 	addu	a2,t0,v0=0A=
    4700:	00c43021 	addu	a2,a2,a0=0A=
    4704:	8e62000c 	lw	v0,12(s3)=0A=
    4708:	ae660288 	sw	a2,648(s3)=0A=
    470c:	ae67028c 	sw	a3,652(s3)=0A=
    4710:	8e680290 	lw	t0,656(s3)=0A=
    4714:	8e690294 	lw	t1,660(s3)=0A=
    4718:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.prc511 +=3D E1000_READ_REG(&adapter->shared, PRC511);=0A=
    471c:	8e640008 	lw	a0,8(s3)=0A=
    4720:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4724:	8c874068 	lw	a3,16488(a0)=0A=
	return __arch__swab32(x);=0A=
    4728:	30e5ff00 	andi	a1,a3,0xff00=0A=
    472c:	00073600 	sll	a2,a3,0x18=0A=
    4730:	00072202 	srl	a0,a3,0x8=0A=
    4734:	00052a00 	sll	a1,a1,0x8=0A=
    4738:	3084ff00 	andi	a0,a0,0xff00=0A=
    473c:	00c53025 	or	a2,a2,a1=0A=
    4740:	00c43025 	or	a2,a2,a0=0A=
    4744:	00073e02 	srl	a3,a3,0x18=0A=
    4748:	00c71825 	or	v1,a2,a3=0A=
    474c:	01233821 	addu	a3,t1,v1=0A=
    4750:	00e3202b 	sltu	a0,a3,v1=0A=
    4754:	01023021 	addu	a2,t0,v0=0A=
    4758:	00c43021 	addu	a2,a2,a0=0A=
    475c:	8e62000c 	lw	v0,12(s3)=0A=
    4760:	ae660290 	sw	a2,656(s3)=0A=
    4764:	ae670294 	sw	a3,660(s3)=0A=
    4768:	8e680298 	lw	t0,664(s3)=0A=
    476c:	8e69029c 	lw	t1,668(s3)=0A=
    4770:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.prc1023 +=3D E1000_READ_REG(&adapter->shared, =
PRC1023);=0A=
    4774:	8e640008 	lw	a0,8(s3)=0A=
    4778:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    477c:	8c87406c 	lw	a3,16492(a0)=0A=
	return __arch__swab32(x);=0A=
    4780:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4784:	00073600 	sll	a2,a3,0x18=0A=
    4788:	00072202 	srl	a0,a3,0x8=0A=
    478c:	00052a00 	sll	a1,a1,0x8=0A=
    4790:	3084ff00 	andi	a0,a0,0xff00=0A=
    4794:	00c53025 	or	a2,a2,a1=0A=
    4798:	00c43025 	or	a2,a2,a0=0A=
    479c:	00073e02 	srl	a3,a3,0x18=0A=
    47a0:	00c71825 	or	v1,a2,a3=0A=
    47a4:	01233821 	addu	a3,t1,v1=0A=
    47a8:	00e3202b 	sltu	a0,a3,v1=0A=
    47ac:	01023021 	addu	a2,t0,v0=0A=
    47b0:	00c43021 	addu	a2,a2,a0=0A=
    47b4:	8e62000c 	lw	v0,12(s3)=0A=
    47b8:	ae660298 	sw	a2,664(s3)=0A=
    47bc:	ae67029c 	sw	a3,668(s3)=0A=
    47c0:	8e6802a0 	lw	t0,672(s3)=0A=
    47c4:	8e6902a4 	lw	t1,676(s3)=0A=
    47c8:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.prc1522 +=3D E1000_READ_REG(&adapter->shared, =
PRC1522);=0A=
    47cc:	8e640008 	lw	a0,8(s3)=0A=
    47d0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    47d4:	8c874070 	lw	a3,16496(a0)=0A=
	return __arch__swab32(x);=0A=
    47d8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    47dc:	00073600 	sll	a2,a3,0x18=0A=
    47e0:	00072202 	srl	a0,a3,0x8=0A=
    47e4:	00052a00 	sll	a1,a1,0x8=0A=
    47e8:	3084ff00 	andi	a0,a0,0xff00=0A=
    47ec:	00c53025 	or	a2,a2,a1=0A=
    47f0:	00c43025 	or	a2,a2,a0=0A=
    47f4:	00073e02 	srl	a3,a3,0x18=0A=
    47f8:	00c71825 	or	v1,a2,a3=0A=
    47fc:	01233821 	addu	a3,t1,v1=0A=
    4800:	00e3202b 	sltu	a0,a3,v1=0A=
    4804:	01023021 	addu	a2,t0,v0=0A=
    4808:	00c43021 	addu	a2,a2,a0=0A=
    480c:	8e62000c 	lw	v0,12(s3)=0A=
    4810:	ae6602a0 	sw	a2,672(s3)=0A=
    4814:	ae6702a4 	sw	a3,676(s3)=0A=
    4818:	8e6802a8 	lw	t0,680(s3)=0A=
    481c:	8e6902ac 	lw	t1,684(s3)=0A=
    4820:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.gprc +=3D E1000_READ_REG(&adapter->shared, GPRC);=0A=
    4824:	8e640008 	lw	a0,8(s3)=0A=
    4828:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    482c:	8c874074 	lw	a3,16500(a0)=0A=
	return __arch__swab32(x);=0A=
    4830:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4834:	00073600 	sll	a2,a3,0x18=0A=
    4838:	00072202 	srl	a0,a3,0x8=0A=
    483c:	00052a00 	sll	a1,a1,0x8=0A=
    4840:	3084ff00 	andi	a0,a0,0xff00=0A=
    4844:	00c53025 	or	a2,a2,a1=0A=
    4848:	00c43025 	or	a2,a2,a0=0A=
    484c:	00073e02 	srl	a3,a3,0x18=0A=
    4850:	00c71825 	or	v1,a2,a3=0A=
    4854:	01233821 	addu	a3,t1,v1=0A=
    4858:	00e3202b 	sltu	a0,a3,v1=0A=
    485c:	01023021 	addu	a2,t0,v0=0A=
    4860:	00c43021 	addu	a2,a2,a0=0A=
    4864:	8e62000c 	lw	v0,12(s3)=0A=
    4868:	ae6602a8 	sw	a2,680(s3)=0A=
    486c:	ae6702ac 	sw	a3,684(s3)=0A=
    4870:	8e6802b0 	lw	t0,688(s3)=0A=
    4874:	8e6902b4 	lw	t1,692(s3)=0A=
    4878:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.bprc +=3D E1000_READ_REG(&adapter->shared, BPRC);=0A=
    487c:	8e640008 	lw	a0,8(s3)=0A=
    4880:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4884:	8c874078 	lw	a3,16504(a0)=0A=
	return __arch__swab32(x);=0A=
    4888:	30e5ff00 	andi	a1,a3,0xff00=0A=
    488c:	00073600 	sll	a2,a3,0x18=0A=
    4890:	00072202 	srl	a0,a3,0x8=0A=
    4894:	00052a00 	sll	a1,a1,0x8=0A=
    4898:	3084ff00 	andi	a0,a0,0xff00=0A=
    489c:	00c53025 	or	a2,a2,a1=0A=
    48a0:	00c43025 	or	a2,a2,a0=0A=
    48a4:	00073e02 	srl	a3,a3,0x18=0A=
    48a8:	00c71825 	or	v1,a2,a3=0A=
    48ac:	01233821 	addu	a3,t1,v1=0A=
    48b0:	00e3202b 	sltu	a0,a3,v1=0A=
    48b4:	01023021 	addu	a2,t0,v0=0A=
    48b8:	00c43021 	addu	a2,a2,a0=0A=
    48bc:	8e62000c 	lw	v0,12(s3)=0A=
    48c0:	ae6602b0 	sw	a2,688(s3)=0A=
    48c4:	ae6702b4 	sw	a3,692(s3)=0A=
    48c8:	8e6802b8 	lw	t0,696(s3)=0A=
    48cc:	8e6902bc 	lw	t1,700(s3)=0A=
    48d0:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.mprc +=3D E1000_READ_REG(&adapter->shared, MPRC);=0A=
    48d4:	8e640008 	lw	a0,8(s3)=0A=
    48d8:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    48dc:	8c87407c 	lw	a3,16508(a0)=0A=
	return __arch__swab32(x);=0A=
    48e0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    48e4:	00073600 	sll	a2,a3,0x18=0A=
    48e8:	00072202 	srl	a0,a3,0x8=0A=
    48ec:	00052a00 	sll	a1,a1,0x8=0A=
    48f0:	3084ff00 	andi	a0,a0,0xff00=0A=
    48f4:	00c53025 	or	a2,a2,a1=0A=
    48f8:	00c43025 	or	a2,a2,a0=0A=
    48fc:	00073e02 	srl	a3,a3,0x18=0A=
    4900:	00c71825 	or	v1,a2,a3=0A=
    4904:	01233821 	addu	a3,t1,v1=0A=
    4908:	00e3202b 	sltu	a0,a3,v1=0A=
    490c:	01023021 	addu	a2,t0,v0=0A=
    4910:	00c43021 	addu	a2,a2,a0=0A=
    4914:	8e62000c 	lw	v0,12(s3)=0A=
    4918:	ae6602b8 	sw	a2,696(s3)=0A=
    491c:	ae6702bc 	sw	a3,700(s3)=0A=
    4920:	8e6802c0 	lw	t0,704(s3)=0A=
    4924:	8e6902c4 	lw	t1,708(s3)=0A=
    4928:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.gptc +=3D E1000_READ_REG(&adapter->shared, GPTC);=0A=
    492c:	8e640008 	lw	a0,8(s3)=0A=
    4930:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4934:	8c874080 	lw	a3,16512(a0)=0A=
	return __arch__swab32(x);=0A=
    4938:	30e5ff00 	andi	a1,a3,0xff00=0A=
    493c:	00073600 	sll	a2,a3,0x18=0A=
    4940:	00072202 	srl	a0,a3,0x8=0A=
    4944:	00052a00 	sll	a1,a1,0x8=0A=
    4948:	3084ff00 	andi	a0,a0,0xff00=0A=
    494c:	00c53025 	or	a2,a2,a1=0A=
    4950:	00c43025 	or	a2,a2,a0=0A=
    4954:	00073e02 	srl	a3,a3,0x18=0A=
    4958:	00c71825 	or	v1,a2,a3=0A=
    495c:	01233821 	addu	a3,t1,v1=0A=
    4960:	00e3202b 	sltu	a0,a3,v1=0A=
    4964:	01023021 	addu	a2,t0,v0=0A=
    4968:	00c43021 	addu	a2,a2,a0=0A=
    496c:	8e62000c 	lw	v0,12(s3)=0A=
    4970:	ae6602c0 	sw	a2,704(s3)=0A=
    4974:	ae6702c4 	sw	a3,708(s3)=0A=
    4978:	8e6802c8 	lw	t0,712(s3)=0A=
    497c:	8e6902cc 	lw	t1,716(s3)=0A=
    4980:	2c420002 	sltiu	v0,v0,2=0A=
=0A=
    /* for the 64-bit byte counters the low dword must be read first */=0A=
    /* both registers clear on the read of the high dword */=0A=
=0A=
    adapter->stats.gorcl +=3D E1000_READ_REG(&adapter->shared, GORCL);=0A=
    4984:	8e640008 	lw	a0,8(s3)=0A=
    4988:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    498c:	8c874088 	lw	a3,16520(a0)=0A=
	return __arch__swab32(x);=0A=
    4990:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4994:	00073600 	sll	a2,a3,0x18=0A=
    4998:	00072202 	srl	a0,a3,0x8=0A=
    499c:	00052a00 	sll	a1,a1,0x8=0A=
    49a0:	3084ff00 	andi	a0,a0,0xff00=0A=
    49a4:	00c53025 	or	a2,a2,a1=0A=
    49a8:	00c43025 	or	a2,a2,a0=0A=
    49ac:	00073e02 	srl	a3,a3,0x18=0A=
    49b0:	00c71825 	or	v1,a2,a3=0A=
    49b4:	01233821 	addu	a3,t1,v1=0A=
    49b8:	00e3202b 	sltu	a0,a3,v1=0A=
    49bc:	01023021 	addu	a2,t0,v0=0A=
    49c0:	00c43021 	addu	a2,a2,a0=0A=
    49c4:	8e62000c 	lw	v0,12(s3)=0A=
    49c8:	ae6602c8 	sw	a2,712(s3)=0A=
    49cc:	ae6702cc 	sw	a3,716(s3)=0A=
    49d0:	8e6802d0 	lw	t0,720(s3)=0A=
    49d4:	8e6902d4 	lw	t1,724(s3)=0A=
    49d8:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.gorch +=3D E1000_READ_REG(&adapter->shared, GORCH);=0A=
    49dc:	8e640008 	lw	a0,8(s3)=0A=
    49e0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    49e4:	8c87408c 	lw	a3,16524(a0)=0A=
	return __arch__swab32(x);=0A=
    49e8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    49ec:	00073600 	sll	a2,a3,0x18=0A=
    49f0:	00072202 	srl	a0,a3,0x8=0A=
    49f4:	00052a00 	sll	a1,a1,0x8=0A=
    49f8:	3084ff00 	andi	a0,a0,0xff00=0A=
    49fc:	00c53025 	or	a2,a2,a1=0A=
    4a00:	00c43025 	or	a2,a2,a0=0A=
    4a04:	00073e02 	srl	a3,a3,0x18=0A=
    4a08:	00c71825 	or	v1,a2,a3=0A=
    4a0c:	01233821 	addu	a3,t1,v1=0A=
    4a10:	00e3202b 	sltu	a0,a3,v1=0A=
    4a14:	01023021 	addu	a2,t0,v0=0A=
    4a18:	00c43021 	addu	a2,a2,a0=0A=
    4a1c:	8e62000c 	lw	v0,12(s3)=0A=
    4a20:	ae6602d0 	sw	a2,720(s3)=0A=
    4a24:	ae6702d4 	sw	a3,724(s3)=0A=
    4a28:	8e6802d8 	lw	t0,728(s3)=0A=
    4a2c:	8e6902dc 	lw	t1,732(s3)=0A=
    4a30:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.gotcl +=3D E1000_READ_REG(&adapter->shared, GOTCL);=0A=
    4a34:	8e640008 	lw	a0,8(s3)=0A=
    4a38:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4a3c:	8c874090 	lw	a3,16528(a0)=0A=
	return __arch__swab32(x);=0A=
    4a40:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4a44:	00073600 	sll	a2,a3,0x18=0A=
    4a48:	00072202 	srl	a0,a3,0x8=0A=
    4a4c:	00052a00 	sll	a1,a1,0x8=0A=
    4a50:	3084ff00 	andi	a0,a0,0xff00=0A=
    4a54:	00c53025 	or	a2,a2,a1=0A=
    4a58:	00c43025 	or	a2,a2,a0=0A=
    4a5c:	00073e02 	srl	a3,a3,0x18=0A=
    4a60:	00c71825 	or	v1,a2,a3=0A=
    4a64:	01233821 	addu	a3,t1,v1=0A=
    4a68:	00e3202b 	sltu	a0,a3,v1=0A=
    4a6c:	01023021 	addu	a2,t0,v0=0A=
    4a70:	00c43021 	addu	a2,a2,a0=0A=
    4a74:	8e62000c 	lw	v0,12(s3)=0A=
    4a78:	ae6602d8 	sw	a2,728(s3)=0A=
    4a7c:	ae6702dc 	sw	a3,732(s3)=0A=
    4a80:	8e6802e0 	lw	t0,736(s3)=0A=
    4a84:	8e6902e4 	lw	t1,740(s3)=0A=
    4a88:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.gotch +=3D E1000_READ_REG(&adapter->shared, GOTCH);=0A=
    4a8c:	8e640008 	lw	a0,8(s3)=0A=
    4a90:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4a94:	8c874094 	lw	a3,16532(a0)=0A=
	return __arch__swab32(x);=0A=
    4a98:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4a9c:	00073600 	sll	a2,a3,0x18=0A=
    4aa0:	00072202 	srl	a0,a3,0x8=0A=
    4aa4:	00052a00 	sll	a1,a1,0x8=0A=
    4aa8:	3084ff00 	andi	a0,a0,0xff00=0A=
    4aac:	00c53025 	or	a2,a2,a1=0A=
    4ab0:	00c43025 	or	a2,a2,a0=0A=
    4ab4:	00073e02 	srl	a3,a3,0x18=0A=
    4ab8:	00c71825 	or	v1,a2,a3=0A=
    4abc:	01233821 	addu	a3,t1,v1=0A=
    4ac0:	00e3202b 	sltu	a0,a3,v1=0A=
    4ac4:	01023021 	addu	a2,t0,v0=0A=
    4ac8:	00c43021 	addu	a2,a2,a0=0A=
    4acc:	8e62000c 	lw	v0,12(s3)=0A=
    4ad0:	ae6602e0 	sw	a2,736(s3)=0A=
    4ad4:	ae6702e4 	sw	a3,740(s3)=0A=
    4ad8:	8e6802e8 	lw	t0,744(s3)=0A=
    4adc:	8e6902ec 	lw	t1,748(s3)=0A=
    4ae0:	2c420002 	sltiu	v0,v0,2=0A=
=0A=
    adapter->stats.rnbc +=3D E1000_READ_REG(&adapter->shared, RNBC);=0A=
    4ae4:	8e640008 	lw	a0,8(s3)=0A=
    4ae8:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4aec:	8c8740a0 	lw	a3,16544(a0)=0A=
	return __arch__swab32(x);=0A=
    4af0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4af4:	00073600 	sll	a2,a3,0x18=0A=
    4af8:	00072202 	srl	a0,a3,0x8=0A=
    4afc:	00052a00 	sll	a1,a1,0x8=0A=
    4b00:	3084ff00 	andi	a0,a0,0xff00=0A=
    4b04:	00c53025 	or	a2,a2,a1=0A=
    4b08:	00c43025 	or	a2,a2,a0=0A=
    4b0c:	00073e02 	srl	a3,a3,0x18=0A=
    4b10:	00c71825 	or	v1,a2,a3=0A=
    4b14:	01233821 	addu	a3,t1,v1=0A=
    4b18:	00e3202b 	sltu	a0,a3,v1=0A=
    4b1c:	01023021 	addu	a2,t0,v0=0A=
    4b20:	00c43021 	addu	a2,a2,a0=0A=
    4b24:	8e62000c 	lw	v0,12(s3)=0A=
    4b28:	ae6602e8 	sw	a2,744(s3)=0A=
    4b2c:	ae6702ec 	sw	a3,748(s3)=0A=
    4b30:	8e6802f0 	lw	t0,752(s3)=0A=
    4b34:	8e6902f4 	lw	t1,756(s3)=0A=
    4b38:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.ruc +=3D E1000_READ_REG(&adapter->shared, RUC);=0A=
    4b3c:	8e640008 	lw	a0,8(s3)=0A=
    4b40:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4b44:	8c8740a4 	lw	a3,16548(a0)=0A=
	return __arch__swab32(x);=0A=
    4b48:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4b4c:	00073600 	sll	a2,a3,0x18=0A=
    4b50:	00072202 	srl	a0,a3,0x8=0A=
    4b54:	00052a00 	sll	a1,a1,0x8=0A=
    4b58:	3084ff00 	andi	a0,a0,0xff00=0A=
    4b5c:	00c53025 	or	a2,a2,a1=0A=
    4b60:	00c43025 	or	a2,a2,a0=0A=
    4b64:	00073e02 	srl	a3,a3,0x18=0A=
    4b68:	00c71825 	or	v1,a2,a3=0A=
    4b6c:	01233821 	addu	a3,t1,v1=0A=
    4b70:	00e3202b 	sltu	a0,a3,v1=0A=
    4b74:	01023021 	addu	a2,t0,v0=0A=
    4b78:	00c43021 	addu	a2,a2,a0=0A=
    4b7c:	8e62000c 	lw	v0,12(s3)=0A=
    4b80:	ae6602f0 	sw	a2,752(s3)=0A=
    4b84:	ae6702f4 	sw	a3,756(s3)=0A=
    4b88:	8e6802f8 	lw	t0,760(s3)=0A=
    4b8c:	8e6902fc 	lw	t1,764(s3)=0A=
    4b90:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.rfc +=3D E1000_READ_REG(&adapter->shared, RFC);=0A=
    4b94:	8e640008 	lw	a0,8(s3)=0A=
    4b98:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4b9c:	8c8740a8 	lw	a3,16552(a0)=0A=
	return __arch__swab32(x);=0A=
    4ba0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4ba4:	00073600 	sll	a2,a3,0x18=0A=
    4ba8:	00072202 	srl	a0,a3,0x8=0A=
    4bac:	00052a00 	sll	a1,a1,0x8=0A=
    4bb0:	3084ff00 	andi	a0,a0,0xff00=0A=
    4bb4:	00c53025 	or	a2,a2,a1=0A=
    4bb8:	00c43025 	or	a2,a2,a0=0A=
    4bbc:	00073e02 	srl	a3,a3,0x18=0A=
    4bc0:	00c71825 	or	v1,a2,a3=0A=
    4bc4:	01233821 	addu	a3,t1,v1=0A=
    4bc8:	00e3202b 	sltu	a0,a3,v1=0A=
    4bcc:	01023021 	addu	a2,t0,v0=0A=
    4bd0:	00c43021 	addu	a2,a2,a0=0A=
    4bd4:	8e62000c 	lw	v0,12(s3)=0A=
    4bd8:	ae6602f8 	sw	a2,760(s3)=0A=
    4bdc:	ae6702fc 	sw	a3,764(s3)=0A=
    4be0:	8e680300 	lw	t0,768(s3)=0A=
    4be4:	8e690304 	lw	t1,772(s3)=0A=
    4be8:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.roc +=3D E1000_READ_REG(&adapter->shared, ROC);=0A=
    4bec:	8e640008 	lw	a0,8(s3)=0A=
    4bf0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4bf4:	8c8740ac 	lw	a3,16556(a0)=0A=
	return __arch__swab32(x);=0A=
    4bf8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4bfc:	00073600 	sll	a2,a3,0x18=0A=
    4c00:	00072202 	srl	a0,a3,0x8=0A=
    4c04:	00052a00 	sll	a1,a1,0x8=0A=
    4c08:	3084ff00 	andi	a0,a0,0xff00=0A=
    4c0c:	00c53025 	or	a2,a2,a1=0A=
    4c10:	00c43025 	or	a2,a2,a0=0A=
    4c14:	00073e02 	srl	a3,a3,0x18=0A=
    4c18:	00c71825 	or	v1,a2,a3=0A=
    4c1c:	01233821 	addu	a3,t1,v1=0A=
    4c20:	00e3202b 	sltu	a0,a3,v1=0A=
    4c24:	01023021 	addu	a2,t0,v0=0A=
    4c28:	00c43021 	addu	a2,a2,a0=0A=
    4c2c:	8e62000c 	lw	v0,12(s3)=0A=
    4c30:	ae660300 	sw	a2,768(s3)=0A=
    4c34:	ae670304 	sw	a3,772(s3)=0A=
    4c38:	8e680308 	lw	t0,776(s3)=0A=
    4c3c:	8e69030c 	lw	t1,780(s3)=0A=
    4c40:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.rjc +=3D E1000_READ_REG(&adapter->shared, RJC);=0A=
    4c44:	8e640008 	lw	a0,8(s3)=0A=
    4c48:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4c4c:	8c8740b0 	lw	a3,16560(a0)=0A=
	return __arch__swab32(x);=0A=
    4c50:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4c54:	00073600 	sll	a2,a3,0x18=0A=
    4c58:	00072202 	srl	a0,a3,0x8=0A=
    4c5c:	00052a00 	sll	a1,a1,0x8=0A=
    4c60:	3084ff00 	andi	a0,a0,0xff00=0A=
    4c64:	00c53025 	or	a2,a2,a1=0A=
    4c68:	00c43025 	or	a2,a2,a0=0A=
    4c6c:	00073e02 	srl	a3,a3,0x18=0A=
    4c70:	00c71825 	or	v1,a2,a3=0A=
    4c74:	01233821 	addu	a3,t1,v1=0A=
    4c78:	00e3202b 	sltu	a0,a3,v1=0A=
    4c7c:	01023021 	addu	a2,t0,v0=0A=
    4c80:	00c43021 	addu	a2,a2,a0=0A=
    4c84:	8e62000c 	lw	v0,12(s3)=0A=
    4c88:	ae660308 	sw	a2,776(s3)=0A=
    4c8c:	ae67030c 	sw	a3,780(s3)=0A=
    4c90:	8e680328 	lw	t0,808(s3)=0A=
    4c94:	8e69032c 	lw	t1,812(s3)=0A=
    4c98:	2c420002 	sltiu	v0,v0,2=0A=
=0A=
    adapter->stats.torl +=3D E1000_READ_REG(&adapter->shared, TORL);=0A=
    4c9c:	8e640008 	lw	a0,8(s3)=0A=
    4ca0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4ca4:	8c8740c0 	lw	a3,16576(a0)=0A=
	return __arch__swab32(x);=0A=
    4ca8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4cac:	00073600 	sll	a2,a3,0x18=0A=
    4cb0:	00072202 	srl	a0,a3,0x8=0A=
    4cb4:	00052a00 	sll	a1,a1,0x8=0A=
    4cb8:	3084ff00 	andi	a0,a0,0xff00=0A=
    4cbc:	00c53025 	or	a2,a2,a1=0A=
    4cc0:	00c43025 	or	a2,a2,a0=0A=
    4cc4:	00073e02 	srl	a3,a3,0x18=0A=
    4cc8:	00c71825 	or	v1,a2,a3=0A=
    4ccc:	01233821 	addu	a3,t1,v1=0A=
    4cd0:	00e3202b 	sltu	a0,a3,v1=0A=
    4cd4:	01023021 	addu	a2,t0,v0=0A=
    4cd8:	00c43021 	addu	a2,a2,a0=0A=
    4cdc:	8e62000c 	lw	v0,12(s3)=0A=
    4ce0:	ae660328 	sw	a2,808(s3)=0A=
    4ce4:	ae67032c 	sw	a3,812(s3)=0A=
    4ce8:	8e680330 	lw	t0,816(s3)=0A=
    4cec:	8e690334 	lw	t1,820(s3)=0A=
    4cf0:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.torh +=3D E1000_READ_REG(&adapter->shared, TORH);=0A=
    4cf4:	8e640008 	lw	a0,8(s3)=0A=
    4cf8:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4cfc:	8c8740c4 	lw	a3,16580(a0)=0A=
	return __arch__swab32(x);=0A=
    4d00:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4d04:	00073600 	sll	a2,a3,0x18=0A=
    4d08:	00072202 	srl	a0,a3,0x8=0A=
    4d0c:	00052a00 	sll	a1,a1,0x8=0A=
    4d10:	3084ff00 	andi	a0,a0,0xff00=0A=
    4d14:	00c53025 	or	a2,a2,a1=0A=
    4d18:	00c43025 	or	a2,a2,a0=0A=
    4d1c:	00073e02 	srl	a3,a3,0x18=0A=
    4d20:	00c71825 	or	v1,a2,a3=0A=
    4d24:	01233821 	addu	a3,t1,v1=0A=
    4d28:	00e3202b 	sltu	a0,a3,v1=0A=
    4d2c:	01023021 	addu	a2,t0,v0=0A=
    4d30:	00c43021 	addu	a2,a2,a0=0A=
    4d34:	8e62000c 	lw	v0,12(s3)=0A=
    4d38:	ae660330 	sw	a2,816(s3)=0A=
    4d3c:	ae670334 	sw	a3,820(s3)=0A=
    4d40:	8e680338 	lw	t0,824(s3)=0A=
    4d44:	8e69033c 	lw	t1,828(s3)=0A=
    4d48:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.totl +=3D E1000_READ_REG(&adapter->shared, TOTL);=0A=
    4d4c:	8e640008 	lw	a0,8(s3)=0A=
    4d50:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4d54:	8c8740c8 	lw	a3,16584(a0)=0A=
	return __arch__swab32(x);=0A=
    4d58:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4d5c:	00073600 	sll	a2,a3,0x18=0A=
    4d60:	00072202 	srl	a0,a3,0x8=0A=
    4d64:	00052a00 	sll	a1,a1,0x8=0A=
    4d68:	3084ff00 	andi	a0,a0,0xff00=0A=
    4d6c:	00c53025 	or	a2,a2,a1=0A=
    4d70:	00c43025 	or	a2,a2,a0=0A=
    4d74:	00073e02 	srl	a3,a3,0x18=0A=
    4d78:	00c71825 	or	v1,a2,a3=0A=
    4d7c:	01233821 	addu	a3,t1,v1=0A=
    4d80:	00e3202b 	sltu	a0,a3,v1=0A=
    4d84:	01023021 	addu	a2,t0,v0=0A=
    4d88:	00c43021 	addu	a2,a2,a0=0A=
    4d8c:	8e62000c 	lw	v0,12(s3)=0A=
    4d90:	ae660338 	sw	a2,824(s3)=0A=
    4d94:	ae67033c 	sw	a3,828(s3)=0A=
    4d98:	8e680340 	lw	t0,832(s3)=0A=
    4d9c:	8e690344 	lw	t1,836(s3)=0A=
    4da0:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.toth +=3D E1000_READ_REG(&adapter->shared, TOTH);=0A=
    4da4:	8e640008 	lw	a0,8(s3)=0A=
    4da8:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4dac:	8c8740cc 	lw	a3,16588(a0)=0A=
	return __arch__swab32(x);=0A=
    4db0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4db4:	00073600 	sll	a2,a3,0x18=0A=
    4db8:	00072202 	srl	a0,a3,0x8=0A=
    4dbc:	00052a00 	sll	a1,a1,0x8=0A=
    4dc0:	3084ff00 	andi	a0,a0,0xff00=0A=
    4dc4:	00c53025 	or	a2,a2,a1=0A=
    4dc8:	00c43025 	or	a2,a2,a0=0A=
    4dcc:	00073e02 	srl	a3,a3,0x18=0A=
    4dd0:	00c71825 	or	v1,a2,a3=0A=
    4dd4:	01233821 	addu	a3,t1,v1=0A=
    4dd8:	00e3202b 	sltu	a0,a3,v1=0A=
    4ddc:	01023021 	addu	a2,t0,v0=0A=
    4de0:	00c43021 	addu	a2,a2,a0=0A=
    4de4:	8e62000c 	lw	v0,12(s3)=0A=
    4de8:	ae660340 	sw	a2,832(s3)=0A=
    4dec:	ae670344 	sw	a3,836(s3)=0A=
    4df0:	8e680348 	lw	t0,840(s3)=0A=
    4df4:	8e69034c 	lw	t1,844(s3)=0A=
    4df8:	2c420002 	sltiu	v0,v0,2=0A=
=0A=
    adapter->stats.tpr +=3D E1000_READ_REG(&adapter->shared, TPR);=0A=
    4dfc:	8e640008 	lw	a0,8(s3)=0A=
    4e00:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4e04:	8c8740d0 	lw	a3,16592(a0)=0A=
	return __arch__swab32(x);=0A=
    4e08:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4e0c:	00073600 	sll	a2,a3,0x18=0A=
    4e10:	00072202 	srl	a0,a3,0x8=0A=
    4e14:	00052a00 	sll	a1,a1,0x8=0A=
    4e18:	3084ff00 	andi	a0,a0,0xff00=0A=
    4e1c:	00c53025 	or	a2,a2,a1=0A=
    4e20:	00c43025 	or	a2,a2,a0=0A=
    4e24:	00073e02 	srl	a3,a3,0x18=0A=
    4e28:	00c71825 	or	v1,a2,a3=0A=
    4e2c:	01233821 	addu	a3,t1,v1=0A=
    4e30:	00e3202b 	sltu	a0,a3,v1=0A=
    4e34:	01023021 	addu	a2,t0,v0=0A=
    4e38:	00c43021 	addu	a2,a2,a0=0A=
    4e3c:	8e62000c 	lw	v0,12(s3)=0A=
    4e40:	ae660348 	sw	a2,840(s3)=0A=
    4e44:	ae67034c 	sw	a3,844(s3)=0A=
    4e48:	8e680350 	lw	t0,848(s3)=0A=
    4e4c:	8e690354 	lw	t1,852(s3)=0A=
    4e50:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.tpt +=3D E1000_READ_REG(&adapter->shared, TPT);=0A=
    4e54:	8e640008 	lw	a0,8(s3)=0A=
    4e58:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4e5c:	8c8740d4 	lw	a3,16596(a0)=0A=
	return __arch__swab32(x);=0A=
    4e60:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4e64:	00073600 	sll	a2,a3,0x18=0A=
    4e68:	00072202 	srl	a0,a3,0x8=0A=
    4e6c:	00052a00 	sll	a1,a1,0x8=0A=
    4e70:	3084ff00 	andi	a0,a0,0xff00=0A=
    4e74:	00c53025 	or	a2,a2,a1=0A=
    4e78:	00c43025 	or	a2,a2,a0=0A=
    4e7c:	00073e02 	srl	a3,a3,0x18=0A=
    4e80:	00c71825 	or	v1,a2,a3=0A=
    4e84:	01233821 	addu	a3,t1,v1=0A=
    4e88:	00e3202b 	sltu	a0,a3,v1=0A=
    4e8c:	01023021 	addu	a2,t0,v0=0A=
    4e90:	00c43021 	addu	a2,a2,a0=0A=
    4e94:	8e62000c 	lw	v0,12(s3)=0A=
    4e98:	ae660350 	sw	a2,848(s3)=0A=
    4e9c:	ae670354 	sw	a3,852(s3)=0A=
    4ea0:	8e680358 	lw	t0,856(s3)=0A=
    4ea4:	8e69035c 	lw	t1,860(s3)=0A=
    4ea8:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.ptc64 +=3D E1000_READ_REG(&adapter->shared, PTC64);=0A=
    4eac:	8e640008 	lw	a0,8(s3)=0A=
    4eb0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4eb4:	8c8740d8 	lw	a3,16600(a0)=0A=
	return __arch__swab32(x);=0A=
    4eb8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4ebc:	00073600 	sll	a2,a3,0x18=0A=
    4ec0:	00072202 	srl	a0,a3,0x8=0A=
    4ec4:	00052a00 	sll	a1,a1,0x8=0A=
    4ec8:	3084ff00 	andi	a0,a0,0xff00=0A=
    4ecc:	00c53025 	or	a2,a2,a1=0A=
    4ed0:	00c43025 	or	a2,a2,a0=0A=
    4ed4:	00073e02 	srl	a3,a3,0x18=0A=
    4ed8:	00c71825 	or	v1,a2,a3=0A=
    4edc:	01233821 	addu	a3,t1,v1=0A=
    4ee0:	00e3202b 	sltu	a0,a3,v1=0A=
    4ee4:	01023021 	addu	a2,t0,v0=0A=
    4ee8:	00c43021 	addu	a2,a2,a0=0A=
    4eec:	8e62000c 	lw	v0,12(s3)=0A=
    4ef0:	ae660358 	sw	a2,856(s3)=0A=
    4ef4:	ae67035c 	sw	a3,860(s3)=0A=
    4ef8:	8e680360 	lw	t0,864(s3)=0A=
    4efc:	8e690364 	lw	t1,868(s3)=0A=
    4f00:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.ptc127 +=3D E1000_READ_REG(&adapter->shared, PTC127);=0A=
    4f04:	8e640008 	lw	a0,8(s3)=0A=
    4f08:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4f0c:	8c8740dc 	lw	a3,16604(a0)=0A=
	return __arch__swab32(x);=0A=
    4f10:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4f14:	00073600 	sll	a2,a3,0x18=0A=
    4f18:	00072202 	srl	a0,a3,0x8=0A=
    4f1c:	00052a00 	sll	a1,a1,0x8=0A=
    4f20:	3084ff00 	andi	a0,a0,0xff00=0A=
    4f24:	00c53025 	or	a2,a2,a1=0A=
    4f28:	00c43025 	or	a2,a2,a0=0A=
    4f2c:	00073e02 	srl	a3,a3,0x18=0A=
    4f30:	00c71825 	or	v1,a2,a3=0A=
    4f34:	01233821 	addu	a3,t1,v1=0A=
    4f38:	00e3202b 	sltu	a0,a3,v1=0A=
    4f3c:	01023021 	addu	a2,t0,v0=0A=
    4f40:	00c43021 	addu	a2,a2,a0=0A=
    4f44:	8e62000c 	lw	v0,12(s3)=0A=
    4f48:	ae660360 	sw	a2,864(s3)=0A=
    4f4c:	ae670364 	sw	a3,868(s3)=0A=
    4f50:	8e680368 	lw	t0,872(s3)=0A=
    4f54:	8e69036c 	lw	t1,876(s3)=0A=
    4f58:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.ptc255 +=3D E1000_READ_REG(&adapter->shared, PTC255);=0A=
    4f5c:	8e640008 	lw	a0,8(s3)=0A=
    4f60:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4f64:	8c8740e0 	lw	a3,16608(a0)=0A=
	return __arch__swab32(x);=0A=
    4f68:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4f6c:	00073600 	sll	a2,a3,0x18=0A=
    4f70:	00072202 	srl	a0,a3,0x8=0A=
    4f74:	00052a00 	sll	a1,a1,0x8=0A=
    4f78:	3084ff00 	andi	a0,a0,0xff00=0A=
    4f7c:	00c53025 	or	a2,a2,a1=0A=
    4f80:	00c43025 	or	a2,a2,a0=0A=
    4f84:	00073e02 	srl	a3,a3,0x18=0A=
    4f88:	00c71825 	or	v1,a2,a3=0A=
    4f8c:	01233821 	addu	a3,t1,v1=0A=
    4f90:	00e3202b 	sltu	a0,a3,v1=0A=
    4f94:	01023021 	addu	a2,t0,v0=0A=
    4f98:	00c43021 	addu	a2,a2,a0=0A=
    4f9c:	8e62000c 	lw	v0,12(s3)=0A=
    4fa0:	ae660368 	sw	a2,872(s3)=0A=
    4fa4:	ae67036c 	sw	a3,876(s3)=0A=
    4fa8:	8e680370 	lw	t0,880(s3)=0A=
    4fac:	8e690374 	lw	t1,884(s3)=0A=
    4fb0:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.ptc511 +=3D E1000_READ_REG(&adapter->shared, PTC511);=0A=
    4fb4:	8e640008 	lw	a0,8(s3)=0A=
    4fb8:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    4fbc:	8c8740e4 	lw	a3,16612(a0)=0A=
	return __arch__swab32(x);=0A=
    4fc0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    4fc4:	00073600 	sll	a2,a3,0x18=0A=
    4fc8:	00072202 	srl	a0,a3,0x8=0A=
    4fcc:	00052a00 	sll	a1,a1,0x8=0A=
    4fd0:	3084ff00 	andi	a0,a0,0xff00=0A=
    4fd4:	00c53025 	or	a2,a2,a1=0A=
    4fd8:	00c43025 	or	a2,a2,a0=0A=
    4fdc:	00073e02 	srl	a3,a3,0x18=0A=
    4fe0:	00c71825 	or	v1,a2,a3=0A=
    4fe4:	01233821 	addu	a3,t1,v1=0A=
    4fe8:	00e3202b 	sltu	a0,a3,v1=0A=
    4fec:	01023021 	addu	a2,t0,v0=0A=
    4ff0:	00c43021 	addu	a2,a2,a0=0A=
    4ff4:	8e62000c 	lw	v0,12(s3)=0A=
    4ff8:	ae660370 	sw	a2,880(s3)=0A=
    4ffc:	ae670374 	sw	a3,884(s3)=0A=
    5000:	8e680378 	lw	t0,888(s3)=0A=
    5004:	8e69037c 	lw	t1,892(s3)=0A=
    5008:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.ptc1023 +=3D E1000_READ_REG(&adapter->shared, =
PTC1023);=0A=
    500c:	8e640008 	lw	a0,8(s3)=0A=
    5010:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    5014:	8c8740e8 	lw	a3,16616(a0)=0A=
	return __arch__swab32(x);=0A=
    5018:	30e5ff00 	andi	a1,a3,0xff00=0A=
    501c:	00073600 	sll	a2,a3,0x18=0A=
    5020:	00072202 	srl	a0,a3,0x8=0A=
    5024:	00052a00 	sll	a1,a1,0x8=0A=
    5028:	3084ff00 	andi	a0,a0,0xff00=0A=
    502c:	00c53025 	or	a2,a2,a1=0A=
    5030:	00c43025 	or	a2,a2,a0=0A=
    5034:	00073e02 	srl	a3,a3,0x18=0A=
    5038:	00c71825 	or	v1,a2,a3=0A=
    503c:	01233821 	addu	a3,t1,v1=0A=
    5040:	00e3202b 	sltu	a0,a3,v1=0A=
    5044:	01023021 	addu	a2,t0,v0=0A=
    5048:	00c43021 	addu	a2,a2,a0=0A=
    504c:	8e62000c 	lw	v0,12(s3)=0A=
    5050:	ae660378 	sw	a2,888(s3)=0A=
    5054:	ae67037c 	sw	a3,892(s3)=0A=
    5058:	8e680380 	lw	t0,896(s3)=0A=
    505c:	8e690384 	lw	t1,900(s3)=0A=
    5060:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.ptc1522 +=3D E1000_READ_REG(&adapter->shared, =
PTC1522);=0A=
    5064:	8e640008 	lw	a0,8(s3)=0A=
    5068:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    506c:	8c8740ec 	lw	a3,16620(a0)=0A=
	return __arch__swab32(x);=0A=
    5070:	30e5ff00 	andi	a1,a3,0xff00=0A=
    5074:	00073600 	sll	a2,a3,0x18=0A=
    5078:	00072202 	srl	a0,a3,0x8=0A=
    507c:	00052a00 	sll	a1,a1,0x8=0A=
    5080:	3084ff00 	andi	a0,a0,0xff00=0A=
    5084:	00c53025 	or	a2,a2,a1=0A=
    5088:	00c43025 	or	a2,a2,a0=0A=
    508c:	00073e02 	srl	a3,a3,0x18=0A=
    5090:	00c71825 	or	v1,a2,a3=0A=
    5094:	01233821 	addu	a3,t1,v1=0A=
    5098:	00e3202b 	sltu	a0,a3,v1=0A=
    509c:	01023021 	addu	a2,t0,v0=0A=
    50a0:	00c43021 	addu	a2,a2,a0=0A=
    50a4:	8e62000c 	lw	v0,12(s3)=0A=
    50a8:	ae660380 	sw	a2,896(s3)=0A=
    50ac:	ae670384 	sw	a3,900(s3)=0A=
    50b0:	8e680388 	lw	t0,904(s3)=0A=
    50b4:	8e69038c 	lw	t1,908(s3)=0A=
    50b8:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.mptc +=3D E1000_READ_REG(&adapter->shared, MPTC);=0A=
    50bc:	8e640008 	lw	a0,8(s3)=0A=
    50c0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    50c4:	8c8740f0 	lw	a3,16624(a0)=0A=
	return __arch__swab32(x);=0A=
    50c8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    50cc:	00073600 	sll	a2,a3,0x18=0A=
    50d0:	00072202 	srl	a0,a3,0x8=0A=
    50d4:	00052a00 	sll	a1,a1,0x8=0A=
    50d8:	3084ff00 	andi	a0,a0,0xff00=0A=
    50dc:	00c53025 	or	a2,a2,a1=0A=
    50e0:	00c43025 	or	a2,a2,a0=0A=
    50e4:	00073e02 	srl	a3,a3,0x18=0A=
    50e8:	00c71825 	or	v1,a2,a3=0A=
    50ec:	01233821 	addu	a3,t1,v1=0A=
    50f0:	00e3202b 	sltu	a0,a3,v1=0A=
    50f4:	01023021 	addu	a2,t0,v0=0A=
    50f8:	00c43021 	addu	a2,a2,a0=0A=
    50fc:	8e62000c 	lw	v0,12(s3)=0A=
    5100:	ae660388 	sw	a2,904(s3)=0A=
    5104:	ae67038c 	sw	a3,908(s3)=0A=
    5108:	8e680390 	lw	t0,912(s3)=0A=
    510c:	8e690394 	lw	t1,916(s3)=0A=
    5110:	2c420002 	sltiu	v0,v0,2=0A=
    adapter->stats.bptc +=3D E1000_READ_REG(&adapter->shared, BPTC);=0A=
    5114:	8e640008 	lw	a0,8(s3)=0A=
    5118:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    511c:	8c8740f4 	lw	a3,16628(a0)=0A=
	return __arch__swab32(x);=0A=
    5120:	30e5ff00 	andi	a1,a3,0xff00=0A=
    5124:	00073600 	sll	a2,a3,0x18=0A=
    5128:	00072202 	srl	a0,a3,0x8=0A=
    512c:	00052a00 	sll	a1,a1,0x8=0A=
    5130:	3084ff00 	andi	a0,a0,0xff00=0A=
    5134:	00c53025 	or	a2,a2,a1=0A=
    5138:	00c43025 	or	a2,a2,a0=0A=
    513c:	00073e02 	srl	a3,a3,0x18=0A=
    5140:	00c71825 	or	v1,a2,a3=0A=
    5144:	01233821 	addu	a3,t1,v1=0A=
    5148:	00e3202b 	sltu	a0,a3,v1=0A=
    514c:	01023021 	addu	a2,t0,v0=0A=
    5150:	00c43021 	addu	a2,a2,a0=0A=
=0A=
    if(adapter->shared.mac_type >=3D e1000_82543) {=0A=
    5154:	8e62000c 	lw	v0,12(s3)=0A=
    5158:	ae660390 	sw	a2,912(s3)=0A=
    515c:	ae670394 	sw	a3,916(s3)=0A=
    5160:	2c420002 	sltiu	v0,v0,2=0A=
    5164:	5440008c 	bnezl	v0,5398 <e1000_update_stats+0x1354>=0A=
    5168:	8e6301dc 	lw	v1,476(s3)=0A=
        adapter->stats.algnerrc +=3D E1000_READ_REG(&adapter->shared, =
ALGNERRC);=0A=
    516c:	8e620008 	lw	v0,8(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    5170:	3c0c00ff 	lui	t4,0xff=0A=
    5174:	8e6801e0 	lw	t0,480(s3)=0A=
    5178:	8e6901e4 	lw	t1,484(s3)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    517c:	8c474004 	lw	a3,16388(v0)=0A=
    5180:	8e6a000c 	lw	t2,12(s3)=0A=
    5184:	00001021 	move	v0,zero=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    5188:	30e5ff00 	andi	a1,a3,0xff00=0A=
    518c:	00073600 	sll	a2,a3,0x18=0A=
    5190:	00ec2024 	and	a0,a3,t4=0A=
    5194:	00052a00 	sll	a1,a1,0x8=0A=
    5198:	00042202 	srl	a0,a0,0x8=0A=
    519c:	00c53025 	or	a2,a2,a1=0A=
    51a0:	00c43025 	or	a2,a2,a0=0A=
    51a4:	00073e02 	srl	a3,a3,0x18=0A=
    51a8:	00c71825 	or	v1,a2,a3=0A=
    51ac:	01234821 	addu	t1,t1,v1=0A=
    51b0:	0123202b 	sltu	a0,t1,v1=0A=
    51b4:	01024021 	addu	t0,t0,v0=0A=
    51b8:	01044021 	addu	t0,t0,a0=0A=
    51bc:	2d4a0002 	sltiu	t2,t2,2=0A=
    51c0:	ae6801e0 	sw	t0,480(s3)=0A=
    51c4:	ae6901e4 	sw	t1,484(s3)=0A=
    51c8:	8e6801f0 	lw	t0,496(s3)=0A=
    51cc:	8e6901f4 	lw	t1,500(s3)=0A=
    51d0:	15400003 	bnez	t2,51e0 <e1000_update_stats+0x119c>=0A=
    51d4:	3c0bff00 	lui	t3,0xff00=0A=
        adapter->stats.rxerrc +=3D E1000_READ_REG(&adapter->shared, =
RXERRC);=0A=
    51d8:	0800147a 	j	51e8 <e1000_update_stats+0x11a4>=0A=
    51dc:	8e660008 	lw	a2,8(s3)=0A=
    51e0:	8e660008 	lw	a2,8(s3)=0A=
    51e4:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    51e8:	8cc4400c 	lw	a0,16396(a2)=0A=
	return __arch__swab32(x);=0A=
    51ec:	3085ff00 	andi	a1,a0,0xff00=0A=
    51f0:	008c3824 	and	a3,a0,t4=0A=
    51f4:	00043600 	sll	a2,a0,0x18=0A=
    51f8:	00052a00 	sll	a1,a1,0x8=0A=
    51fc:	00073a02 	srl	a3,a3,0x8=0A=
    5200:	00c53025 	or	a2,a2,a1=0A=
    5204:	008b2024 	and	a0,a0,t3=0A=
    5208:	00c73025 	or	a2,a2,a3=0A=
    520c:	00042602 	srl	a0,a0,0x18=0A=
    5210:	00c41825 	or	v1,a2,a0=0A=
    5214:	01233821 	addu	a3,t1,v1=0A=
    5218:	00e3202b 	sltu	a0,a3,v1=0A=
    521c:	01023021 	addu	a2,t0,v0=0A=
    5220:	00c43021 	addu	a2,a2,a0=0A=
    5224:	8e62000c 	lw	v0,12(s3)=0A=
    5228:	ae6601f0 	sw	a2,496(s3)=0A=
    522c:	ae6701f4 	sw	a3,500(s3)=0A=
    5230:	8e680230 	lw	t0,560(s3)=0A=
    5234:	8e690234 	lw	t1,564(s3)=0A=
    5238:	2c420002 	sltiu	v0,v0,2=0A=
        adapter->stats.tncrs +=3D E1000_READ_REG(&adapter->shared, =
TNCRS);=0A=
    523c:	8e640008 	lw	a0,8(s3)=0A=
    5240:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    5244:	8c874034 	lw	a3,16436(a0)=0A=
	return __arch__swab32(x);=0A=
    5248:	30e5ff00 	andi	a1,a3,0xff00=0A=
    524c:	00073600 	sll	a2,a3,0x18=0A=
    5250:	00072202 	srl	a0,a3,0x8=0A=
    5254:	00052a00 	sll	a1,a1,0x8=0A=
    5258:	3084ff00 	andi	a0,a0,0xff00=0A=
    525c:	00c53025 	or	a2,a2,a1=0A=
    5260:	00c43025 	or	a2,a2,a0=0A=
    5264:	00073e02 	srl	a3,a3,0x18=0A=
    5268:	00c71825 	or	v1,a2,a3=0A=
    526c:	01233821 	addu	a3,t1,v1=0A=
    5270:	00e3202b 	sltu	a0,a3,v1=0A=
    5274:	01023021 	addu	a2,t0,v0=0A=
    5278:	00c43021 	addu	a2,a2,a0=0A=
    527c:	8e62000c 	lw	v0,12(s3)=0A=
    5280:	ae660230 	sw	a2,560(s3)=0A=
    5284:	ae670234 	sw	a3,564(s3)=0A=
    5288:	8e680240 	lw	t0,576(s3)=0A=
    528c:	8e690244 	lw	t1,580(s3)=0A=
    5290:	2c420002 	sltiu	v0,v0,2=0A=
        adapter->stats.cexterr +=3D E1000_READ_REG(&adapter->shared, =
CEXTERR);=0A=
    5294:	8e640008 	lw	a0,8(s3)=0A=
    5298:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    529c:	8c87403c 	lw	a3,16444(a0)=0A=
	return __arch__swab32(x);=0A=
    52a0:	30e5ff00 	andi	a1,a3,0xff00=0A=
    52a4:	00073600 	sll	a2,a3,0x18=0A=
    52a8:	00072202 	srl	a0,a3,0x8=0A=
    52ac:	00052a00 	sll	a1,a1,0x8=0A=
    52b0:	3084ff00 	andi	a0,a0,0xff00=0A=
    52b4:	00c53025 	or	a2,a2,a1=0A=
    52b8:	00c43025 	or	a2,a2,a0=0A=
    52bc:	00073e02 	srl	a3,a3,0x18=0A=
    52c0:	00c71825 	or	v1,a2,a3=0A=
    52c4:	01233821 	addu	a3,t1,v1=0A=
    52c8:	00e3202b 	sltu	a0,a3,v1=0A=
    52cc:	01023021 	addu	a2,t0,v0=0A=
    52d0:	00c43021 	addu	a2,a2,a0=0A=
    52d4:	8e62000c 	lw	v0,12(s3)=0A=
    52d8:	ae660240 	sw	a2,576(s3)=0A=
    52dc:	ae670244 	sw	a3,580(s3)=0A=
    52e0:	8e680398 	lw	t0,920(s3)=0A=
    52e4:	8e69039c 	lw	t1,924(s3)=0A=
    52e8:	2c420002 	sltiu	v0,v0,2=0A=
        adapter->stats.tsctc +=3D E1000_READ_REG(&adapter->shared, =
TSCTC);=0A=
    52ec:	8e640008 	lw	a0,8(s3)=0A=
    52f0:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    52f4:	8c8740f8 	lw	a3,16632(a0)=0A=
	return __arch__swab32(x);=0A=
    52f8:	30e5ff00 	andi	a1,a3,0xff00=0A=
    52fc:	00073600 	sll	a2,a3,0x18=0A=
    5300:	00072202 	srl	a0,a3,0x8=0A=
    5304:	00052a00 	sll	a1,a1,0x8=0A=
    5308:	3084ff00 	andi	a0,a0,0xff00=0A=
    530c:	00c53025 	or	a2,a2,a1=0A=
    5310:	00c43025 	or	a2,a2,a0=0A=
    5314:	00073e02 	srl	a3,a3,0x18=0A=
    5318:	00c71825 	or	v1,a2,a3=0A=
    531c:	01233821 	addu	a3,t1,v1=0A=
    5320:	00e3202b 	sltu	a0,a3,v1=0A=
    5324:	01023021 	addu	a2,t0,v0=0A=
    5328:	00c43021 	addu	a2,a2,a0=0A=
    532c:	8e62000c 	lw	v0,12(s3)=0A=
    5330:	ae660398 	sw	a2,920(s3)=0A=
    5334:	ae67039c 	sw	a3,924(s3)=0A=
    5338:	8e6803a0 	lw	t0,928(s3)=0A=
    533c:	8e6903a4 	lw	t1,932(s3)=0A=
    5340:	2c420002 	sltiu	v0,v0,2=0A=
        adapter->stats.tsctfc +=3D E1000_READ_REG(&adapter->shared, =
TSCTFC);=0A=
    5344:	8e640008 	lw	a0,8(s3)=0A=
    5348:	00001021 	move	v0,zero=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    534c:	8c8740fc 	lw	a3,16636(a0)=0A=
	return __arch__swab32(x);=0A=
    5350:	30e5ff00 	andi	a1,a3,0xff00=0A=
    5354:	00073600 	sll	a2,a3,0x18=0A=
    5358:	00072202 	srl	a0,a3,0x8=0A=
    535c:	00052a00 	sll	a1,a1,0x8=0A=
    5360:	3084ff00 	andi	a0,a0,0xff00=0A=
    5364:	00c53025 	or	a2,a2,a1=0A=
    5368:	00c43025 	or	a2,a2,a0=0A=
    536c:	00073e02 	srl	a3,a3,0x18=0A=
    5370:	00c71825 	or	v1,a2,a3=0A=
    5374:	01233821 	addu	a3,t1,v1=0A=
    5378:	00e3202b 	sltu	a0,a3,v1=0A=
    537c:	01023021 	addu	a2,t0,v0=0A=
    5380:	00c43021 	addu	a2,a2,a0=0A=
    5384:	00c01021 	move	v0,a2=0A=
    5388:	00e01821 	move	v1,a3=0A=
    538c:	ae6203a0 	sw	v0,928(s3)=0A=
    5390:	ae6303a4 	sw	v1,932(s3)=0A=
    }=0A=
=0A=
    /* Fill out the OS statistics structure */=0A=
=0A=
    adapter->net_stats.rx_packets =3D adapter->stats.gprc;=0A=
    adapter->net_stats.tx_packets =3D adapter->stats.gptc;=0A=
    adapter->net_stats.rx_bytes =3D adapter->stats.gorcl;=0A=
    adapter->net_stats.tx_bytes =3D adapter->stats.gotcl;=0A=
    adapter->net_stats.multicast =3D adapter->stats.mprc;=0A=
    adapter->net_stats.collisions =3D adapter->stats.colc;=0A=
=0A=
    /* Rx Errors */=0A=
=0A=
    adapter->net_stats.rx_errors =3D=0A=
    5394:	8e6301dc 	lw	v1,476(s3)=0A=
    5398:	8e6201f4 	lw	v0,500(s3)=0A=
    539c:	8e6401e4 	lw	a0,484(s3)=0A=
    53a0:	8e65024c 	lw	a1,588(s3)=0A=
    53a4:	8e6602ec 	lw	a2,748(s3)=0A=
    53a8:	00431021 	addu	v0,v0,v1=0A=
    53ac:	8e7201fc 	lw	s2,508(s3)=0A=
    53b0:	00441021 	addu	v0,v0,a0=0A=
    53b4:	00451021 	addu	v0,v0,a1=0A=
    53b8:	8e710244 	lw	s1,580(s3)=0A=
    53bc:	8e6402ac 	lw	a0,684(s3)=0A=
    53c0:	00461021 	addu	v0,v0,a2=0A=
        adapter->stats.rxerrc + adapter->stats.crcerrs +=0A=
        adapter->stats.algnerrc + adapter->stats.rlec + =
adapter->stats.rnbc +=0A=
        adapter->stats.mpc + adapter->stats.cexterr;=0A=
    adapter->net_stats.rx_dropped =3D adapter->stats.rnbc;=0A=
    adapter->net_stats.rx_length_errors =3D adapter->stats.rlec;=0A=
    adapter->net_stats.rx_crc_errors =3D adapter->stats.crcerrs;=0A=
    adapter->net_stats.rx_frame_errors =3D adapter->stats.algnerrc;=0A=
    adapter->net_stats.rx_fifo_errors =3D adapter->stats.mpc;=0A=
    adapter->net_stats.rx_missed_errors =3D adapter->stats.mpc;=0A=
=0A=
    /* Tx Errors */=0A=
=0A=
    adapter->net_stats.tx_errors =3D adapter->stats.ecol + =
adapter->stats.latecol;=0A=
    53c4:	8e6a021c 	lw	t2,540(s3)=0A=
    53c8:	8e63020c 	lw	v1,524(s3)=0A=
    53cc:	00521021 	addu	v0,v0,s2=0A=
    53d0:	00511021 	addu	v0,v0,s1=0A=
    53d4:	8e6502c4 	lw	a1,708(s3)=0A=
    53d8:	8e6602cc 	lw	a2,716(s3)=0A=
    53dc:	8e6702dc 	lw	a3,732(s3)=0A=
    53e0:	8e6802bc 	lw	t0,700(s3)=0A=
    53e4:	8e690224 	lw	t1,548(s3)=0A=
    53e8:	8e6b02ec 	lw	t3,748(s3)=0A=
    53ec:	8e6c024c 	lw	t4,588(s3)=0A=
    53f0:	8e6d01dc 	lw	t5,476(s3)=0A=
    53f4:	8e6e01e4 	lw	t6,484(s3)=0A=
    53f8:	ae640150 	sw	a0,336(s3)=0A=
    53fc:	ae620160 	sw	v0,352(s3)=0A=
    adapter->net_stats.tx_aborted_errors =3D adapter->stats.ecol;=0A=
    adapter->net_stats.tx_window_errors =3D adapter->stats.latecol;=0A=
=0A=
    /* Tx Dropped needs to be maintained elsewhere */=0A=
=0A=
    if(adapter->shared.media_type =3D=3D e1000_media_type_copper) {=0A=
    5400:	8e640010 	lw	a0,16(s3)=0A=
    5404:	8e62020c 	lw	v0,524(s3)=0A=
    5408:	02407821 	move	t7,s2=0A=
    540c:	006a1821 	addu	v1,v1,t2=0A=
    5410:	ae630164 	sw	v1,356(s3)=0A=
    5414:	01e08021 	move	s0,t7=0A=
    5418:	01401821 	move	v1,t2=0A=
    541c:	ae650154 	sw	a1,340(s3)=0A=
    5420:	ae660158 	sw	a2,344(s3)=0A=
    5424:	ae67015c 	sw	a3,348(s3)=0A=
    5428:	ae680170 	sw	t0,368(s3)=0A=
    542c:	ae690174 	sw	t1,372(s3)=0A=
    5430:	ae6b0168 	sw	t3,360(s3)=0A=
    5434:	ae6c0178 	sw	t4,376(s3)=0A=
    5438:	ae6d0180 	sw	t5,384(s3)=0A=
    543c:	ae6e0184 	sw	t6,388(s3)=0A=
    5440:	ae6f0188 	sw	t7,392(s3)=0A=
    5444:	ae70018c 	sw	s0,396(s3)=0A=
    5448:	ae620190 	sw	v0,400(s3)=0A=
    544c:	14800011 	bnez	a0,5494 <e1000_update_stats+0x1450>=0A=
    5450:	ae6301a0 	sw	v1,416(s3)=0A=
        adapter->idle_errors +=3D=0A=
    5454:	26700008 	addiu	s0,s3,8=0A=
    5458:	02002021 	move	a0,s0=0A=
    545c:	3c110000 	lui	s1,0x0=0A=
    5460:	26310000 	addiu	s1,s1,0=0A=
    5464:	0220f809 	jalr	s1=0A=
    5468:	2405000a 	li	a1,10=0A=
    546c:	8e6303ac 	lw	v1,940(s3)=0A=
    5470:	304200ff 	andi	v0,v0,0xff=0A=
            (e1000_read_phy_reg(&adapter->shared, PHY_1000T_STATUS)=0A=
             & PHY_IDLE_ERROR_COUNT_MASK);=0A=
        adapter->receive_errors +=3D=0A=
    5474:	02002021 	move	a0,s0=0A=
    5478:	00621821 	addu	v1,v1,v0=0A=
    547c:	ae6303ac 	sw	v1,940(s3)=0A=
    5480:	0220f809 	jalr	s1=0A=
    5484:	24050015 	li	a1,21=0A=
    5488:	8e6303a8 	lw	v1,936(s3)=0A=
    548c:	00621821 	addu	v1,v1,v0=0A=
    5490:	ae6303a8 	sw	v1,936(s3)=0A=
            e1000_read_phy_reg(&adapter->shared, M88E1000_RX_ERR_CNTR);=0A=
    }=0A=
=0A=
    spin_unlock_irqrestore(&adapter->stats_lock, flags);=0A=
    5494:	40016000 	mfc0	at,$12=0A=
    5498:	32940001 	andi	s4,s4,0x1=0A=
    549c:	34210001 	ori	at,at,0x1=0A=
    54a0:	38210001 	xori	at,at,0x1=0A=
    54a4:	0281a025 	or	s4,s4,at=0A=
    54a8:	40946000 	mtc0	s4,$12=0A=
	...=0A=
    return;=0A=
}=0A=
    54b8:	8fbf0024 	lw	ra,36(sp)=0A=
    54bc:	8fb40020 	lw	s4,32(sp)=0A=
    54c0:	8fb3001c 	lw	s3,28(sp)=0A=
    54c4:	8fb20018 	lw	s2,24(sp)=0A=
    54c8:	8fb10014 	lw	s1,20(sp)=0A=
    54cc:	8fb00010 	lw	s0,16(sp)=0A=
    54d0:	03e00008 	jr	ra=0A=
    54d4:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
000054d8 <e1000_intr>:=0A=
    54d8:	27bdffd0 	addiu	sp,sp,-48=0A=
    54dc:	afb10014 	sw	s1,20(sp)=0A=
    54e0:	afbf002c 	sw	ra,44(sp)=0A=
    54e4:	afb60028 	sw	s6,40(sp)=0A=
    54e8:	afb50024 	sw	s5,36(sp)=0A=
    54ec:	afb40020 	sw	s4,32(sp)=0A=
    54f0:	afb3001c 	sw	s3,28(sp)=0A=
    54f4:	afb20018 	sw	s2,24(sp)=0A=
    54f8:	afb00010 	sw	s0,16(sp)=0A=
=0A=
/**=0A=
 * e1000_irq_disable - Mask off interrupt generation on the NIC=0A=
 * @adapter: board private structure=0A=
 **/=0A=
=0A=
static inline void=0A=
e1000_irq_disable(struct e1000_adapter *adapter)=0A=
{=0A=
    E1000_DBG("e1000_irq_disable\n");=0A=
=0A=
    /* Mask off all interrupts */=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, IMC, ~0);=0A=
    return;=0A=
}=0A=
=0A=
/**=0A=
 * e1000_irq_enable - Enable default interrupt generation settings=0A=
 * @adapter: board private structure=0A=
 **/=0A=
=0A=
static inline void=0A=
e1000_irq_enable(struct e1000_adapter *adapter)=0A=
{=0A=
    E1000_DBG("e1000_irq_enable\n");=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, IMS, adapter->int_mask);=0A=
    return;=0A=
}=0A=
=0A=
/**=0A=
 * e1000_intr - Interrupt Handler=0A=
 * @irq: interrupt number=0A=
 * @data: pointer to a network interface device structure=0A=
 * @pt_regs: CPU registers structure=0A=
 **/=0A=
=0A=
void=0A=
e1000_intr(int irq,=0A=
           void *data,=0A=
           struct pt_regs *regs)=0A=
{=0A=
    struct net_device *netdev =3D (struct net_device *) data;=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    54fc:	8cb00064 	lw	s0,100(a1)=0A=
    uint32_t icr;=0A=
    uint loop_count =3D E1000_MAX_INTR;=0A=
    5500:	24110001 	li	s1,1=0A=
    5504:	8e02000c 	lw	v0,12(s0)=0A=
    5508:	2c420002 	sltiu	v0,v0,2=0A=
    550c:	8e030008 	lw	v1,8(s0)=0A=
    5510:	2402ffff 	li	v0,-1=0A=
    5514:	ac6200d8 	sw	v0,216(v1)=0A=
=0A=
    E1000_DBG("e1000_intr\n");=0A=
=0A=
    e1000_irq_disable(adapter);=0A=
=0A=
    while(loop_count > 0 && (icr =3D E1000_READ_REG(&adapter->shared, =
ICR)) !=3D 0) {=0A=
    5518:	3c1300ff 	lui	s3,0xff=0A=
    551c:	3c12ff00 	lui	s2,0xff00=0A=
    5520:	24160001 	li	s6,1=0A=
    5524:	3c150000 	lui	s5,0x0=0A=
    5528:	26b50000 	addiu	s5,s5,0=0A=
    552c:	3c140000 	lui	s4,0x0=0A=
    5530:	269458dc 	addiu	s4,s4,22748=0A=
    5534:	8e07000c 	lw	a3,12(s0)=0A=
    5538:	2ce20002 	sltiu	v0,a3,2=0A=
    553c:	8e060008 	lw	a2,8(s0)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    5540:	8cc200c0 	lw	v0,192(a2)=0A=
	return __arch__swab32(x);=0A=
    5544:	3043ff00 	andi	v1,v0,0xff00=0A=
    5548:	00022e00 	sll	a1,v0,0x18=0A=
    554c:	00532024 	and	a0,v0,s3=0A=
    5550:	00031a00 	sll	v1,v1,0x8=0A=
    5554:	00a32825 	or	a1,a1,v1=0A=
    5558:	00042202 	srl	a0,a0,0x8=0A=
    555c:	00521024 	and	v0,v0,s2=0A=
    5560:	00a42825 	or	a1,a1,a0=0A=
    5564:	00021602 	srl	v0,v0,0x18=0A=
    5568:	00a22825 	or	a1,a1,v0=0A=
    556c:	10a00017 	beqz	a1,55cc <e1000_intr+0xf4>=0A=
    5570:	30a2000c 	andi	v0,a1,0xc=0A=
=0A=
        if(icr & (E1000_ICR_RXSEQ | E1000_ICR_LSC)) {=0A=
    5574:	1040000b 	beqz	v0,55a4 <e1000_intr+0xcc>=0A=
    5578:	00000000 	nop=0A=
            adapter->shared.get_link_status =3D 1;=0A=
    557c:	ae160058 	sw	s6,88(s0)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5580:	c202008c 	ll	v0,140(s0)=0A=
    5584:	34420008 	ori	v0,v0,0x8=0A=
    5588:	e202008c 	sc	v0,140(s0)=0A=
    558c:	1040fffc 	beqz	v0,5580 <e1000_intr+0xa8>=0A=
    5590:	00000000 	nop=0A=
            set_bit(E1000_LINK_STATUS_CHANGED, &adapter->flags);=0A=
            /* run the watchdog ASAP */=0A=
            mod_timer(&adapter->timer_id, jiffies);=0A=
    5594:	3c050000 	lui	a1,0x0=0A=
    5598:	8ca50000 	lw	a1,0(a1)=0A=
    559c:	02a0f809 	jalr	s5=0A=
    55a0:	26040094 	addiu	a0,s0,148=0A=
        }=0A=
=0A=
        e1000_clean_rx_irq(adapter);=0A=
    55a4:	0280f809 	jalr	s4=0A=
    55a8:	02002021 	move	a0,s0=0A=
        e1000_clean_tx_irq(adapter);=0A=
        loop_count--;=0A=
    55ac:	2631ffff 	addiu	s1,s1,-1=0A=
    55b0:	3c020000 	lui	v0,0x0=0A=
    55b4:	24425624 	addiu	v0,v0,22052=0A=
    55b8:	0040f809 	jalr	v0=0A=
    55bc:	02002021 	move	a0,s0=0A=
    }=0A=
    55c0:	1620ffdd 	bnez	s1,5538 <e1000_intr+0x60>=0A=
    55c4:	8e07000c 	lw	a3,12(s0)=0A=
    55c8:	8e060008 	lw	a2,8(s0)=0A=
    55cc:	2ce20002 	sltiu	v0,a3,2=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    55d0:	8e0500cc 	lw	a1,204(s0)=0A=
	return __arch__swab32(x);=0A=
    55d4:	30a4ff00 	andi	a0,a1,0xff00=0A=
    55d8:	00051600 	sll	v0,a1,0x18=0A=
    55dc:	00051a02 	srl	v1,a1,0x8=0A=
    55e0:	00042200 	sll	a0,a0,0x8=0A=
    55e4:	00441025 	or	v0,v0,a0=0A=
    55e8:	3063ff00 	andi	v1,v1,0xff00=0A=
    55ec:	00431025 	or	v0,v0,v1=0A=
    55f0:	00052e02 	srl	a1,a1,0x18=0A=
    55f4:	00451025 	or	v0,v0,a1=0A=
    55f8:	acc200d0 	sw	v0,208(a2)=0A=
=0A=
    e1000_irq_enable(adapter);=0A=
=0A=
    return;=0A=
}=0A=
    55fc:	8fbf002c 	lw	ra,44(sp)=0A=
    5600:	8fb60028 	lw	s6,40(sp)=0A=
    5604:	8fb50024 	lw	s5,36(sp)=0A=
    5608:	8fb40020 	lw	s4,32(sp)=0A=
    560c:	8fb3001c 	lw	s3,28(sp)=0A=
    5610:	8fb20018 	lw	s2,24(sp)=0A=
    5614:	8fb10014 	lw	s1,20(sp)=0A=
    5618:	8fb00010 	lw	s0,16(sp)=0A=
    561c:	03e00008 	jr	ra=0A=
    5620:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
00005624 <e1000_clean_tx_irq>:=0A=
    5624:	27bdffd0 	addiu	sp,sp,-48=0A=
    5628:	afb50024 	sw	s5,36(sp)=0A=
    562c:	afb40020 	sw	s4,32(sp)=0A=
    5630:	afbf002c 	sw	ra,44(sp)=0A=
    5634:	afb60028 	sw	s6,40(sp)=0A=
    5638:	afb3001c 	sw	s3,28(sp)=0A=
    563c:	afb20018 	sw	s2,24(sp)=0A=
    5640:	afb10014 	sw	s1,20(sp)=0A=
    5644:	afb00010 	sw	s0,16(sp)=0A=
    5648:	0080a021 	move	s4,a0=0A=
=0A=
/**=0A=
 * e1000_clean_tx_irq - Reclaim resources after transmit completes=0A=
 * @adapter: board private structure=0A=
 **/=0A=
=0A=
static void=0A=
e1000_clean_tx_irq(struct e1000_adapter *adapter)=0A=
{=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    int i;=0A=
=0A=
    struct e1000_tx_desc *tx_desc;=0A=
    struct net_device *netdev =3D adapter->netdev;=0A=
=0A=
    E1000_DBG("e1000_clean_tx_irq\n");=0A=
=0A=
    i =3D adapter->tx_ring.next_to_clean;=0A=
    564c:	8e9200fc 	lw	s2,252(s4)=0A=
    tx_desc =3D E1000_TX_DESC(adapter->tx_ring, i);=0A=
    5650:	8e8400e4 	lw	a0,228(s4)=0A=
=0A=
    while(tx_desc->upper.data & cpu_to_le32(E1000_TXD_STAT_DD)) {=0A=
    5654:	3c050100 	lui	a1,0x100=0A=
    5658:	00121900 	sll	v1,s2,0x4=0A=
    565c:	0083a821 	addu	s5,a0,v1=0A=
    5660:	8ea2000c 	lw	v0,12(s5)=0A=
    5664:	00451024 	and	v0,v0,a1=0A=
    5668:	10400051 	beqz	v0,57b0 <e1000_clean_tx_irq+0x18c>=0A=
    566c:	8e960148 	lw	s6,328(s4)=0A=
    5670:	269300f4 	addiu	s3,s4,244=0A=
=0A=
        if(adapter->tx_ring.buffer_info[i].dma !=3D 0) {=0A=
    5674:	8e860100 	lw	a2,256(s4)=0A=
    5678:	00121040 	sll	v0,s2,0x1=0A=
    567c:	00521021 	addu	v0,v0,s2=0A=
    5680:	000288c0 	sll	s1,v0,0x3=0A=
    5684:	02262021 	addu	a0,s1,a2=0A=
    5688:	8c820008 	lw	v0,8(a0)=0A=
    568c:	8c83000c 	lw	v1,12(a0)=0A=
    5690:	00431025 	or	v0,v0,v1=0A=
    5694:	10400006 	beqz	v0,56b0 <e1000_clean_tx_irq+0x8c>=0A=
    5698:	24050001 	li	a1,1=0A=
            pci_unmap_page(pdev, adapter->tx_ring.buffer_info[i].dma,=0A=
                           adapter->tx_ring.buffer_info[i].length,=0A=
                           PCI_DMA_TODEVICE);=0A=
            adapter->tx_ring.buffer_info[i].dma =3D 0;=0A=
    569c:	00001021 	move	v0,zero=0A=
    56a0:	00001821 	move	v1,zero=0A=
    56a4:	ac820008 	sw	v0,8(a0)=0A=
    56a8:	ac83000c 	sw	v1,12(a0)=0A=
    56ac:	8e860100 	lw	a2,256(s4)=0A=
        }=0A=
=0A=
        if(adapter->tx_ring.buffer_info[i].skb !=3D NULL) {=0A=
    56b0:	02261021 	addu	v0,s1,a2=0A=
    56b4:	8c460000 	lw	a2,0(v0)=0A=
    56b8:	10c00026 	beqz	a2,5754 <e1000_clean_tx_irq+0x130>=0A=
    56bc:	24c40070 	addiu	a0,a2,112=0A=
extern __inline__ int atomic_sub_return(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp, result;=0A=
=0A=
	__asm__ __volatile__(=0A=
    56c0:	c0830000 	ll	v1,0(a0)=0A=
    56c4:	00651023 	subu	v0,v1,a1=0A=
    56c8:	e0820000 	sc	v0,0(a0)=0A=
    56cc:	1040fffc 	beqz	v0,56c0 <e1000_clean_tx_irq+0x9c>=0A=
    56d0:	00651023 	subu	v0,v1,a1=0A=
 * is executing from interrupt context.=0A=
 */=0A=
static inline void dev_kfree_skb_irq(struct sk_buff *skb)=0A=
{=0A=
	if (atomic_dec_and_test(&skb->users)) {=0A=
    56d4:	5440001d 	bnezl	v0,574c <e1000_clean_tx_irq+0x128>=0A=
    56d8:	8e820100 	lw	v0,256(s4)=0A=
		int cpu =3Dsmp_processor_id();=0A=
		unsigned long flags;=0A=
=0A=
		local_irq_save(flags);=0A=
    56dc:	40106000 	mfc0	s0,$12=0A=
    56e0:	00000000 	nop=0A=
    56e4:	36010001 	ori	at,s0,0x1=0A=
    56e8:	38210001 	xori	at,at,0x1=0A=
    56ec:	40816000 	mtc0	at,$12=0A=
    56f0:	00000040 	sll	zero,zero,0x1=0A=
    56f4:	00000040 	sll	zero,zero,0x1=0A=
    56f8:	00000040 	sll	zero,zero,0x1=0A=
		skb->next =3D softnet_data[cpu].completion_queue;=0A=
    56fc:	3c030000 	lui	v1,0x0=0A=
    5700:	8c630020 	lw	v1,32(v1)=0A=
		softnet_data[cpu].completion_queue =3D skb;=0A=
		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);=0A=
    5704:	00002021 	move	a0,zero=0A=
    5708:	acc30000 	sw	v1,0(a2)=0A=
    570c:	3c020000 	lui	v0,0x0=0A=
    5710:	24420000 	addiu	v0,v0,0=0A=
    5714:	3c010000 	lui	at,0x0=0A=
    5718:	ac260020 	sw	a2,32(at)=0A=
    571c:	0040f809 	jalr	v0=0A=
    5720:	24050001 	li	a1,1=0A=
		local_irq_restore(flags);=0A=
    5724:	40016000 	mfc0	at,$12=0A=
    5728:	32100001 	andi	s0,s0,0x1=0A=
    572c:	34210001 	ori	at,at,0x1=0A=
    5730:	38210001 	xori	at,at,0x1=0A=
    5734:	02018025 	or	s0,s0,at=0A=
    5738:	40906000 	mtc0	s0,$12=0A=
	...=0A=
            dev_kfree_skb_irq(adapter->tx_ring.buffer_info[i].skb);=0A=
            adapter->tx_ring.buffer_info[i].skb =3D NULL;=0A=
    5748:	8e820100 	lw	v0,256(s4)=0A=
    574c:	02221021 	addu	v0,s1,v0=0A=
    5750:	ac400000 	sw	zero,0(v0)=0A=
 * Atomically adds @i to @v.  Note that the guaranteed useful range=0A=
 * of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
    5754:	24020001 	li	v0,1=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5758:	c2640000 	ll	a0,0(s3)=0A=
    575c:	00822021 	addu	a0,a0,v0=0A=
    5760:	e2640000 	sc	a0,0(s3)=0A=
    5764:	1080fffc 	beqz	a0,5758 <e1000_clean_tx_irq+0x134>=0A=
    5768:	00000000 	nop=0A=
        }=0A=
=0A=
        atomic_inc(&adapter->tx_ring.unused);=0A=
        i =3D (i + 1) % adapter->tx_ring.count;=0A=
    576c:	8e8300f0 	lw	v1,240(s4)=0A=
    5770:	26420001 	addiu	v0,s2,1=0A=
=0A=
        tx_desc->upper.data =3D 0;=0A=
        tx_desc =3D E1000_TX_DESC(adapter->tx_ring, i);=0A=
    }=0A=
    5774:	3c060100 	lui	a2,0x100=0A=
    5778:	0043001b 	divu	zero,v0,v1=0A=
    577c:	50600001 	beqzl	v1,5784 <e1000_clean_tx_irq+0x160>=0A=
    5780:	0007000d 	break	0x7=0A=
    5784:	aea0000c 	sw	zero,12(s5)=0A=
    5788:	8e8400e4 	lw	a0,228(s4)=0A=
    578c:	00002810 	mfhi	a1=0A=
    5790:	00a09021 	move	s2,a1=0A=
    5794:	00000000 	nop=0A=
    5798:	00121900 	sll	v1,s2,0x4=0A=
    579c:	0083a821 	addu	s5,a0,v1=0A=
    57a0:	8ea2000c 	lw	v0,12(s5)=0A=
    57a4:	00461024 	and	v0,v0,a2=0A=
    57a8:	5440ffb3 	bnezl	v0,5678 <e1000_clean_tx_irq+0x54>=0A=
    57ac:	8e860100 	lw	a2,256(s4)=0A=
=0A=
    adapter->tx_ring.next_to_clean =3D i;=0A=
=0A=
    if(adapter->tx_ring.next_to_clean =3D=3D =
adapter->tx_ring.next_to_use)=0A=
    57b0:	8e8200f8 	lw	v0,248(s4)=0A=
    57b4:	16420004 	bne	s2,v0,57c8 <e1000_clean_tx_irq+0x1a4>=0A=
    57b8:	ae9200fc 	sw	s2,252(s4)=0A=
        atomic_set(&adapter->tx_timeout, 0);=0A=
    57bc:	ae80010c 	sw	zero,268(s4)=0A=
    57c0:	080015f5 	j	57d4 <e1000_clean_tx_irq+0x1b0>=0A=
    57c4:	26c5002c 	addiu	a1,s6,44=0A=
    else=0A=
        atomic_set(&adapter->tx_timeout, 3);=0A=
    57c8:	24020003 	li	v0,3=0A=
    57cc:	ae82010c 	sw	v0,268(s4)=0A=
 * @nr: bit number to test=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
    57d0:	26c5002c 	addiu	a1,s6,44=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    57d4:	8ca20000 	lw	v0,0(a1)=0A=
    57d8:	30420001 	andi	v0,v0,0x1=0A=
=0A=
    if(netif_queue_stopped(netdev) &&=0A=
       (atomic_read(&adapter->tx_ring.unused) >=0A=
        (adapter->tx_ring.count * 3 / 4))) {=0A=
    57dc:	10400036 	beqz	v0,58b8 <e1000_clean_tx_irq+0x294>=0A=
    57e0:	8fbf002c 	lw	ra,44(sp)=0A=
    57e4:	8e8200f0 	lw	v0,240(s4)=0A=
    57e8:	8e8400f4 	lw	a0,244(s4)=0A=
    57ec:	00021840 	sll	v1,v0,0x1=0A=
    57f0:	00621821 	addu	v1,v1,v0=0A=
    57f4:	00031882 	srl	v1,v1,0x2=0A=
    57f8:	0064182b 	sltu	v1,v1,a0=0A=
    57fc:	5060002f 	beqzl	v1,58bc <e1000_clean_tx_irq+0x298>=0A=
    5800:	8fb60028 	lw	s6,40(sp)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5804:	24020001 	li	v0,1=0A=
    5808:	c0a40000 	ll	a0,0(a1)=0A=
    580c:	00821825 	or	v1,a0,v0=0A=
    5810:	00621826 	xor	v1,v1,v0=0A=
    5814:	e0a30000 	sc	v1,0(a1)=0A=
    5818:	1060fffb 	beqz	v1,5808 <e1000_clean_tx_irq+0x1e4>=0A=
    581c:	00821824 	and	v1,a0,v0=0A=
}=0A=
=0A=
static inline void netif_wake_queue(struct net_device *dev)=0A=
{=0A=
	if (test_and_clear_bit(__LINK_STATE_XOFF, &dev->state))=0A=
    5820:	50600025 	beqzl	v1,58b8 <e1000_clean_tx_irq+0x294>=0A=
    5824:	8fbf002c 	lw	ra,44(sp)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5828:	24020008 	li	v0,8=0A=
    582c:	c0a40000 	ll	a0,0(a1)=0A=
    5830:	00821825 	or	v1,a0,v0=0A=
    5834:	e0a30000 	sc	v1,0(a1)=0A=
    5838:	1060fffc 	beqz	v1,582c <e1000_clean_tx_irq+0x208>=0A=
    583c:	00821824 	and	v1,a0,v0=0A=
#define HAVE_NETIF_QUEUE=0A=
=0A=
static inline void __netif_schedule(struct net_device *dev)=0A=
{=0A=
	if (!test_and_set_bit(__LINK_STATE_SCHED, &dev->state)) {=0A=
    5840:	5460001d 	bnezl	v1,58b8 <e1000_clean_tx_irq+0x294>=0A=
    5844:	8fbf002c 	lw	ra,44(sp)=0A=
		unsigned long flags;=0A=
		int cpu =3D smp_processor_id();=0A=
=0A=
		local_irq_save(flags);=0A=
    5848:	40106000 	mfc0	s0,$12=0A=
    584c:	00000000 	nop=0A=
    5850:	36010001 	ori	at,s0,0x1=0A=
    5854:	38210001 	xori	at,at,0x1=0A=
    5858:	40816000 	mtc0	at,$12=0A=
    585c:	00000040 	sll	zero,zero,0x1=0A=
    5860:	00000040 	sll	zero,zero,0x1=0A=
    5864:	00000040 	sll	zero,zero,0x1=0A=
		dev->next_sched =3D softnet_data[cpu].output_queue;=0A=
    5868:	3c030000 	lui	v1,0x0=0A=
    586c:	8c63001c 	lw	v1,28(v1)=0A=
		softnet_data[cpu].output_queue =3D dev;=0A=
		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);=0A=
    5870:	00002021 	move	a0,zero=0A=
    5874:	aec30038 	sw	v1,56(s6)=0A=
    5878:	3c020000 	lui	v0,0x0=0A=
    587c:	24420000 	addiu	v0,v0,0=0A=
    5880:	3c010000 	lui	at,0x0=0A=
    5884:	ac36001c 	sw	s6,28(at)=0A=
    5888:	0040f809 	jalr	v0=0A=
    588c:	24050001 	li	a1,1=0A=
		local_irq_restore(flags);=0A=
    5890:	40016000 	mfc0	at,$12=0A=
    5894:	32100001 	andi	s0,s0,0x1=0A=
    5898:	34210001 	ori	at,at,0x1=0A=
    589c:	38210001 	xori	at,at,0x1=0A=
    58a0:	02018025 	or	s0,s0,at=0A=
    58a4:	40906000 	mtc0	s0,$12=0A=
	...=0A=
=0A=
#ifdef IANS=0A=
        if((adapter->iANSdata->iANS_status =3D=3D IANS_COMMUNICATION_UP) =
&&=0A=
           (adapter->iANSdata->reporting_mode =3D=3D =
IANS_STATUS_REPORTING_ON))=0A=
            if(ans_notify)=0A=
                ans_notify(netdev, IANS_IND_XMIT_QUEUE_READY);=0A=
#endif=0A=
        netif_wake_queue(netdev);=0A=
    }=0A=
=0A=
    return;=0A=
}=0A=
    58b4:	8fbf002c 	lw	ra,44(sp)=0A=
    58b8:	8fb60028 	lw	s6,40(sp)=0A=
    58bc:	8fb50024 	lw	s5,36(sp)=0A=
    58c0:	8fb40020 	lw	s4,32(sp)=0A=
    58c4:	8fb3001c 	lw	s3,28(sp)=0A=
    58c8:	8fb20018 	lw	s2,24(sp)=0A=
    58cc:	8fb10014 	lw	s1,20(sp)=0A=
    58d0:	8fb00010 	lw	s0,16(sp)=0A=
    58d4:	03e00008 	jr	ra=0A=
    58d8:	27bd0030 	addiu	sp,sp,48=0A=
=0A=
000058dc <e1000_clean_rx_irq>:=0A=
    58dc:	27bdffc0 	addiu	sp,sp,-64=0A=
    58e0:	afb60030 	sw	s6,48(sp)=0A=
    58e4:	afb30024 	sw	s3,36(sp)=0A=
    58e8:	afbf003c 	sw	ra,60(sp)=0A=
    58ec:	afbe0038 	sw	s8,56(sp)=0A=
    58f0:	afb70034 	sw	s7,52(sp)=0A=
    58f4:	afb5002c 	sw	s5,44(sp)=0A=
    58f8:	afb40028 	sw	s4,40(sp)=0A=
    58fc:	afb20020 	sw	s2,32(sp)=0A=
    5900:	afb1001c 	sw	s1,28(sp)=0A=
    5904:	afb00018 	sw	s0,24(sp)=0A=
    5908:	0080b021 	move	s6,a0=0A=
=0A=
/**=0A=
 * e1000_clean_rx_irq - Send received data up the network stack,=0A=
 * @adapter: board private structure=0A=
 **/=0A=
=0A=
static void=0A=
e1000_clean_rx_irq(struct e1000_adapter *adapter)=0A=
{=0A=
    struct net_device *netdev =3D adapter->netdev;=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    struct e1000_rx_desc *rx_desc;=0A=
    int i;=0A=
    uint32_t length;=0A=
    struct sk_buff *skb;=0A=
    uint8_t last_byte;=0A=
    unsigned long flags;=0A=
=0A=
    E1000_DBG("e1000_clean_rx_irq\n");=0A=
=0A=
    i =3D adapter->rx_ring.next_to_clean;=0A=
    590c:	8ed50128 	lw	s5,296(s6)=0A=
    5910:	8ec30148 	lw	v1,328(s6)=0A=
    rx_desc =3D E1000_RX_DESC(adapter->rx_ring, i);=0A=
    5914:	8ec20110 	lw	v0,272(s6)=0A=
    5918:	afa30010 	sw	v1,16(sp)=0A=
    591c:	00151900 	sll	v1,s5,0x4=0A=
    5920:	00439821 	addu	s3,v0,v1=0A=
=0A=
    while(rx_desc->status & E1000_RXD_STAT_DD) {=0A=
    5924:	9267000c 	lbu	a3,12(s3)=0A=
    5928:	30e20001 	andi	v0,a3,0x1=0A=
    592c:	10400120 	beqz	v0,5db0 <e1000_clean_rx_irq+0x4d4>=0A=
    5930:	26d40120 	addiu	s4,s6,288=0A=
        pci_unmap_single(pdev, adapter->rx_ring.buffer_info[i].dma,=0A=
                         adapter->rx_ring.buffer_info[i].length,=0A=
                         PCI_DMA_FROMDEVICE);=0A=
=0A=
        skb =3D adapter->rx_ring.buffer_info[i].skb;=0A=
    5934:	96640008 	lhu	a0,8(s3)=0A=
    5938:	8ec5012c 	lw	a1,300(s6)=0A=
    593c:	0015f040 	sll	s8,s5,0x1=0A=
    5940:	03d51021 	addu	v0,s8,s5=0A=
    5944:	0002b8c0 	sll	s7,v0,0x3=0A=
=0A=
=0A=
static __inline__ __const__ __u16 __fswab16(__u16 x)=0A=
{=0A=
	return __arch__swab16(x);=0A=
    5948:	00041a02 	srl	v1,a0,0x8=0A=
    594c:	00042200 	sll	a0,a0,0x8=0A=
    5950:	00832025 	or	a0,a0,v1=0A=
    5954:	02e52821 	addu	a1,s7,a1=0A=
        length =3D le16_to_cpu(rx_desc->length);=0A=
=0A=
        if(!(rx_desc->status & E1000_RXD_STAT_EOP)) {=0A=
    5958:	30e20002 	andi	v0,a3,0x2=0A=
    595c:	8cb10000 	lw	s1,0(a1)=0A=
    5960:	1440003d 	bnez	v0,5a58 <e1000_clean_rx_irq+0x17c>=0A=
    5964:	3092ffff 	andi	s2,a0,0xffff=0A=
	return result;=0A=
}=0A=
=0A=
extern __inline__ int atomic_sub_return(int i, atomic_t * v)=0A=
{=0A=
    5968:	24120001 	li	s2,1=0A=
    596c:	26220070 	addiu	v0,s1,112=0A=
	unsigned long temp, result;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5970:	c0440000 	ll	a0,0(v0)=0A=
    5974:	00921823 	subu	v1,a0,s2=0A=
    5978:	e0430000 	sc	v1,0(v0)=0A=
    597c:	1060fffc 	beqz	v1,5970 <e1000_clean_rx_irq+0x94>=0A=
    5980:	00921823 	subu	v1,a0,s2=0A=
 * is executing from interrupt context.=0A=
 */=0A=
static inline void dev_kfree_skb_irq(struct sk_buff *skb)=0A=
{=0A=
	if (atomic_dec_and_test(&skb->users)) {=0A=
    5984:	1460001d 	bnez	v1,59fc <e1000_clean_rx_irq+0x120>=0A=
    5988:	02602021 	move	a0,s3=0A=
		int cpu =3Dsmp_processor_id();=0A=
		unsigned long flags;=0A=
=0A=
		local_irq_save(flags);=0A=
    598c:	40106000 	mfc0	s0,$12=0A=
    5990:	00000000 	nop=0A=
    5994:	36010001 	ori	at,s0,0x1=0A=
    5998:	38210001 	xori	at,at,0x1=0A=
    599c:	40816000 	mtc0	at,$12=0A=
    59a0:	00000040 	sll	zero,zero,0x1=0A=
    59a4:	00000040 	sll	zero,zero,0x1=0A=
    59a8:	00000040 	sll	zero,zero,0x1=0A=
		skb->next =3D softnet_data[cpu].completion_queue;=0A=
    59ac:	3c030000 	lui	v1,0x0=0A=
    59b0:	8c630020 	lw	v1,32(v1)=0A=
		softnet_data[cpu].completion_queue =3D skb;=0A=
		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);=0A=
    59b4:	00002021 	move	a0,zero=0A=
    59b8:	ae230000 	sw	v1,0(s1)=0A=
    59bc:	3c020000 	lui	v0,0x0=0A=
    59c0:	24420000 	addiu	v0,v0,0=0A=
    59c4:	3c010000 	lui	at,0x0=0A=
    59c8:	ac310020 	sw	s1,32(at)=0A=
    59cc:	0040f809 	jalr	v0=0A=
    59d0:	24050001 	li	a1,1=0A=
		local_irq_restore(flags);=0A=
    59d4:	40016000 	mfc0	at,$12=0A=
    59d8:	32100001 	andi	s0,s0,0x1=0A=
    59dc:	34210001 	ori	at,at,0x1=0A=
    59e0:	38210001 	xori	at,at,0x1=0A=
    59e4:	02018025 	or	s0,s0,at=0A=
    59e8:	40906000 	mtc0	s0,$12=0A=
	...=0A=
=0A=
            /* All receives must fit into a single buffer */=0A=
=0A=
            E1000_DBG("Receive packet consumed multiple buffers\n");=0A=
=0A=
            dev_kfree_skb_irq(skb);=0A=
            memset(rx_desc, 0, 16);=0A=
    59f8:	02602021 	move	a0,s3=0A=
    59fc:	00002821 	move	a1,zero=0A=
    5a00:	3c020000 	lui	v0,0x0=0A=
    5a04:	24420000 	addiu	v0,v0,0=0A=
    5a08:	0040f809 	jalr	v0=0A=
    5a0c:	24060010 	li	a2,16=0A=
	...=0A=
            mb();=0A=
            adapter->rx_ring.buffer_info[i].skb =3D NULL;=0A=
    5a30:	8ec2012c 	lw	v0,300(s6)=0A=
    5a34:	02e21021 	addu	v0,s7,v0=0A=
    5a38:	ac400000 	sw	zero,0(v0)=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5a3c:	c2830000 	ll	v1,0(s4)=0A=
    5a40:	00721821 	addu	v1,v1,s2=0A=
    5a44:	e2830000 	sc	v1,0(s4)=0A=
    5a48:	1060fffc 	beqz	v1,5a3c <e1000_clean_rx_irq+0x160>=0A=
    5a4c:	00000000 	nop=0A=
=0A=
            atomic_inc(&adapter->rx_ring.unused);=0A=
=0A=
            i =3D (i + 1) % adapter->rx_ring.count;=0A=
=0A=
            rx_desc =3D E1000_RX_DESC(adapter->rx_ring, i);=0A=
            continue;=0A=
    5a50:	0800175b 	j	5d6c <e1000_clean_rx_irq+0x490>=0A=
    5a54:	8ec6011c 	lw	a2,284(s6)=0A=
        }=0A=
=0A=
        if(rx_desc->errors & E1000_RXD_ERR_FRAME_ERR_MASK) {=0A=
    5a58:	9262000d 	lbu	v0,13(s3)=0A=
    5a5c:	30440097 	andi	a0,v0,0x97=0A=
    5a60:	5080007b 	beqzl	a0,5c50 <e1000_clean_rx_irq+0x374>=0A=
    5a64:	8e220060 	lw	v0,96(s1)=0A=
=0A=
            last_byte =3D *(skb->data + length - 1);=0A=
    5a68:	8e220080 	lw	v0,128(s1)=0A=
=0A=
            if(TBI_ACCEPT=0A=
    5a6c:	8ec30060 	lw	v1,96(s6)=0A=
    5a70:	00521021 	addu	v0,v0,s2=0A=
    5a74:	10600037 	beqz	v1,5b54 <e1000_clean_rx_irq+0x278>=0A=
    5a78:	9042ffff 	lbu	v0,-1(v0)=0A=
    5a7c:	38830001 	xori	v1,a0,0x1=0A=
    5a80:	3842000f 	xori	v0,v0,0xf=0A=
    5a84:	2c630001 	sltiu	v1,v1,1=0A=
    5a88:	2c420001 	sltiu	v0,v0,1=0A=
    5a8c:	00621824 	and	v1,v1,v0=0A=
    5a90:	50600031 	beqzl	v1,5b58 <e1000_clean_rx_irq+0x27c>=0A=
    5a94:	24120001 	li	s2,1=0A=
    5a98:	9662000e 	lhu	v0,14(s3)=0A=
    5a9c:	1440000b 	bnez	v0,5acc <e1000_clean_rx_irq+0x1f0>=0A=
    5aa0:	8ec2003c 	lw	v0,60(s6)=0A=
    5aa4:	2e430041 	sltiu	v1,s2,65=0A=
    5aa8:	38630001 	xori	v1,v1,0x1=0A=
    5aac:	24420001 	addiu	v0,v0,1=0A=
    5ab0:	0052102b 	sltu	v0,v0,s2=0A=
    5ab4:	38420001 	xori	v0,v0,0x1=0A=
    5ab8:	00431024 	and	v0,v0,v1=0A=
    5abc:	1440000b 	bnez	v0,5aec <e1000_clean_rx_irq+0x210>=0A=
    5ac0:	00000000 	nop=0A=
    5ac4:	080016d6 	j	5b58 <e1000_clean_rx_irq+0x27c>=0A=
    5ac8:	24120001 	li	s2,1=0A=
    5acc:	2e43003d 	sltiu	v1,s2,61=0A=
    5ad0:	38630001 	xori	v1,v1,0x1=0A=
    5ad4:	2442fffd 	addiu	v0,v0,-3=0A=
    5ad8:	0052102b 	sltu	v0,v0,s2=0A=
    5adc:	38420001 	xori	v0,v0,0x1=0A=
    5ae0:	00431024 	and	v0,v0,v1=0A=
    5ae4:	5040001c 	beqzl	v0,5b58 <e1000_clean_rx_irq+0x27c>=0A=
    5ae8:	24120001 	li	s2,1=0A=
               (&adapter->shared, rx_desc->special, rx_desc->errors, =
length,=0A=
                last_byte)) {=0A=
                spin_lock_irqsave(&adapter->stats_lock, flags);=0A=
    5aec:	40106000 	mfc0	s0,$12=0A=
    5af0:	00000000 	nop=0A=
    5af4:	36010001 	ori	at,s0,0x1=0A=
    5af8:	38210001 	xori	at,at,0x1=0A=
    5afc:	40816000 	mtc0	at,$12=0A=
    5b00:	00000040 	sll	zero,zero,0x1=0A=
    5b04:	00000040 	sll	zero,zero,0x1=0A=
    5b08:	00000040 	sll	zero,zero,0x1=0A=
                e1000_tbi_adjust_stats(&adapter->shared, &adapter->stats,=0A=
    5b0c:	26c40008 	addiu	a0,s6,8=0A=
    5b10:	8e270080 	lw	a3,128(s1)=0A=
    5b14:	26c501d8 	addiu	a1,s6,472=0A=
    5b18:	3c020000 	lui	v0,0x0=0A=
    5b1c:	24420000 	addiu	v0,v0,0=0A=
    5b20:	0040f809 	jalr	v0=0A=
    5b24:	02403021 	move	a2,s2=0A=
                                       length, skb->data);=0A=
                spin_unlock_irqrestore(&adapter->stats_lock, flags);=0A=
    5b28:	40016000 	mfc0	at,$12=0A=
    5b2c:	32100001 	andi	s0,s0,0x1=0A=
    5b30:	34210001 	ori	at,at,0x1=0A=
    5b34:	38210001 	xori	at,at,0x1=0A=
    5b38:	02018025 	or	s0,s0,at=0A=
    5b3c:	40906000 	mtc0	s0,$12=0A=
	...=0A=
                length--;=0A=
            } else {=0A=
    5b4c:	08001713 	j	5c4c <e1000_clean_rx_irq+0x370>=0A=
    5b50:	2652ffff 	addiu	s2,s2,-1=0A=
	return result;=0A=
}=0A=
=0A=
extern __inline__ int atomic_sub_return(int i, atomic_t * v)=0A=
{=0A=
    5b54:	24120001 	li	s2,1=0A=
    5b58:	26220070 	addiu	v0,s1,112=0A=
	unsigned long temp, result;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5b5c:	c0440000 	ll	a0,0(v0)=0A=
    5b60:	00921823 	subu	v1,a0,s2=0A=
    5b64:	e0430000 	sc	v1,0(v0)=0A=
    5b68:	1060fffc 	beqz	v1,5b5c <e1000_clean_rx_irq+0x280>=0A=
    5b6c:	00921823 	subu	v1,a0,s2=0A=
 * is executing from interrupt context.=0A=
 */=0A=
static inline void dev_kfree_skb_irq(struct sk_buff *skb)=0A=
{=0A=
	if (atomic_dec_and_test(&skb->users)) {=0A=
    5b70:	1460001d 	bnez	v1,5be8 <e1000_clean_rx_irq+0x30c>=0A=
    5b74:	02602021 	move	a0,s3=0A=
		int cpu =3Dsmp_processor_id();=0A=
		unsigned long flags;=0A=
=0A=
		local_irq_save(flags);=0A=
    5b78:	40106000 	mfc0	s0,$12=0A=
    5b7c:	00000000 	nop=0A=
    5b80:	36010001 	ori	at,s0,0x1=0A=
    5b84:	38210001 	xori	at,at,0x1=0A=
    5b88:	40816000 	mtc0	at,$12=0A=
    5b8c:	00000040 	sll	zero,zero,0x1=0A=
    5b90:	00000040 	sll	zero,zero,0x1=0A=
    5b94:	00000040 	sll	zero,zero,0x1=0A=
		skb->next =3D softnet_data[cpu].completion_queue;=0A=
    5b98:	3c030000 	lui	v1,0x0=0A=
    5b9c:	8c630020 	lw	v1,32(v1)=0A=
		softnet_data[cpu].completion_queue =3D skb;=0A=
		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);=0A=
    5ba0:	00002021 	move	a0,zero=0A=
    5ba4:	ae230000 	sw	v1,0(s1)=0A=
    5ba8:	3c020000 	lui	v0,0x0=0A=
    5bac:	24420000 	addiu	v0,v0,0=0A=
    5bb0:	3c010000 	lui	at,0x0=0A=
    5bb4:	ac310020 	sw	s1,32(at)=0A=
    5bb8:	0040f809 	jalr	v0=0A=
    5bbc:	24050001 	li	a1,1=0A=
		local_irq_restore(flags);=0A=
    5bc0:	40016000 	mfc0	at,$12=0A=
    5bc4:	32100001 	andi	s0,s0,0x1=0A=
    5bc8:	34210001 	ori	at,at,0x1=0A=
    5bcc:	38210001 	xori	at,at,0x1=0A=
    5bd0:	02018025 	or	s0,s0,at=0A=
    5bd4:	40906000 	mtc0	s0,$12=0A=
	...=0A=
=0A=
                E1000_DBG("Receive Errors Reported by Hardware\n");=0A=
=0A=
                dev_kfree_skb_irq(skb);=0A=
                memset(rx_desc, 0, 16);=0A=
    5be4:	02602021 	move	a0,s3=0A=
    5be8:	00002821 	move	a1,zero=0A=
    5bec:	3c020000 	lui	v0,0x0=0A=
    5bf0:	24420000 	addiu	v0,v0,0=0A=
    5bf4:	0040f809 	jalr	v0=0A=
    5bf8:	24060010 	li	a2,16=0A=
	...=0A=
                mb();=0A=
                adapter->rx_ring.buffer_info[i].skb =3D NULL;=0A=
    5c1c:	8ec3012c 	lw	v1,300(s6)=0A=
    5c20:	03d51021 	addu	v0,s8,s5=0A=
    5c24:	000210c0 	sll	v0,v0,0x3=0A=
    5c28:	00431021 	addu	v0,v0,v1=0A=
    5c2c:	ac400000 	sw	zero,0(v0)=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5c30:	c2830000 	ll	v1,0(s4)=0A=
    5c34:	00721821 	addu	v1,v1,s2=0A=
    5c38:	e2830000 	sc	v1,0(s4)=0A=
    5c3c:	1060fffc 	beqz	v1,5c30 <e1000_clean_rx_irq+0x354>=0A=
    5c40:	00000000 	nop=0A=
=0A=
                atomic_inc(&adapter->rx_ring.unused);=0A=
                i =3D (i + 1) % adapter->rx_ring.count;=0A=
=0A=
                rx_desc =3D E1000_RX_DESC(adapter->rx_ring, i);=0A=
                continue;=0A=
    5c44:	0800175b 	j	5d6c <e1000_clean_rx_irq+0x490>=0A=
    5c48:	8ec6011c 	lw	a2,284(s6)=0A=
}=0A=
=0A=
static inline int skb_is_nonlinear(const struct sk_buff *skb)=0A=
{=0A=
	return skb->data_len;=0A=
    5c4c:	8e220060 	lw	v0,96(s1)=0A=
}=0A=
=0A=
static inline int skb_headlen(const struct sk_buff *skb)=0A=
{=0A=
	return skb->len - skb->data_len;=0A=
}=0A=
=0A=
#define SKB_PAGE_ASSERT(skb) do { if (skb_shinfo(skb)->nr_frags) BUG(); =
} while (0)=0A=
#define SKB_FRAG_ASSERT(skb) do { if (skb_shinfo(skb)->frag_list) BUG(); =
} while (0)=0A=
#define SKB_LINEAR_ASSERT(skb) do { if (skb_is_nonlinear(skb)) BUG(); } =
while (0)=0A=
=0A=
/*=0A=
 *	Add data to an sk_buff=0A=
 */=0A=
 =0A=
static inline unsigned char *__skb_put(struct sk_buff *skb, unsigned int =
len)=0A=
{=0A=
	unsigned char *tmp=3Dskb->tail;=0A=
	SKB_LINEAR_ASSERT(skb);=0A=
	skb->tail+=3Dlen;=0A=
	skb->len+=3Dlen;=0A=
	return tmp;=0A=
}=0A=
=0A=
/**=0A=
 *	skb_put - add data to a buffer=0A=
 *	@skb: buffer to use =0A=
 *	@len: amount of data to add=0A=
 *=0A=
 *	This function extends the used data area of the buffer. If this would=0A=
 *	exceed the total buffer size the kernel will panic. A pointer to the=0A=
 *	first byte of the extra data is returned.=0A=
 */=0A=
 =0A=
static inline unsigned char *skb_put(struct sk_buff *skb, unsigned int =
len)=0A=
{=0A=
	unsigned char *tmp=3Dskb->tail;=0A=
	SKB_LINEAR_ASSERT(skb);=0A=
    5c50:	1040000a 	beqz	v0,5c7c <e1000_clean_rx_irq+0x3a0>=0A=
    5c54:	2650fffc 	addiu	s0,s2,-4=0A=
    5c58:	3c040000 	lui	a0,0x0=0A=
    5c5c:	24840000 	addiu	a0,a0,0=0A=
    5c60:	3c050000 	lui	a1,0x0=0A=
    5c64:	24a500b4 	addiu	a1,a1,180=0A=
    5c68:	3c020000 	lui	v0,0x0=0A=
    5c6c:	24420000 	addiu	v0,v0,0=0A=
    5c70:	0040f809 	jalr	v0=0A=
    5c74:	24060315 	li	a2,789=0A=
    5c78:	ac000000 	sw	zero,0(zero)=0A=
	skb->tail+=3Dlen;=0A=
    5c7c:	8e220084 	lw	v0,132(s1)=0A=
	skb->len+=3Dlen;=0A=
    5c80:	8e23005c 	lw	v1,92(s1)=0A=
	if(skb->tail>skb->end) {=0A=
    5c84:	8e240088 	lw	a0,136(s1)=0A=
    5c88:	00501021 	addu	v0,v0,s0=0A=
    5c8c:	00701821 	addu	v1,v1,s0=0A=
    5c90:	0082202b 	sltu	a0,a0,v0=0A=
    5c94:	ae23005c 	sw	v1,92(s1)=0A=
    5c98:	10800008 	beqz	a0,5cbc <e1000_clean_rx_irq+0x3e0>=0A=
    5c9c:	ae220084 	sw	v0,132(s1)=0A=
		skb_over_panic(skb, len, current_text_addr());=0A=
    5ca0:	02002821 	move	a1,s0=0A=
    5ca4:	3c060000 	lui	a2,0x0=0A=
    5ca8:	24c65ca0 	addiu	a2,a2,23712=0A=
    5cac:	3c020000 	lui	v0,0x0=0A=
    5cb0:	24420000 	addiu	v0,v0,0=0A=
    5cb4:	0040f809 	jalr	v0=0A=
    5cb8:	02202021 	move	a0,s1=0A=
            }=0A=
        }=0A=
=0A=
        /* Good Receive */=0A=
        skb_put(skb, length - CRC_LENGTH);=0A=
=0A=
        /* Adjust socket buffer accounting to only cover the ethernet =
frame=0A=
         * Not what the stack intends, but there exist TCP problems that=0A=
         * break NFS for network interfaces that need 2k receive buffers=0A=
         */=0A=
        skb->truesize =3D skb->len;=0A=
    5cbc:	8e22005c 	lw	v0,92(s1)=0A=
=0A=
        /* Receive Checksum Offload */=0A=
        e1000_rx_checksum(adapter, rx_desc, skb);=0A=
    5cc0:	02203021 	move	a2,s1=0A=
    5cc4:	02c02021 	move	a0,s6=0A=
    5cc8:	ae220078 	sw	v0,120(s1)=0A=
    5ccc:	3c020000 	lui	v0,0x0=0A=
    5cd0:	244274ec 	addiu	v0,v0,29932=0A=
    5cd4:	0040f809 	jalr	v0=0A=
    5cd8:	02602821 	move	a1,s3=0A=
=0A=
#ifdef IANS=0A=
        if(adapter->iANSdata->iANS_status =3D=3D IANS_COMMUNICATION_UP) {=0A=
            if(bd_ans_os_Receive(adapter, rx_desc, skb) =3D=3D =
BD_ANS_FAILURE)=0A=
                dev_kfree_skb_irq(skb);=0A=
            else=0A=
                netif_rx(skb);=0A=
        } else {=0A=
            skb->protocol =3D eth_type_trans(skb, netdev);=0A=
            netif_rx(skb);=0A=
        }=0A=
#else=0A=
        skb->protocol =3D eth_type_trans(skb, netdev);=0A=
    5cdc:	8fa50010 	lw	a1,16(sp)=0A=
    5ce0:	3c020000 	lui	v0,0x0=0A=
    5ce4:	24420000 	addiu	v0,v0,0=0A=
    5ce8:	0040f809 	jalr	v0=0A=
    5cec:	02202021 	move	a0,s1=0A=
    5cf0:	a6220074 	sh	v0,116(s1)=0A=
        netif_rx(skb);=0A=
    5cf4:	3c020000 	lui	v0,0x0=0A=
    5cf8:	24420000 	addiu	v0,v0,0=0A=
    5cfc:	0040f809 	jalr	v0=0A=
    5d00:	02202021 	move	a0,s1=0A=
#endif=0A=
        memset(rx_desc, 0, 16);=0A=
    5d04:	02602021 	move	a0,s3=0A=
    5d08:	00002821 	move	a1,zero=0A=
    5d0c:	3c020000 	lui	v0,0x0=0A=
    5d10:	24420000 	addiu	v0,v0,0=0A=
    5d14:	0040f809 	jalr	v0=0A=
    5d18:	24060010 	li	a2,16=0A=
	...=0A=
        mb();=0A=
        adapter->rx_ring.buffer_info[i].skb =3D NULL;=0A=
    5d3c:	8ec2012c 	lw	v0,300(s6)=0A=
    5d40:	03d51821 	addu	v1,s8,s5=0A=
    5d44:	000318c0 	sll	v1,v1,0x3=0A=
    5d48:	00621821 	addu	v1,v1,v0=0A=
    5d4c:	ac600000 	sw	zero,0(v1)=0A=
 * Atomically adds @i to @v.  Note that the guaranteed useful range=0A=
 * of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
    5d50:	24020001 	li	v0,1=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5d54:	c2830000 	ll	v1,0(s4)=0A=
    5d58:	00621821 	addu	v1,v1,v0=0A=
    5d5c:	e2830000 	sc	v1,0(s4)=0A=
    5d60:	1060fffc 	beqz	v1,5d54 <e1000_clean_rx_irq+0x478>=0A=
    5d64:	00000000 	nop=0A=
=0A=
        atomic_inc(&adapter->rx_ring.unused);=0A=
=0A=
        i =3D (i + 1) % adapter->rx_ring.count;=0A=
    5d68:	8ec6011c 	lw	a2,284(s6)=0A=
    5d6c:	26a20001 	addiu	v0,s5,1=0A=
    5d70:	0046001b 	divu	zero,v0,a2=0A=
    5d74:	50c00001 	beqzl	a2,5d7c <e1000_clean_rx_irq+0x4a0>=0A=
    5d78:	0007000d 	break	0x7=0A=
=0A=
        rx_desc =3D E1000_RX_DESC(adapter->rx_ring, i);=0A=
    5d7c:	8ec40110 	lw	a0,272(s6)=0A=
    5d80:	00001810 	mfhi	v1=0A=
    5d84:	0060a821 	move	s5,v1=0A=
    5d88:	00000000 	nop=0A=
    5d8c:	00151100 	sll	v0,s5,0x4=0A=
    5d90:	00829821 	addu	s3,a0,v0=0A=
    }=0A=
    5d94:	9262000c 	lbu	v0,12(s3)=0A=
    5d98:	00403821 	move	a3,v0=0A=
    5d9c:	30e30001 	andi	v1,a3,0x1=0A=
    5da0:	5460fee5 	bnezl	v1,5938 <e1000_clean_rx_irq+0x5c>=0A=
    5da4:	96640008 	lhu	a0,8(s3)=0A=
    5da8:	0800176d 	j	5db4 <e1000_clean_rx_irq+0x4d8>=0A=
    5dac:	00000000 	nop=0A=
    5db0:	8ec6011c 	lw	a2,284(s6)=0A=
=0A=
    /* if the Rx ring is less than 3/4 full, allocate more sk_buffs */=0A=
=0A=
    if(atomic_read(&adapter->rx_ring.unused) > (adapter->rx_ring.count / =
4)) {=0A=
    5db4:	8ec30120 	lw	v1,288(s6)=0A=
    5db8:	00061082 	srl	v0,a2,0x2=0A=
    5dbc:	0043102b 	sltu	v0,v0,v1=0A=
    5dc0:	5040000f 	beqzl	v0,5e00 <e1000_clean_rx_irq+0x524>=0A=
    5dc4:	aed50128 	sw	s5,296(s6)=0A=
=0A=
extern void FASTCALL(__tasklet_schedule(struct tasklet_struct *t));=0A=
=0A=
static inline void tasklet_schedule(struct tasklet_struct *t)=0A=
{=0A=
    5dc8:	26c500d0 	addiu	a1,s6,208=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5dcc:	24020001 	li	v0,1=0A=
    5dd0:	c2c400d4 	ll	a0,212(s6)=0A=
    5dd4:	00821825 	or	v1,a0,v0=0A=
    5dd8:	e2c300d4 	sc	v1,212(s6)=0A=
    5ddc:	1060fffc 	beqz	v1,5dd0 <e1000_clean_rx_irq+0x4f4>=0A=
    5de0:	00821824 	and	v1,a0,v0=0A=
extern void FASTCALL(__tasklet_schedule(struct tasklet_struct *t));=0A=
=0A=
static inline void tasklet_schedule(struct tasklet_struct *t)=0A=
{=0A=
	if (!test_and_set_bit(TASKLET_STATE_SCHED, &t->state))=0A=
    5de4:	54600006 	bnezl	v1,5e00 <e1000_clean_rx_irq+0x524>=0A=
    5de8:	aed50128 	sw	s5,296(s6)=0A=
		__tasklet_schedule(t);=0A=
    5dec:	3c020000 	lui	v0,0x0=0A=
    5df0:	24420000 	addiu	v0,v0,0=0A=
    5df4:	0040f809 	jalr	v0=0A=
    5df8:	00a02021 	move	a0,a1=0A=
        tasklet_schedule(&adapter->rx_fill_tasklet);=0A=
    }=0A=
    adapter->rx_ring.next_to_clean =3D i;=0A=
    5dfc:	aed50128 	sw	s5,296(s6)=0A=
=0A=
    return;=0A=
}=0A=
    5e00:	8fbf003c 	lw	ra,60(sp)=0A=
    5e04:	8fbe0038 	lw	s8,56(sp)=0A=
    5e08:	8fb70034 	lw	s7,52(sp)=0A=
    5e0c:	8fb60030 	lw	s6,48(sp)=0A=
    5e10:	8fb5002c 	lw	s5,44(sp)=0A=
    5e14:	8fb40028 	lw	s4,40(sp)=0A=
    5e18:	8fb30024 	lw	s3,36(sp)=0A=
    5e1c:	8fb20020 	lw	s2,32(sp)=0A=
    5e20:	8fb1001c 	lw	s1,28(sp)=0A=
    5e24:	8fb00018 	lw	s0,24(sp)=0A=
    5e28:	03e00008 	jr	ra=0A=
    5e2c:	27bd0040 	addiu	sp,sp,64=0A=
=0A=
00005e30 <e1000_alloc_rx_buffers>:=0A=
    5e30:	27bdffb8 	addiu	sp,sp,-72=0A=
    5e34:	afb20028 	sw	s2,40(sp)=0A=
    5e38:	00809021 	move	s2,a0=0A=
    5e3c:	afb40030 	sw	s4,48(sp)=0A=
    5e40:	afbf0044 	sw	ra,68(sp)=0A=
    5e44:	afbe0040 	sw	s8,64(sp)=0A=
    5e48:	afb7003c 	sw	s7,60(sp)=0A=
    5e4c:	afb60038 	sw	s6,56(sp)=0A=
    5e50:	afb50034 	sw	s5,52(sp)=0A=
    5e54:	afb3002c 	sw	s3,44(sp)=0A=
    5e58:	afb10024 	sw	s1,36(sp)=0A=
    5e5c:	afb00020 	sw	s0,32(sp)=0A=
 * @nr: bit number to test=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
    5e60:	2654008c 	addiu	s4,s2,140=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    5e64:	8e820000 	lw	v0,0(s4)=0A=
=0A=
/**=0A=
 * e1000_alloc_rx_buffers - Replace used receive buffers=0A=
 * @data: address of board private structure=0A=
 **/=0A=
=0A=
static void=0A=
e1000_alloc_rx_buffers(unsigned long data)=0A=
{=0A=
    struct e1000_adapter *adapter =3D (struct e1000_adapter *) data;=0A=
    struct net_device *netdev =3D adapter->netdev;=0A=
    5e68:	8e430148 	lw	v1,328(s2)=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    5e6c:	30420001 	andi	v0,v0,0x1=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    struct e1000_rx_desc *rx_desc;=0A=
    struct sk_buff *skb;=0A=
    int i;=0A=
    int reserve_len;=0A=
=0A=
    E1000_DBG("e1000_alloc_rx_buffers\n");=0A=
=0A=
    /* kernel 2.4.7 seems to be broken with respect to tasklet locking */=0A=
    if(!spin_trylock(&adapter->rx_fill_lock))=0A=
        return;=0A=
=0A=
    if(!test_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    5e70:	104000a9 	beqz	v0,6118 <e1000_alloc_rx_buffers+0x2e8>=0A=
    5e74:	afa30010 	sw	v1,16(sp)=0A=
        spin_unlock(&adapter->rx_fill_lock);=0A=
        return;=0A=
    }=0A=
=0A=
#ifdef IANS=0A=
    reserve_len =3D E1000_ROUNDUP2(BD_ANS_INFO_SIZE, 16) + 2;=0A=
#else=0A=
    reserve_len =3D 2;=0A=
#endif=0A=
=0A=
    i =3D adapter->rx_ring.next_to_use;=0A=
    5e78:	8e530124 	lw	s3,292(s2)=0A=
=0A=
    while(adapter->rx_ring.buffer_info[i].skb =3D=3D NULL) {=0A=
    5e7c:	8e42012c 	lw	v0,300(s2)=0A=
    5e80:	00131840 	sll	v1,s3,0x1=0A=
    5e84:	00731821 	addu	v1,v1,s3=0A=
    5e88:	000318c0 	sll	v1,v1,0x3=0A=
    5e8c:	00621821 	addu	v1,v1,v0=0A=
    5e90:	8c640000 	lw	a0,0(v1)=0A=
    5e94:	548000a0 	bnezl	a0,6118 <e1000_alloc_rx_buffers+0x2e8>=0A=
    5e98:	ae530124 	sw	s3,292(s2)=0A=
    5e9c:	3c0d00ff 	lui	t5,0xff=0A=
    5ea0:	3c1eff00 	lui	s8,0xff00=0A=
    5ea4:	24170001 	li	s7,1=0A=
    5ea8:	26550120 	addiu	s5,s2,288=0A=
        rx_desc =3D E1000_RX_DESC(adapter->rx_ring, i);=0A=
=0A=
        skb =3D alloc_skb(adapter->rx_buffer_len + reserve_len, =
GFP_ATOMIC);=0A=
    5eac:	8e4400b8 	lw	a0,184(s2)=0A=
    5eb0:	8e460110 	lw	a2,272(s2)=0A=
    5eb4:	00131900 	sll	v1,s3,0x4=0A=
    5eb8:	24050020 	li	a1,32=0A=
    5ebc:	afad0018 	sw	t5,24(sp)=0A=
    5ec0:	24840002 	addiu	a0,a0,2=0A=
    5ec4:	3c020000 	lui	v0,0x0=0A=
    5ec8:	24420000 	addiu	v0,v0,0=0A=
    5ecc:	0040f809 	jalr	v0=0A=
    5ed0:	00c3b021 	addu	s6,a2,v1=0A=
    5ed4:	00402821 	move	a1,v0=0A=
=0A=
        if(skb =3D=3D NULL) {=0A=
    5ed8:	14a00008 	bnez	a1,5efc <e1000_alloc_rx_buffers+0xcc>=0A=
    5edc:	8fad0018 	lw	t5,24(sp)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    5ee0:	c2820000 	ll	v0,0(s4)=0A=
    5ee4:	34420002 	ori	v0,v0,0x2=0A=
    5ee8:	e2820000 	sc	v0,0(s4)=0A=
    5eec:	1040fffc 	beqz	v0,5ee0 <e1000_alloc_rx_buffers+0xb0>=0A=
    5ef0:	00000000 	nop=0A=
            /* Alloc Failed; If we could not allocate a=0A=
             *  skb during this schedule. Wait for a while before=0A=
             *  tasklet to allocate skb is called again.=0A=
             */=0A=
            set_bit(E1000_RX_REFILL, &adapter->flags);=0A=
            break;=0A=
    5ef4:	08001846 	j	6118 <e1000_alloc_rx_buffers+0x2e8>=0A=
    5ef8:	ae530124 	sw	s3,292(s2)=0A=
 */=0A=
=0A=
static inline void skb_reserve(struct sk_buff *skb, unsigned int len)=0A=
{=0A=
	skb->data+=3Dlen;=0A=
    5efc:	8ca20080 	lw	v0,128(a1)=0A=
	skb->tail+=3Dlen;=0A=
    5f00:	8ca30084 	lw	v1,132(a1)=0A=
        }=0A=
=0A=
        /* Make buffer alignment 2 beyond a 16 byte boundary=0A=
         * this will result in a 16 byte aligned IP header after=0A=
         * the 14 byte MAC header is removed=0A=
         */=0A=
        skb_reserve(skb, reserve_len);=0A=
=0A=
        skb->dev =3D netdev;=0A=
    5f04:	8fa40010 	lw	a0,16(sp)=0A=
 */=0A=
=0A=
static inline void skb_reserve(struct sk_buff *skb, unsigned int len)=0A=
{=0A=
	skb->data+=3Dlen;=0A=
    5f08:	24420002 	addiu	v0,v0,2=0A=
	skb->tail+=3Dlen;=0A=
    5f0c:	24630002 	addiu	v1,v1,2=0A=
    5f10:	aca20080 	sw	v0,128(a1)=0A=
    5f14:	aca40018 	sw	a0,24(a1)=0A=
=0A=
static inline void skb_reserve(struct sk_buff *skb, unsigned int len)=0A=
{=0A=
	skb->data+=3Dlen;=0A=
	skb->tail+=3Dlen;=0A=
    5f18:	aca30084 	sw	v1,132(a1)=0A=
=0A=
        adapter->rx_ring.buffer_info[i].skb =3D skb;=0A=
    5f1c:	8e44012c 	lw	a0,300(s2)=0A=
    5f20:	00138040 	sll	s0,s3,0x1=0A=
    5f24:	02138021 	addu	s0,s0,s3=0A=
    5f28:	001080c0 	sll	s0,s0,0x3=0A=
    5f2c:	02042021 	addu	a0,s0,a0=0A=
    5f30:	ac850000 	sw	a1,0(a0)=0A=
        adapter->rx_ring.buffer_info[i].length =3D =
adapter->rx_buffer_len;=0A=
    5f34:	8e42012c 	lw	v0,300(s2)=0A=
    5f38:	8e4300b8 	lw	v1,184(s2)=0A=
    5f3c:	02021021 	addu	v0,s0,v0=0A=
    5f40:	ac430010 	sw	v1,16(v0)=0A=
 * until either pci_unmap_single or pci_dma_sync_single is performed.=0A=
 */=0A=
static inline dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr,=0A=
					size_t size, int direction)=0A=
{=0A=
    5f44:	8cb10080 	lw	s1,128(a1)=0A=
    5f48:	8e4500b8 	lw	a1,184(s2)=0A=
	if (direction =3D=3D PCI_DMA_NONE)=0A=
		BUG();=0A=
=0A=
#ifdef CONFIG_NONCOHERENT_IO=0A=
	dma_cache_wback_inv((unsigned long)ptr, size);=0A=
    5f4c:	3c020000 	lui	v0,0x0=0A=
    5f50:	8c420000 	lw	v0,0(v0)=0A=
    5f54:	02202021 	move	a0,s1=0A=
    5f58:	0040f809 	jalr	v0=0A=
    5f5c:	afad0018 	sw	t5,24(sp)=0A=
        adapter->rx_ring.buffer_info[i].dma =3D=0A=
            pci_map_single(pdev, skb->data, adapter->rx_buffer_len,=0A=
                           PCI_DMA_FROMDEVICE);=0A=
    5f60:	8e45012c 	lw	a1,300(s2)=0A=
 * IO bus memory addresses are also 1:1 with the physical address=0A=
 */=0A=
static inline unsigned long virt_to_bus(volatile void * address)=0A=
{=0A=
	return PHYSADDR(address);=0A=
    5f64:	3c041fff 	lui	a0,0x1fff=0A=
    5f68:	3484ffff 	ori	a0,a0,0xffff=0A=
    5f6c:	02241824 	and	v1,s1,a0=0A=
    5f70:	02052821 	addu	a1,s0,a1=0A=
    5f74:	00001021 	move	v0,zero=0A=
    5f78:	aca20008 	sw	v0,8(a1)=0A=
    5f7c:	aca3000c 	sw	v1,12(a1)=0A=
    5f80:	8e48012c 	lw	t0,300(s2)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    5f84:	8fad0018 	lw	t5,24(sp)=0A=
}=0A=
static __inline__ __u32 __swab32p(__u32 *x)=0A=
{=0A=
	return __arch__swab32p(x);=0A=
}=0A=
static __inline__ void __swab32s(__u32 *addr)=0A=
{=0A=
	__arch__swab32s(addr);=0A=
}=0A=
=0A=
#ifdef __BYTEORDER_HAS_U64__=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
        return (((__u64)__swab32(l)) << 32) | ((__u64)(__swab32(h)));=0A=
    5f88:	00002021 	move	a0,zero=0A=
    5f8c:	02088021 	addu	s0,s0,t0=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
    5f90:	8e03000c 	lw	v1,12(s0)=0A=
    5f94:	8e080008 	lw	t0,8(s0)=0A=
        return (((__u64)__swab32(l)) << 32) | ((__u64)(__swab32(h)));=0A=
    5f98:	00003021 	move	a2,zero=0A=
    5f9c:	3062ff00 	andi	v0,v1,0xff00=0A=
    5fa0:	00021200 	sll	v0,v0,0x8=0A=
    5fa4:	00036600 	sll	t4,v1,0x18=0A=
    5fa8:	006d5024 	and	t2,v1,t5=0A=
    5fac:	310bff00 	andi	t3,t0,0xff00=0A=
    5fb0:	01826025 	or	t4,t4,v0=0A=
    5fb4:	00084e00 	sll	t1,t0,0x18=0A=
    5fb8:	010d1024 	and	v0,t0,t5=0A=
    5fbc:	000a5202 	srl	t2,t2,0x8=0A=
    5fc0:	007e1824 	and	v1,v1,s8=0A=
    5fc4:	000b5a00 	sll	t3,t3,0x8=0A=
    5fc8:	00021202 	srl	v0,v0,0x8=0A=
    5fcc:	018a6025 	or	t4,t4,t2=0A=
    5fd0:	012b4825 	or	t1,t1,t3=0A=
    5fd4:	00031e02 	srl	v1,v1,0x18=0A=
    5fd8:	011e4024 	and	t0,t0,s8=0A=
    5fdc:	01224825 	or	t1,t1,v0=0A=
    5fe0:	01832825 	or	a1,t4,v1=0A=
    5fe4:	00084602 	srl	t0,t0,0x18=0A=
    5fe8:	01283825 	or	a3,t1,t0=0A=
    5fec:	00052000 	sll	a0,a1,0x0=0A=
    5ff0:	00002821 	move	a1,zero=0A=
    5ff4:	00862025 	or	a0,a0,a2=0A=
    5ff8:	00a72825 	or	a1,a1,a3=0A=
=0A=
        rx_desc->buffer_addr =3D =
cpu_to_le64(adapter->rx_ring.buffer_info[i].dma);=0A=
    5ffc:	aec40000 	sw	a0,0(s6)=0A=
    6000:	aec50004 	sw	a1,4(s6)=0A=
    6004:	8e42000c 	lw	v0,12(s2)=0A=
    6008:	2c420002 	sltiu	v0,v0,2=0A=
    600c:	1440000e 	bnez	v0,6048 <e1000_alloc_rx_buffers+0x218>=0A=
    6010:	3262ff00 	andi	v0,s3,0xff00=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6014:	00021200 	sll	v0,v0,0x8=0A=
    6018:	00131e00 	sll	v1,s3,0x18=0A=
    601c:	026d2024 	and	a0,s3,t5=0A=
    6020:	00621825 	or	v1,v1,v0=0A=
    6024:	00042202 	srl	a0,a0,0x8=0A=
    6028:	8e450008 	lw	a1,8(s2)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    602c:	027e1024 	and	v0,s3,s8=0A=
    6030:	00641825 	or	v1,v1,a0=0A=
    6034:	00021602 	srl	v0,v0,0x18=0A=
    6038:	00621825 	or	v1,v1,v0=0A=
=0A=
        /* move tail */=0A=
        E1000_WRITE_REG(&adapter->shared, RDT, i);=0A=
    603c:	aca32818 	sw	v1,10264(a1)=0A=
    6040:	0800181d 	j	6074 <e1000_alloc_rx_buffers+0x244>=0A=
    6044:	00000000 	nop=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6048:	00021200 	sll	v0,v0,0x8=0A=
    604c:	00131e00 	sll	v1,s3,0x18=0A=
    6050:	026d2024 	and	a0,s3,t5=0A=
    6054:	00621825 	or	v1,v1,v0=0A=
    6058:	00042202 	srl	a0,a0,0x8=0A=
    605c:	8e450008 	lw	a1,8(s2)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6060:	027e1024 	and	v0,s3,s8=0A=
    6064:	00641825 	or	v1,v1,a0=0A=
    6068:	00021602 	srl	v0,v0,0x18=0A=
    606c:	00621825 	or	v1,v1,v0=0A=
    6070:	aca30128 	sw	v1,296(a1)=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    6074:	c2a20000 	ll	v0,0(s5)=0A=
    6078:	00571023 	subu	v0,v0,s7=0A=
    607c:	e2a20000 	sc	v0,0(s5)=0A=
    6080:	1040fffc 	beqz	v0,6074 <e1000_alloc_rx_buffers+0x244>=0A=
    6084:	00000000 	nop=0A=
=0A=
        atomic_dec(&adapter->rx_ring.unused);=0A=
=0A=
        i =3D (i + 1) % adapter->rx_ring.count;=0A=
    6088:	8e43011c 	lw	v1,284(s2)=0A=
    608c:	26640001 	addiu	a0,s3,1=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    6090:	24020002 	li	v0,2=0A=
    6094:	0083001b 	divu	zero,a0,v1=0A=
    6098:	50600001 	beqzl	v1,60a0 <e1000_alloc_rx_buffers+0x270>=0A=
    609c:	0007000d 	break	0x7=0A=
    60a0:	00008010 	mfhi	s0=0A=
    60a4:	02009821 	move	s3,s0=0A=
    60a8:	00000000 	nop=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    60ac:	c2840000 	ll	a0,0(s4)=0A=
    60b0:	00821825 	or	v1,a0,v0=0A=
    60b4:	00621826 	xor	v1,v1,v0=0A=
    60b8:	e2830000 	sc	v1,0(s4)=0A=
    60bc:	1060fffb 	beqz	v1,60ac <e1000_alloc_rx_buffers+0x27c>=0A=
    60c0:	00821824 	and	v1,a0,v0=0A=
=0A=
        if(test_and_clear_bit(E1000_RX_REFILL, &adapter->flags)) {=0A=
    60c4:	5060000c 	beqzl	v1,60f8 <e1000_alloc_rx_buffers+0x2c8>=0A=
    60c8:	8e42012c 	lw	v0,300(s2)=0A=
            /* Trigger Soft Interrupt */=0A=
            E1000_WRITE_REG(&adapter->shared, ICS, E1000_ICS_RXT0);=0A=
    60cc:	8e42000c 	lw	v0,12(s2)=0A=
    60d0:	2c420002 	sltiu	v0,v0,2=0A=
    60d4:	14400005 	bnez	v0,60ec <e1000_alloc_rx_buffers+0x2bc>=0A=
    60d8:	8e420008 	lw	v0,8(s2)=0A=
    60dc:	3c038000 	lui	v1,0x8000=0A=
    60e0:	ac4300c8 	sw	v1,200(v0)=0A=
    60e4:	0800183e 	j	60f8 <e1000_alloc_rx_buffers+0x2c8>=0A=
    60e8:	8e42012c 	lw	v0,300(s2)=0A=
    60ec:	3c048000 	lui	a0,0x8000=0A=
    60f0:	ac4400c8 	sw	a0,200(v0)=0A=
        }=0A=
    }=0A=
    60f4:	8e42012c 	lw	v0,300(s2)=0A=
    60f8:	00101840 	sll	v1,s0,0x1=0A=
    60fc:	00701821 	addu	v1,v1,s0=0A=
    6100:	000318c0 	sll	v1,v1,0x3=0A=
    6104:	00621821 	addu	v1,v1,v0=0A=
    6108:	8c640000 	lw	a0,0(v1)=0A=
    610c:	5080ff68 	beqzl	a0,5eb0 <e1000_alloc_rx_buffers+0x80>=0A=
    6110:	8e4400b8 	lw	a0,184(s2)=0A=
=0A=
    adapter->rx_ring.next_to_use =3D i;=0A=
    6114:	ae530124 	sw	s3,292(s2)=0A=
=0A=
    spin_unlock(&adapter->rx_fill_lock);=0A=
    return;=0A=
}=0A=
    6118:	8fbf0044 	lw	ra,68(sp)=0A=
    611c:	8fbe0040 	lw	s8,64(sp)=0A=
    6120:	8fb7003c 	lw	s7,60(sp)=0A=
    6124:	8fb60038 	lw	s6,56(sp)=0A=
    6128:	8fb50034 	lw	s5,52(sp)=0A=
    612c:	8fb40030 	lw	s4,48(sp)=0A=
    6130:	8fb3002c 	lw	s3,44(sp)=0A=
    6134:	8fb20028 	lw	s2,40(sp)=0A=
    6138:	8fb10024 	lw	s1,36(sp)=0A=
    613c:	8fb00020 	lw	s0,32(sp)=0A=
    6140:	03e00008 	jr	ra=0A=
    6144:	27bd0048 	addiu	sp,sp,72=0A=
=0A=
00006148 <e1000_ioctl>:=0A=
    6148:	27bdffe8 	addiu	sp,sp,-24=0A=
=0A=
/**=0A=
 * e1000_ioctl - =0A=
 * @netdev:=0A=
 * @ifreq:=0A=
 * @cmd:=0A=
 **/=0A=
=0A=
int=0A=
e1000_ioctl(struct net_device *netdev,=0A=
            struct ifreq *ifr,=0A=
            int cmd)=0A=
{=0A=
#ifdef IANS=0A=
    IANS_BD_PARAM_HEADER *header;=0A=
#endif=0A=
=0A=
    E1000_DBG("e1000_do_ioctl\n");=0A=
=0A=
    switch (cmd) {=0A=
    614c:	34028946 	li	v0,0x8946=0A=
    6150:	afbf0010 	sw	ra,16(sp)=0A=
=0A=
#ifdef IANS=0A=
    case IANS_BASE_SIOC:=0A=
        header =3D (IANS_BD_PARAM_HEADER *) ifr->ifr_data;=0A=
        if((header->Opcode !=3D IANS_OP_EXT_GET_STATUS) &&=0A=
           (!capable(CAP_NET_ADMIN)))=0A=
            return -EPERM;=0A=
        return bd_ans_os_Ioctl(netdev, ifr, cmd);=0A=
        break;=0A=
#endif=0A=
=0A=
#ifdef IDIAG=0A=
    case IDIAG_PRO_BASE_SIOC:=0A=
        if(!capable(CAP_NET_ADMIN))=0A=
            return -EPERM;=0A=
=0A=
#ifdef DIAG_DEBUG=0A=
        printk("Entering diagnostics\n");=0A=
#endif=0A=
        e1000_diag_ioctl(netdev, ifr);=0A=
        break;=0A=
#endif /* IDIAG */=0A=
=0A=
#ifdef SIOCETHTOOL=0A=
    case SIOCETHTOOL:=0A=
=0A=
        return e1000_ethtool_ioctl(netdev, ifr);=0A=
    6154:	3c090000 	lui	t1,0x0=0A=
    6158:	25296dd8 	addiu	t1,t1,28120=0A=
    615c:	340389f2 	li	v1,0x89f2=0A=
    6160:	00804021 	move	t0,a0=0A=
    6164:	10c20013 	beq	a2,v0,61b4 <e1000_ioctl+0x6c>=0A=
    6168:	00a03821 	move	a3,a1=0A=
    616c:	14c30018 	bne	a2,v1,61d0 <e1000_ioctl+0x88>=0A=
    6170:	2402ff86 	li	v0,-122=0A=
=0A=
static inline int capable(int cap)=0A=
{=0A=
#if 1 /* ok now */=0A=
	if (cap_raised(current->cap_effective, cap))=0A=
    6174:	8f8301d4 	lw	v1,468(gp)=0A=
    6178:	30631000 	andi	v1,v1,0x1000=0A=
#else=0A=
	if (cap_is_fs_cap(cap) ? current->fsuid =3D=3D 0 : current->euid =3D=3D =
0)=0A=
#endif=0A=
	{=0A=
		current->flags |=3D PF_SUPERPRIV;=0A=
		return 1;=0A=
    617c:	24060001 	li	a2,1=0A=
    6180:	3c070000 	lui	a3,0x0=0A=
    6184:	24e70000 	addiu	a3,a3,0=0A=
=0A=
static inline int capable(int cap)=0A=
{=0A=
#if 1 /* ok now */=0A=
	if (cap_raised(current->cap_effective, cap))=0A=
    6188:	10600005 	beqz	v1,61a0 <e1000_ioctl+0x58>=0A=
    618c:	2402ffff 	li	v0,-1=0A=
#else=0A=
	if (cap_is_fs_cap(cap) ? current->fsuid =3D=3D 0 : current->euid =3D=3D =
0)=0A=
#endif=0A=
	{=0A=
		current->flags |=3D PF_SUPERPRIV;=0A=
    6190:	8f830004 	lw	v1,4(gp)=0A=
    6194:	34630100 	ori	v1,v1,0x100=0A=
		return 1;=0A=
    6198:	08001869 	j	61a4 <e1000_ioctl+0x5c>=0A=
    619c:	af830004 	sw	v1,4(gp)=0A=
	}=0A=
	return 0;=0A=
    61a0:	00003021 	move	a2,zero=0A=
    61a4:	14c00007 	bnez	a2,61c4 <e1000_ioctl+0x7c>=0A=
    61a8:	8fbf0010 	lw	ra,16(sp)=0A=
    61ac:	08001875 	j	61d4 <e1000_ioctl+0x8c>=0A=
    61b0:	00000000 	nop=0A=
    61b4:	0120f809 	jalr	t1=0A=
    61b8:	00000000 	nop=0A=
    61bc:	08001875 	j	61d4 <e1000_ioctl+0x8c>=0A=
    61c0:	8fbf0010 	lw	ra,16(sp)=0A=
    61c4:	00e0f809 	jalr	a3=0A=
    61c8:	00000000 	nop=0A=
=0A=
        break;=0A=
#endif=0A=
=0A=
    default:=0A=
        return -EOPNOTSUPP;=0A=
    }=0A=
=0A=
    return 0;=0A=
    61cc:	00001021 	move	v0,zero=0A=
}=0A=
    61d0:	8fbf0010 	lw	ra,16(sp)=0A=
    61d4:	03e00008 	jr	ra=0A=
    61d8:	27bd0018 	addiu	sp,sp,24=0A=
=0A=
000061dc <e1000_hibernate_adapter>:=0A=
    61dc:	27bdffe0 	addiu	sp,sp,-32=0A=
    61e0:	afb20018 	sw	s2,24(sp)=0A=
    61e4:	afbf001c 	sw	ra,28(sp)=0A=
    61e8:	afb10014 	sw	s1,20(sp)=0A=
    61ec:	afb00010 	sw	s0,16(sp)=0A=
    61f0:	00809021 	move	s2,a0=0A=
=0A=
/**=0A=
 * e1000_rx_checksum - Receive Checksum Offload for 82543=0A=
 * @adapter: board private structure=0A=
 * @rx_desc: receive descriptor=0A=
 * @sk_buff: socket buffer with received data=0A=
 **/=0A=
=0A=
static inline void=0A=
e1000_rx_checksum(struct e1000_adapter *adapter,=0A=
                  struct e1000_rx_desc *rx_desc,=0A=
                  struct sk_buff *skb)=0A=
{=0A=
    /* 82543 or newer only */=0A=
    if((adapter->shared.mac_type < e1000_82543) ||=0A=
       /* Ignore Checksum bit is set */=0A=
       (rx_desc->status & E1000_RXD_STAT_IXSM) ||=0A=
       /* TCP Checksum has not been calculated */=0A=
       (!(rx_desc->status & E1000_RXD_STAT_TCPCS))) {=0A=
=0A=
        skb->ip_summed =3D CHECKSUM_NONE;=0A=
        return;=0A=
    }=0A=
=0A=
    /* At this point we know the hardware did the TCP checksum */=0A=
    /* now look at the TCP checksum error bit */=0A=
    if(rx_desc->errors & E1000_RXD_ERR_TCPE) {=0A=
        /* let the stack verify checksum errors */=0A=
        skb->ip_summed =3D CHECKSUM_NONE;=0A=
        adapter->XsumRXError++;=0A=
    } else {=0A=
        /* TCP checksum is good */=0A=
        skb->ip_summed =3D CHECKSUM_UNNECESSARY;=0A=
        adapter->XsumRXGood++;=0A=
    }=0A=
=0A=
    return;=0A=
}=0A=
=0A=
void=0A=
e1000_hibernate_adapter(struct net_device *netdev)=0A=
{=0A=
    uint32_t icr;=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    61f4:	8e500064 	lw	s0,100(s2)=0A=
    61f8:	8e02000c 	lw	v0,12(s0)=0A=
    61fc:	2c420002 	sltiu	v0,v0,2=0A=
    6200:	8e030008 	lw	v1,8(s0)=0A=
    6204:	2402ffff 	li	v0,-1=0A=
    6208:	ac6200d8 	sw	v0,216(v1)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    620c:	c242002c 	ll	v0,44(s2)=0A=
    6210:	34420001 	ori	v0,v0,0x1=0A=
    6214:	e242002c 	sc	v0,44(s2)=0A=
    6218:	1040fffc 	beqz	v0,620c <e1000_hibernate_adapter+0x30>=0A=
    621c:	00000000 	nop=0A=
=0A=
    e1000_irq_disable(adapter);=0A=
    netif_stop_queue(netdev);=0A=
    adapter->shared.adapter_stopped =3D 0;=0A=
    e1000_adapter_stop(&adapter->shared);=0A=
    6220:	26110008 	addiu	s1,s0,8=0A=
    6224:	ae000064 	sw	zero,100(s0)=0A=
    6228:	3c030000 	lui	v1,0x0=0A=
    622c:	24630000 	addiu	v1,v1,0=0A=
    6230:	0060f809 	jalr	v1=0A=
    6234:	02202021 	move	a0,s1=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    6238:	8e02008c 	lw	v0,140(s0)=0A=
    623c:	30420001 	andi	v0,v0,0x1=0A=
=0A=
    if(test_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    6240:	10400021 	beqz	v0,62c8 <e1000_hibernate_adapter+0xec>=0A=
    6244:	24030001 	li	v1,1=0A=
 * Atomically adds @i to @v.  Note that the guaranteed useful range=0A=
 * of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
    6248:	260200d8 	addiu	v0,s0,216=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    624c:	c0440000 	ll	a0,0(v0)=0A=
    6250:	00832021 	addu	a0,a0,v1=0A=
    6254:	e0440000 	sc	a0,0(v0)=0A=
    6258:	1080fffc 	beqz	a0,624c <e1000_hibernate_adapter+0x70>=0A=
    625c:	00000000 	nop=0A=
=0A=
        /* Disable tasklet only when interface is opened. */=0A=
        tasklet_disable(&adapter->rx_fill_tasklet);=0A=
=0A=
        /* clean out old buffers */=0A=
        e1000_clean_rx_ring(adapter);=0A=
    6260:	3c020000 	lui	v0,0x0=0A=
    6264:	244228d8 	addiu	v0,v0,10456=0A=
    6268:	0040f809 	jalr	v0=0A=
    626c:	02002021 	move	a0,s0=0A=
        e1000_clean_tx_ring(adapter);=0A=
    6270:	3c020000 	lui	v0,0x0=0A=
    6274:	24422720 	addiu	v0,v0,10016=0A=
    6278:	0040f809 	jalr	v0=0A=
    627c:	02002021 	move	a0,s0=0A=
=0A=
        /* Delete watchdog timer */=0A=
        del_timer(&adapter->timer_id);=0A=
    6280:	3c020000 	lui	v0,0x0=0A=
    6284:	24420000 	addiu	v0,v0,0=0A=
    6288:	0040f809 	jalr	v0=0A=
    628c:	26040094 	addiu	a0,s0,148=0A=
    6290:	8e03000c 	lw	v1,12(s0)=0A=
    6294:	2c630002 	sltiu	v1,v1,2=0A=
    6298:	8e230000 	lw	v1,0(s1)=0A=
    629c:	2402ffff 	li	v0,-1=0A=
    62a0:	ac6200d8 	sw	v0,216(v1)=0A=
=0A=
        /* Unhook irq */=0A=
        e1000_irq_disable(adapter);=0A=
    62a4:	8e02000c 	lw	v0,12(s0)=0A=
    62a8:	2c420002 	sltiu	v0,v0,2=0A=
        icr =3D E1000_READ_REG(&adapter->shared, ICR);=0A=
    62ac:	8e020008 	lw	v0,8(s0)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    62b0:	8c4300c0 	lw	v1,192(v0)=0A=
        free_irq(netdev->irq, netdev);=0A=
    62b4:	8e440024 	lw	a0,36(s2)=0A=
    62b8:	3c020000 	lui	v0,0x0=0A=
    62bc:	24420000 	addiu	v0,v0,0=0A=
    62c0:	0040f809 	jalr	v0=0A=
    62c4:	02402821 	move	a1,s2=0A=
    }=0A=
}=0A=
    62c8:	8fbf001c 	lw	ra,28(sp)=0A=
    62cc:	8fb20018 	lw	s2,24(sp)=0A=
    62d0:	8fb10014 	lw	s1,20(sp)=0A=
    62d4:	8fb00010 	lw	s0,16(sp)=0A=
    62d8:	03e00008 	jr	ra=0A=
    62dc:	27bd0020 	addiu	sp,sp,32=0A=
=0A=
000062e0 <e1000_wakeup_adapter>:=0A=
    62e0:	27bdffd8 	addiu	sp,sp,-40=0A=
    62e4:	afb20020 	sw	s2,32(sp)=0A=
    62e8:	afb1001c 	sw	s1,28(sp)=0A=
    62ec:	afbf0024 	sw	ra,36(sp)=0A=
    62f0:	afb00018 	sw	s0,24(sp)=0A=
    62f4:	00809021 	move	s2,a0=0A=
=0A=
void=0A=
e1000_wakeup_adapter(struct net_device *netdev)=0A=
{=0A=
    uint32_t icr;=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    62f8:	8e500064 	lw	s0,100(s2)=0A=
=0A=
    adapter->shared.adapter_stopped =3D 0;=0A=
    e1000_adapter_stop(&adapter->shared);=0A=
    62fc:	3c030000 	lui	v1,0x0=0A=
    6300:	24630000 	addiu	v1,v1,0=0A=
    6304:	26110008 	addiu	s1,s0,8=0A=
    6308:	02202021 	move	a0,s1=0A=
    630c:	0060f809 	jalr	v1=0A=
    6310:	ae000064 	sw	zero,100(s0)=0A=
    adapter->shared.adapter_stopped =3D 0;=0A=
    adapter->shared.fc =3D adapter->shared.original_fc;=0A=
    6314:	8e020030 	lw	v0,48(s0)=0A=
    6318:	ae000064 	sw	zero,100(s0)=0A=
    631c:	ae020018 	sw	v0,24(s0)=0A=
=0A=
    if(!e1000_init_hw(&adapter->shared))=0A=
    6320:	3c020000 	lui	v0,0x0=0A=
    6324:	24420000 	addiu	v0,v0,0=0A=
    6328:	0040f809 	jalr	v0=0A=
    632c:	02202021 	move	a0,s1=0A=
    6330:	54400008 	bnezl	v0,6354 <e1000_wakeup_adapter+0x74>=0A=
    6334:	8e02008c 	lw	v0,140(s0)=0A=
        printk("Hardware Init Failed at wakeup\n");=0A=
    6338:	3c040000 	lui	a0,0x0=0A=
    633c:	24840db0 	addiu	a0,a0,3504=0A=
    6340:	3c020000 	lui	v0,0x0=0A=
    6344:	24420000 	addiu	v0,v0,0=0A=
    6348:	0040f809 	jalr	v0=0A=
    634c:	00000000 	nop=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    6350:	8e02008c 	lw	v0,140(s0)=0A=
    6354:	30420001 	andi	v0,v0,0x1=0A=
=0A=
    if(test_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    6358:	10400059 	beqz	v0,64c0 <e1000_wakeup_adapter+0x1e0>=0A=
    635c:	8fbf0024 	lw	ra,36(sp)=0A=
=0A=
        /* Setup Rctl */=0A=
        e1000_setup_rctl(adapter);=0A=
    6360:	3c020000 	lui	v0,0x0=0A=
    6364:	24422308 	addiu	v0,v0,8968=0A=
    6368:	0040f809 	jalr	v0=0A=
    636c:	02002021 	move	a0,s0=0A=
        e1000_configure_rx(adapter);=0A=
    6370:	3c020000 	lui	v0,0x0=0A=
    6374:	244223a8 	addiu	v0,v0,9128=0A=
    6378:	0040f809 	jalr	v0=0A=
    637c:	02002021 	move	a0,s0=0A=
        e1000_alloc_rx_buffers((unsigned long) adapter);=0A=
    6380:	3c020000 	lui	v0,0x0=0A=
    6384:	24425e30 	addiu	v0,v0,24112=0A=
    6388:	0040f809 	jalr	v0=0A=
    638c:	02002021 	move	a0,s0=0A=
        e1000_set_multi(netdev);=0A=
    6390:	3c020000 	lui	v0,0x0=0A=
    6394:	24420000 	addiu	v0,v0,0=0A=
    6398:	0040f809 	jalr	v0=0A=
    639c:	02402021 	move	a0,s2=0A=
        e1000_configure_tx(adapter);=0A=
    63a0:	3c020000 	lui	v0,0x0=0A=
    63a4:	24421f60 	addiu	v0,v0,8032=0A=
    63a8:	0040f809 	jalr	v0=0A=
    63ac:	02002021 	move	a0,s0=0A=
=0A=
extern void it_real_fn(unsigned long);=0A=
=0A=
static inline void init_timer(struct timer_list * timer)=0A=
{=0A=
    63b0:	26040094 	addiu	a0,s0,148=0A=
=0A=
#ifdef IANS=0A=
        if((IANS_BD_TAGGING_MODE) =
(ANS_PRIVATE_DATA_FIELD(adapter)->tag_mode)=0A=
           !=3D IANS_BD_TAGGING_NONE)=0A=
            bd_ans_hw_EnableVLAN(adapter);=0A=
#endif=0A=
=0A=
        /* Set the watchdog timer for 2 seconds */=0A=
        init_timer(&adapter->timer_id);=0A=
        adapter->timer_id.function =3D &e1000_watchdog;=0A=
    63b4:	3c020000 	lui	v0,0x0=0A=
    63b8:	24420000 	addiu	v0,v0,0=0A=
extern void it_real_fn(unsigned long);=0A=
=0A=
static inline void init_timer(struct timer_list * timer)=0A=
{=0A=
	timer->list.next =3D timer->list.prev =3D NULL;=0A=
    63bc:	ac800004 	sw	zero,4(a0)=0A=
    63c0:	ac800000 	sw	zero,0(a0)=0A=
    63c4:	ae0200a4 	sw	v0,164(s0)=0A=
        adapter->timer_id.data =3D (unsigned long) netdev;=0A=
    63c8:	ae1200a0 	sw	s2,160(s0)=0A=
        mod_timer(&adapter->timer_id, (jiffies + 2 * HZ));=0A=
    63cc:	3c050000 	lui	a1,0x0=0A=
    63d0:	8ca50000 	lw	a1,0(a1)=0A=
    63d4:	3c020000 	lui	v0,0x0=0A=
    63d8:	24420000 	addiu	v0,v0,0=0A=
    63dc:	0040f809 	jalr	v0=0A=
    63e0:	24a500c8 	addiu	a1,a1,200=0A=
 * Atomically subtracts @i from @v.  Note that the guaranteed=0A=
 * useful range of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
    63e4:	260300d8 	addiu	v1,s0,216=0A=
    63e8:	24020001 	li	v0,1=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    63ec:	c0650000 	ll	a1,0(v1)=0A=
    63f0:	00a22823 	subu	a1,a1,v0=0A=
    63f4:	e0650000 	sc	a1,0(v1)=0A=
    63f8:	10a0fffc 	beqz	a1,63ec <e1000_wakeup_adapter+0x10c>=0A=
    63fc:	00000000 	nop=0A=
    6400:	8e04000c 	lw	a0,12(s0)=0A=
    6404:	2c840002 	sltiu	a0,a0,2=0A=
    6408:	8e230000 	lw	v1,0(s1)=0A=
    640c:	2402ffff 	li	v0,-1=0A=
    6410:	ac6200d8 	sw	v0,216(v1)=0A=
=0A=
        tasklet_enable(&adapter->rx_fill_tasklet);=0A=
=0A=
        /* Hook irq */=0A=
        e1000_irq_disable(adapter);=0A=
    6414:	8e02000c 	lw	v0,12(s0)=0A=
    6418:	2c420002 	sltiu	v0,v0,2=0A=
        icr =3D E1000_READ_REG(&adapter->shared, ICR);=0A=
    641c:	8e020008 	lw	v0,8(s0)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    6420:	8c4300c0 	lw	v1,192(v0)=0A=
        if(request_irq=0A=
    6424:	8e440024 	lw	a0,36(s2)=0A=
    6428:	3c050000 	lui	a1,0x0=0A=
    642c:	24a50000 	addiu	a1,a1,0=0A=
    6430:	3c070000 	lui	a3,0x0=0A=
    6434:	24e70000 	addiu	a3,a3,0=0A=
    6438:	3c060200 	lui	a2,0x200=0A=
    643c:	3c020000 	lui	v0,0x0=0A=
    6440:	24420000 	addiu	v0,v0,0=0A=
    6444:	0040f809 	jalr	v0=0A=
    6448:	afb20010 	sw	s2,16(sp)=0A=
    644c:	50400008 	beqzl	v0,6470 <e1000_wakeup_adapter+0x190>=0A=
    6450:	8e02000c 	lw	v0,12(s0)=0A=
           (netdev->irq, &e1000_intr, SA_SHIRQ, e1000_driver_name, =
netdev) !=3D 0)=0A=
            printk(KERN_ERR "e1000: Unable to hook irq.\n");=0A=
    6454:	3c040000 	lui	a0,0x0=0A=
    6458:	24840dd0 	addiu	a0,a0,3536=0A=
    645c:	3c020000 	lui	v0,0x0=0A=
    6460:	24420000 	addiu	v0,v0,0=0A=
    6464:	0040f809 	jalr	v0=0A=
    6468:	00000000 	nop=0A=
    646c:	8e02000c 	lw	v0,12(s0)=0A=
    6470:	2c420002 	sltiu	v0,v0,2=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    6474:	8e0500cc 	lw	a1,204(s0)=0A=
    6478:	8e060008 	lw	a2,8(s0)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    647c:	30a4ff00 	andi	a0,a1,0xff00=0A=
    6480:	00051600 	sll	v0,a1,0x18=0A=
    6484:	00051a02 	srl	v1,a1,0x8=0A=
    6488:	00042200 	sll	a0,a0,0x8=0A=
    648c:	00441025 	or	v0,v0,a0=0A=
    6490:	3063ff00 	andi	v1,v1,0xff00=0A=
    6494:	00431025 	or	v0,v0,v1=0A=
    6498:	00052e02 	srl	a1,a1,0x18=0A=
    649c:	00451025 	or	v0,v0,a1=0A=
    64a0:	acc200d0 	sw	v0,208(a2)=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    64a4:	c242002c 	ll	v0,44(s2)=0A=
    64a8:	2401fffe 	li	at,-2=0A=
    64ac:	00411024 	and	v0,v0,at=0A=
    64b0:	e242002c 	sc	v0,44(s2)=0A=
    64b4:	1040fffb 	beqz	v0,64a4 <e1000_wakeup_adapter+0x1c4>=0A=
    64b8:	00000000 	nop=0A=
=0A=
        e1000_irq_enable(adapter);=0A=
        netif_start_queue(netdev);=0A=
    }=0A=
}=0A=
    64bc:	8fbf0024 	lw	ra,36(sp)=0A=
    64c0:	8fb20020 	lw	s2,32(sp)=0A=
    64c4:	8fb1001c 	lw	s1,28(sp)=0A=
    64c8:	8fb00018 	lw	s0,24(sp)=0A=
    64cc:	03e00008 	jr	ra=0A=
    64d0:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
000064d4 <e1000_xmit_lbtest_frame>:=0A=
    64d4:	27bdffd8 	addiu	sp,sp,-40=0A=
    64d8:	afb40020 	sw	s4,32(sp)=0A=
    64dc:	afb3001c 	sw	s3,28(sp)=0A=
    64e0:	afb20018 	sw	s2,24(sp)=0A=
    64e4:	afb10014 	sw	s1,20(sp)=0A=
    64e8:	afbf0024 	sw	ra,36(sp)=0A=
    64ec:	afb00010 	sw	s0,16(sp)=0A=
    64f0:	00a09821 	move	s3,a1=0A=
=0A=
#ifdef IDIAG=0A=
int=0A=
e1000_xmit_lbtest_frame(struct sk_buff *skb,=0A=
                        struct e1000_adapter *adapter)=0A=
{=0A=
    /*struct e1000_adapter *adapter =3D netdev->priv; */=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    struct e1000_tx_desc *tx_desc;=0A=
    int i;=0A=
=0A=
    i =3D adapter->tx_ring.next_to_use;=0A=
    64f4:	8e6600f8 	lw	a2,248(s3)=0A=
    tx_desc =3D E1000_TX_DESC(adapter->tx_ring, i);=0A=
=0A=
    adapter->tx_ring.buffer_info[i].skb =3D skb;=0A=
    64f8:	8e630100 	lw	v1,256(s3)=0A=
    64fc:	00809021 	move	s2,a0=0A=
    6500:	00068840 	sll	s1,a2,0x1=0A=
    6504:	02268821 	addu	s1,s1,a2=0A=
    6508:	001188c0 	sll	s1,s1,0x3=0A=
    650c:	02231821 	addu	v1,s1,v1=0A=
    6510:	8e6700e4 	lw	a3,228(s3)=0A=
    6514:	ac720000 	sw	s2,0(v1)=0A=
    adapter->tx_ring.buffer_info[i].length =3D skb->len;=0A=
    6518:	8e620100 	lw	v0,256(s3)=0A=
    651c:	8e44005c 	lw	a0,92(s2)=0A=
    6520:	00063100 	sll	a2,a2,0x4=0A=
    6524:	02221021 	addu	v0,s1,v0=0A=
    6528:	ac440010 	sw	a0,16(v0)=0A=
    adapter->tx_ring.buffer_info[i].dma =3D=0A=
    652c:	8e430080 	lw	v1,128(s2)=0A=
 */=0A=
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page =
*page,=0A=
				      unsigned long offset, size_t size,=0A=
                                      int direction)=0A=
{=0A=
    6530:	3c040000 	lui	a0,0x0=0A=
    6534:	8c840000 	lw	a0,0(a0)=0A=
    6538:	8e45005c 	lw	a1,92(s2)=0A=
    653c:	3c028000 	lui	v0,0x8000=0A=
    6540:	00431021 	addu	v0,v0,v1=0A=
    6544:	00021302 	srl	v0,v0,0xc=0A=
 */=0A=
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page =
*page,=0A=
				      unsigned long offset, size_t size,=0A=
                                      int direction)=0A=
{=0A=
    6548:	00021180 	sll	v0,v0,0x6=0A=
    654c:	00e6a021 	addu	s4,a3,a2=0A=
 */=0A=
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page =
*page,=0A=
				      unsigned long offset, size_t size,=0A=
                                      int direction)=0A=
{=0A=
    6550:	00441021 	addu	v0,v0,a0=0A=
    6554:	30630fff 	andi	v1,v1,0xfff=0A=
=0A=
	if (direction =3D=3D PCI_DMA_NONE)=0A=
		BUG();=0A=
=0A=
	addr =3D (unsigned long) page_address(page);=0A=
    6558:	8c500038 	lw	s0,56(v0)=0A=
	addr +=3D offset;=0A=
#ifdef CONFIG_NONCOHERENT_IO=0A=
	dma_cache_wback_inv(addr, size);=0A=
    655c:	3c060000 	lui	a2,0x0=0A=
    6560:	8cc60000 	lw	a2,0(a2)=0A=
    6564:	02038021 	addu	s0,s0,v1=0A=
    6568:	00c0f809 	jalr	a2=0A=
    656c:	02002021 	move	a0,s0=0A=
        pci_map_page(pdev, virt_to_page(skb->data),=0A=
                     (unsigned long) skb->data & ~PAGE_MASK, skb->len,=0A=
                     PCI_DMA_TODEVICE);=0A=
    6570:	8e650100 	lw	a1,256(s3)=0A=
 * IO bus memory addresses are also 1:1 with the physical address=0A=
 */=0A=
static inline unsigned long virt_to_bus(volatile void * address)=0A=
{=0A=
	return PHYSADDR(address);=0A=
    6574:	3c041fff 	lui	a0,0x1fff=0A=
    6578:	3484ffff 	ori	a0,a0,0xffff=0A=
    657c:	02041824 	and	v1,s0,a0=0A=
    6580:	02252821 	addu	a1,s1,a1=0A=
    6584:	00001021 	move	v0,zero=0A=
    6588:	aca20008 	sw	v0,8(a1)=0A=
    658c:	aca3000c 	sw	v1,12(a1)=0A=
    6590:	8e640100 	lw	a0,256(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6594:	3c0d00ff 	lui	t5,0xff=0A=
    6598:	02248821 	addu	s1,s1,a0=0A=
static __inline__ __const__ __u64 __fswab64(__u64 x)=0A=
{=0A=
#  ifdef __SWAB_64_THRU_32__=0A=
	__u32 h =3D x >> 32;=0A=
        __u32 l =3D x & ((1ULL<<32)-1);=0A=
    659c:	8e2b000c 	lw	t3,12(s1)=0A=
    65a0:	8e2c0008 	lw	t4,8(s1)=0A=
        return (((__u64)__swab32(l)) << 32) | ((__u64)(__swab32(h)));=0A=
    65a4:	00002021 	move	a0,zero=0A=
    65a8:	3166ff00 	andi	a2,t3,0xff00=0A=
    65ac:	016d4024 	and	t0,t3,t5=0A=
    65b0:	00063200 	sll	a2,a2,0x8=0A=
    65b4:	000b5600 	sll	t2,t3,0x18=0A=
    65b8:	3189ff00 	andi	t1,t4,0xff00=0A=
    65bc:	01465025 	or	t2,t2,a2=0A=
    65c0:	000c3e00 	sll	a3,t4,0x18=0A=
    65c4:	018d3024 	and	a2,t4,t5=0A=
    65c8:	00084202 	srl	t0,t0,0x8=0A=
    65cc:	00094a00 	sll	t1,t1,0x8=0A=
    65d0:	00063202 	srl	a2,a2,0x8=0A=
    65d4:	01485025 	or	t2,t2,t0=0A=
    65d8:	00e93825 	or	a3,a3,t1=0A=
    65dc:	000b5e02 	srl	t3,t3,0x18=0A=
    65e0:	00e63825 	or	a3,a3,a2=0A=
    65e4:	014b1825 	or	v1,t2,t3=0A=
    65e8:	000c6602 	srl	t4,t4,0x18=0A=
    65ec:	00ec2825 	or	a1,a3,t4=0A=
    65f0:	00031000 	sll	v0,v1,0x0=0A=
    65f4:	00001821 	move	v1,zero=0A=
    65f8:	00441025 	or	v0,v0,a0=0A=
    65fc:	00651825 	or	v1,v1,a1=0A=
=0A=
    tx_desc->buffer_addr =3D =
cpu_to_le64(adapter->tx_ring.buffer_info[i].dma);=0A=
    6600:	ae820000 	sw	v0,0(s4)=0A=
    6604:	ae830004 	sw	v1,4(s4)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    6608:	8e44005c 	lw	a0,92(s2)=0A=
    tx_desc->lower.data =3D cpu_to_le32(skb->len);=0A=
=0A=
    /* zero out the status field in the descriptor */=0A=
=0A=
    tx_desc->upper.data =3D 0;=0A=
=0A=
    tx_desc->lower.data |=3D E1000_TXD_CMD_EOP;=0A=
    660c:	3c050100 	lui	a1,0x100=0A=
    tx_desc->lower.data |=3D E1000_TXD_CMD_IFCS;=0A=
    6610:	3c060200 	lui	a2,0x200=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6614:	3083ff00 	andi	v1,a0,0xff00=0A=
    6618:	00031a00 	sll	v1,v1,0x8=0A=
    661c:	008d6824 	and	t5,a0,t5=0A=
    6620:	00041600 	sll	v0,a0,0x18=0A=
    6624:	00431025 	or	v0,v0,v1=0A=
    6628:	000d6a02 	srl	t5,t5,0x8=0A=
    662c:	00042602 	srl	a0,a0,0x18=0A=
    6630:	004d1025 	or	v0,v0,t5=0A=
    6634:	00441025 	or	v0,v0,a0=0A=
    6638:	00451025 	or	v0,v0,a1=0A=
    663c:	00461025 	or	v0,v0,a2=0A=
    tx_desc->lower.data |=3D E1000_TXD_CMD_IDE;=0A=
    6640:	3c038000 	lui	v1,0x8000=0A=
    6644:	00432025 	or	a0,v0,v1=0A=
    6648:	ae80000c 	sw	zero,12(s4)=0A=
    664c:	ae840008 	sw	a0,8(s4)=0A=
=0A=
    if(adapter->shared.report_tx_early =3D=3D 1)=0A=
    6650:	8e63006c 	lw	v1,108(s3)=0A=
    6654:	24020001 	li	v0,1=0A=
    6658:	54620002 	bnel	v1,v0,6664 <e1000_xmit_lbtest_frame+0x190>=0A=
    665c:	3c021000 	lui	v0,0x1000=0A=
        tx_desc->lower.data |=3D E1000_TXD_CMD_RS;=0A=
    6660:	3c020800 	lui	v0,0x800=0A=
    else=0A=
        tx_desc->lower.data |=3D E1000_TXD_CMD_RPS;=0A=
    6664:	00821025 	or	v0,a0,v0=0A=
    6668:	ae820008 	sw	v0,8(s4)=0A=
=0A=
    /* Move the HW Tx Tail Pointer */=0A=
=0A=
    adapter->tx_ring.next_to_use++;=0A=
    666c:	8e6200f8 	lw	v0,248(s3)=0A=
    adapter->tx_ring.next_to_use %=3D adapter->tx_ring.count;=0A=
    6670:	8e6300f0 	lw	v1,240(s3)=0A=
    6674:	24420001 	addiu	v0,v0,1=0A=
    6678:	0043001b 	divu	zero,v0,v1=0A=
    667c:	ae6200f8 	sw	v0,248(s3)=0A=
    6680:	50600001 	beqzl	v1,6688 <e1000_xmit_lbtest_frame+0x1b4>=0A=
    6684:	0007000d 	break	0x7=0A=
    6688:	8e62000c 	lw	v0,12(s3)=0A=
    668c:	2c420002 	sltiu	v0,v0,2=0A=
    6690:	00003010 	mfhi	a2=0A=
    6694:	1440000e 	bnez	v0,66d0 <e1000_xmit_lbtest_frame+0x1fc>=0A=
    6698:	ae6600f8 	sw	a2,248(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    669c:	30c3ff00 	andi	v1,a2,0xff00=0A=
    66a0:	00031a00 	sll	v1,v1,0x8=0A=
    66a4:	00061600 	sll	v0,a2,0x18=0A=
    66a8:	00062202 	srl	a0,a2,0x8=0A=
    66ac:	00431025 	or	v0,v0,v1=0A=
    66b0:	3084ff00 	andi	a0,a0,0xff00=0A=
    66b4:	8e650008 	lw	a1,8(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    66b8:	00441025 	or	v0,v0,a0=0A=
    66bc:	00061e02 	srl	v1,a2,0x18=0A=
    66c0:	00431025 	or	v0,v0,v1=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, TDT, adapter->tx_ring.next_to_use);=0A=
    66c4:	aca23818 	sw	v0,14360(a1)=0A=
    66c8:	080019bf 	j	66fc <e1000_xmit_lbtest_frame+0x228>=0A=
    66cc:	00000000 	nop=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    66d0:	30c3ff00 	andi	v1,a2,0xff00=0A=
    66d4:	00031a00 	sll	v1,v1,0x8=0A=
    66d8:	00061600 	sll	v0,a2,0x18=0A=
    66dc:	00062202 	srl	a0,a2,0x8=0A=
    66e0:	00431025 	or	v0,v0,v1=0A=
    66e4:	3084ff00 	andi	a0,a0,0xff00=0A=
    66e8:	8e650008 	lw	a1,8(s3)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    66ec:	00441025 	or	v0,v0,a0=0A=
    66f0:	00061e02 	srl	v1,a2,0x18=0A=
    66f4:	00431025 	or	v0,v0,v1=0A=
    66f8:	aca20438 	sw	v0,1080(a1)=0A=
    mdelay(10);=0A=
    66fc:	3c040000 	lui	a0,0x0=0A=
    6700:	8c840000 	lw	a0,0(a0)=0A=
    6704:	3c031999 	lui	v1,0x1999=0A=
    6708:	24050009 	li	a1,9=0A=
    670c:	346396c0 	ori	v1,v1,0x96c0=0A=
    6710:	2406ffff 	li	a2,-1=0A=
{=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
	__asm__("multu\t%2,%3"=0A=
    6714:	00640019 	multu	v1,a0=0A=
    6718:	00001010 	mfhi	v0=0A=
	...=0A=
    6724:	1440ffff 	bnez	v0,6724 <e1000_xmit_lbtest_frame+0x250>=0A=
    6728:	2442ffff 	addiu	v0,v0,-1=0A=
    672c:	24a5ffff 	addiu	a1,a1,-1=0A=
    6730:	14a6fff8 	bne	a1,a2,6714 <e1000_xmit_lbtest_frame+0x240>=0A=
    6734:	266200f4 	addiu	v0,s3,244=0A=
 * Atomically subtracts @i from @v.  Note that the guaranteed=0A=
 * useful range of an atomic_t is only 24 bits.=0A=
 */=0A=
extern __inline__ void atomic_sub(int i, atomic_t * v)=0A=
{=0A=
    6738:	24030001 	li	v1,1=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    673c:	c0450000 	ll	a1,0(v0)=0A=
    6740:	00a32823 	subu	a1,a1,v1=0A=
    6744:	e0450000 	sc	a1,0(v0)=0A=
    6748:	10a0fffc 	beqz	a1,673c <e1000_xmit_lbtest_frame+0x268>=0A=
    674c:	00000000 	nop=0A=
=0A=
    atomic_dec(&adapter->tx_ring.unused);=0A=
=0A=
    if(atomic_read(&adapter->tx_ring.unused) <=3D 1) {=0A=
    6750:	8c440000 	lw	a0,0(v0)=0A=
    6754:	28840002 	slti	a0,a0,2=0A=
    6758:	50800005 	beqzl	a0,6770 <e1000_xmit_lbtest_frame+0x29c>=0A=
    675c:	24020001 	li	v0,1=0A=
=0A=
        /* this driver never actually drops transmits,=0A=
         * so use tx_dropped count to indicate the number of times=0A=
         * netif_stop_queue is called due to no available descriptors=0A=
         */=0A=
=0A=
        adapter->net_stats.tx_dropped++;=0A=
    6760:	8e63016c 	lw	v1,364(s3)=0A=
        return (0);=0A=
    6764:	00001021 	move	v0,zero=0A=
    6768:	24630001 	addiu	v1,v1,1=0A=
    676c:	ae63016c 	sw	v1,364(s3)=0A=
    }=0A=
    return (1);=0A=
}=0A=
    6770:	8fbf0024 	lw	ra,36(sp)=0A=
    6774:	8fb40020 	lw	s4,32(sp)=0A=
    6778:	8fb3001c 	lw	s3,28(sp)=0A=
    677c:	8fb20018 	lw	s2,24(sp)=0A=
    6780:	8fb10014 	lw	s1,20(sp)=0A=
    6784:	8fb00010 	lw	s0,16(sp)=0A=
    6788:	03e00008 	jr	ra=0A=
    678c:	27bd0028 	addiu	sp,sp,40=0A=
=0A=
00006790 <e1000_rcv_lbtest_frame>:=0A=
=0A=
int=0A=
e1000_rcv_lbtest_frame(struct e1000_adapter *adapter,=0A=
                       unsigned int frame_size)=0A=
{=0A=
    struct pci_dev *pdev =3D adapter->pdev;=0A=
    struct e1000_rx_desc *rx_desc;=0A=
    int i, j =3D 0, rcved_pkt =3D 0;=0A=
    uint32_t Length;=0A=
    struct sk_buff *skb;=0A=
=0A=
    mdelay(500);=0A=
    6790:	3c060000 	lui	a2,0x0=0A=
    6794:	8cc60000 	lw	a2,0(a2)=0A=
    6798:	27bdffb8 	addiu	sp,sp,-72=0A=
    679c:	3c031999 	lui	v1,0x1999=0A=
    67a0:	afbe0040 	sw	s8,64(sp)=0A=
    67a4:	afa5004c 	sw	a1,76(sp)=0A=
    67a8:	0080f021 	move	s8,a0=0A=
    67ac:	afbf0044 	sw	ra,68(sp)=0A=
    67b0:	afb7003c 	sw	s7,60(sp)=0A=
    67b4:	afb60038 	sw	s6,56(sp)=0A=
    67b8:	afb50034 	sw	s5,52(sp)=0A=
    67bc:	afb40030 	sw	s4,48(sp)=0A=
    67c0:	afb3002c 	sw	s3,44(sp)=0A=
    67c4:	afb20028 	sw	s2,40(sp)=0A=
    67c8:	afb10024 	sw	s1,36(sp)=0A=
    67cc:	afb00020 	sw	s0,32(sp)=0A=
    67d0:	afa00010 	sw	zero,16(sp)=0A=
    67d4:	00003821 	move	a3,zero=0A=
    67d8:	240401f3 	li	a0,499=0A=
    67dc:	346396c0 	ori	v1,v1,0x96c0=0A=
    67e0:	2405ffff 	li	a1,-1=0A=
{=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
	__asm__("multu\t%2,%3"=0A=
    67e4:	00660019 	multu	v1,a2=0A=
    67e8:	00001010 	mfhi	v0=0A=
	...=0A=
    67f4:	1440ffff 	bnez	v0,67f4 <e1000_rcv_lbtest_frame+0x64>=0A=
    67f8:	2442ffff 	addiu	v0,v0,-1=0A=
    67fc:	2484ffff 	addiu	a0,a0,-1=0A=
    6800:	1485fff8 	bne	a0,a1,67e4 <e1000_rcv_lbtest_frame+0x54>=0A=
    6804:	00000000 	nop=0A=
    i =3D adapter->rx_ring.next_to_clean;=0A=
    6808:	8fd20128 	lw	s2,296(s8)=0A=
    rx_desc =3D E1000_RX_DESC(adapter->rx_ring, i);=0A=
    680c:	8fc40110 	lw	a0,272(s8)=0A=
    6810:	00121900 	sll	v1,s2,0x4=0A=
    6814:	0083b021 	addu	s6,a0,v1=0A=
=0A=
    while(rx_desc->status & E1000_RXD_STAT_DD) {=0A=
    6818:	92c2000c 	lbu	v0,12(s6)=0A=
    681c:	30420001 	andi	v0,v0,0x1=0A=
    6820:	1040005e 	beqz	v0,699c <e1000_rcv_lbtest_frame+0x20c>=0A=
    6824:	3c157fff 	lui	s5,0x7fff=0A=
    6828:	24130001 	li	s3,1=0A=
    682c:	27d40120 	addiu	s4,s8,288=0A=
    6830:	36b5f1c0 	ori	s5,s5,0xf1c0=0A=
        Length =3D le16_to_cpu(rx_desc->length) - CRC_LENGTH;=0A=
        skb =3D adapter->rx_ring.buffer_info[i].skb;=0A=
    6834:	8fc3012c 	lw	v1,300(s8)=0A=
    6838:	00121040 	sll	v0,s2,0x1=0A=
    683c:	00521021 	addu	v0,v0,s2=0A=
    6840:	0002b8c0 	sll	s7,v0,0x3=0A=
    6844:	02e31821 	addu	v1,s7,v1=0A=
    6848:	8c710000 	lw	s1,0(v1)=0A=
=0A=
        /* Snoop the packet for pattern */=0A=
        rcved_pkt =3D e1000_check_lbtest_frame(skb, frame_size);=0A=
    684c:	8fa5004c 	lw	a1,76(sp)=0A=
    6850:	3c020000 	lui	v0,0x0=0A=
    6854:	24426d8c 	addiu	v0,v0,28044=0A=
    6858:	0040f809 	jalr	v0=0A=
    685c:	02202021 	move	a0,s1=0A=
    6860:	00403821 	move	a3,v0=0A=
	return result;=0A=
}=0A=
=0A=
extern __inline__ int atomic_sub_return(int i, atomic_t * v)=0A=
{=0A=
    6864:	26220070 	addiu	v0,s1,112=0A=
	unsigned long temp, result;=0A=
=0A=
	__asm__ __volatile__(=0A=
    6868:	c0440000 	ll	a0,0(v0)=0A=
    686c:	00931823 	subu	v1,a0,s3=0A=
    6870:	e0430000 	sc	v1,0(v0)=0A=
    6874:	1060fffc 	beqz	v1,6868 <e1000_rcv_lbtest_frame+0xd8>=0A=
    6878:	00931823 	subu	v1,a0,s3=0A=
 * is executing from interrupt context.=0A=
 */=0A=
static inline void dev_kfree_skb_irq(struct sk_buff *skb)=0A=
{=0A=
	if (atomic_dec_and_test(&skb->users)) {=0A=
    687c:	5460001f 	bnezl	v1,68fc <e1000_rcv_lbtest_frame+0x16c>=0A=
    6880:	8fc2012c 	lw	v0,300(s8)=0A=
		int cpu =3Dsmp_processor_id();=0A=
		unsigned long flags;=0A=
=0A=
		local_irq_save(flags);=0A=
    6884:	40106000 	mfc0	s0,$12=0A=
    6888:	00000000 	nop=0A=
    688c:	36010001 	ori	at,s0,0x1=0A=
    6890:	38210001 	xori	at,at,0x1=0A=
    6894:	40816000 	mtc0	at,$12=0A=
    6898:	00000040 	sll	zero,zero,0x1=0A=
    689c:	00000040 	sll	zero,zero,0x1=0A=
    68a0:	00000040 	sll	zero,zero,0x1=0A=
		skb->next =3D softnet_data[cpu].completion_queue;=0A=
    68a4:	3c030000 	lui	v1,0x0=0A=
    68a8:	8c630020 	lw	v1,32(v1)=0A=
		softnet_data[cpu].completion_queue =3D skb;=0A=
		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);=0A=
    68ac:	00002021 	move	a0,zero=0A=
    68b0:	24050001 	li	a1,1=0A=
    68b4:	ae230000 	sw	v1,0(s1)=0A=
    68b8:	3c020000 	lui	v0,0x0=0A=
    68bc:	24420000 	addiu	v0,v0,0=0A=
    68c0:	3c010000 	lui	at,0x0=0A=
    68c4:	ac310020 	sw	s1,32(at)=0A=
    68c8:	0040f809 	jalr	v0=0A=
    68cc:	afa70018 	sw	a3,24(sp)=0A=
		local_irq_restore(flags);=0A=
    68d0:	40016000 	mfc0	at,$12=0A=
    68d4:	32100001 	andi	s0,s0,0x1=0A=
    68d8:	34210001 	ori	at,at,0x1=0A=
    68dc:	38210001 	xori	at,at,0x1=0A=
    68e0:	02018025 	or	s0,s0,at=0A=
    68e4:	40906000 	mtc0	s0,$12=0A=
	...=0A=
    68f4:	8fa70018 	lw	a3,24(sp)=0A=
=0A=
        pci_unmap_single(pdev, adapter->rx_ring.buffer_info[i].dma,=0A=
                         adapter->rx_ring.buffer_info[i].length,=0A=
                         PCI_DMA_FROMDEVICE);=0A=
=0A=
        dev_kfree_skb_irq(skb);=0A=
        adapter->rx_ring.buffer_info[i].skb =3D NULL;=0A=
    68f8:	8fc2012c 	lw	v0,300(s8)=0A=
    68fc:	02e21021 	addu	v0,s7,v0=0A=
    6900:	ac400000 	sw	zero,0(v0)=0A=
=0A=
        rx_desc->status =3D 0;=0A=
    6904:	a2c0000c 	sb	zero,12(s6)=0A=
extern __inline__ void atomic_add(int i, atomic_t * v)=0A=
{=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    6908:	c2830000 	ll	v1,0(s4)=0A=
    690c:	00731821 	addu	v1,v1,s3=0A=
    6910:	e2830000 	sc	v1,0(s4)=0A=
    6914:	1060fffc 	beqz	v1,6908 <e1000_rcv_lbtest_frame+0x178>=0A=
    6918:	00000000 	nop=0A=
        atomic_inc(&adapter->rx_ring.unused);=0A=
=0A=
        i++;=0A=
        i %=3D adapter->rx_ring.count;=0A=
    691c:	8fc2011c 	lw	v0,284(s8)=0A=
    6920:	26520001 	addiu	s2,s2,1=0A=
        rx_desc =3D E1000_RX_DESC(adapter->rx_ring, i);=0A=
=0A=
        if(rcved_pkt)=0A=
            break;=0A=
=0A=
        /* waited enough */=0A=
        if(j++ >=3D adapter->rx_ring.count)=0A=
    6924:	8fa30010 	lw	v1,16(sp)=0A=
    6928:	0242001b 	divu	zero,s2,v0=0A=
    692c:	50400001 	beqzl	v0,6934 <e1000_rcv_lbtest_frame+0x1a4>=0A=
    6930:	0007000d 	break	0x7=0A=
    6934:	8fc50110 	lw	a1,272(s8)=0A=
    6938:	0062302b 	sltu	a2,v1,v0=0A=
    693c:	00601021 	move	v0,v1=0A=
    6940:	24420001 	addiu	v0,v0,1=0A=
    6944:	afa20010 	sw	v0,16(sp)=0A=
    6948:	00001021 	move	v0,zero=0A=
    694c:	00002010 	mfhi	a0=0A=
    6950:	00809021 	move	s2,a0=0A=
    6954:	00000000 	nop=0A=
    6958:	00121900 	sll	v1,s2,0x4=0A=
    695c:	14e0000f 	bnez	a3,699c <e1000_rcv_lbtest_frame+0x20c>=0A=
    6960:	00a3b021 	addu	s6,a1,v1=0A=
    6964:	10c00010 	beqz	a2,69a8 <e1000_rcv_lbtest_frame+0x218>=0A=
    6968:	8fbf0044 	lw	ra,68(sp)=0A=
 * first constant multiplications gets optimized away if the delay is=0A=
 * a constant)=0A=
 */=0A=
extern __inline__ void __udelay(unsigned long usecs, unsigned long lpj)=0A=
{=0A=
    696c:	3c020000 	lui	v0,0x0=0A=
    6970:	8c420000 	lw	v0,0(v0)=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
	__asm__("multu\t%2,%3"=0A=
    6974:	02a20019 	multu	s5,v0=0A=
    6978:	00001010 	mfhi	v0=0A=
	...=0A=
    6984:	1440ffff 	bnez	v0,6984 <e1000_rcv_lbtest_frame+0x1f4>=0A=
    6988:	2442ffff 	addiu	v0,v0,-1=0A=
            return 0;=0A=
=0A=
        mdelay(5);=0A=
=0A=
    }=0A=
    698c:	92c3000c 	lbu	v1,12(s6)=0A=
    6990:	30630001 	andi	v1,v1,0x1=0A=
    6994:	5460ffa8 	bnezl	v1,6838 <e1000_rcv_lbtest_frame+0xa8>=0A=
    6998:	8fc3012c 	lw	v1,300(s8)=0A=
=0A=
    adapter->rx_ring.next_to_clean =3D i;=0A=
    699c:	afd20128 	sw	s2,296(s8)=0A=
=0A=
    return (rcved_pkt);=0A=
    69a0:	00e01021 	move	v0,a3=0A=
=0A=
}=0A=
    69a4:	8fbf0044 	lw	ra,68(sp)=0A=
    69a8:	8fbe0040 	lw	s8,64(sp)=0A=
    69ac:	8fb7003c 	lw	s7,60(sp)=0A=
    69b0:	8fb60038 	lw	s6,56(sp)=0A=
    69b4:	8fb50034 	lw	s5,52(sp)=0A=
    69b8:	8fb40030 	lw	s4,48(sp)=0A=
    69bc:	8fb3002c 	lw	s3,44(sp)=0A=
    69c0:	8fb20028 	lw	s2,40(sp)=0A=
    69c4:	8fb10024 	lw	s1,36(sp)=0A=
    69c8:	8fb00020 	lw	s0,32(sp)=0A=
    69cc:	03e00008 	jr	ra=0A=
    69d0:	27bd0048 	addiu	sp,sp,72=0A=
=0A=
000069d4 <e1000_selective_wakeup_adapter>:=0A=
    69d4:	27bdffe0 	addiu	sp,sp,-32=0A=
    69d8:	afb10014 	sw	s1,20(sp)=0A=
    69dc:	afbf0018 	sw	ra,24(sp)=0A=
    69e0:	afb00010 	sw	s0,16(sp)=0A=
=0A=
void=0A=
e1000_selective_wakeup_adapter(struct net_device *netdev)=0A=
{=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    69e4:	8c900064 	lw	s0,100(a0)=0A=
    uint32_t ctrl, txcw;=0A=
=0A=
    e1000_init_hw(&adapter->shared);=0A=
    69e8:	3c020000 	lui	v0,0x0=0A=
    69ec:	24420000 	addiu	v0,v0,0=0A=
    69f0:	26110008 	addiu	s1,s0,8=0A=
    69f4:	0040f809 	jalr	v0=0A=
    69f8:	02202021 	move	a0,s1=0A=
=0A=
    if((adapter->link_active =3D=3D FALSE) &&=0A=
    69fc:	8e0300b0 	lw	v1,176(s0)=0A=
    6a00:	14600048 	bnez	v1,6b24 <e1000_selective_wakeup_adapter+0x150>=0A=
    6a04:	2604008c 	addiu	a0,s0,140=0A=
    6a08:	8e0a000c 	lw	t2,12(s0)=0A=
    6a0c:	24020002 	li	v0,2=0A=
    6a10:	55420045 	bnel	t2,v0,6b28 =
<e1000_selective_wakeup_adapter+0x154>=0A=
    6a14:	8c820000 	lw	v0,0(a0)=0A=
       (adapter->shared.mac_type =3D=3D e1000_82543)) {=0A=
=0A=
        txcw =3D E1000_READ_REG(&adapter->shared, TXCW);=0A=
    6a18:	8e220000 	lw	v0,0(s1)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6a1c:	3c0700ff 	lui	a3,0xff=0A=
        ctrl =3D E1000_READ_REG(&adapter->shared, CTRL);=0A=
    6a20:	2d4a0002 	sltiu	t2,t2,2=0A=
    6a24:	00405821 	move	t3,v0=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    6a28:	8c480178 	lw	t0,376(v0)=0A=
    6a2c:	8d690000 	lw	t1,0(t3)=0A=
	return __arch__swab32(x);=0A=
    6a30:	3104ff00 	andi	a0,t0,0xff00=0A=
    6a34:	3125ff00 	andi	a1,t1,0xff00=0A=
    6a38:	01273024 	and	a2,t1,a3=0A=
    6a3c:	00081e00 	sll	v1,t0,0x18=0A=
    6a40:	01073824 	and	a3,t0,a3=0A=
    6a44:	00091600 	sll	v0,t1,0x18=0A=
    6a48:	00042200 	sll	a0,a0,0x8=0A=
    6a4c:	00052a00 	sll	a1,a1,0x8=0A=
    6a50:	00063202 	srl	a2,a2,0x8=0A=
    6a54:	00641825 	or	v1,v1,a0=0A=
    6a58:	00451025 	or	v0,v0,a1=0A=
    6a5c:	00073a02 	srl	a3,a3,0x8=0A=
    6a60:	00671825 	or	v1,v1,a3=0A=
    6a64:	00461025 	or	v0,v0,a2=0A=
    6a68:	00084602 	srl	t0,t0,0x18=0A=
    6a6c:	00094e02 	srl	t1,t1,0x18=0A=
    6a70:	00681825 	or	v1,v1,t0=0A=
    6a74:	00493025 	or	a2,v0,t1=0A=
        E1000_WRITE_REG(&adapter->shared, TXCW, txcw & ~E1000_TXCW_ANE);=0A=
    6a78:	3c047fff 	lui	a0,0x7fff=0A=
    6a7c:	3484ffff 	ori	a0,a0,0xffff=0A=
    6a80:	00642024 	and	a0,v1,a0=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6a84:	3065ff00 	andi	a1,v1,0xff00=0A=
    6a88:	00031600 	sll	v0,v1,0x18=0A=
    6a8c:	00052a00 	sll	a1,a1,0x8=0A=
    6a90:	00041a02 	srl	v1,a0,0x8=0A=
    6a94:	00451025 	or	v0,v0,a1=0A=
    6a98:	3063ff00 	andi	v1,v1,0xff00=0A=
    6a9c:	00431025 	or	v0,v0,v1=0A=
    6aa0:	00042602 	srl	a0,a0,0x18=0A=
    6aa4:	00441025 	or	v0,v0,a0=0A=
    6aa8:	ad620178 	sw	v0,376(t3)=0A=
    6aac:	8e02000c 	lw	v0,12(s0)=0A=
    6ab0:	2c420002 	sltiu	v0,v0,2=0A=
        E1000_WRITE_REG(&adapter->shared, CTRL,=0A=
    6ab4:	34c500c1 	ori	a1,a2,0xc1=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6ab8:	30a3ff00 	andi	v1,a1,0xff00=0A=
    6abc:	00031a00 	sll	v1,v1,0x8=0A=
    6ac0:	00051600 	sll	v0,a1,0x18=0A=
    6ac4:	00052202 	srl	a0,a1,0x8=0A=
    6ac8:	00431025 	or	v0,v0,v1=0A=
    6acc:	3084ff00 	andi	a0,a0,0xff00=0A=
    6ad0:	8e030008 	lw	v1,8(s0)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6ad4:	00441025 	or	v0,v0,a0=0A=
    6ad8:	00052e02 	srl	a1,a1,0x18=0A=
    6adc:	00451025 	or	v0,v0,a1=0A=
    6ae0:	ac620000 	sw	v0,0(v1)=0A=
                        (ctrl | E1000_CTRL_SLU | E1000_CTRL_ILOS |=0A=
                         E1000_CTRL_FD));=0A=
        mdelay(20);=0A=
    6ae4:	3c040000 	lui	a0,0x0=0A=
    6ae8:	8c840000 	lw	a0,0(a0)=0A=
    6aec:	3c031999 	lui	v1,0x1999=0A=
    6af0:	24050013 	li	a1,19=0A=
    6af4:	346396c0 	ori	v1,v1,0x96c0=0A=
    6af8:	2406ffff 	li	a2,-1=0A=
{=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
	__asm__("multu\t%2,%3"=0A=
    6afc:	00640019 	multu	v1,a0=0A=
    6b00:	00001010 	mfhi	v0=0A=
	...=0A=
    6b0c:	1440ffff 	bnez	v0,6b0c <e1000_selective_wakeup_adapter+0x138>=0A=
    6b10:	2442ffff 	addiu	v0,v0,-1=0A=
    6b14:	24a5ffff 	addiu	a1,a1,-1=0A=
    6b18:	14a6fff8 	bne	a1,a2,6afc <e1000_selective_wakeup_adapter+0x128>=0A=
    6b1c:	00000000 	nop=0A=
 * @nr: bit number to test=0A=
 * @addr: Address to start counting from=0A=
 */=0A=
extern __inline__ int test_bit(int nr, volatile void *addr)=0A=
{=0A=
    6b20:	2604008c 	addiu	a0,s0,140=0A=
	return ((1UL << (nr & 31)) & (((const unsigned int *) addr)[nr >> 5])) =
!=3D 0;=0A=
    6b24:	8c820000 	lw	v0,0(a0)=0A=
    6b28:	30420001 	andi	v0,v0,0x1=0A=
    }=0A=
=0A=
    if(!test_bit(E1000_BOARD_OPEN, &adapter->flags)) {=0A=
    6b2c:	14400013 	bnez	v0,6b7c <e1000_selective_wakeup_adapter+0x1a8>=0A=
    6b30:	00000000 	nop=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    6b34:	c0820000 	ll	v0,0(a0)=0A=
    6b38:	34420001 	ori	v0,v0,0x1=0A=
    6b3c:	e0820000 	sc	v0,0(a0)=0A=
    6b40:	1040fffc 	beqz	v0,6b34 <e1000_selective_wakeup_adapter+0x160>=0A=
    6b44:	00000000 	nop=0A=
    6b48:	c0830000 	ll	v1,0(a0)=0A=
    6b4c:	34630004 	ori	v1,v1,0x4=0A=
    6b50:	e0830000 	sc	v1,0(a0)=0A=
    6b54:	1060fffc 	beqz	v1,6b48 <e1000_selective_wakeup_adapter+0x174>=0A=
    6b58:	00000000 	nop=0A=
        set_bit(E1000_BOARD_OPEN, &adapter->flags);=0A=
        set_bit(E1000_DIAG_OPEN, &adapter->flags);=0A=
        e1000_setup_tx_resources(adapter);=0A=
    6b5c:	3c020000 	lui	v0,0x0=0A=
    6b60:	24421e60 	addiu	v0,v0,7776=0A=
    6b64:	0040f809 	jalr	v0=0A=
    6b68:	02002021 	move	a0,s0=0A=
        e1000_setup_rx_resources(adapter);=0A=
    6b6c:	3c020000 	lui	v0,0x0=0A=
    6b70:	24422208 	addiu	v0,v0,8712=0A=
    6b74:	0040f809 	jalr	v0=0A=
    6b78:	02002021 	move	a0,s0=0A=
    }=0A=
    e1000_setup_rctl(adapter);=0A=
    6b7c:	3c020000 	lui	v0,0x0=0A=
    6b80:	24422308 	addiu	v0,v0,8968=0A=
    6b84:	0040f809 	jalr	v0=0A=
    6b88:	02002021 	move	a0,s0=0A=
    e1000_configure_rx(adapter);=0A=
    6b8c:	3c020000 	lui	v0,0x0=0A=
    6b90:	244223a8 	addiu	v0,v0,9128=0A=
    6b94:	0040f809 	jalr	v0=0A=
    6b98:	02002021 	move	a0,s0=0A=
    e1000_alloc_rx_buffers((unsigned long) adapter);=0A=
    6b9c:	3c020000 	lui	v0,0x0=0A=
    6ba0:	24425e30 	addiu	v0,v0,24112=0A=
    6ba4:	0040f809 	jalr	v0=0A=
    6ba8:	02002021 	move	a0,s0=0A=
    e1000_configure_tx(adapter);=0A=
    6bac:	3c020000 	lui	v0,0x0=0A=
    6bb0:	24421f60 	addiu	v0,v0,8032=0A=
    6bb4:	0040f809 	jalr	v0=0A=
    6bb8:	02002021 	move	a0,s0=0A=
}=0A=
    6bbc:	8fbf0018 	lw	ra,24(sp)=0A=
    6bc0:	8fb10014 	lw	s1,20(sp)=0A=
    6bc4:	8fb00010 	lw	s0,16(sp)=0A=
    6bc8:	03e00008 	jr	ra=0A=
    6bcc:	27bd0020 	addiu	sp,sp,32=0A=
=0A=
00006bd0 <e1000_selective_hibernate_adapter>:=0A=
    6bd0:	27bdffe0 	addiu	sp,sp,-32=0A=
    6bd4:	afbf0018 	sw	ra,24(sp)=0A=
    6bd8:	afb10014 	sw	s1,20(sp)=0A=
    6bdc:	afb00010 	sw	s0,16(sp)=0A=
=0A=
void=0A=
e1000_selective_hibernate_adapter(struct net_device *netdev)=0A=
{=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    6be0:	8c910064 	lw	s1,100(a0)=0A=
    uint32_t ctrl, txcw;=0A=
=0A=
    if((adapter->link_active =3D=3D FALSE) &&=0A=
    6be4:	8e2200b0 	lw	v0,176(s1)=0A=
    6be8:	14400043 	bnez	v0,6cf8 =
<e1000_selective_hibernate_adapter+0x128>=0A=
    6bec:	24020002 	li	v0,2=0A=
    6bf0:	8e2a000c 	lw	t2,12(s1)=0A=
    6bf4:	15420040 	bne	t2,v0,6cf8 =
<e1000_selective_hibernate_adapter+0x128>=0A=
    6bf8:	3c0700ff 	lui	a3,0xff=0A=
       (adapter->shared.mac_type =3D=3D e1000_82543)) {=0A=
=0A=
        txcw =3D E1000_READ_REG(&adapter->shared, TXCW);=0A=
    6bfc:	8e2b0008 	lw	t3,8(s1)=0A=
        ctrl =3D E1000_READ_REG(&adapter->shared, CTRL);=0A=
        ctrl &=3D ~E1000_CTRL_SLU & ~E1000_CTRL_ILOS;=0A=
    6c00:	2d4a0002 	sltiu	t2,t2,2=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    6c04:	8d690178 	lw	t1,376(t3)=0A=
    6c08:	8d620000 	lw	v0,0(t3)=0A=
	return __arch__swab32(x);=0A=
    6c0c:	3124ff00 	andi	a0,t1,0xff00=0A=
    6c10:	3045ff00 	andi	a1,v0,0xff00=0A=
    6c14:	00474024 	and	t0,v0,a3=0A=
    6c18:	00093600 	sll	a2,t1,0x18=0A=
    6c1c:	01273824 	and	a3,t1,a3=0A=
    6c20:	00021e00 	sll	v1,v0,0x18=0A=
    6c24:	00042200 	sll	a0,a0,0x8=0A=
    6c28:	00052a00 	sll	a1,a1,0x8=0A=
    6c2c:	00073a02 	srl	a3,a3,0x8=0A=
    6c30:	00c43025 	or	a2,a2,a0=0A=
    6c34:	00651825 	or	v1,v1,a1=0A=
    6c38:	00084202 	srl	t0,t0,0x8=0A=
    6c3c:	00021602 	srl	v0,v0,0x18=0A=
    6c40:	00c73025 	or	a2,a2,a3=0A=
    6c44:	00681825 	or	v1,v1,t0=0A=
    6c48:	00094e02 	srl	t1,t1,0x18=0A=
    6c4c:	3042003f 	andi	v0,v0,0x3f=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6c50:	00c93025 	or	a2,a2,t1=0A=
    6c54:	00433825 	or	a3,v0,v1=0A=
        E1000_WRITE_REG(&adapter->shared, TXCW, txcw | E1000_TXCW_ANE);=0A=
    6c58:	3c038000 	lui	v1,0x8000=0A=
    6c5c:	00c31825 	or	v1,a2,v1=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6c60:	3065ff00 	andi	a1,v1,0xff00=0A=
    6c64:	00031600 	sll	v0,v1,0x18=0A=
    6c68:	00032202 	srl	a0,v1,0x8=0A=
    6c6c:	00052a00 	sll	a1,a1,0x8=0A=
    6c70:	00451025 	or	v0,v0,a1=0A=
    6c74:	3084ff00 	andi	a0,a0,0xff00=0A=
    6c78:	00441025 	or	v0,v0,a0=0A=
    6c7c:	00031e02 	srl	v1,v1,0x18=0A=
    6c80:	00431025 	or	v0,v0,v1=0A=
    6c84:	ad620178 	sw	v0,376(t3)=0A=
    6c88:	8e22000c 	lw	v0,12(s1)=0A=
    6c8c:	2c420002 	sltiu	v0,v0,2=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6c90:	30e3ff00 	andi	v1,a3,0xff00=0A=
    6c94:	00031a00 	sll	v1,v1,0x8=0A=
    6c98:	00071600 	sll	v0,a3,0x18=0A=
    6c9c:	00072202 	srl	a0,a3,0x8=0A=
    6ca0:	00431025 	or	v0,v0,v1=0A=
    6ca4:	3084ff00 	andi	a0,a0,0xff00=0A=
        E1000_WRITE_REG(&adapter->shared, CTRL, ctrl);=0A=
    6ca8:	8e250008 	lw	a1,8(s1)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    6cac:	00441025 	or	v0,v0,a0=0A=
    6cb0:	00071e02 	srl	v1,a3,0x18=0A=
    6cb4:	00431025 	or	v0,v0,v1=0A=
    6cb8:	aca20000 	sw	v0,0(a1)=0A=
        mdelay(20);=0A=
    6cbc:	3c040000 	lui	a0,0x0=0A=
    6cc0:	8c840000 	lw	a0,0(a0)=0A=
    6cc4:	3c031999 	lui	v1,0x1999=0A=
    6cc8:	24050013 	li	a1,19=0A=
    6ccc:	346396c0 	ori	v1,v1,0x96c0=0A=
    6cd0:	2406ffff 	li	a2,-1=0A=
{=0A=
	unsigned long lo;=0A=
=0A=
	usecs *=3D 0x00068db8;		/* 2**32 / (1000000 / HZ) */=0A=
	__asm__("multu\t%2,%3"=0A=
    6cd4:	00640019 	multu	v1,a0=0A=
    6cd8:	00001010 	mfhi	v0=0A=
	...=0A=
    6ce4:	1440ffff 	bnez	v0,6ce4 =
<e1000_selective_hibernate_adapter+0x114>=0A=
    6ce8:	2442ffff 	addiu	v0,v0,-1=0A=
    6cec:	24a5ffff 	addiu	a1,a1,-1=0A=
    6cf0:	14a6fff8 	bne	a1,a2,6cd4 =
<e1000_selective_hibernate_adapter+0x104>=0A=
    6cf4:	00000000 	nop=0A=
    }=0A=
    /* clean out old buffers */=0A=
    e1000_clean_rx_ring(adapter);=0A=
    6cf8:	3c020000 	lui	v0,0x0=0A=
    6cfc:	244228d8 	addiu	v0,v0,10456=0A=
    6d00:	0040f809 	jalr	v0=0A=
    6d04:	02202021 	move	a0,s1=0A=
    e1000_clean_tx_ring(adapter);=0A=
    6d08:	3c020000 	lui	v0,0x0=0A=
    6d0c:	24422720 	addiu	v0,v0,10016=0A=
    6d10:	0040f809 	jalr	v0=0A=
    6d14:	02202021 	move	a0,s1=0A=
 * It also implies a memory barrier.=0A=
 */=0A=
extern __inline__ int=0A=
test_and_clear_bit(int nr, volatile void *addr)=0A=
{=0A=
    6d18:	2630008c 	addiu	s0,s1,140=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp, res;=0A=
=0A=
	__asm__ __volatile__(=0A=
    6d1c:	24020004 	li	v0,4=0A=
    6d20:	c2040000 	ll	a0,0(s0)=0A=
    6d24:	00821825 	or	v1,a0,v0=0A=
    6d28:	00621826 	xor	v1,v1,v0=0A=
    6d2c:	e2030000 	sc	v1,0(s0)=0A=
    6d30:	1060fffb 	beqz	v1,6d20 =
<e1000_selective_hibernate_adapter+0x150>=0A=
    6d34:	00821824 	and	v1,a0,v0=0A=
    if(test_and_clear_bit(E1000_DIAG_OPEN, &adapter->flags)) {=0A=
    6d38:	10600010 	beqz	v1,6d7c =
<e1000_selective_hibernate_adapter+0x1ac>=0A=
    6d3c:	8fbf0018 	lw	ra,24(sp)=0A=
        e1000_free_tx_resources(adapter);=0A=
    6d40:	3c020000 	lui	v0,0x0=0A=
    6d44:	244226b4 	addiu	v0,v0,9908=0A=
    6d48:	0040f809 	jalr	v0=0A=
    6d4c:	02202021 	move	a0,s1=0A=
        e1000_free_rx_resources(adapter);=0A=
    6d50:	3c020000 	lui	v0,0x0=0A=
    6d54:	2442284c 	addiu	v0,v0,10316=0A=
    6d58:	0040f809 	jalr	v0=0A=
    6d5c:	02202021 	move	a0,s1=0A=
{=0A=
	unsigned long *m =3D ((unsigned long *) addr) + (nr >> 5);=0A=
	unsigned long temp;=0A=
=0A=
	__asm__ __volatile__(=0A=
    6d60:	c2030000 	ll	v1,0(s0)=0A=
    6d64:	2401fffe 	li	at,-2=0A=
    6d68:	00611824 	and	v1,v1,at=0A=
    6d6c:	e2030000 	sc	v1,0(s0)=0A=
    6d70:	1060fffb 	beqz	v1,6d60 =
<e1000_selective_hibernate_adapter+0x190>=0A=
    6d74:	00000000 	nop=0A=
        clear_bit(E1000_BOARD_OPEN, &adapter->flags);=0A=
    }=0A=
}=0A=
    6d78:	8fbf0018 	lw	ra,24(sp)=0A=
    6d7c:	8fb10014 	lw	s1,20(sp)=0A=
    6d80:	8fb00010 	lw	s0,16(sp)=0A=
    6d84:	03e00008 	jr	ra=0A=
    6d88:	27bd0020 	addiu	sp,sp,32=0A=
=0A=
00006d8c <e1000_check_lbtest_frame>:=0A=
=0A=
static int=0A=
e1000_check_lbtest_frame(struct sk_buff *skb,=0A=
                         unsigned int frame_size)=0A=
{=0A=
    frame_size =3D (frame_size % 2) ? (frame_size - 1) : frame_size;=0A=
    if(*(skb->data + 3) =3D=3D 0xFF) {=0A=
    6d8c:	8c860080 	lw	a2,128(a0)=0A=
    6d90:	30a20001 	andi	v0,a1,0x1=0A=
    6d94:	00a22823 	subu	a1,a1,v0=0A=
    6d98:	90c40003 	lbu	a0,3(a2)=0A=
        if((*(skb->data + frame_size / 2 + 10) =3D=3D 0xBE) &&=0A=
    6d9c:	00052842 	srl	a1,a1,0x1=0A=
    6da0:	240300ff 	li	v1,255=0A=
    6da4:	240700be 	li	a3,190=0A=
    6da8:	14830008 	bne	a0,v1,6dcc <e1000_check_lbtest_frame+0x40>=0A=
    6dac:	00c53021 	addu	a2,a2,a1=0A=
    6db0:	90c3000a 	lbu	v1,10(a2)=0A=
    6db4:	240400af 	li	a0,175=0A=
    6db8:	14670004 	bne	v1,a3,6dcc <e1000_check_lbtest_frame+0x40>=0A=
    6dbc:	24020001 	li	v0,1=0A=
    6dc0:	90c3000c 	lbu	v1,12(a2)=0A=
    6dc4:	10640002 	beq	v1,a0,6dd0 <e1000_check_lbtest_frame+0x44>=0A=
    6dc8:	00000000 	nop=0A=
           (*(skb->data + frame_size / 2 + 12) =3D=3D 0xAF)) {=0A=
            return 1;=0A=
        }=0A=
    }=0A=
    return 0;=0A=
    6dcc:	00001021 	move	v0,zero=0A=
}=0A=
    6dd0:	03e00008 	jr	ra=0A=
    6dd4:	00000000 	nop=0A=
=0A=
00006dd8 <e1000_ethtool_ioctl>:=0A=
    6dd8:	27bdfeb8 	addiu	sp,sp,-328=0A=
    6ddc:	afb5013c 	sw	s5,316(sp)=0A=
    6de0:	afb40138 	sw	s4,312(sp)=0A=
    6de4:	afb30134 	sw	s3,308(sp)=0A=
    6de8:	afb1012c 	sw	s1,300(sp)=0A=
    6dec:	afbf0140 	sw	ra,320(sp)=0A=
    6df0:	afb20130 	sw	s2,304(sp)=0A=
    6df4:	afb00128 	sw	s0,296(sp)=0A=
    6df8:	00a09821 	move	s3,a1=0A=
#endif /* IDIAG */=0A=
=0A=
#ifdef SIOCETHTOOL=0A=
/**=0A=
 * e1000_ethtool_ioctl - Ethtool Ioctl Support =0A=
 * @netdev: net device structure =0A=
 * @ifr: interface request structure =0A=
 **/=0A=
=0A=
static int=0A=
e1000_ethtool_ioctl(struct net_device *netdev,=0A=
                    struct ifreq *ifr)=0A=
{=0A=
    struct ethtool_cmd eth_cmd;=0A=
    struct e1000_adapter *adapter =3D netdev->priv;=0A=
    boolean_t re_initiate =3D FALSE;=0A=
=0A=
#ifdef ETHTOOL_GLINK=0A=
    struct ethtool_value eth_e1000_linkinfo;=0A=
#endif=0A=
#ifdef ETHTOOL_GDRVINFO=0A=
    struct ethtool_drvinfo eth_e1000_info;=0A=
#endif=0A=
#ifdef ETHTOOL_GWOL=0A=
    struct ethtool_wolinfo eth_e1000_wolinfo;=0A=
#endif=0A=
=0A=
    /* Get the data structure */=0A=
    if(copy_from_user(&eth_cmd, ifr->ifr_data, sizeof(eth_cmd)))=0A=
    6dfc:	8e650010 	lw	a1,16(s3)=0A=
    6e00:	8f8303bc 	lw	v1,956(gp)=0A=
    6e04:	0080a821 	move	s5,a0=0A=
    6e08:	24a2002c 	addiu	v0,a1,44=0A=
    6e0c:	00a21025 	or	v0,a1,v0=0A=
    6e10:	00621824 	and	v1,v1,v0=0A=
    6e14:	8eb20064 	lw	s2,100(s5)=0A=
    6e18:	00008821 	move	s1,zero=0A=
    6e1c:	27b40010 	addiu	s4,sp,16=0A=
    6e20:	04600006 	bltz	v1,6e3c <e1000_ethtool_ioctl+0x64>=0A=
    6e24:	2406002c 	li	a2,44=0A=
    6e28:	02802021 	move	a0,s4=0A=
    6e2c:	3c010000 	lui	at,0x0=0A=
    6e30:	24210000 	addiu	at,at,0=0A=
    6e34:	0020f809 	jalr	at=0A=
    6e38:	00a60821 	addu	at,a1,a2=0A=
    6e3c:	14c00162 	bnez	a2,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    6e40:	2402fff2 	li	v0,-14=0A=
        return -EFAULT;=0A=
=0A=
    switch (eth_cmd.cmd) {=0A=
    6e44:	8fa20010 	lw	v0,16(sp)=0A=
    6e48:	2442ffff 	addiu	v0,v0,-1=0A=
    6e4c:	2c43000a 	sltiu	v1,v0,10=0A=
    6e50:	5060015d 	beqzl	v1,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    6e54:	2402ff86 	li	v0,-122=0A=
    6e58:	00021080 	sll	v0,v0,0x2=0A=
    6e5c:	3c030000 	lui	v1,0x0=0A=
    6e60:	00621821 	addu	v1,v1,v0=0A=
    6e64:	8c630f48 	lw	v1,3912(v1)=0A=
    6e68:	00600008 	jr	v1=0A=
    6e6c:	00000000 	nop=0A=
        /* Get the information */=0A=
    case ETHTOOL_GSET:=0A=
        if(adapter->shared.media_type =3D=3D e1000_media_type_copper) {=0A=
    6e70:	8e420010 	lw	v0,16(s2)=0A=
    6e74:	1440000c 	bnez	v0,6ea8 <e1000_ethtool_ioctl+0xd0>=0A=
    6e78:	24030440 	li	v1,1088=0A=
            eth_cmd.supported =3D =
E1000_ETHTOOL_COPPER_INTERFACE_SUPPORTS;=0A=
    6e7c:	2404026f 	li	a0,623=0A=
            eth_cmd.advertising =3D =
E1000_ETHTOOL_COPPER_INTERFACE_ADVERTISE;=0A=
            eth_cmd.port =3D PORT_MII;=0A=
    6e80:	24020002 	li	v0,2=0A=
    6e84:	afa40018 	sw	a0,24(sp)=0A=
    6e88:	a3a2001f 	sb	v0,31(sp)=0A=
    6e8c:	afa40014 	sw	a0,20(sp)=0A=
            eth_cmd.phy_address =3D adapter->shared.phy_addr;=0A=
    6e90:	9243002f 	lbu	v1,47(s2)=0A=
    6e94:	a3a30020 	sb	v1,32(sp)=0A=
            eth_cmd.transceiver =3D=0A=
    6e98:	8e42000c 	lw	v0,12(s2)=0A=
    6e9c:	2c420003 	sltiu	v0,v0,3=0A=
                (adapter->shared.mac_type >=0A=
                 e1000_82543) ? XCVR_INTERNAL : XCVR_EXTERNAL;=0A=
        } else {=0A=
    6ea0:	08001bae 	j	6eb8 <e1000_ethtool_ioctl+0xe0>=0A=
    6ea4:	a3a20021 	sb	v0,33(sp)=0A=
            eth_cmd.supported =3D E1000_ETHTOOL_FIBER_INTERFACE_SUPPORTS;=0A=
            eth_cmd.advertising =3D =
E1000_ETHTOOL_FIBER_INTERFACE_ADVERTISE;=0A=
            eth_cmd.port =3D PORT_FIBRE;=0A=
    6ea8:	24020003 	li	v0,3=0A=
    6eac:	afa30018 	sw	v1,24(sp)=0A=
    6eb0:	a3a2001f 	sb	v0,31(sp)=0A=
    6eb4:	afa30014 	sw	v1,20(sp)=0A=
        }=0A=
=0A=
        if(adapter->link_active =3D=3D TRUE) {=0A=
    6eb8:	8e4300b0 	lw	v1,176(s2)=0A=
    6ebc:	24020001 	li	v0,1=0A=
    6ec0:	54620010 	bnel	v1,v0,6f04 <e1000_ethtool_ioctl+0x12c>=0A=
    6ec4:	a7a0001c 	sh	zero,28(sp)=0A=
            e1000_get_speed_and_duplex(&adapter->shared, =
&adapter->link_speed,=0A=
    6ec8:	265000b4 	addiu	s0,s2,180=0A=
    6ecc:	265100b6 	addiu	s1,s2,182=0A=
    6ed0:	3c020000 	lui	v0,0x0=0A=
    6ed4:	24420000 	addiu	v0,v0,0=0A=
    6ed8:	26440008 	addiu	a0,s2,8=0A=
    6edc:	02002821 	move	a1,s0=0A=
    6ee0:	0040f809 	jalr	v0=0A=
    6ee4:	02203021 	move	a2,s1=0A=
                                       &adapter->link_duplex);=0A=
            eth_cmd.speed =3D adapter->link_speed;=0A=
    6ee8:	96030000 	lhu	v1,0(s0)=0A=
    6eec:	a7a3001c 	sh	v1,28(sp)=0A=
            eth_cmd.duplex =3D=0A=
    6ef0:	96220000 	lhu	v0,0(s1)=0A=
    6ef4:	38420002 	xori	v0,v0,0x2=0A=
    6ef8:	2c420001 	sltiu	v0,v0,1=0A=
                (adapter->link_duplex =3D=3D=0A=
                 FULL_DUPLEX) ? DUPLEX_FULL : DUPLEX_HALF;=0A=
        } else {=0A=
    6efc:	08001bc2 	j	6f08 <e1000_ethtool_ioctl+0x130>=0A=
    6f00:	a3a2001e 	sb	v0,30(sp)=0A=
            eth_cmd.speed =3D 0;=0A=
            eth_cmd.duplex =3D 0;=0A=
    6f04:	a3a0001e 	sb	zero,30(sp)=0A=
        }=0A=
=0A=
        if(adapter->shared.autoneg)=0A=
    6f08:	92420078 	lbu	v0,120(s2)=0A=
    6f0c:	10400003 	beqz	v0,6f1c <e1000_ethtool_ioctl+0x144>=0A=
    6f10:	24020001 	li	v0,1=0A=
            eth_cmd.autoneg =3D AUTONEG_ENABLE;=0A=
    6f14:	08001bc8 	j	6f20 <e1000_ethtool_ioctl+0x148>=0A=
    6f18:	a3a20022 	sb	v0,34(sp)=0A=
        else=0A=
            eth_cmd.autoneg =3D AUTONEG_DISABLE;=0A=
    6f1c:	a3a00022 	sb	zero,34(sp)=0A=
=0A=
        if(copy_to_user(ifr->ifr_data, &eth_cmd, sizeof(eth_cmd)))=0A=
    6f20:	8e640010 	lw	a0,16(s3)=0A=
    6f24:	8f8303bc 	lw	v1,956(gp)=0A=
    6f28:	2482002c 	addiu	v0,a0,44=0A=
    6f2c:	00821025 	or	v0,a0,v0=0A=
    6f30:	00621824 	and	v1,v1,v0=0A=
    6f34:	0460011d 	bltz	v1,73ac <e1000_ethtool_ioctl+0x5d4>=0A=
    6f38:	2406002c 	li	a2,44=0A=
    6f3c:	02802821 	move	a1,s4=0A=
    6f40:	3c010000 	lui	at,0x0=0A=
    6f44:	24210000 	addiu	at,at,0=0A=
    6f48:	0020f809 	jalr	at=0A=
    6f4c:	00000000 	nop=0A=
            return -EFAULT;=0A=
    6f50:	08001ceb 	j	73ac <e1000_ethtool_ioctl+0x5d4>=0A=
    6f54:	00000000 	nop=0A=
=0A=
static inline int capable(int cap)=0A=
{=0A=
#if 1 /* ok now */=0A=
	if (cap_raised(current->cap_effective, cap))=0A=
    6f58:	8f8201d4 	lw	v0,468(gp)=0A=
    6f5c:	30421000 	andi	v0,v0,0x1000=0A=
    6f60:	10400005 	beqz	v0,6f78 <e1000_ethtool_ioctl+0x1a0>=0A=
    6f64:	24030001 	li	v1,1=0A=
#else=0A=
	if (cap_is_fs_cap(cap) ? current->fsuid =3D=3D 0 : current->euid =3D=3D =
0)=0A=
#endif=0A=
	{=0A=
		current->flags |=3D PF_SUPERPRIV;=0A=
    6f68:	8f820004 	lw	v0,4(gp)=0A=
    6f6c:	34420100 	ori	v0,v0,0x100=0A=
		return 1;=0A=
    6f70:	08001bdf 	j	6f7c <e1000_ethtool_ioctl+0x1a4>=0A=
    6f74:	af820004 	sw	v0,4(gp)=0A=
	}=0A=
	return 0;=0A=
    6f78:	00001821 	move	v1,zero=0A=
=0A=
        break;=0A=
=0A=
        /* set information */=0A=
    case ETHTOOL_SSET:=0A=
        /* need proper permission to do set */=0A=
        if(!capable(CAP_NET_ADMIN))=0A=
    6f7c:	10600112 	beqz	v1,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    6f80:	2402ffff 	li	v0,-1=0A=
            return -EPERM;=0A=
=0A=
        /* Cannot Force speed/duplex and at the same time autoneg.=0A=
         * Autoneg will override forcing. =0A=
         * For example to force speed/duplex pass in =0A=
         *  'speed 100 duplex half autoneg off'=0A=
         * pass in 'autoneg on' to start autoneg.=0A=
         */=0A=
        printk("e1000: Requested link to be forced to %d Speed, %s =
Duplex "=0A=
    6f84:	93a2001e 	lbu	v0,30(sp)=0A=
    6f88:	3c060000 	lui	a2,0x0=0A=
    6f8c:	24c60284 	addiu	a2,a2,644=0A=
    6f90:	14400003 	bnez	v0,6fa0 <e1000_ethtool_ioctl+0x1c8>=0A=
    6f94:	97a5001c 	lhu	a1,28(sp)=0A=
    6f98:	3c060000 	lui	a2,0x0=0A=
    6f9c:	24c6028c 	addiu	a2,a2,652=0A=
    6fa0:	93a20022 	lbu	v0,34(sp)=0A=
    6fa4:	3c070000 	lui	a3,0x0=0A=
    6fa8:	24e70e30 	addiu	a3,a3,3632=0A=
    6fac:	14400003 	bnez	v0,6fbc <e1000_ethtool_ioctl+0x1e4>=0A=
    6fb0:	00000000 	nop=0A=
    6fb4:	3c070000 	lui	a3,0x0=0A=
    6fb8:	24e70e44 	addiu	a3,a3,3652=0A=
    6fbc:	3c040000 	lui	a0,0x0=0A=
    6fc0:	24840df0 	addiu	a0,a0,3568=0A=
    6fc4:	3c100000 	lui	s0,0x0=0A=
    6fc8:	26100000 	addiu	s0,s0,0=0A=
    6fcc:	0200f809 	jalr	s0=0A=
    6fd0:	00000000 	nop=0A=
               "%s\n", eth_cmd.speed, (eth_cmd.duplex ? "Full" : "Half"),=0A=
               (eth_cmd.autoneg ? "and Autonegotiate" : "."));=0A=
=0A=
        if(eth_cmd.autoneg && eth_cmd.speed)=0A=
    6fd4:	93a30022 	lbu	v1,34(sp)=0A=
    6fd8:	10600016 	beqz	v1,7034 <e1000_ethtool_ioctl+0x25c>=0A=
    6fdc:	97a2001c 	lhu	v0,28(sp)=0A=
    6fe0:	10400006 	beqz	v0,6ffc <e1000_ethtool_ioctl+0x224>=0A=
    6fe4:	00000000 	nop=0A=
            printk("e1000: Autoneg request will over-ride speed =
forcing\n");=0A=
    6fe8:	3c040000 	lui	a0,0x0=0A=
    6fec:	24840e48 	addiu	a0,a0,3656=0A=
    6ff0:	0200f809 	jalr	s0=0A=
    6ff4:	00000000 	nop=0A=
    6ff8:	93a30022 	lbu	v1,34(sp)=0A=
=0A=
        /* if not in autoneg mode and have been asked to enable autoneg =
*/=0A=
        if(eth_cmd.autoneg) {=0A=
    6ffc:	1060000d 	beqz	v1,7034 <e1000_ethtool_ioctl+0x25c>=0A=
    7000:	97a2001c 	lhu	v0,28(sp)=0A=
            if(adapter->shared.autoneg &&=0A=
    7004:	92420078 	lbu	v0,120(s2)=0A=
    7008:	10400004 	beqz	v0,701c <e1000_ethtool_ioctl+0x244>=0A=
    700c:	2403002f 	li	v1,47=0A=
    7010:	96440048 	lhu	a0,72(s2)=0A=
    7014:	108300ec 	beq	a0,v1,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    7018:	00001021 	move	v0,zero=0A=
               adapter->shared.autoneg_advertised =3D=3D =
AUTONEG_ADV_DEFAULT)=0A=
                /* If already in Autoneg */=0A=
                return 0;=0A=
            else {=0A=
                adapter->shared.autoneg =3D 1;=0A=
    701c:	24030001 	li	v1,1=0A=
                adapter->shared.autoneg_advertised =3D =
AUTONEG_ADV_DEFAULT;=0A=
    7020:	2402002f 	li	v0,47=0A=
    7024:	a6420048 	sh	v0,72(s2)=0A=
    7028:	a2430078 	sb	v1,120(s2)=0A=
                re_initiate =3D TRUE;=0A=
            }=0A=
        }=0A=
    702c:	08001c6c 	j	71b0 <e1000_ethtool_ioctl+0x3d8>=0A=
    7030:	24110001 	li	s1,1=0A=
        /* Force link to whatever speed and duplex */=0A=
        /* Also turning off Autoneg in case of non-gig speeds */=0A=
        else if(eth_cmd.speed) {=0A=
    7034:	1040005e 	beqz	v0,71b0 <e1000_ethtool_ioctl+0x3d8>=0A=
    7038:	00402021 	move	a0,v0=0A=
            /* Check for invalid request */=0A=
            if(((eth_cmd.speed !=3D SPEED_10) && (eth_cmd.speed !=3D =
SPEED_100) &&=0A=
    703c:	3883000a 	xori	v1,a0,0xa=0A=
    7040:	38820064 	xori	v0,a0,0x64=0A=
    7044:	0003182b 	sltu	v1,zero,v1=0A=
    7048:	0002102b 	sltu	v0,zero,v0=0A=
    704c:	00621824 	and	v1,v1,v0=0A=
    7050:	10600003 	beqz	v1,7060 <e1000_ethtool_ioctl+0x288>=0A=
    7054:	240203e8 	li	v0,1000=0A=
    7058:	148200db 	bne	a0,v0,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    705c:	2402ffea 	li	v0,-22=0A=
    7060:	93a2001e 	lbu	v0,30(sp)=0A=
    7064:	2c420002 	sltiu	v0,v0,2=0A=
    7068:	104000d7 	beqz	v0,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    706c:	2402ffea 	li	v0,-22=0A=
    7070:	8e430010 	lw	v1,16(s2)=0A=
    7074:	24020001 	li	v0,1=0A=
    7078:	10620063 	beq	v1,v0,7208 <e1000_ethtool_ioctl+0x430>=0A=
    707c:	265000b4 	addiu	s0,s2,180=0A=
                (eth_cmd.speed !=3D SPEED_1000)) ||=0A=
               ((eth_cmd.duplex !=3D DUPLEX_HALF) &&=0A=
                (eth_cmd.duplex !=3D DUPLEX_FULL)) ||=0A=
               (adapter->shared.media_type =3D=3D =
e1000_media_type_fiber))=0A=
                return -EINVAL;=0A=
=0A=
            e1000_get_speed_and_duplex(&adapter->shared, =
&adapter->link_speed,=0A=
    7080:	265100b6 	addiu	s1,s2,182=0A=
    7084:	26440008 	addiu	a0,s2,8=0A=
    7088:	02002821 	move	a1,s0=0A=
    708c:	3c020000 	lui	v0,0x0=0A=
    7090:	24420000 	addiu	v0,v0,0=0A=
    7094:	0040f809 	jalr	v0=0A=
    7098:	02203021 	move	a2,s1=0A=
                                       &adapter->link_duplex);=0A=
            /* If we are already forced to requested speed and duplex=0A=
             * Donot do anything, just return=0A=
             */=0A=
            if(!adapter->shared.autoneg &&=0A=
    709c:	92430078 	lbu	v1,120(s2)=0A=
    70a0:	5460000b 	bnezl	v1,70d0 <e1000_ethtool_ioctl+0x2f8>=0A=
    70a4:	a2400078 	sb	zero,120(s2)=0A=
    70a8:	96030000 	lhu	v1,0(s0)=0A=
    70ac:	97a2001c 	lhu	v0,28(sp)=0A=
    70b0:	54620007 	bnel	v1,v0,70d0 <e1000_ethtool_ioctl+0x2f8>=0A=
    70b4:	a2400078 	sb	zero,120(s2)=0A=
    70b8:	93a3001e 	lbu	v1,30(sp)=0A=
    70bc:	96240000 	lhu	a0,0(s1)=0A=
    70c0:	24630001 	addiu	v1,v1,1=0A=
    70c4:	108300c0 	beq	a0,v1,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    70c8:	00001021 	move	v0,zero=0A=
               (adapter->link_speed =3D=3D eth_cmd.speed) &&=0A=
               (adapter->link_duplex =3D=3D (eth_cmd.duplex + 1)))=0A=
=0A=
                return 0;=0A=
=0A=
            adapter->shared.autoneg =3D 0;=0A=
    70cc:	a2400078 	sb	zero,120(s2)=0A=
            adapter->shared.autoneg_advertised =3D 0;=0A=
    70d0:	a6400048 	sh	zero,72(s2)=0A=
            re_initiate =3D TRUE;=0A=
            switch (eth_cmd.speed + eth_cmd.duplex) {=0A=
    70d4:	97a2001c 	lhu	v0,28(sp)=0A=
    70d8:	93a3001e 	lbu	v1,30(sp)=0A=
    70dc:	24040064 	li	a0,100=0A=
    70e0:	00431821 	addu	v1,v0,v1=0A=
    70e4:	1064001a 	beq	v1,a0,7150 <e1000_ethtool_ioctl+0x378>=0A=
    70e8:	24110001 	li	s1,1=0A=
    70ec:	28620065 	slti	v0,v1,101=0A=
    70f0:	10400008 	beqz	v0,7114 <e1000_ethtool_ioctl+0x33c>=0A=
    70f4:	240203e8 	li	v0,1000=0A=
    70f8:	2402000a 	li	v0,10=0A=
    70fc:	10620012 	beq	v1,v0,7148 <e1000_ethtool_ioctl+0x370>=0A=
    7100:	2402000b 	li	v0,11=0A=
    7104:	10620015 	beq	v1,v0,715c <e1000_ethtool_ioctl+0x384>=0A=
    7108:	24030001 	li	v1,1=0A=
    710c:	08001c6a 	j	71a8 <e1000_ethtool_ioctl+0x3d0>=0A=
    7110:	24020020 	li	v0,32=0A=
    7114:	10620016 	beq	v1,v0,7170 <e1000_ethtool_ioctl+0x398>=0A=
    7118:	286203e9 	slti	v0,v1,1001=0A=
    711c:	10400006 	beqz	v0,7138 <e1000_ethtool_ioctl+0x360>=0A=
    7120:	240203e9 	li	v0,1001=0A=
    7124:	24020065 	li	v0,101=0A=
    7128:	1062000e 	beq	v1,v0,7164 <e1000_ethtool_ioctl+0x38c>=0A=
    712c:	24030001 	li	v1,1=0A=
    7130:	08001c6a 	j	71a8 <e1000_ethtool_ioctl+0x3d0>=0A=
    7134:	24020020 	li	v0,32=0A=
    7138:	10620013 	beq	v1,v0,7188 <e1000_ethtool_ioctl+0x3b0>=0A=
    713c:	24030001 	li	v1,1=0A=
    7140:	08001c6a 	j	71a8 <e1000_ethtool_ioctl+0x3d0>=0A=
    7144:	24020020 	li	v0,32=0A=
            case (SPEED_10 + DUPLEX_HALF):=0A=
                adapter->shared.forced_speed_duplex =3D e1000_10_half;=0A=
                break;=0A=
    7148:	08001c6c 	j	71b0 <e1000_ethtool_ioctl+0x3d8>=0A=
    714c:	a240007a 	sb	zero,122(s2)=0A=
            case (SPEED_100 + DUPLEX_HALF):=0A=
                adapter->shared.forced_speed_duplex =3D e1000_100_half;=0A=
    7150:	24020002 	li	v0,2=0A=
                break;=0A=
    7154:	08001c6c 	j	71b0 <e1000_ethtool_ioctl+0x3d8>=0A=
    7158:	a242007a 	sb	v0,122(s2)=0A=
            case (SPEED_10 + DUPLEX_FULL):=0A=
                adapter->shared.forced_speed_duplex =3D e1000_10_full;=0A=
                break;=0A=
    715c:	08001c6c 	j	71b0 <e1000_ethtool_ioctl+0x3d8>=0A=
    7160:	a251007a 	sb	s1,122(s2)=0A=
            case (SPEED_100 + DUPLEX_FULL):=0A=
                adapter->shared.forced_speed_duplex =3D e1000_100_full;=0A=
    7164:	24020003 	li	v0,3=0A=
                break;=0A=
    7168:	08001c6c 	j	71b0 <e1000_ethtool_ioctl+0x3d8>=0A=
    716c:	a242007a 	sb	v0,122(s2)=0A=
            case (SPEED_1000 + DUPLEX_HALF):=0A=
                printk("Half Duplex is not supported at 1000 Mbps\n");=0A=
    7170:	3c040000 	lui	a0,0x0=0A=
    7174:	24840e80 	addiu	a0,a0,3712=0A=
    7178:	3c020000 	lui	v0,0x0=0A=
    717c:	24420000 	addiu	v0,v0,0=0A=
    7180:	0040f809 	jalr	v0=0A=
    7184:	00000000 	nop=0A=
            case (SPEED_1000 + DUPLEX_FULL):=0A=
                printk("Using Auto-neg at 1000 Mbps Full Duplex\n");=0A=
    7188:	3c040000 	lui	a0,0x0=0A=
    718c:	24840eac 	addiu	a0,a0,3756=0A=
    7190:	3c020000 	lui	v0,0x0=0A=
    7194:	24420000 	addiu	v0,v0,0=0A=
    7198:	0040f809 	jalr	v0=0A=
    719c:	00000000 	nop=0A=
            default:=0A=
                adapter->shared.autoneg =3D 1;=0A=
    71a0:	24030001 	li	v1,1=0A=
                adapter->shared.autoneg_advertised =3D =
ADVERTISE_1000_FULL;=0A=
    71a4:	24020020 	li	v0,32=0A=
    71a8:	a6420048 	sh	v0,72(s2)=0A=
    71ac:	a2430078 	sb	v1,120(s2)=0A=
                break;=0A=
            }=0A=
        }=0A=
=0A=
        /* End of force */=0A=
        /* Put the adapter to new settings */=0A=
        if(re_initiate =3D=3D TRUE) {=0A=
    71b0:	24020001 	li	v0,1=0A=
    71b4:	56220005 	bnel	s1,v0,71cc <e1000_ethtool_ioctl+0x3f4>=0A=
    71b8:	93a20022 	lbu	v0,34(sp)=0A=
            e1000_hibernate_adapter(netdev);=0A=
    71bc:	3c020000 	lui	v0,0x0=0A=
    71c0:	24420000 	addiu	v0,v0,0=0A=
            e1000_wakeup_adapter(netdev);=0A=
        } else if(!eth_cmd.autoneg && !eth_cmd.speed) {=0A=
    71c4:	08001c96 	j	7258 <e1000_ethtool_ioctl+0x480>=0A=
    71c8:	02a02021 	move	a0,s5=0A=
    71cc:	1440007e 	bnez	v0,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    71d0:	2402ff86 	li	v0,-122=0A=
    71d4:	97a2001c 	lhu	v0,28(sp)=0A=
    71d8:	5440007b 	bnezl	v0,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    71dc:	2402ff86 	li	v0,-122=0A=
            printk("Cannot turn off autoneg without "=0A=
    71e0:	3c040000 	lui	a0,0x0=0A=
    71e4:	24840ed8 	addiu	a0,a0,3800=0A=
    71e8:	3c100000 	lui	s0,0x0=0A=
    71ec:	26100000 	addiu	s0,s0,0=0A=
    71f0:	0200f809 	jalr	s0=0A=
    71f4:	00000000 	nop=0A=
                   "knowing what speed to force the link\n");=0A=
            printk("Speed specified was %dMbps\n", eth_cmd.speed);=0A=
    71f8:	3c040000 	lui	a0,0x0=0A=
    71fc:	24840f20 	addiu	a0,a0,3872=0A=
    7200:	0200f809 	jalr	s0=0A=
    7204:	97a5001c 	lhu	a1,28(sp)=0A=
            return -EINVAL;=0A=
    7208:	08001cf2 	j	73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    720c:	2402ffea 	li	v0,-22=0A=
=0A=
static inline int capable(int cap)=0A=
{=0A=
#if 1 /* ok now */=0A=
	if (cap_raised(current->cap_effective, cap))=0A=
    7210:	8f8201d4 	lw	v0,468(gp)=0A=
    7214:	30421000 	andi	v0,v0,0x1000=0A=
    7218:	10400005 	beqz	v0,7230 <e1000_ethtool_ioctl+0x458>=0A=
    721c:	24030001 	li	v1,1=0A=
#else=0A=
	if (cap_is_fs_cap(cap) ? current->fsuid =3D=3D 0 : current->euid =3D=3D =
0)=0A=
#endif=0A=
	{=0A=
		current->flags |=3D PF_SUPERPRIV;=0A=
    7220:	8f820004 	lw	v0,4(gp)=0A=
    7224:	34420100 	ori	v0,v0,0x100=0A=
		return 1;=0A=
    7228:	08001c8d 	j	7234 <e1000_ethtool_ioctl+0x45c>=0A=
    722c:	af820004 	sw	v0,4(gp)=0A=
	}=0A=
	return 0;=0A=
    7230:	00001821 	move	v1,zero=0A=
        }=0A=
        /* We donot support setting of =0A=
         * whatever else that was requested */=0A=
        else=0A=
            return -EOPNOTSUPP;=0A=
=0A=
        break;=0A=
=0A=
#ifdef ETHTOOL_NWAY_RST=0A=
    case ETHTOOL_NWAY_RST:=0A=
        /* need proper permission to restart auto-negotiation */=0A=
        if(!capable(CAP_NET_ADMIN))=0A=
    7234:	10600064 	beqz	v1,73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    7238:	2402ffff 	li	v0,-1=0A=
            return -EPERM;=0A=
=0A=
        adapter->shared.autoneg =3D 1;=0A=
    723c:	24030001 	li	v1,1=0A=
        adapter->shared.autoneg_advertised =3D AUTONEG_ADV_DEFAULT;=0A=
    7240:	2402002f 	li	v0,47=0A=
    7244:	a6420048 	sh	v0,72(s2)=0A=
        e1000_hibernate_adapter(netdev);=0A=
    7248:	02a02021 	move	a0,s5=0A=
    724c:	3c020000 	lui	v0,0x0=0A=
    7250:	24420000 	addiu	v0,v0,0=0A=
    7254:	a2430078 	sb	v1,120(s2)=0A=
    7258:	0040f809 	jalr	v0=0A=
    725c:	00000000 	nop=0A=
        e1000_wakeup_adapter(netdev);=0A=
    7260:	3c020000 	lui	v0,0x0=0A=
    7264:	24420000 	addiu	v0,v0,0=0A=
    7268:	0040f809 	jalr	v0=0A=
    726c:	02a02021 	move	a0,s5=0A=
=0A=
        break;=0A=
    7270:	08001cf2 	j	73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    7274:	00001021 	move	v0,zero=0A=
#endif=0A=
=0A=
#ifdef ETHTOOL_GLINK=0A=
    case ETHTOOL_GLINK:=0A=
        eth_e1000_linkinfo.data =3D adapter->link_active;=0A=
    7278:	8e4200b0 	lw	v0,176(s2)=0A=
        if(copy_to_user(ifr->ifr_data, &eth_e1000_linkinfo, =
sizeof(eth_e1000_linkinfo)))=0A=
    727c:	8e640010 	lw	a0,16(s3)=0A=
    7280:	27a50040 	addiu	a1,sp,64=0A=
    7284:	afa20044 	sw	v0,68(sp)=0A=
    7288:	8f8303bc 	lw	v1,956(gp)=0A=
    728c:	24820008 	addiu	v0,a0,8=0A=
    7290:	00821025 	or	v0,a0,v0=0A=
    7294:	00621824 	and	v1,v1,v0=0A=
    7298:	04600044 	bltz	v1,73ac <e1000_ethtool_ioctl+0x5d4>=0A=
    729c:	24060008 	li	a2,8=0A=
    72a0:	3c010000 	lui	at,0x0=0A=
    72a4:	24210000 	addiu	at,at,0=0A=
    72a8:	0020f809 	jalr	at=0A=
    72ac:	00000000 	nop=0A=
            return -EFAULT;=0A=
    72b0:	08001ceb 	j	73ac <e1000_ethtool_ioctl+0x5d4>=0A=
    72b4:	00000000 	nop=0A=
        break;=0A=
#endif=0A=
=0A=
#ifdef ETHTOOL_GDRVINFO=0A=
    case ETHTOOL_GDRVINFO:=0A=
        strcpy(eth_e1000_info.driver, e1000_driver_name);=0A=
    72b8:	27a3004c 	addiu	v1,sp,76=0A=
    72bc:	3c020000 	lui	v0,0x0=0A=
    72c0:	24420000 	addiu	v0,v0,0=0A=
extern __inline__ char *strcpy(char *__dest, __const__ char *__src)=0A=
{=0A=
  char *__xdest =3D __dest;=0A=
=0A=
  __asm__ __volatile__(=0A=
    72c4:	90410000 	lbu	at,0(v0)=0A=
    72c8:	24420001 	addiu	v0,v0,1=0A=
    72cc:	a0610000 	sb	at,0(v1)=0A=
    72d0:	1420fffc 	bnez	at,72c4 <e1000_ethtool_ioctl+0x4ec>=0A=
    72d4:	24630001 	addiu	v1,v1,1=0A=
        strcpy(eth_e1000_info.version, e1000_driver_version);=0A=
    72d8:	27a4006c 	addiu	a0,sp,108=0A=
    72dc:	3c020000 	lui	v0,0x0=0A=
    72e0:	24420000 	addiu	v0,v0,0=0A=
extern __inline__ char *strcpy(char *__dest, __const__ char *__src)=0A=
{=0A=
  char *__xdest =3D __dest;=0A=
=0A=
  __asm__ __volatile__(=0A=
    72e4:	90410000 	lbu	at,0(v0)=0A=
    72e8:	24420001 	addiu	v0,v0,1=0A=
    72ec:	a0810000 	sb	at,0(a0)=0A=
    72f0:	1420fffc 	bnez	at,72e4 <e1000_ethtool_ioctl+0x50c>=0A=
    72f4:	24840001 	addiu	a0,a0,1=0A=
        strcpy(eth_e1000_info.fw_version, "None");=0A=
    72f8:	27a3008c 	addiu	v1,sp,140=0A=
    72fc:	3c020000 	lui	v0,0x0=0A=
    7300:	24420f3c 	addiu	v0,v0,3900=0A=
extern __inline__ char *strcpy(char *__dest, __const__ char *__src)=0A=
{=0A=
  char *__xdest =3D __dest;=0A=
=0A=
  __asm__ __volatile__(=0A=
    7304:	90410000 	lbu	at,0(v0)=0A=
    7308:	24420001 	addiu	v0,v0,1=0A=
    730c:	a0610000 	sb	at,0(v1)=0A=
    7310:	1420fffc 	bnez	at,7304 <e1000_ethtool_ioctl+0x52c>=0A=
    7314:	24630001 	addiu	v1,v1,1=0A=
        strcpy(eth_e1000_info.bus_info, adapter->pdev->slot_name);=0A=
    7318:	8e44014c 	lw	a0,332(s2)=0A=
    731c:	27a200ac 	addiu	v0,sp,172=0A=
    7320:	24840270 	addiu	a0,a0,624=0A=
extern __inline__ char *strcpy(char *__dest, __const__ char *__src)=0A=
{=0A=
  char *__xdest =3D __dest;=0A=
=0A=
  __asm__ __volatile__(=0A=
    7324:	90810000 	lbu	at,0(a0)=0A=
    7328:	24840001 	addiu	a0,a0,1=0A=
    732c:	a0410000 	sb	at,0(v0)=0A=
    7330:	1420fffc 	bnez	at,7324 <e1000_ethtool_ioctl+0x54c>=0A=
    7334:	24420001 	addiu	v0,v0,1=0A=
        if(copy_to_user(ifr->ifr_data, &eth_e1000_info, =
sizeof(eth_e1000_info)))=0A=
    7338:	8e640010 	lw	a0,16(s3)=0A=
    733c:	8f8303bc 	lw	v1,956(gp)=0A=
    7340:	27a50048 	addiu	a1,sp,72=0A=
    7344:	248200c4 	addiu	v0,a0,196=0A=
    7348:	00821025 	or	v0,a0,v0=0A=
    734c:	00621824 	and	v1,v1,v0=0A=
    7350:	04600016 	bltz	v1,73ac <e1000_ethtool_ioctl+0x5d4>=0A=
    7354:	240600c4 	li	a2,196=0A=
    7358:	3c010000 	lui	at,0x0=0A=
    735c:	24210000 	addiu	at,at,0=0A=
    7360:	0020f809 	jalr	at=0A=
    7364:	00000000 	nop=0A=
            return -EFAULT;=0A=
    7368:	08001ceb 	j	73ac <e1000_ethtool_ioctl+0x5d4>=0A=
    736c:	00000000 	nop=0A=
        break;=0A=
#endif=0A=
=0A=
#ifdef ETHTOOL_GWOL=0A=
    case ETHTOOL_GWOL:=0A=
        eth_e1000_wolinfo.supported =3D eth_e1000_wolinfo.wolopts =3D =
WAKE_MAGIC;=0A=
        if(copy_to_user=0A=
    7370:	8e640010 	lw	a0,16(s3)=0A=
    7374:	24020020 	li	v0,32=0A=
    7378:	afa20114 	sw	v0,276(sp)=0A=
    737c:	afa20118 	sw	v0,280(sp)=0A=
    7380:	8f8303bc 	lw	v1,956(gp)=0A=
    7384:	24820014 	addiu	v0,a0,20=0A=
    7388:	00821025 	or	v0,a0,v0=0A=
    738c:	00621824 	and	v1,v1,v0=0A=
    7390:	27a50110 	addiu	a1,sp,272=0A=
    7394:	04600005 	bltz	v1,73ac <e1000_ethtool_ioctl+0x5d4>=0A=
    7398:	24060014 	li	a2,20=0A=
    739c:	3c010000 	lui	at,0x0=0A=
    73a0:	24210000 	addiu	at,at,0=0A=
    73a4:	0020f809 	jalr	at=0A=
    73a8:	00000000 	nop=0A=
    73ac:	10c00005 	beqz	a2,73c4 <e1000_ethtool_ioctl+0x5ec>=0A=
    73b0:	2402fff2 	li	v0,-14=0A=
           (ifr->ifr_data, &eth_e1000_wolinfo, =
sizeof(eth_e1000_wolinfo)))=0A=
            return -EFAULT;=0A=
    73b4:	08001cf3 	j	73cc <e1000_ethtool_ioctl+0x5f4>=0A=
    73b8:	8fbf0140 	lw	ra,320(sp)=0A=
        break;=0A=
#endif=0A=
=0A=
    default:=0A=
        return -EOPNOTSUPP;=0A=
    73bc:	08001cf2 	j	73c8 <e1000_ethtool_ioctl+0x5f0>=0A=
    73c0:	2402ff86 	li	v0,-122=0A=
    }=0A=
=0A=
    return 0;=0A=
    73c4:	00001021 	move	v0,zero=0A=
=0A=
}=0A=
    73c8:	8fbf0140 	lw	ra,320(sp)=0A=
    73cc:	8fb5013c 	lw	s5,316(sp)=0A=
    73d0:	8fb40138 	lw	s4,312(sp)=0A=
    73d4:	8fb30134 	lw	s3,308(sp)=0A=
    73d8:	8fb20130 	lw	s2,304(sp)=0A=
    73dc:	8fb1012c 	lw	s1,300(sp)=0A=
    73e0:	8fb00128 	lw	s0,296(sp)=0A=
    73e4:	03e00008 	jr	ra=0A=
    73e8:	27bd0148 	addiu	sp,sp,328=0A=
=0A=
000073ec <e1000_enable_WOL>:=0A=
    73ec:	00804021 	move	t0,a0=0A=
#endif /* SIOCETHTOOL */=0A=
=0A=
/**=0A=
 * e1000_enable_WOL - Wake On Lan Support (Magic Pkt)=0A=
 * @adapter: Adapter structure =0A=
 **/=0A=
=0A=
static void=0A=
e1000_enable_WOL(struct e1000_adapter *adapter)=0A=
{=0A=
    uint32_t wuc_val;=0A=
=0A=
    if(adapter->shared.mac_type <=3D e1000_82543)=0A=
    73f0:	8d06000c 	lw	a2,12(t0)=0A=
    73f4:	2cc20003 	sltiu	v0,a2,3=0A=
    73f8:	1440001f 	bnez	v0,7478 <e1000_enable_WOL+0x8c>=0A=
    73fc:	2cc20002 	sltiu	v0,a2,2=0A=
        return;=0A=
=0A=
    /* Set up Wake-Up Ctrl reg */=0A=
    wuc_val =3D E1000_READ_REG(&adapter->shared, WUC);=0A=
    7400:	8d070008 	lw	a3,8(t0)=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    7404:	8ce55800 	lw	a1,22528(a3)=0A=
	return __arch__swab32(x);=0A=
    7408:	30a3ff00 	andi	v1,a1,0xff00=0A=
    740c:	00052600 	sll	a0,a1,0x18=0A=
    7410:	00051202 	srl	v0,a1,0x8=0A=
    7414:	00031a00 	sll	v1,v1,0x8=0A=
    7418:	00832025 	or	a0,a0,v1=0A=
    741c:	3042ff00 	andi	v0,v0,0xff00=0A=
    7420:	00822025 	or	a0,a0,v0=0A=
    7424:	00052e02 	srl	a1,a1,0x18=0A=
    7428:	00852825 	or	a1,a0,a1=0A=
    wuc_val &=3D ~(E1000_WUC_APME | E1000_WUC_APMPME);=0A=
    742c:	2402fff6 	li	v0,-10=0A=
    7430:	00a22824 	and	a1,a1,v0=0A=
    wuc_val |=3D (E1000_WUC_PME_STATUS | E1000_WUC_PME_EN);=0A=
    7434:	2cc30002 	sltiu	v1,a2,2=0A=
    7438:	34a50006 	ori	a1,a1,0x6=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    743c:	30a4ff00 	andi	a0,a1,0xff00=0A=
    7440:	00042200 	sll	a0,a0,0x8=0A=
    7444:	00051600 	sll	v0,a1,0x18=0A=
    7448:	00051a02 	srl	v1,a1,0x8=0A=
    744c:	00441025 	or	v0,v0,a0=0A=
    7450:	3063ff00 	andi	v1,v1,0xff00=0A=
    7454:	00431025 	or	v0,v0,v1=0A=
    7458:	00052602 	srl	a0,a1,0x18=0A=
    745c:	00441025 	or	v0,v0,a0=0A=
=0A=
    E1000_WRITE_REG(&adapter->shared, WUC, wuc_val);=0A=
    7460:	ace25800 	sw	v0,22528(a3)=0A=
    7464:	8d02000c 	lw	v0,12(t0)=0A=
    7468:	2c420002 	sltiu	v0,v0,2=0A=
=0A=
    /* Set up Wake-up Filter */=0A=
    E1000_WRITE_REG(&adapter->shared, WUFC, E1000_WUFC_MAG);=0A=
=0A=
    return;=0A=
}=0A=
    746c:	8d030008 	lw	v1,8(t0)=0A=
    7470:	3c020200 	lui	v0,0x200=0A=
    7474:	ac625808 	sw	v0,22536(v1)=0A=
    7478:	03e00008 	jr	ra=0A=
    747c:	00000000 	nop=0A=
=0A=
00007480 <e1000_write_pci_cfg>:=0A=
    7480:	27bdffe8 	addiu	sp,sp,-24=0A=
    7484:	afbf0010 	sw	ra,16(sp)=0A=
=0A=
/**=0A=
 * e1000_write_pci_cg -=0A=
 * @shared:=0A=
 * @reg:=0A=
 * @value:=0A=
 **/=0A=
=0A=
void=0A=
e1000_write_pci_cfg(struct e1000_shared_adapter *shared,=0A=
                    uint32_t reg,=0A=
                    uint16_t *value)=0A=
{=0A=
    struct e1000_adapter *adapter =3D (struct e1000_adapter *) =
shared->back;=0A=
    7488:	8c82000c 	lw	v0,12(a0)=0A=
=0A=
    pci_write_config_word(adapter->pdev, reg, *value);=0A=
    748c:	8c44014c 	lw	a0,332(v0)=0A=
    7490:	3c020000 	lui	v0,0x0=0A=
    7494:	24420000 	addiu	v0,v0,0=0A=
    7498:	0040f809 	jalr	v0=0A=
    749c:	94c60000 	lhu	a2,0(a2)=0A=
    return;=0A=
}=0A=
    74a0:	8fbf0010 	lw	ra,16(sp)=0A=
    74a4:	03e00008 	jr	ra=0A=
    74a8:	27bd0018 	addiu	sp,sp,24=0A=
=0A=
000074ac <e1000_irq_enable>:=0A=
    74ac:	8c82000c 	lw	v0,12(a0)=0A=
    74b0:	2c420002 	sltiu	v0,v0,2=0A=
	__arch__swab16s(addr);=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
    74b4:	8c8500cc 	lw	a1,204(a0)=0A=
    74b8:	8c860008 	lw	a2,8(a0)=0A=
}=0A=
=0A=
static __inline__ __const__ __u32 __fswab32(__u32 x)=0A=
{=0A=
	return __arch__swab32(x);=0A=
    74bc:	30a4ff00 	andi	a0,a1,0xff00=0A=
    74c0:	00051600 	sll	v0,a1,0x18=0A=
    74c4:	00051a02 	srl	v1,a1,0x8=0A=
    74c8:	00042200 	sll	a0,a0,0x8=0A=
    74cc:	00441025 	or	v0,v0,a0=0A=
    74d0:	3063ff00 	andi	v1,v1,0xff00=0A=
    74d4:	00431025 	or	v0,v0,v1=0A=
    74d8:	00052e02 	srl	a1,a1,0x18=0A=
    74dc:	00451025 	or	v0,v0,a1=0A=
    74e0:	acc200d0 	sw	v0,208(a2)=0A=
    74e4:	03e00008 	jr	ra=0A=
    74e8:	00000000 	nop=0A=
=0A=
000074ec <e1000_rx_checksum>:=0A=
    74ec:	00803821 	move	a3,a0=0A=
    74f0:	8ce2000c 	lw	v0,12(a3)=0A=
    74f4:	2c420002 	sltiu	v0,v0,2=0A=
    74f8:	14400006 	bnez	v0,7514 <e1000_rx_checksum+0x28>=0A=
    74fc:	3c042000 	lui	a0,0x2000=0A=
    7500:	8ca2000c 	lw	v0,12(a1)=0A=
    7504:	3c032400 	lui	v1,0x2400=0A=
    7508:	00431024 	and	v0,v0,v1=0A=
    750c:	50440003 	beql	v0,a0,751c <e1000_rx_checksum+0x30>=0A=
    7510:	90a2000d 	lbu	v0,13(a1)=0A=
    7514:	03e00008 	jr	ra=0A=
    7518:	a0c0006b 	sb	zero,107(a2)=0A=
    751c:	30420020 	andi	v0,v0,0x20=0A=
    7520:	1040000b 	beqz	v0,7550 <e1000_rx_checksum+0x64>=0A=
    7524:	24020002 	li	v0,2=0A=
    7528:	a0c0006b 	sb	zero,107(a2)=0A=
    752c:	8ce20140 	lw	v0,320(a3)=0A=
    7530:	8ce30144 	lw	v1,324(a3)=0A=
    7534:	24630001 	addiu	v1,v1,1=0A=
    7538:	2c640001 	sltiu	a0,v1,1=0A=
    753c:	00441021 	addu	v0,v0,a0=0A=
    7540:	ace20140 	sw	v0,320(a3)=0A=
    7544:	ace30144 	sw	v1,324(a3)=0A=
    7548:	03e00008 	jr	ra=0A=
    754c:	00000000 	nop=0A=
    7550:	a0c2006b 	sb	v0,107(a2)=0A=
    7554:	8ce40138 	lw	a0,312(a3)=0A=
    7558:	8ce5013c 	lw	a1,316(a3)=0A=
    755c:	24a50001 	addiu	a1,a1,1=0A=
    7560:	2ca20001 	sltiu	v0,a1,1=0A=
    7564:	00822021 	addu	a0,a0,v0=0A=
    7568:	ace40138 	sw	a0,312(a3)=0A=
    756c:	ace5013c 	sw	a1,316(a3)=0A=
    7570:	03e00008 	jr	ra=0A=
	...=0A=

------=_NextPart_000_002F_01C1BBCA.589767F0--
