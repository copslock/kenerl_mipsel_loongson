Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0R9NZj31769
	for linux-mips-outgoing; Sun, 27 Jan 2002 01:23:35 -0800
Received: from host099.momenco.com (IDENT:root@www.momenco.com [64.169.228.99])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0R9MjP31655
	for <linux-mips@oss.sgi.com>; Sun, 27 Jan 2002 01:22:45 -0800
Received: (from mdharm@localhost)
	by host099.momenco.com (8.11.6/8.11.6) id g0R8Mgu11460
	for linux-mips@oss.sgi.com; Sun, 27 Jan 2002 00:22:42 -0800
Date: Sun, 27 Jan 2002 00:22:42 -0800
From: Matthew Dharm <mdharm@momenco.com>
To: linux-mips@oss.sgi.com
Subject: Help with OOPSes, anyone?
Message-ID: <20020127002242.A11373@momenco.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Momentum Computer, Inc.
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

So, I'm back to trying to get Linux running on our boards, and I'm having a
problem I'd like some help with...

(See http://www.momenco.com/products/ocelot if you're interested.)

At one point, we had 2.4.5 working on this board.  That was the result of
joint work between myself, RedHat, and MontaVista.  Seemed to work pretty
well, given that we had basically no userspace to work with.  So, while it
seemed functional, it's not much of a datapoint.

So, I did a cvs update, and tried to build 2.4.17.  Lo and behold, it still
compiles.  And it even runs.  And the RedHat 7.1 userspace from oss.sgi.com
even seems to work, mostly.

But, under certain conditions, the kernel OOPSes.  Attached to this message
are a few of those OOPSes (serial console is wonderful!) along with the
ksymoops output.  I think the read_lsmod() warning is bogus, because there
are, actually, no modules loaded.

My instincts are telling me that these are all being caused by the same
problem, but I'll be damned if I can figure out what that is.  Caching is a
good suspect, but that's just because it's always a good suspect.

What does work is a ping -f to the board... so I think the interrupt code
is rock-solid.  It's pretty simple anyway, so I'm not suprised that's a
problem.

While we did have some problem supporting our boards that have 512MB on
them, the board I'm testing with only has 128MB.  Dealing with the 512MB
problems (which, I understand, are caused by the cache-flush routines
trying to flush too much), is on the TODO list, but I don't think those
problems are affecting me right now.

Load does seem to be a factor.  Big compiles, lots of NFS traffic, that
sort of thing seems to be the triggering factor.  It's easy to duplicate,
given a few minutes.  Oddly enough, lite loads or idle doesn't trigger this
-- I FTPed the SRPM for wget and built it without any problems.  Heck, it
even works!  But when I try to build something bigger (say, ncftp or
glibc), it dies an ugly death.  Heck, I could FTP, build, and use ksymoops
natively on the board without any problems.  Lots of things work fine,
but sometimes....

I know Ralf has one of our boards, but I don't know if he's in the same
country as that board... Ralf?

In these OOPSes, one is caused by some code in unaligned.c -- I've seen
several (many) like this, tho I only captured and decoded one.  The code in
question seems to be one of those "you can never get here" situations,
which makes me really worry.  The other two look like some form of
NULL-pointer dereference.

I've tried several different configurations, stripping down drivers as I
go.  I'm going to continue that tomorrow/monday, but I don't have high
hopes that will fix the problem.  I'm thinking about trying
CONFIG_MIPS_UNCACHED, but I don't know if that works on an RM7000 processor
-- the L1 and L2 are built-in to the processor, and I don't think the L1
can be deactivated.  Then again, I don't know how CONFIG_MIPS_UNCACHED
works, so if someone would like to clue me in on the subject, I'd really
appreciate it.

Another thing I'm going to try is an ELF image from that Redhat/Montavista
work, to see if it shows the same problems.  That datapoint will be useful
also.

If anyone has any clues as to what's going on, I'd really appreciate it.
Anyone?

Matt

-- 
Matthew Dharm                              Work: mdharm@momenco.com
Senior Software Designer, Momentum Computer


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.in"

Unhandled kernel unaligned access in unaligned.c:emulate_load_store_insn, line 345:
$0 : 00000000 90045400 813fb004 021dc71d 813fb000 00000003 00000001 85a19020
$8 : 00000028 80242788 00000000 0065002c 3c520292 00000000 3c520292 00000000
$16: 021dc71d 813fa3fc 00000001 90045401 813fb004 802c3aa8 00000003 00008001
$24: 8129ea64 85750cc0                   813f6000 813f7e90 813f7e90 802396d8
Hi : 00000000
Lo : 0000000e
epc  : 8010a3fc    Not tainted
Status: 90045402
Cause : 00008010
Process rpciod (pid: 8, stackpage=813f6000)
Stack: 00000002 8023a360 85747274 90045401 813fa000 813fa3fc 85750bc0 802c64c8
       802c64c8 8029541c 813ff410 00000000 802396d8 802396bc 85750bc0 813fe8e0
       85e2c140 85a19620 813fa000 8023904c 813fa314 85747700 85750bc0 813fe8e0
       85750bc0 85750c14 00000005 8023b1a4 85750c14 85750bc0 00000005 802c64c8
       00000000 85750bc0 8023a92c 00008400 acd8a3f8 85461000 3c520291 00000000
       00000000 ...
Call Trace: [<8023a360>] [<802396d8>] [<802396bc>] [<8023904c>] [<8023b1a4>] [<8023a92c>]
 [<8023ab9c>] [<8023aa54>] [<8023b7b8>] [<8023b620>] [<8023b620>] [<80100da0>]
 [<8023bb8c>] [<8023c1a0>] [<80100d90>]

Code: 00c09021  3c15802c  26b53aa8 <8e05fffc> 8ca20000  00561024  1040002f  00001821  40116000 
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.out"

ksymoops 2.4.0 on mips 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
$0 : 00000000 90045400 813fb004 021dc71d 813fb000 00000003 00000001 85a19020
$8 : 00000028 80242788 00000000 0065002c 3c520292 00000000 3c520292 00000000
$16: 021dc71d 813fa3fc 00000001 90045401 813fb004 802c3aa8 00000003 00008001
$24: 8129ea64 85750cc0                   813f6000 813f7e90 813f7e90 802396d8
epc  : 8010a3fc    Not tainted
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
Status: 90045402
Cause : 00008010
Process rpciod (pid: 8, stackpage=813f6000)
Stack: 00000002 8023a360 85747274 90045401 813fa000 813fa3fc 85750bc0 802c64c8
       802c64c8 8029541c 813ff410 00000000 802396d8 802396bc 85750bc0 813fe8e0
       85e2c140 85a19620 813fa000 8023904c 813fa314 85747700 85750bc0 813fe8e0
       85750bc0 85750c14 00000005 8023b1a4 85750c14 85750bc0 00000005 802c64c8
       00000000 85750bc0 8023a92c 00008400 acd8a3f8 85461000 3c520291 00000000
       00000000 ...
Call Trace: [<8023a360>] [<802396d8>] [<802396bc>] [<8023904c>] [<8023b1a4>] [<8023a92c>]
 [<8023ab9c>] [<8023aa54>] [<8023b7b8>] [<8023b620>] [<8023b620>] [<80100da0>]
 [<8023bb8c>] [<8023c1a0>] [<80100d90>]
Code: 00c09021  3c15802c  26b53aa8 <8e05fffc> 8ca20000  00561024  1040002f  00001821  40116000 

>>PC;  8010a3fc <__wake_up+6c/198>   <=====
Trace; 8023a360 <rpc_wake_up_next+6c/ac>
Trace; 802396d8 <xprt_clear_backlog+48/5c>
Trace; 802396bc <xprt_clear_backlog+2c/5c>
Trace; 8023904c <xprt_release+cc/110>
Trace; 8023b1a4 <rpc_release_task+1d4/240>
Trace; 8023a92c <__rpc_execute+378/3a0>
Trace; 8023ab9c <__rpc_schedule+1a0/20c>
Trace; 8023aa54 <__rpc_schedule+58/20c>
Trace; 8023b7b8 <rpciod+198/370>
Trace; 8023b620 <rpciod+0/370>
Trace; 8023b620 <rpciod+0/370>
Trace; 80100da0 <kernel_thread+40/70>
Trace; 8023bb8c <rpciod_up+d4/180>
Trace; 8023c1a0 <rpcauth_create+40/58>
Trace; 80100d90 <kernel_thread+30/70>
Code;  8010a3f0 <__wake_up+60/198>
00000000 <_PC>:
Code;  8010a3f0 <__wake_up+60/198>
   0:   00c09021  move    s2,a2
Code;  8010a3f4 <__wake_up+64/198>
   4:   3c15802c  lui     s5,0x802c
Code;  8010a3f8 <__wake_up+68/198>
   8:   26b53aa8  addiu   s5,s5,15016
Code;  8010a3fc <__wake_up+6c/198>   <=====
   c:   8e05fffc  lw      a1,-4(s0)   <=====
Code;  8010a400 <__wake_up+70/198>
  10:   8ca20000  lw      v0,0(a1)
Code;  8010a404 <__wake_up+74/198>
  14:   00561024  and     v0,v0,s6
Code;  8010a408 <__wake_up+78/198>
  18:   1040002f  beqz    v0,d8 <_PC+0xd8> 8010a4c8 <__wake_up+138/198>
Code;  8010a40c <__wake_up+7c/198>
  1c:   00001821  move    v1,zero
Code;  8010a410 <__wake_up+80/198>
  20:   40116000  mfc0    s1,$12

Kernel panic: Aiee, killing interrupt handler!

2 warnings issued.  Results may not be reliable.

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops2.in"

Unable to handle kernel paging request at virtual address 00000020, epc == 8010a19c, ra <1>Unable to handle kernel paging request at virtual address 00000062, epc == 80206ce4, ra == 80217c2c
Oops in fault.c:do_page_fault, line 204:
$0 : 00000000 00000001 812efecc 812efe60 00000000 802e0020 0000ab22 812efecc
$8 : c0a80112 00000000 00000000 00000002 00000000 00000000 802e3626 00000000
$16: 812efecc 00001d3c 812ee8a0 813fc620 87156b20 812ee8a0 00000000 812ee8cc
$24: 00000000 85919c47                   85918000 85919a50 87156bf8 80217c2c
Hi : 00000000
Lo : 00000e00
epc  : 80206ce4    Not tainted
Status: b0045403
Cause : 00008008
Process cc1 (pid: 3366, stackpage=85918000)
Stack: 87156bf8 8021636c c0a80101 00000000 00000000 801f3ee0 812efc80 81296140
       81296140 87156b20 87156bf8 81296140 813fc620 00000000 87156bf8 00001d3c
       812efee0 00000000 87156b20 00000020 812ee8a0 812ee8cc 80217c2c 80217b38
       812ee8a0 802f6c94 801ef2b0 812fb590 87156bf8 87156b20 87156bf8 802c64c0
       802b68a0 802b68c0 00800000 00000060 00000010 8021aa50 00000056 812ea140
       00000001 ...
Call Trace: [<8021636c>] [<801f3ee0>] [<80217c2c>] [<80217b38>] [<801ef2b0>] [<8021aa50>]
 [<8021b62c>] [<80203978>] [<80236c68>] [<8011773c>] [<8011354c>] [<801f421c>]
 [<801133dc>] [<8011782c>] [<80112e8c>] [<8010631c>] [<80106630>] [<801065ec>]
 [<8019609c>] [<8012b808>] [<8023b1e4>] [<80117448>] [<801a7aec>] [<801a7aec>]
 [<8010dd00>] [<8010dd8c>] [<8010debc>] [<8010e2b8>] [<8010e184>] [<80247686>]
 [<80108c3c>] [<8012b808>] [<80247628>] [<8010a19c>] [<801033f0>] [<8012b460>]
 [<8011ed48>] [<8011ede8>] [<8011ee00>] [<80109938>] [<8011efd0>] ...

Code: 8ea20080  8ea3007c  8e64000c <94850062> 00431023  0045102a  1040002c  8eb1000c  8c8200fc 
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops2.out"

ksymoops 2.4.0 on mips 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel paging request at virtual address 00000020, epc == 8010a19c, ra <1>Unable to handle kernel paging request at virtual address 00000062, epc == 80206ce4, ra == 80217c2c
$0 : 00000000 00000001 812efecc 812efe60 00000000 802e0020 0000ab22 812efecc
$8 : c0a80112 00000000 00000000 00000002 00000000 00000000 802e3626 00000000
$16: 812efecc 00001d3c 812ee8a0 813fc620 87156b20 812ee8a0 00000000 812ee8cc
$24: 00000000 85919c47                   85918000 85919a50 87156bf8 80217c2c
epc  : 80206ce4    Not tainted
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
Status: b0045403
Cause : 00008008
Process cc1 (pid: 3366, stackpage=85918000)
Stack: 87156bf8 8021636c c0a80101 00000000 00000000 801f3ee0 812efc80 81296140
       81296140 87156b20 87156bf8 81296140 813fc620 00000000 87156bf8 00001d3c
       812efee0 00000000 87156b20 00000020 812ee8a0 812ee8cc 80217c2c 80217b38
       812ee8a0 802f6c94 801ef2b0 812fb590 87156bf8 87156b20 87156bf8 802c64c0
       802b68a0 802b68c0 00800000 00000060 00000010 8021aa50 00000056 812ea140
       00000001 ...
Call Trace: [<8021636c>] [<801f3ee0>] [<80217c2c>] [<80217b38>] [<801ef2b0>] [<8021aa50>]
 [<8021b62c>] [<80203978>] [<80236c68>] [<8011773c>] [<8011354c>] [<801f421c>]
 [<801133dc>] [<8011782c>] [<80112e8c>] [<8010631c>] [<80106630>] [<801065ec>]
 [<8019609c>] [<8012b808>] [<8023b1e4>] [<80117448>] [<801a7aec>] [<801a7aec>]
 [<8010dd00>] [<8010dd8c>] [<8010debc>] [<8010e2b8>] [<8010e184>] [<80247686>]
 [<80108c3c>] [<8012b808>] [<80247628>] [<8010a19c>] [<801033f0>] [<8012b460>]
 [<8011ed48>] [<8011ede8>] [<8011ee00>] [<80109938>] [<8011efd0>] ...
Warning (Oops_trace_line): garbage '...' at end of trace line ignored
Code: 8ea20080  8ea3007c  8e64000c <94850062> 00431023  0045102a  1040002c  8eb1000c  8c8200fc 

>>RA;  80217c2c <tcp_transmit_skb+534/610>
>>PC;  80206ce4 <ip_queue_xmit+26c/628>   <=====
Trace; 8021636c <tcp_rcv_established+874/8c4>
Trace; 801f3ee0 <net_tx_action+94/160>
Trace; 80217c2c <tcp_transmit_skb+534/610>
Trace; 80217b38 <tcp_transmit_skb+440/610>
Trace; 801ef2b0 <alloc_skb+168/278>
Trace; 8021aa50 <tcp_send_ack+100/114>
Trace; 8021b62c <tcp_delack_timer+1b8/234>
Trace; 80203978 <ip_rcv+27c/524>
Trace; 80236c68 <xprt_release_write+34/6c>
Trace; 8011773c <timer_bh+350/3d4>
Trace; 8011354c <bh_action+34/88>
Trace; 801f421c <net_rx_action+214/3d8>
Trace; 801133dc <tasklet_hi_action+cc/148>
Trace; 8011782c <do_timer+6c/c4>
Trace; 80112e8c <do_softirq+bc/188>
Trace; 8010631c <handle_IRQ_event+80/f4>
Trace; 80106630 <do_IRQ+f0/114>
Trace; 801065ec <do_IRQ+ac/114>
Trace; 8019609c <ll_galileo_irq+c/14>
Trace; 8012b808 <__alloc_pages+70/21c>
Trace; 8023b1e4 <rpc_release_task+214/240>
Trace; 80117448 <timer_bh+5c/3d4>
Trace; 801a7aec <serial_console_write+9c/288>
Trace; 801a7aec <serial_console_write+9c/288>
Trace; 8010dd00 <__call_console_drivers+68/94>
Trace; 8010dd8c <_call_console_drivers+60/70>
Trace; 8010debc <call_console_drivers+120/168>
Trace; 8010e2b8 <release_console_sem+4c/12c>
Trace; 8010e184 <printk+1f8/254>
Trace; 80247686 <mips_io_port_base+12da/2da4>
Trace; 80108c3c <do_page_fault+254/398>
Trace; 8012b808 <__alloc_pages+70/21c>
Trace; 80247628 <mips_io_port_base+127c/2da4>
Trace; 8010a19c <schedule+274/468>
Trace; 801033f0 <ret_from_sys_call+0/34>
Trace; 8012b460 <_alloc_pages+20/2c>
Trace; 8011ed48 <do_anonymous_page+118/154>
Trace; 8011ede8 <do_no_page+64/1c8>
Trace; 8011ee00 <do_no_page+7c/1c8>
Trace; 80109938 <nopage_tlbl+f4/fc>
Trace; 8011efd0 <handle_mm_fault+84/144>
Code;  80206cd8 <ip_queue_xmit+260/628>
00000000 <_PC>:
Code;  80206cd8 <ip_queue_xmit+260/628>
   0:   8ea20080  lw      v0,128(s5)
Code;  80206cdc <ip_queue_xmit+264/628>
   4:   8ea3007c  lw      v1,124(s5)
Code;  80206ce0 <ip_queue_xmit+268/628>
   8:   8e64000c  lw      a0,12(s3)
Code;  80206ce4 <ip_queue_xmit+26c/628>   <=====
   c:   94850062  lhu     a1,98(a0)   <=====
Code;  80206ce8 <ip_queue_xmit+270/628>
  10:   00431023  subu    v0,v0,v1
Code;  80206cec <ip_queue_xmit+274/628>
  14:   0045102a  slt     v0,v0,a1
Code;  80206cf0 <ip_queue_xmit+278/628>
  18:   1040002c  beqz    v0,cc <_PC+0xcc> 80206da4 <ip_queue_xmit+32c/628>
Code;  80206cf4 <ip_queue_xmit+27c/628>
  1c:   8eb1000c  lw      s1,12(s5)
Code;  80206cf8 <ip_queue_xmit+280/628>
  20:   8c8200fc  lw      v0,252(a0)

Kernel panic: Aiee, killing interrupt handler!

3 warnings issued.  Results may not be reliable.

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops3.in"

Unable to handle kernel paging request at virtual address 00000004, epc == 801289b8, ra == 8016b820
Oops in fault.c:do_page_fault, line 204:
$0 : 00000000 b0045400 00000000 00000000 81207600 81207608 000004c2 00000000
$8 : 813ff000 b0045401 00000000 00000000 00000000 00000000 00000065 87dcfd12
$16: 81207600 000000f0 00000001 812914e8 871ab960 8114f580 00000010 879278e0
$24: 00000000 2af984e0                   8719a000 8719bd38 00000000 8016b820
Hi : 00000000
Lo : 00000780
epc  : 801289b8    Not tainted
Status: b0045402
Cause : 0000800c
Process rpmq (pid: 666, stackpage=8719a000)
Stack: 8719bd60 00000000 00000000 8017065c 00000000 81205b20 8016b820 8016df98
       00000001 81205be0 8719bd60 8719bd60 00000000 879278e0 879278e0 8114f580
       871ab960 0000001f 00001000 871ab960 879278e0 8016d870 000001d2 871ab960
       00000004 8012b808 00001000 879278e0 00000000 879278e0 8114f580 871ab960
       8016e338 879279a0 8114f580 00000000 80121cc8 0000001f 00000006 8012b460
       8114f580 ...
Call Trace: [<8017065c>] [<8016b820>] [<8016df98>] [<8016d870>] [<8012b808>] [<8016e338>]
 [<80121cc8>] [<8012b460>] [<80121dcc>] [<80121dd8>] [<801226cc>] [<80122a0c>]
 [<801fb26c>] [<801fb088>] [<801136e4>] [<80123060>] [<80122f58>] [<8016716c>]
 [<80112e8c>] [<8010631c>] [<80131bec>] [<801319e8>] [<80106630>] [<801065ec>]
 [<801057e8>] [<8019604c>]

Code: 00000000  8d020004  8d030000 <ac620004> ac430000  8e040008  ac880004  ad040000  ad050004 


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops3.out"

ksymoops 2.4.0 on mips 2.4.17.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17/ (default)
     -m /boot/System.map-2.4.17 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel paging request at virtual address 00000004, epc == 801289b8, ra == 8016b820
$0 : 00000000 b0045400 00000000 00000000 81207600 81207608 000004c2 00000000
$8 : 813ff000 b0045401 00000000 00000000 00000000 00000000 00000065 87dcfd12
$16: 81207600 000000f0 00000001 812914e8 871ab960 8114f580 00000010 879278e0
$24: 00000000 2af984e0                   8719a000 8719bd38 00000000 8016b820
epc  : 801289b8    Not tainted
Using defaults from ksymoops -t elf32-tradbigmips -a mips:3000
Status: b0045402
Cause : 0000800c
Process rpmq (pid: 666, stackpage=8719a000)
Stack: 8719bd60 00000000 00000000 8017065c 00000000 81205b20 8016b820 8016df98
       00000001 81205be0 8719bd60 8719bd60 00000000 879278e0 879278e0 8114f580
       871ab960 0000001f 00001000 871ab960 879278e0 8016d870 000001d2 871ab960
       00000004 8012b808 00001000 879278e0 00000000 879278e0 8114f580 871ab960
       8016e338 879279a0 8114f580 00000000 80121cc8 0000001f 00000006 8012b460
       8114f580 ...
Call Trace: [<8017065c>] [<8016b820>] [<8016df98>] [<8016d870>] [<8012b808>] [<8016e338>]
 [<80121cc8>] [<8012b460>] [<80121dcc>] [<80121dd8>] [<801226cc>] [<80122a0c>]
 [<801fb26c>] [<801fb088>] [<801136e4>] [<80123060>] [<80122f58>] [<8016716c>]
 [<80112e8c>] [<8010631c>] [<80131bec>] [<801319e8>] [<80106630>] [<801065ec>]
 [<801057e8>] [<8019604c>]
Code: 00000000  8d020004  8d030000 <ac620004> ac430000  8e040008  ac880004  ad040000  ad050004 

>>RA;  8016b820 <nfs_create_request+d0/1e0>
>>PC;  801289b8 <kmem_cache_alloc+b8/1ac>   <=====
Trace; 8017065c <nfs_flush_file+58/a0>
Trace; 8016b820 <nfs_create_request+d0/1e0>
Trace; 8016df98 <nfs_pagein_inode+50/98>
Trace; 8016d870 <nfs_readpage_async+30/fc>
Trace; 8012b808 <__alloc_pages+70/21c>
Trace; 8016e338 <nfs_readpage+10c/154>
Trace; 80121cc8 <add_to_page_cache_unique+b0/c8>
Trace; 8012b460 <_alloc_pages+20/2c>
Trace; 80121dcc <page_cache_read+ec/11c>
Trace; 80121dd8 <page_cache_read+f8/11c>
Trace; 801226cc <generic_file_readahead+174/1ec>
Trace; 80122a0c <do_generic_file_read+24c/51c>
Trace; 801fb26c <ip_rcv+460/524>
Trace; 801fb088 <ip_rcv+27c/524>
Trace; 801136e4 <__run_task_queue+c8/e4>
Trace; 80123060 <generic_file_read+94/1a0>
Trace; 80122f58 <file_read_actor+0/74>
Trace; 8016716c <nfs_file_read+cc/ec>
Trace; 80112e8c <do_softirq+bc/188>
Trace; 8010631c <handle_IRQ_event+80/f4>
Trace; 80131bec <sys_read+d8/130>
Trace; 801319e8 <sys_lseek+98/b8>
Trace; 80106630 <do_IRQ+f0/114>
Trace; 801065ec <do_IRQ+ac/114>
Trace; 801057e8 <stack_done+1c/38>
Trace; 8019604c <ll_pri_enet_irq+c/14>
Code;  801289ac <kmem_cache_alloc+ac/1ac>
00000000 <_PC>:
Code;  801289ac <kmem_cache_alloc+ac/1ac>
   0:   00000000  nop
Code;  801289b0 <kmem_cache_alloc+b0/1ac>
   4:   8d020004  lw      v0,4(t0)
Code;  801289b4 <kmem_cache_alloc+b4/1ac>
   8:   8d030000  lw      v1,0(t0)
Code;  801289b8 <kmem_cache_alloc+b8/1ac>   <=====
   c:   ac620004  sw      v0,4(v1)   <=====
Code;  801289bc <kmem_cache_alloc+bc/1ac>
  10:   ac430000  sw      v1,0(v0)
Code;  801289c0 <kmem_cache_alloc+c0/1ac>
  14:   8e040008  lw      a0,8(s0)
Code;  801289c4 <kmem_cache_alloc+c4/1ac>
  18:   ac880004  sw      t0,4(a0)
Code;  801289c8 <kmem_cache_alloc+c8/1ac>
  1c:   ad040000  sw      a0,0(t0)
Code;  801289cc <kmem_cache_alloc+cc/1ac>
  20:   ad050004  sw      a1,4(t0)


2 warnings issued.  Results may not be reliable.

--KsGdsel6WgEHnImy--
