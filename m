Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2B7mJE23560
	for linux-mips-outgoing; Sun, 10 Mar 2002 23:48:19 -0800
Received: from gda-server ([202.88.152.146])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2B7mB923556
	for <linux-mips@oss.sgi.com>; Sun, 10 Mar 2002 23:48:11 -0800
Received: from [192.168.0.186] by gda-server
  (ArGoSoft Mail Server, Version 1.5 (1.5.0.8)); Mon, 11 Mar 2002 12:20:28 
Message-ID: <3C8CFB45.9E749117@gdatech.co.in>
Date: Tue, 12 Mar 2002 00:15:25 +0530
From: santhosh <ps.santhosh@gdatech.co.in>
Organization: gdatech
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com, gmo <gmo@broadcom.com>,
   mhuang <mhuang@broadcom.com>, mpl <mpl@broadcom.com>,
   jtardo <jtardo@broadcom.com>, ttruong <ttruong@broadcom.com>,
   kwalker <kwalker@broadcom.com>, "nitin.borle" <nitin.borle@broadcom.com>
Subject: Linux-mips porting issues
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi All ...

      Subj: Linux-Porting  issue
Here I ported Linux -mips on  BCM1250 board(Broadcom)  had occurred
some error which showed below


CFE>Boot -z -elf 192.168.200.150:zimage
andkishore_rane: Loader:elf Filesys:tftp Dev:eth0
File:192.168.200.150:zimage Optionsnull)
Loading: 0x80100000/1342312 0x80248000/2297856 0x80479000/343232 Entry
at 0x8010
047c
*** command status = 0

nandkishore_rane: CFE> go
Closing network.
Starting program at 0x8010047c
RUN! CPU revision is: 01040101
Linux version 2.4.17sb20020206 (root@gda_Santhosh) (gcc version 3.0.1
with SiByt
e modifications) #1 SMP Fri Mar 8 11:26:50 IST 2002
This kernel optimized for board runs with CFE
Determined physical RAM map:
memory: 0026e000 @ 00000000 (usable)
memory: 01987748 @ 004788b8 (usable)
memory: 00000000 @ 01f04000 (usable)
memory: 0020a8b8 @ 0026e000 (reserved)
Initial ramdisk at: 0x8026e000 (2140344 bytes)
On node 0 totalpages: 7680
zone(0): 7680 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram0
CPU revision is: 01040101
Linux version 2.4.17sb20020206 (root@gda_Santhosh) (gcc version 3.0.1
with SiByt
e modifications) #1 SMP Fri Mar 8 11:26:50 IST 2002


    Then hung ...........

with regards
santhosh
