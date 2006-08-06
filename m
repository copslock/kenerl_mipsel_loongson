Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Aug 2006 05:03:44 +0100 (BST)
Received: from web27003.mail.ukl.yahoo.com ([217.146.177.3]:13965 "HELO
	web27003.mail.ukl.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037515AbWHFEDn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 6 Aug 2006 05:03:43 +0100
Received: (qmail 51418 invoked by uid 60001); 6 Aug 2006 04:03:29 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.uk;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=DBm45oDPk6BmJ8d02Bi57+lai0Z1n55Vsn9m+AzgitZYHDbGRkde2b4882KGKxfauYD7q4l++z//QntHPRbn6mJdu8GsUijKxstMjgDRg8nzW586gW5L0sODl7lEnhgcFEJguwcVawC6IL8jVLGAvIhwV7xomV4QO8Zh2RqpFC4=  ;
Message-ID: <20060806040329.51416.qmail@web27003.mail.ukl.yahoo.com>
Received: from [60.49.88.237] by web27003.mail.ukl.yahoo.com via HTTP; Sun, 06 Aug 2006 04:03:29 GMT
Date:	Sun, 6 Aug 2006 04:03:29 +0000 (GMT)
From:	Kiah Tang <wct_tang@yahoo.co.uk>
Reply-To: Kiah Tang <wct_tang@yahoo.co.uk>
Subject: EXT2-fs error
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wct_tang@yahoo.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12187
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wct_tang@yahoo.co.uk
Precedence: bulk
X-list: linux-mips

Hi all,
 
I have to say that I am a totally newbie in Linux kernel, yet I need to build a Linux kernel in very short period of time. 

I have an embedded MIPS box equipped with a 64MB of NAND flash and 64MB of DRAM. I am using a cross-compiler (buildroot) on the PC. 

I built Linux kernel (V2.4) as follows: 
- Created EXT2 ramdisk.gz as documented in Documentation/ramdisk.txt 
- The ramdisk contains the content of buildroot/build_mipsel/root/, which contains bin, etc, lib, linuxrc, sbin (sh.. etc), usr. I also created under /dev console null, tty*.... 
- Copied ramdisk.gz to /linux/arc/mips/ramdisk/ 
- Compiled the kernel 
- Donwloaded to the DRAM (0x800c0000) via PMON. 

Linux seems to boot up and the ramdisk seems to be mounted correctly. However modprobe failed. When I removed modprobe by undef CONFIG_KMOD, the system failed earlier at /sbin/sh step. 

Tracing down the codes, I noticed I got EXT2-fs error. 

Can anyone help? 

In addition, as a newbie, I would like to ask: 
- Is ramdisk necessary at all? 
- (How) Can I build a complete filesystem and kernel in a single piece and download on NAND flash? 

The printk messages is as follow: 

[snip] 
<6>Linux NET4.0 for Linux 2.4 
<6>Based upon Swansea University Computer Society NET3.039 
<4>sock_init: calling sk_init... 
<4>sock_init: calling skb_init... 
<4>sock_init: calling register_filesystem... 
<4>register_filesystem: calling find_filesystem... 
<4>find_filesystem: i(*p)->name=rootfs name=sockfs 
<4>find_filesystem: i(*p)->name=bdev name=sockfs 
<4>find_filesystem: p=801a4460 
<4>register_filesystem: p=801a4460 *p=00000000 
<4>sock_init: &sock_fs_type=801ab938 name=%S fs_flag=80177494 
<4>sock_init: calling sock_mnt... 
<4>find_filesystem: i(*p)->name=rootfs name=sockfs 
<4>find_filesystem: i(*p)->name=bdev name=sockfs 
<4>find_filesystem: i(*p)->name=sockfs name=sockfs 
<4>find_filesystem: p=801a4460 
<4>do_kern_mount: fstype="sockfs" type=801ab938 flags=0 name="sockfs" data=00000000 
<4>do_kern_mount: get_sb_nodev sb=802b5400 
<4>do_kern_mount: mnt=810b61a0 
<4>sock_init: calling rtnetlink_init... 
<4>Initializing RT netlink socket 
<4>__get_free_pages calling page_address... 
<4>do_basic_setup: calling start_context_thread... 
<4>__get_free_pages calling page_address... 
<4>__get_free_pages calling page_address... 
<4>add_to_runqueue: p=802b0000 
<4>do_basic_setup: calling do_initcalls... 
<4>__get_free_pages calling page_address... 
<4>add_to_runqueue: p=810fa000 
<4>Starting kswapd 
<4>__get_free_pages calling page_address... 
<4>add_to_runqueue: p=810f8000 
<4>register_filesystem: calling find_filesystem... 
<4>find_filesystem: i(*p)->name=rootfs name=tmpfs 
<4>find_filesystem: i(*p)->name=bdev name=tmpfs 
<4>find_filesystem: i(*p)->name=sockfs name=tmpfs 
<4>find_filesystem: p=801ab948 
<4>register_filesystem: p=801ab948 *p=00000000 
<4>find_filesystem: i(*p)->name=rootfs name=tmpfs 
<4>find_filesystem: i(*p)->name=bdev name=tmpfs 
<4>find_filesystem: i(*p)->name=sockfs name=tmpfs 
<4>find_filesystem: i(*p)->name=tmpfs name=tmpfs 
<4>find_filesystem: p=801ab948 
<4>do_kern_mount: fstype="tmpfs" type=801a4278 flags=0 name="tmpfs" data=00000000 
<4>do_kern_mount: get_sb_nodev sb=802b5800 
<4>do_kern_mount: mnt=810b61e0 
<4>__get_free_pages calling page_address... 
<4>add_to_runqueue: p=810f6000 
<4>__get_free_pages calling page_address... 
<4>add_to_runqueue: p=810f4000 
<4>add_to_runqueue: p=802b6000 
<4>register_filesystem: calling find_filesystem... 
<4>find_filesystem: i(*p)->name=rootfs name=pipefs 
<4>find_filesystem: i(*p)->name=bdev name=pipefs 
<4>find_filesystem: i(*p)->name=sockfs name=pipefs 
<4>find_filesystem: i(*p)->name=tmpfs name=pipefs 
<4>find_filesystem: p=801a4288 
<4>register_filesystem: p=801a4288 *p=00000000 
<4>find_filesystem: i(*p)->name=rootfs name=pipefs 
<4>find_filesystem: i(*p)->name=bdev name=pipefs 
<4>find_filesystem: i(*p)->name=sockfs name=pipefs 
<4>find_filesystem: i(*p)->name=tmpfs name=pipefs 
<4>find_filesystem: i(*p)->name=pipefs name=pipefs 
<4>find_filesystem: p=801a4288 
<4>do_kern_mount: fstype="pipefs" type=801a4748 flags=0 name="pipefs" data=00000000 
<4>do_kern_mount: get_sb_nodev sb=802b5c00 
<4>do_kern_mount: mnt=810b6220 
<4>register_filesystem: calling find_filesystem... 
<4>find_filesystem: i(*p)->name=rootfs name=ext2 
<4>find_filesystem: i(*p)->name=bdev name=ext2 
<4>find_filesystem: i(*p)->name=sockfs name=ext2 
<4>find_filesystem: i(*p)->name=tmpfs name=ext2 
<4>find_filesystem: i(*p)->name=pipefs name=ext2 
<4>find_filesystem: p=801a4758 
<4>register_filesystem: p=801a4758 *p=00000000 
<4>register_filesystem: calling find_filesystem... 
<4>find_filesystem: i(*p)->name=rootfs name=ramfs 
<4>find_filesystem: i(*p)->name=bdev name=ramfs 
<4>find_filesystem: i(*p)->name=sockfs name=ramfs 
<4>find_filesystem: i(*p)->name=tmpfs name=ramfs 
<4>find_filesystem: i(*p)->name=pipefs name=ramfs 
<4>find_filesystem: i(*p)->name=ext2 name=ramfs 
<4>find_filesystem: p=801a4c90 
<4>register_filesystem: p=801a4c90 *p=00000000 
<4>__get_free_pages calling page_address... 
<4>__get_free_pages calling page_address... 
<4>__get_free_pages calling page_address... 
<4>add_to_runqueue: p=810fa000 
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabledþ 
<6>ttyS00 at 0xbe800000 (irq = 2) is a ST16654 
<6>ttyS01 at 0xbe880000 (irq = 0) is a ST16654 
<6>ttyS02 at 0xbe900000 (irq = 0) is a ST16654 
<6>ttyS03 at 0xbe980000 (irq = 0) is a ST16654 
<6>ttyS04 at 0xbea00000 (irq = 0) is a ST16654 
<6>ttyS05 at 0xbea80000 (irq = 0) is a ST16654 
<6>ttyS06 at 0xbeb00000 (irq = 0) is a ST16654 
<6>ttyS07 at 0xbeb80000 (irq = 0) is a ST16654 
<4>RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize 
<4>add_to_runqueue: p=802b0000 
<4>add_to_runqueue: p=802b6000 
<4>add_to_runqueue: p=802b0000 
<4>add_to_runqueue: p=802b6000 
<4>init: calling prepare_namespace.. 
<4>prepare_namespace: sys_mkdir dev 
<4>__get_free_pages calling page_address... 
<4>sys_mkdir: tmp=/dev mode=1c0 
<4>path_lookup: calling path_init with path=/dev flags=10 nd=802b7f50 
<4>path_init: name=/dev flags=10 nd=802b7f50 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mkdir: path_lookup error=0 
<4>sys_mkdir: lookup_create dentry=802bd320 
<4>sys_mkdir: vfs_mkdir error=0 
<4>sys_mkdir: tmp=810f1000 error=0 
<4>prepare_namespace: sys_mkdir root 
<4>sys_mkdir: tmp=/root mode=1c0 
<4>path_lookup: calling path_init with path=/root flags=10 nd=802b7f50 
<4>path_init: name=/root flags=10 nd=802b7f50 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mkdir: path_lookup error=0 
<4>sys_mkdir: lookup_create dentry=802bd3a0 
<4>sys_mkdir: vfs_mkdir error=0 
<4>sys_mkdir: tmp=810f1000 error=0 
<4>prepare_namespace: sys_mknod dev/console 
<4>sys_mknod: filename=/dev/console mode=2180 dev=501 
<4>path_lookup: calling path_init with path=/dev/console flags=10 nd=802b7f48 
<4>path_init: name=/dev/console flags=10 nd=802b7f48 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mknod: path_lookup error=0 
<4>sys_mknod: lookup_create dentry=802bd420 
<4>__get_free_pages calling page_address... 
<4>__get_free_pages calling page_address... 
<4>sys_mknod: vfs_mknod error=0 
<4>sys_mknod: tmp=/dev/console error=0 
<4>prepare_namespace: ROOT_DEV=100 
<4>create_dev: *name=/dev/root dev=100 *devfs_name= 
<4>path_lookup: calling path_init with path=/dev/root flags=10 nd=802b7ef8 
<4>path_init: name=/dev/root flags=10 nd=802b7ef8 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mknod: filename=/dev/root mode=6180 dev=100 
<4>path_lookup: calling path_init with path=/dev/root flags=10 nd=802b7ee8 
<4>path_init: name=/dev/root flags=10 nd=802b7ee8 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mknod: path_lookup error=0 
<4>sys_mknod: lookup_create dentry=802bd4a0 
<4>sys_mknod: vfs_mknod error=0 
<4>sys_mknod: tmp=/dev/root error=0 
<4>create_dev: *name=/dev/ram dev=100 *devfs_name= 
<4>path_lookup: calling path_init with path=/dev/ram flags=10 nd=802b7ee0 
<4>path_init: name=/dev/ram flags=10 nd=802b7ee0 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mknod: filename=/dev/ram mode=6180 dev=100 
<4>path_lookup: calling path_init with path=/dev/ram flags=10 nd=802b7ed0 
<4>path_init: name=/dev/ram flags=10 nd=802b7ed0 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mknod: path_lookup error=0 
<4>sys_mknod: lookup_create dentry=802bd520 
<4>sys_mknod: vfs_mknod error=0 
<4>sys_mknod: tmp=/dev/ram error=0 
<4>create_dev: *name=/dev/initrd dev=1fa *devfs_name= 
<4>path_lookup: calling path_init with path=/dev/initrd flags=10 nd=802b7ee0 
<4>path_init: name=/dev/initrd flags=10 nd=802b7ee0 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mknod: filename=/dev/initrd mode=6180 dev=1fa 
<4>path_lookup: calling path_init with path=/dev/initrd flags=10 nd=802b7ed0 
<4>path_init: name=/dev/initrd flags=10 nd=802b7ed0 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mknod: path_lookup error=0 
<4>sys_mknod: lookup_create dentry=802bd5a0 
<4>sys_mknod: vfs_mknod error=0 
<4>sys_mknod: tmp=/dev/initrd error=0 
<4>open_namei: pathname=/dev/ram 
<4>path_lookup: calling path_init with path=/dev/ram flags=1 nd=802b7e28 
<4>path_init: name=/dev/ram flags=1 nd=802b7e28 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>open_namei: inode=810f0420 
<4>open_namei: error=0 permission=80102fe0 
<4>open_namei: get_lease error=0 
<4>open_namei: inode=810f0420 
<4>open_namei: return with 0 
<4>dentry_open: calling get_empty_filp... 
<4>__get_free_pages calling page_address... 
<4>dentry_open: get_empty_filp f=810ee0a0 
<4>dentry_open: calling get_write_access... 
<4>dentry_open: get_write_access error=0 
<4>dentry_open: calling fops_get... 
<4>dentry_open: f->f_op=801a4498 
<4>dentry_open: inode->i_sb->s_files=810ee0a0 
<4>dentry_open: calling f->f_op->open... 
<4>__get_free_pages calling page_address... 
<4>dentry_open: f->f_op->open error=0 
<4>dentry_open: return f=810ee0a0 
<4>open_namei: pathname=/dev/initrd 
<4>path_lookup: calling path_init with path=/dev/initrd flags=1 nd=802b7e28 
<4>path_init: name=/dev/initrd flags=1 nd=802b7e28 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>open_namei: inode=810f0600 
<4>open_namei: error=0 permission=80102fe0 
<4>open_namei: get_lease error=0 
<4>open_namei: return with 0 
<4>dentry_open: calling get_empty_filp... 
<4>dentry_open: get_empty_filp f=810ee120 
<4>dentry_open: calling fops_get... 
<4>dentry_open: f->f_op=801a4498 
<4>dentry_open: inode->i_sb->s_files=810ee120 
<4>dentry_open: calling f->f_op->open... 
<4>dentry_open: f->f_op->open error=0 
<4>dentry_open: return f=810ee120 
<5>RAMDISK: Compressed image found at block 0 
<4>__get_free_pages calling page_address... 
<4>__get_free_pages calling page_address... 
<4>__get_free_pages calling page_address... 
<4>__get_free_pages calling page_address... 
<3>crc error<6>Freeing initrd memory: 388k freed 
<4>path_lookup: calling path_init with path=/dev/ram flags=10 nd=802b7ef8 
<4>path_init: name=/dev/ram flags=10 nd=802b7ef8 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>mount_root: root_device_name= 
<4>create_dev: *name=/dev/root dev=100 *devfs_name= 
<4>path_lookup: calling path_init with path=/dev/root flags=10 nd=802b7ed8 
<4>path_init: name=/dev/root flags=10 nd=802b7ed8 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mknod: filename=/dev/root mode=6180 dev=100 
<4>path_lookup: calling path_init with path=/dev/root flags=10 nd=802b7ec8 
<4>path_init: name=/dev/root flags=10 nd=802b7ec8 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mknod: path_lookup error=0 
<4>sys_mknod: lookup_create dentry=802bd4a0 
<4>sys_mknod: vfs_mknod error=0 
<4>sys_mknod: tmp=/dev/root error=0 
<4>mount_block_root: fs_names=810f1000: "/dev/root" 
<4>get_fs_names: s=00008001 page=810f1000 "/dev/root" 
<4>get_fs_names: root_fs_names=00000000 page=810f1000 "/dev/root" 
<4>get_fs_names: len=80 
<4>get_fs_names: p= 
<4>get_fs_names: p= 
<4>nodev bdev 
<4>nodev sockfs 
<4>nodev tmpfs 
<4>nodev pipefs 
<4> ext2 
<4>nodev ramfs 
<4> 
<4>get_fs_names: p= 
<4>nodev sockfs 
<4>nodev tmpfs 
<4>nodev pipefs 
<4> ext2 
<4>nodev ramfs 
<4> 
<4>get_fs_names: p= 
<4>nodev tmpfs 
<4>nodev pipefs 
<4> ext2 
<4>nodev ramfs 
<4> 
<4>get_fs_names: p= 
<4>nodev pipefs 
<4> ext2 
<4>nodev ramfs 
<4> 
<4>get_fs_names: p= 
<4> ext2 
<4>nodev ramfs 
<4> 
<4>get_fs_names: p= 
<4>nodev ramfs 
<4> 
<4>get_fs_names: p= 
<4> 
<4>mount_block_root: get_fs_names done 
<4>sys_mount: dev_name=/dev/root dir_name=/root type=ext2 flags=8001 data= 
<4>__get_free_pages calling page_address... 
<4>sys_mount: type_page=ext2 retval=0 
<4>__get_free_pages calling page_address... 
<4>sys_mount: dir_page=/root 
<4>__get_free_pages calling page_address... 
<4>sys_mount: dev_page=/dev/root retval=0 
<4>sys_mount: data_page= retval=0 
<4>do_mount: flags=8001 
<4>path_lookup: calling path_init with path=/root flags=9 nd=802b7eb0 
<4>path_init: name=/root flags=9 nd=802b7eb0 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>do_mount: &nd=802b7eb0 retval=0 
<4>find_filesystem: i(*p)->name=rootfs name=ext2 
<4>find_filesystem: i(*p)->name=bdev name=ext2 
<4>find_filesystem: i(*p)->name=sockfs name=ext2 
<4>find_filesystem: i(*p)->name=tmpfs name=ext2 
<4>find_filesystem: i(*p)->name=pipefs name=ext2 
<4>find_filesystem: i(*p)->name=ext2 name=ext2 
<4>find_filesystem: p=801a4758 
<4>do_kern_mount: fstype="ext2" type=801a4c80 flags=8001 name="/dev/root" data=00000000 
<4>get_sb_bdev: fs_type=801a4c80 flags=8001 dev_name="/dev/root" data=00000000 
<4>path_lookup: calling path_init with path=/dev/root flags=9 nd=802b7df0 
<4>path_init: name=/dev/root flags=9 nd=802b7df0 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>get_sb_bdev: path_lookup error=0 
<4>get_sb_bdev: bdev->bd_dev= 
<4>get_sb_bdev: blkdev_get error=0 
<4>__get_free_pages calling page_address... 
<4>get_sb_bdev: s=-2129713152 
<4>do_kern_mount: get_sb_bdev sb=810f2800 
<4>do_kern_mount: mnt=810b6260 
<4>do_add_mount: mnt=810b6260 err=-2129960352 
<4>do_add_mount: 
<4>do_mount: do_add_mount retval=0 
<4>do_mount: exiting with retval=0 
<4>sys_mount: do_mount retval=0 
<4>sys_mount: retval=0 
<4>mount_block_root: err=0 *p= flags=8001 root_mount_data=0 
<4>path_lookup: calling path_init with path=/root flags=b nd=802b7f00 
<4>path_init: name=/root flags=b nd=802b7f00 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>mount_block_root: ROOT_DEV=100 
<4>VFS: Mounted root (ext2 filesystem) readonly. 
<4>path_lookup: calling path_init with path=/dev flags=9 nd=802b7f58 
<4>path_init: name=/dev flags=9 nd=802b7f58 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>sys_mount: dev_name=. dir_name=/ type= flags=2000 data= 
<4>sys_mount: type_page= retval=0 
<4>sys_mount: dir_page=/ 
<4>__get_free_pages calling page_address... 
<4>sys_mount: dev_page=. retval=0 
<4>sys_mount: data_page= retval=0 
<4>do_mount: flags=2000 
<4>path_lookup: calling path_init with path=/ flags=9 nd=802b7f08 
<4>path_init: name=/ flags=9 nd=802b7f08 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>do_mount: &nd=802b7f08 retval=0 
<4>path_lookup: calling path_init with path=. flags=9 nd=802b7ea0 
<4>path_init: name=. flags=9 nd=802b7ea0 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>do_mount: do_move_mount retval=0 
<4>do_mount: exiting with retval=0 
<4>sys_mount: do_mount retval=0 
<4>sys_mount: retval=0 
<4>path_lookup: calling path_init with path=. flags=2b nd=802b7f60 
<4>path_init: name=. flags=2b nd=802b7f60 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>init: calling free_initmem.. 
<6>Freeing unused kernel memory: 80k freed 
<4>init: calling unlock_kernel.. 
<4>__get_free_pages calling page_address... 
<4>init: calling open dev console.. 
<4>open_namei: pathname=/dev/console 
<4>path_lookup: calling path_init with path=/dev/console flags=1 nd=802b7ea8 
<4>path_init: name=/dev/console flags=1 nd=802b7ea8 
<4>path_lookup: calling path_walk.. 
<2>EXT2-fs error (device ramdisk(1,0)): ext2_check_page: bad entry in directory #69: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0 
<4>path_lookup: error=0 
<4>open_namei: inode=00000000 
<4>open_namei: exit error=-2 
<4>Warning: unable to open an initial console. 
<4>init: open dev console done 
<4>init: calling run_init_process sbin init.. 
<4>path_lookup: calling path_init with path=/sbin/init flags=9 nd=802b7d40 
<4>path_init: name=/sbin/init flags=9 nd=802b7d40 
<4>path_lookup: calling path_walk.. 
<2>EXT2-fs error (device ramdisk(1,0)): ext2_check_page: bad entry in directory #56: rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0 
<4>path_lookup: error=-2 
<4>init: calling run_init_process etc init.. 
<4>path_lookup: calling path_init with path=/etc/init flags=9 nd=802b7d40 
<4>path_init: name=/etc/init flags=9 nd=802b7d40 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=-2 
<4>init: calling run_init_process bin init.. 
<4>path_lookup: calling path_init with path=/bin/init flags=9 nd=802b7d40 
<4>path_init: name=/bin/init flags=9 nd=802b7d40 
<4>path_lookup: calling path_walk.. 
<4>__get_free_pages calling page_address... 
<4>path_lookup: error=-2 
<4>init: calling run_init_process bin sh.. 
<4>path_lookup: calling path_init with path=/bin/sh flags=9 nd=802b7d40 
<4>path_init: name=/bin/sh flags=9 nd=802b7d40 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=0 
<4>dentry_open: calling get_empty_filp... 
<4>dentry_open: get_empty_filp f=810ee0a0 
<4>dentry_open: calling fops_get... 
<4>dentry_open: f->f_op=801a4b10 
<4>dentry_open: inode->i_sb->s_files=810ee0a0 
<4>dentry_open: calling f->f_op->open... 
<4>dentry_open: f->f_op->open error=0 
<4>dentry_open: return f=810ee0a0 
<4>__get_free_pages calling page_address... 
<4>__get_free_pages calling page_address... 
<4>add_to_runqueue: p=80190000 
<4>path_lookup: calling path_init with path=/sbin/modprobe flags=9 nd=80191cf0 
<4>path_init: name=/sbin/modprobe flags=9 nd=80191cf0 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=-2 
<3>kmod: failed to exec /sbin/modprobe -s -k binfmt-464c, errno = 2 
<4>add_to_runqueue: p=802b6000 
<4>__get_free_pages calling page_address... 
<4>add_to_runqueue: p=80190000 
<4>path_lookup: calling path_init with path=/sbin/modprobe flags=9 nd=80191cf0 
<4>path_init: name=/sbin/modprobe flags=9 nd=80191cf0 
<4>path_lookup: calling path_walk.. 
<4>path_lookup: error=-2 
<3>kmod: failed to exec /sbin/modprobe -s -k binfmt-464c, errno = 2 
<4>add_to_runqueue: p=802b6000 
<0>Kernel panic: No init found. Try passing init= option to kernel. 
<4> 
[system rebooted to PMON...]
