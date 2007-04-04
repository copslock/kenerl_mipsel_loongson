Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 13:42:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:39325 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20021827AbXDDMm5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Apr 2007 13:42:57 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l34Cgu8k031244
	for <linux-mips@linux-mips.org>; Wed, 4 Apr 2007 13:42:57 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l34CgudS031243
	for linux-mips@linux-mips.org; Wed, 4 Apr 2007 13:42:56 +0100
Date:	Wed, 4 Apr 2007 13:42:56 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Recently, on the other side of the fence ...
Message-ID: <20070404124256.GA31237@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14788
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Date:	Sat, 31 Mar 2007 02:01:36 +0300
From:	Oleksandr Tymoshenko <gonzo@univ.kiev.ua>
To:	freebsd-mips@freebsd.org, freebsd-embedded@freebsd.org
Subject: FreeBSD/MIPS project status update

	On behalf of FreeBSD/MIPS team I'm proud to announce that
project has reached single-user stage. On the moment FreeBSD/MIPS
runs only in malta board emulation mode of GXemul though adm5120
support is on it's way and people with real MIPS-based hardware
can start playing with latest repo snapshot bringing FreeBSD on it.

Many thanks to all who contributed with their time, efforts and
experience. Especially to #bsdmips crowd for patience to newbies :)

Attached mips.txt is a "recording" of sample GXemul session.
Current p4 repo snapshot: http://kanar.ci0.org/mips2.tar.gz
Check http://wiki.freebsd.org/FreeBSD/mips for sample build script
P4 URL: 
http://perforce.freebsd.org/depotTreeBrowser.cgi?FSPC=//depot/projects/mips2/...

-- 
gonzo


GXemul 0.4.1    Copyright (C) 2003-2006  Anders Gavare
Read the source code and/or documentation for other Copyright messages.

Simple setup...
    net: simulating 10.0.0.0/8 (max outgoing: TCP=100, UDP=100)
        simulated gateway: 10.0.0.254 (60:50:40:30:20:10)
            using nameserver 192.168.0.1
    machine "default":
        memory: 64 MB
        cpu0: 4Kc (I+D = 16+16 KB)
        machine: MALTA (evbmips, little endian)
        bootstring: kernel
        diskimage: /usr/home/gonzo/FreeBSD/mips.img
            IDE DISK id 0, read/write, 512 MB (1048576 sectors)
        loading /tftpboot/kernel
        starting cpu0 at 0x80127420 (gp=0x8033e180)
-------------------------------------------------------------------------------

GXemul> c
entry: mips_init()
  picache_stride    = 4096
  picache_loopcount = 4
  pdcache_stride    = 4096
  pdcache_loopcount = 4
mips_cache_ops.mco_pdcache_wbinv_all  == 0x802dcdb0
Exception vector at 80000000 almost out of space
Kernel page table maps 16384 4K pages and is 511K
KDB: debugger backends: ddb
KDB: current backend: ddb
cp: (null)
cannot determine clock frequency, defaulting to 10MHz
Copyright (c) 1992-2006 The FreeBSD Project.
Copyright (c) 1979, 1980, 1983, 1986, 1988, 1989, 1991, 1992, 1993, 1994
	The Regents of the University of California. All rights reserved.
FreeBSD 7.0-CURRENT #65: Fri Mar 30 19:03:48 EEST 2007
    gonzo@jeeves.bluezbox.com:/home/gonzo/FreeBSD/mips.build/mips/home/gonzo/FreeBSD/p4/mips2/src/sys/MALTA
cpu0: MIPS Technologies processor v1.128
  MMU: Standard TLB, 16 entries
  L1 i-cache: 2 ways of 512 sets, 16 bytes per line
  L1 d-cache: 2 ways of 512 sets, 16 bytes per line
