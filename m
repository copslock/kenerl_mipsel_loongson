Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id LAA401772 for <linux-archive@neteng.engr.sgi.com>; Mon, 5 Jan 1998 11:41:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA04096 for linux-list; Mon, 5 Jan 1998 11:40:07 -0800
Received: from tantrik.engr.sgi.com (tantrik.engr.sgi.com [192.26.72.25]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA04017 for <linux@cthulhu.engr.sgi.com>; Mon, 5 Jan 1998 11:40:06 -0800
Received: from localhost (shm@localhost) by tantrik.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) via SMTP id LAA12544 for <linux@engr.sgi.com>; Mon, 5 Jan 1998 11:40:00 -0800 (PST)
Date: Mon, 5 Jan 1998 11:40:00 -0800 (PST)
From: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
Reply-To: Shrijeet Mukherjee <shm@cthulhu.engr.sgi.com>
To: linux@cthulhu.engr.sgi.com
Subject: linux-971208: problems with compilation 
Message-ID: <Pine.SGI.3.94.980105102340.12573A-100000@tantrik.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


trying to setup the cross compile under irix6.5 and trying to compile,
first came up with the problem of not finding some include files and
failing the make depend ... then if I included the pointer to /usr/include
it went head and compiled .. but came up with the following errors ..

Any suggestion for dealing with them are WELCOME ..


sched.c:314: warning: `timerlist_lock' defined but not used
In file included from /usr/linux/linux-971208/include/asm/uaccess.h:17,
                 from mem.c:25:
/usr/linux/linux-971208/include/asm/asm.h:96: warning: `ABS' redefined
/usr/linux/linux-971208/include/linux/ftape.h:205: warning: this is the location of the previous definition
No such feature exists (-5,116)