clock0: <Generic MIPS32 ticker> on motherboard
clock0: [FAST]
gt0: <GT64120 chip> on motherboard
pcib0: <GT64120 PCI bridge> on gt0
[ 8259: TODO: Level triggered (MCA bus) ]
[ 8259: WARNING: Bit 2 set ]
[ 8259: TODO: Level triggered (MCA bus) ]
[ 8259: WARNING: Bit 2 set ]
pcib0: [FAST]
pci0: <PCI bus> on pcib0
uart0: <8250 or 16450 or compatible> on obio0
uart0: [FAST]
uart0: console (115200,n,8,1)
pci0: <bridge, PCI-ISA> at device 9.0 (no driver attached)
atapci0: <Intel PIIX4 UDMA33 controller> port 0x1f0-0x1f7,0x3f6,0x170-0x177,0x376 at device 9.1 on pci0
ata0: <ATA channel 0> on atapci0
ata0: WARNING - DMA allocation failed, disabling DMA
ata1: <ATA channel 1> on atapci0
ata1: WARNING - DMA allocation failed, disabling DMA
Timecounter "MIPS32" frequency 10000000 Hz quality 800
Timecounters tick every 10.000 msec
ad0: 514MB <mips.img 1.0> at ata0-master PIO4
Trying to mount root from ufs:ad0s1a
warning: no time-of-day clock registered, system time will not be set accurately
Enter full pathname of shell or RETURN for /bin/sh: 
# mount -o rw /
# hostname mips.bluezbox.com
# uname -a
FreeBSD mips.bluezbox.com 7.0-CURRENT FreeBSD 7.0-CURRENT #65: Fri Mar 30 19:03:48 EEST 2007     gonzo@jeeves.bluezbox.com:/home/gonzo/FreeBSD/mips.build/mips/home/gonzo/FreeBSD/p4/mips2/src/sys/MALTA  mips
# cd /root
# ls
.cshrc		.profile	args.c		hello.c
.login		Makefile	hello		signal.c
# cat Makefile
CFLAGS=-msoft-float -G0 -mabicalls -EL -Wl,-EL -static -march=mips32
CC=cc

all: hello signal args

hello: hello.c
	$(CC) $(CFLAGS) -o hello hello.c

signal: signal.c
	$(CC) $(CFLAGS) -o signal signal.c

args: args.c
	$(CC) $(CFLAGS) -o args args.c

clean: 
	rm -f signal hello args
# cat hello.c
#include <stdio.h>

int main(int argc, char * argv[])
{
        printf("Hello world\n");
}
# cat args.c
#include <stdio.h>

int main(int argc, char * argv[])
{
	int i ;

	printf("Arguments: %d\n", argc);
	for(i = 0; i < argc; i++) {
		printf("#%d == '%s'\n", i, argv[i]);
	}
}
# cat signal.c
#include <stdio.h>
#include <signal.h>

void sig_int(int signum)
{
	printf("Interrupted!\n");
	exit(0);
}

void sig_general(int signum)
{
	printf("Signal: %d!\n", signum);
}

int main(int argc, char * argv[])
{
	int i = 0; 
	signal(SIGINT, sig_int);
	signal(SIGUSR1, sig_general);
	signal(SIGUSR2, sig_general);
        while(i < 10) {
		sleep(1);
		if(i % 2)
			kill(getpid(), SIGUSR1);
		else
			kill(getpid(), SIGUSR2);
		printf(">> %d\n", i++);
	}
	kill(getpid(), SIGINT);
	i = 0;
        while(i < 10) {
		printf(">> %d\n", i++);
		sleep(1);
	}
}
# make
cc -msoft-float -G0 -mabicalls -EL -Wl,-EL -static -march=mips32 -o signal signal.c
cc -msoft-float -G0 -mabicalls -EL -Wl,-EL -static -march=mips32 -o args args.c
# make clean
rm -f signal hello args
# make
cc -msoft-float -G0 -mabicalls -EL -Wl,-EL -static -march=mips32 -o hello hello.c
cc -msoft-float -G0 -mabicalls -EL -Wl,-EL -static -march=mips32 -o signal signal.c
cc -msoft-float -G0 -mabicalls -EL -Wl,-EL -static -march=mips32 -o args args.c
# ls -la
total 2340
drwxr-xr-x   2 root  wheel     512 Mar 30 19:41 .
drwxr-xr-x  18 root  wheel     512 Mar 27 13:27 ..
-rw-r--r--   2 root  wheel     801 Mar 27 13:27 .cshrc
-rw-r--r--   1 root  wheel     293 Mar 27 13:27 .login
-rw-r--r--   2 root  wheel     251 Mar 27 13:27 .profile
-rw-r--r--   1 root  wheel     283 Mar 30 16:09 Makefile
-rwxr-xr-x   1 root  wheel  367585 Mar 30 19:40 args
-rw-r--r--   1 root  wheel     173 Mar 30 19:14 args.c
-rwxr-xr-x   1 root  wheel  367586 Mar 30 19:40 hello
-rw-r--r--   1 root  wheel      91 Mar 27 18:17 hello.c
-rwxr-xr-x   1 root  wheel  372613 Mar 30 19:40 signal
-rw-r--r--   1 root  wheel     552 Mar 27 17:42 signal.c
# file hello args signal
hello:  ELF 32-bit LSB executable, MIPS, version 1 (FreeBSD), for FreeBSD 7.0 (700018), statically linked, for FreeBSD 7.0 (700018), not stripped
args:   ELF 32-bit LSB executable, MIPS, version 1 (FreeBSD), for FreeBSD 7.0 (700018), statically linked, for FreeBSD 7.0 (700018), not stripped
signal: ELF 32-bit LSB executable, MIPS, version 1 (FreeBSD), for FreeBSD 7.0 (700018), statically linked, for FreeBSD 7.0 (700018), not stripped
# ./hello
Hello world
# ./args this is a test
Arguments: 5
#0 == './args'
#1 == 'this'
#2 == 'is'
#3 == 'a'
#4 == 'test'
# ./signal
Signal: 31!
>> 0
Signal: 30!
>> 1
Signal: 31!
>> 2
Signal: 30!
>> 3
Signal: 31!
>> 4
Signal: 30!
>> 5
Signal: 31!
>> 6
Signal: 30!
>> 7
Signal: 31!
>> 8
Signal: 30!
>> 9
Interrupted!
# who am i
who: /var/run/utmp: No such file or directory
# id
uid=0(root) gid=0(wheel) groups=0(wheel)
# ifconfig -a
lo0: flags=8008<LOOPBACK,MULTICAST> mtu 16384
# ifconfig lo0 127.0.0.1
# ifconfig -a
lo0: flags=8049<UP,LOOPBACK,RUNNING,MULTICAST> mtu 16384
	inet 127.0.0.1 netmask 0xff000000 
# ping -c 10 127.0.0.1
PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: icmp_seq=0 ttl=64 time=2.470 ms
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=1.646 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=1.645 ms
64 bytes from 127.0.0.1: icmp_seq=3 ttl=64 time=1.643 ms
64 bytes from 127.0.0.1: icmp_seq=4 ttl=64 time=1.645 ms
64 bytes from 127.0.0.1: icmp_seq=5 ttl=64 time=1.641 ms
64 bytes from 127.0.0.1: icmp_seq=6 ttl=64 time=1.646 ms
64 bytes from 127.0.0.1: icmp_seq=7 ttl=64 time=1.643 ms
64 bytes from 127.0.0.1: icmp_seq=8 ttl=64 time=1.643 ms
64 bytes from 127.0.0.1: icmp_seq=9 ttl=64 time=1.645 ms

--- 127.0.0.1 ping statistics ---
10 packets transmitted, 10 packets received, 0% packet loss
round-trip min/avg/max/stddev = 1.641/1.727/2.470/0.248 ms
# halt -p
Waiting (max 60 seconds) for system process `vnlru' to stop...done
Waiting (max 60 seconds) for system process `bufdaemon' to stop...done
Waiting (max 60 seconds) for system process `syncer' to stop...
Syncing disks, vnodes remaining...0 