pc_keyb.c: In function `kbd_wait_for_input':
pc_keyb.c:57: warning: unused variable `n'
pc_keyb.c: In function `initialize_kbd':
pc_keyb.c:189: warning: implicit declaration of function `disable_irq'
pc_keyb.c:191: warning: implicit declaration of function `enable_irq'
pcnet32.c: In function `pcnet32_probe1':
pcnet32.c:324: warning: passing arg 1 makes integer from pointer without a cast
pcnet32.c: In function `pcnet32_start_xmit':
pcnet32.c:638: warning: passing arg 1 makes integer from pointer without a cast
pcnet32.c: In function `pcnet32_rx':
pcnet32.c:850: warning: passing arg 1 makes integer from pointer without a cast
pcnet32.c:816: warning: `pkt_len' might be used uninitialized in this function
pcnet32.c:817: warning: `skb' might be used uninitialized in this function
pcnet32.c:843: warning: `skb' might be used uninitialized in this function
pcnet32.c:844: warning: `skb' might be used uninitialized in this function
sonic.c: In function `sonic_rx':
sonic.c:591: warning: `status' might be used uninitialized in this function
sonic.c:595: warning: `skb' might be used uninitialized in this function
sonic.c:596: warning: `pkt_len' might be used uninitialized in this function
sonic.c:597: warning: `pkt_ptr' might be used uninitialized in this function
sonic.c:621: warning: `skb' might be used uninitialized in this function
sonic.c:622: warning: `skb' might be used uninitialized in this function
sonic.c:622: warning: `len' might be used uninitialized in this function
swapfile.c: In function `sys_swapon':
swapfile.c:610: warning: passing arg 1 makes integer from pointer without a cast
file.c: In function `fat_file_read':
file.c:179: warning: unsigned int format, umode_t arg (arg 2)
file.c: In function `fat_file_write':
file.c:297: warning: unsigned int format, umode_t arg (arg 2)
inode.c: In function `fat_read_super':
inode.c:457: warning: int format, uid_t arg (arg 5)
inode.c:457: warning: int format, gid_t arg (arg 6)
generic.c: In function `remove_proc_entry':
generic.c:302: warning: int format, long int arg (arg 2)
generic.c:302: warning: int format, long int arg (arg 3)
inode.c: In function `nfs_refresh_inode':
inode.c:633: warning: unsigned int format, umode_t arg (arg 3)
file.c: In function `nfs_file_read':
file.c:117: warning: long unsigned int format, size_t arg (arg 4)
file.c: In function `nfs_file_write':
file.c:170: warning: long unsigned int format, size_t arg (arg 5)
file.c:187: warning: unsigned int format, umode_t arg (arg 2)
dir.c: In function `nfs_invalidate_dircache':
dir.c:317: warning: unsigned int format, dev_t arg (arg 2)
dir.c: In function `nfs_dentry_delete':
dir.c:445: warning: int format, long int arg (arg 6)
nfsfh.c: In function `fh_verify':
nfsfh.c:1012: warning: unsigned int format, dev_t arg (arg 2)
nfsfh.c: In function `fh_compose':
nfsfh.c:1093: warning: unsigned int format, dev_t arg (arg 2)
export.c: In function `exp_export':
export.c:168: warning: unsigned int format, dev_t arg (arg 4)
export.c: In function `exp_rootfh':
export.c:396: warning: unsigned int format, dev_t arg (arg 3)
export.c:410: warning: unsigned int format, dev_t arg (arg 2)
svc.c: In function `lockd_down':
svc.c:285: warning: int format, pid_t arg (arg 2)
nls_base.c: In function `load_nls':
nls_base.c:209: warning: unused variable `ret'
nls_base.c:208: warning: unused variable `buf'
nls_cp850.c:250: warning: `charset2upper' defined but not used
nls_iso8859-1.c:138: warning: `charset2upper' defined but not used
skbuff.c: In function `skb_copy':
skbuff.c:269: warning: `offset' might be used uninitialized in this function
skbuff.c: In function `skb_realloc_headroom':
skbuff.c:319: warning: `offset' might be used uninitialized in this function
af_unix.c: In function `unix_stream_connect1':
af_unix.c:625: warning: `skb' might be used uninitialized in this function
af_unix.c:684: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
af_unix.c:689: warning: `skb' might be used uninitialized in this function
af_unix.c:694: warning: `newsk' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:297: warning: `newsk' might be used uninitialized in this function
af_unix.c: In function `unix_dgram_sendmsg':
af_unix.c:907: warning: `skb' might be used uninitialized in this function
af_unix.c:939: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
af_unix.c:952: warning: `skb' might be used uninitialized in this function
af_unix.c:962: warning: `skb' might be used uninitialized in this function
af_unix.c:968: warning: `skb' might be used uninitialized in this function
af_unix.c:973: warning: `newsk' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:297: warning: `newsk' might be used uninitialized in this function
af_unix.c: In function `unix_stream_sendmsg':
af_unix.c:988: warning: `size' might be used uninitialized in this function
af_unix.c:989: warning: `skb' might be used uninitialized in this function
af_unix.c:1061: warning: `skb' might be used uninitialized in this function
af_unix.c:1061: warning: `skb' might be used uninitialized in this function
af_unix.c:1068: warning: `skb' might be used uninitialized in this function
af_unix.c:1068: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
af_unix.c:1074: warning: `skb' might be used uninitialized in this function
af_unix.c:1081: warning: `newsk' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:297: warning: `newsk' might be used uninitialized in this function
proc.c: In function `get__openreq':
proc.c:71: warning: int format, long int arg (arg 14)
proc.c: In function `get__sock':
proc.c:122: warning: int format, long int arg (arg 14)
packet.c: In function `packet_sendmsg':
packet.c:117: warning: `skb' might be used uninitialized in this function
packet.c:118: warning: `dev' might be used uninitialized in this function
packet.c:184: warning: `skb' might be used uninitialized in this function
packet.c:185: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
packet.c:209: warning: `skb' might be used uninitialized in this function
ip_fragment.c: In function `ip_glue':
ip_fragment.c:307: warning: `skb' might be used uninitialized in this function
ip_fragment.c:310: warning: `ptr' might be used uninitialized in this function
ip_fragment.c:332: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
ip_fragment.c:347: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h: In function `ip_forward':
/usr/linux/linux-971208/include/net/route.h:156: warning: `hh' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:157: warning: `hh_len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h: In function `ip_build_pkt':
/usr/linux/linux-971208/include/net/route.h:156: warning: `hh' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:157: warning: `hh_len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h: In function `ip_build_header':
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
ip_output.c: In function `ip_queue_xmit':
ip_output.c:348: warning: `tot_len' might be used uninitialized in this function
ip_output.c:404: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:157: warning: `hh_len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:156: warning: `hh' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `skb' might be used uninitialized in this function
ip_output.c: In function `ip_build_xmit':
ip_output.c:495: warning: `fraglen' might be used uninitialized in this function
ip_output.c:495: warning: `maxfraglen' might be used uninitialized in this function
ip_output.c:495: warning: `fragheaderlen' might be used uninitialized in this function
ip_output.c:497: warning: `offset' might be used uninitialized in this function
ip_output.c:497: warning: `mf' might be used uninitialized in this function
ip_output.c:498: warning: `id' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:156: warning: `hh' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:157: warning: `hh_len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:156: warning: `hh' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:157: warning: `hh_len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
ip_output.c: In function `ip_fragment':
ip_output.c:787: warning: `ptr' might be used uninitialized in this function
ip_output.c:789: warning: `skb2' might be used uninitialized in this function
ip_output.c:790: warning: `mtu' might be used uninitialized in this function
ip_output.c:790: warning: `len' might be used uninitialized in this function
ip_output.c:791: warning: `offset' might be used uninitialized in this function
ip_output.c:792: warning: `not_last_frag' might be used uninitialized in this function
ip_output.c:793: warning: `dont_fragment' might be used uninitialized in this function
ip_output.c:880: warning: `skb' might be used uninitialized in this function
ip_output.c:891: warning: `skb' might be used uninitialized in this function
ip_output.c: In function `ip_reply':
ip_output.c:954: warning: `reply' might be used uninitialized in this function
ip_output.c:955: warning: `iphlen' might be used uninitialized in this function
ip_output.c:959: warning: `daddr' might be used uninitialized in this function
ip_output.c:982: warning: `skb' might be used uninitialized in this function
ip_output.c:76: warning: `skb' might be used uninitialized in this function
ip_output.c:77: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:156: warning: `hh' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:157: warning: `hh_len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `len' might be used uninitialized in this function
ip_output.c:992: warning: `skb' might be used uninitialized in this function
ip_output.c:992: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp.c: In function `tcp_append_tail':
tcp.c:749: warning: `copy' might be used uninitialized in this function
tcp.c:761: warning: `len' might be used uninitialized in this function
tcp.c: In function `tcp_do_sendmsg':
tcp.c:803: warning: `seglen' might be used uninitialized in this function
tcp.c:804: warning: `from' might be used uninitialized in this function
tcp.c:810: warning: `copy' might be used uninitialized in this function
tcp.c:812: warning: `skb' might be used uninitialized in this function
tcp.c:933: warning: `skb' might be used uninitialized in this function
tcp.c:940: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp.c:952: warning: `skb' might be used uninitialized in this function
tcp.c:952: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_output.c: In function `tcp_fragment':
tcp_output.c:209: warning: `buff' might be used uninitialized in this function
tcp_output.c:232: warning: `skb' might be used uninitialized in this function
tcp_output.c:237: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_output.c:263: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_output.c:273: warning: `newsk' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:376: warning: `newsk' might be used uninitialized in this function
tcp_output.c: In function `tcp_retrans_try_collapse':
tcp_output.c:583: warning: `th2' might be used uninitialized in this function
tcp_output.c:584: warning: `size1' might be used uninitialized in this function
tcp_output.c:584: warning: `size2' might be used uninitialized in this function
tcp_output.c:605: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h: In function `tcp_send_fin':
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_output.c: In function `tcp_send_synack':
tcp_output.c:838: warning: `th' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_output.c:874: warning: `mss' might be used uninitialized in this function
tcp_output.c:874: warning: `sack' might be used uninitialized in this function
tcp_output.c:874: warning: `ts' might be used uninitialized in this function
tcp_output.c:874: warning: `offer_wscale' might be used uninitialized in this function
tcp_output.c:874: warning: `wscale' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/tcp.h:615: warning: `count' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/tcp.h:616: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_output.c: In function `tcp_send_ack':
tcp_output.c:936: warning: `buff' might be used uninitialized in this function
tcp_output.c:968: warning: `skb' might be used uninitialized in this function
tcp_output.c:972: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_output.c: In function `tcp_write_wakeup':
tcp_output.c:998: warning: `buff' might be used uninitialized in this function
tcp_output.c:1040: warning: `skb' might be used uninitialized in this function
tcp_output.c:1061: warning: `skb' might be used uninitialized in this function
tcp_output.c:1065: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_ipv4.c: In function `tcp_v4_connect':
tcp_ipv4.c:488: warning: `buff' might be used uninitialized in this function
tcp_ipv4.c:491: warning: `th' might be used uninitialized in this function
tcp_ipv4.c:569: warning: `skb' might be used uninitialized in this function
tcp_ipv4.c:574: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_ipv4.c:617: warning: `skb' might be used uninitialized in this function
tcp_ipv4.c:617: warning: `mss' might be used uninitialized in this function
tcp_ipv4.c:617: warning: `sack' might be used uninitialized in this function
tcp_ipv4.c:617: warning: `ts' might be used uninitialized in this function
tcp_ipv4.c:617: warning: `offer_wscale' might be used uninitialized in this function
tcp_ipv4.c:617: warning: `wscale' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/tcp.h:615: warning: `count' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/tcp.h:616: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/tcp.h:616: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_ipv4.c:637: warning: `newsk' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:297: warning: `newsk' might be used uninitialized in this function
tcp_ipv4.c: In function `tcp_v4_send_reset':
tcp_ipv4.c:916: warning: `skb1' might be used uninitialized in this function
tcp_ipv4.c:926: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_ipv4.c: In function `tcp_v4_send_synack':
tcp_ipv4.c:982: warning: `th' might be used uninitialized in this function
tcp_ipv4.c:984: warning: `mss' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_ipv4.c:1045: warning: `mss' might be used uninitialized in this function
tcp_ipv4.c:1045: warning: `sack' might be used uninitialized in this function
tcp_ipv4.c:1045: warning: `ts' might be used uninitialized in this function
tcp_ipv4.c:1045: warning: `offer_wscale' might be used uninitialized in this function
tcp_ipv4.c:1045: warning: `wscale' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/tcp.h:615: warning: `count' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/tcp.h:616: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
tcp_ipv4.c:1050: warning: `th' might be used uninitialized in this function
arp.c: In function `arp_send':
arp.c:1243: warning: `skb' might be used uninitialized in this function
arp.c:1265: warning: `skb' might be used uninitialized in this function
arp.c:1266: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
igmp.c: In function `igmp_send_report':
igmp.c:249: warning: `skb' might be used uninitialized in this function
igmp.c:265: warning: `skb' might be used uninitialized in this function
igmp.c:266: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:157: warning: `hh_len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:156: warning: `hh' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `len' might be used uninitialized in this function
/usr/linux/linux-971208/include/net/route.h:164: warning: `skb' might be used uninitialized in this function
igmp.c:268: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
igmp.c:286: warning: `skb' might be used uninitialized in this function
/usr/linux/linux-971208/include/linux/skbuff.h:425: warning: `tmp' might be used uninitialized in this function
sched.c: In function `rpciod':
sched.c:754: warning: int format, pid_t arg (arg 2)
sched.c: In function `rpciod_up':
sched.c:821: warning: int format, pid_t arg (arg 2)
sched.c: In function `rpciod_down':
sched.c:853: warning: int format, pid_t arg (arg 2)
sched.c:858: warning: int format, pid_t arg (arg 2)
sched.c:880: warning: int format, pid_t arg (arg 2)
auth_unix.c: In function `authunix_fake_cred':
auth_unix.c:104: warning: int format, uid_t arg (arg 2)
auth_unix.c:104: warning: int format, gid_t arg (arg 3)
setup.c: In function `jazz_setup':
setup.c:101: warning: implicit declaration of function `add_wired_entry'
io.c:47: warning: `sni_readb' defined but not used
io.c:60: warning: `sni_readw' defined but not used
io.c:73: warning: `sni_readl' defined but not used
io.c:86: warning: `sni_writeb' defined but not used
io.c:95: warning: `sni_writew' defined but not used
io.c:104: warning: `sni_writel' defined but not used
io.c:113: warning: `sni_memset_io' defined but not used
io.c:133: warning: `sni_memcpy_fromio' defined but not used
io.c:154: warning: `sni_memcpy_toio' defined but not used
/usr/linux/linux-971208/include/asm/floppy.h:98: warning: `FDC2' defined but not used
ptrace.c: In function `sys_ptrace':
ptrace.c:254: warning: `res' might be used uninitialized in this function
checksum.c: In function `csum_partial_copy_from_user':
checksum.c:121: warning: unused variable `dst_err_ptr'
dump_tlb.c: In function `dump_tlb':
dump_tlb.c:83: warning: unsigned int format, different type arg (arg 3)
dump_tlb.c:83: warning: unsigned int format, different type arg (arg 4)
dump_tlb.c:83: warning: int format, different type arg (arg 8)
dump_tlb.c:83: warning: unsigned int format, different type arg (arg 9)
dump_tlb.c:83: warning: int format, different type arg (arg 13)
dump_tlb.c: At top level:
dump_tlb.c:23: warning: `cache_map' defined but not used
drivers/char/char.a(vt.o): In function `vt_ioctl':
vt.c(.text+0x92c): undefined reference to `key_maps'
vt.c(.text+0x934): undefined reference to `key_maps'
vt.c(.text+0x9bc): undefined reference to `key_maps'
vt.c(.text+0x9c0): undefined reference to `key_maps'
vt.c(.text+0xa00): undefined reference to `keymap_count'
vt.c(.text+0xa04): undefined reference to `keymap_count'
vt.c(.text+0xa0c): undefined reference to `keymap_count'
vt.c(.text+0xa10): undefined reference to `keymap_count'
vt.c(.text+0xa84): undefined reference to `key_maps'
vt.c(.text+0xa8c): undefined reference to `key_maps'
vt.c(.text+0xa98): undefined reference to `keymap_count'
vt.c(.text+0xa9c): undefined reference to `keymap_count'
vt.c(.text+0xb04): undefined reference to `key_maps'
vt.c(.text+0xb0c): undefined reference to `key_maps'
vt.c(.text+0xb2c): undefined reference to `keymap_count'
vt.c(.text+0xb30): undefined reference to `keymap_count'
vt.c(.text+0xb38): undefined reference to `keymap_count'
vt.c(.text+0xb3c): undefined reference to `keymap_count'
vt.c(.text+0xc60): undefined reference to `func_table'
vt.c(.text+0xc68): undefined reference to `func_table'
vt.c(.text+0xce0): undefined reference to `func_table'
vt.c(.text+0xce4): undefined reference to `func_table'
vt.c(.text+0xce8): undefined reference to `func_table'
drivers/char/char.a(vt.o)(.text+0xcf0):vt.c: more undefined references to `func_table' follow
drivers/char/char.a(vt.o): In function `vt_ioctl':
vt.c(.text+0xcf4): undefined reference to `funcbufsize'
vt.c(.text+0xcf8): undefined reference to `funcbufsize'
vt.c(.text+0xcfc): undefined reference to `funcbufleft'
vt.c(.text+0xd00): undefined reference to `funcbufleft'
vt.c(.text+0xd04): undefined reference to `funcbufptr'
vt.c(.text+0xd08): undefined reference to `funcbufptr'
vt.c(.text+0xd78): undefined reference to `func_table'
vt.c(.text+0xd84): undefined reference to `func_table'
vt.c(.text+0xdb0): undefined reference to `funcbufleft'
vt.c(.text+0xdb4): undefined reference to `funcbufleft'
vt.c(.text+0xde0): undefined reference to `func_table'
vt.c(.text+0xde4): undefined reference to `func_table'
vt.c(.text+0xe1c): undefined reference to `func_table'
vt.c(.text+0xe24): undefined reference to `func_table'
vt.c(.text+0xe28): undefined reference to `funcbufleft'
vt.c(.text+0xe2c): undefined reference to `funcbufleft'
vt.c(.text+0xe38): undefined reference to `funcbufsize'
vt.c(.text+0xe3c): undefined reference to `funcbufsize'
vt.c(.text+0xe84): undefined reference to `func_table'
vt.c(.text+0xe8c): undefined reference to `func_table'
vt.c(.text+0xe90): undefined reference to `funcbufptr'
vt.c(.text+0xe94): undefined reference to `funcbufptr'
vt.c(.text+0xeb8): undefined reference to `funcbufptr'
vt.c(.text+0xebc): undefined reference to `funcbufptr'
vt.c(.text+0xec0): undefined reference to `func_table'
vt.c(.text+0xec4): undefined reference to `func_table'
vt.c(.text+0xefc): undefined reference to `funcbufptr'
vt.c(.text+0xf00): undefined reference to `funcbufptr'
vt.c(.text+0xf28): undefined reference to `funcbufptr'
vt.c(.text+0xf2c): undefined reference to `funcbufptr'
vt.c(.text+0xf30): undefined reference to `func_table'
vt.c(.text+0xf34): undefined reference to `func_table'
vt.c(.text+0xf64): undefined reference to `funcbufptr'
vt.c(.text+0xf68): undefined reference to `funcbufptr'
vt.c(.text+0xf6c): undefined reference to `func_buf'
vt.c(.text+0xf70): undefined reference to `func_buf'
vt.c(.text+0xf7c): undefined reference to `funcbufsize'
vt.c(.text+0xf84): undefined reference to `funcbufsize'
vt.c(.text+0xf88): undefined reference to `funcbufleft'
vt.c(.text+0xf8c): undefined reference to `funcbufleft'
vt.c(.text+0xf90): undefined reference to `funcbufsize'
vt.c(.text+0xf94): undefined reference to `funcbufsize'
vt.c(.text+0xf98): undefined reference to `funcbufptr'
vt.c(.text+0xf9c): undefined reference to `funcbufptr'
vt.c(.text+0xfa0): undefined reference to `funcbufsize'
vt.c(.text+0xfa4): undefined reference to `funcbufsize'
vt.c(.text+0xfb4): undefined reference to `funcbufleft'
vt.c(.text+0xfb8): undefined reference to `funcbufleft'
vt.c(.text+0xfc4): undefined reference to `func_table'
vt.c(.text+0xfcc): undefined reference to `func_table'
vt.c(.text+0x101c): undefined reference to `accent_table_size'
vt.c(.text+0x1020): undefined reference to `accent_table_size'
vt.c(.text+0x1030): undefined reference to `accent_table'
vt.c(.text+0x1034): undefined reference to `accent_table'
vt.c(.text+0x108c): undefined reference to `accent_table_size'
vt.c(.text+0x1090): undefined reference to `accent_table_size'
vt.c(.text+0x1094): undefined reference to `accent_table'
vt.c(.text+0x1098): undefined reference to `accent_table'
drivers/char/char.a(keyboard.o): In function `handle_scancode':
keyboard.c(.text+0x328): undefined reference to `key_maps'
keyboard.c(.text+0x330): undefined reference to `key_maps'
keyboard.c(.text+0x334): undefined reference to `key_maps'
keyboard.c(.text+0x33c): undefined reference to `key_maps'
drivers/char/char.a(keyboard.o): In function `handle_diacr':
keyboard.c(.text+0xcfc): undefined reference to `accent_table'
keyboard.c(.text+0xd08): undefined reference to `accent_table'
keyboard.c(.text+0xd0c): undefined reference to `accent_table_size'
keyboard.c(.text+0xd10): undefined reference to `accent_table_size'
keyboard.c(.text+0xd28): undefined reference to `accent_table'
keyboard.c(.text+0xd30): undefined reference to `accent_table'
keyboard.c(.text+0xd3c): undefined reference to `accent_table'
keyboard.c(.text+0xd44): undefined reference to `accent_table'
drivers/char/char.a(keyboard.o): In function `do_fn':
keyboard.c(.text+0xdcc): undefined reference to `func_table'
keyboard.c(.text+0xdd4): undefined reference to `func_table'
drivers/char/char.a(keyboard.o): In function `compute_shiftstate':
keyboard.c(.text+0x113c): undefined reference to `plain_map'
keyboard.c(.text+0x1140): undefined reference to `plain_map'
make: *** [vmlinux] Error 1
