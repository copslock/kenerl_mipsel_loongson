Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2005 10:36:58 +0100 (BST)
Received: from web32507.mail.mud.yahoo.com ([IPv6:::ffff:68.142.207.217]:58493
	"HELO web32507.mail.mud.yahoo.com") by linux-mips.org with SMTP
	id <S8226150AbVEQJgm>; Tue, 17 May 2005 10:36:42 +0100
Received: (qmail 76785 invoked by uid 60001); 17 May 2005 09:36:33 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=MJzQhQTcW7MssD9Z5SrYxkHIQGyEb8eaPt1hiNhBVxu3vMUNubDbJ4Oc3IWqhJk8YFd9RcJjRNYNUih7QRf18qlv8SVHOA2Snlnw7rievAf3ATuPV4rsCljEQRAT1BDYcsyporpYIgXAv7DIOj4Ghwr5azszU+Xirhf1ku/asWg=  ;
Message-ID: <20050517093633.76783.qmail@web32507.mail.mud.yahoo.com>
Received: from [85.250.113.238] by web32507.mail.mud.yahoo.com via HTTP; Tue, 17 May 2005 02:36:32 PDT
Date:	Tue, 17 May 2005 02:36:32 -0700 (PDT)
From:	Michael Belamina <belamina1@yahoo.com>
Subject: 64 bit kernel for BCM1250
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <belamina1@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: belamina1@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

  I have built a 64 bit kernel for BCM1250.
  When the kernel is loaded and control is passed to
kernel_entry there is an exception:

CFE> boot -elf LinuxServer:vmlinux.64
Loader:elf Filesys:tftp Dev:eth2
File:LinuxServer:vmlinux.64 Options:(null)
Loading: 0xffffffff80100000/2162688
0xffffffff80310000/557344 Entry at 0xffffffff802d0000
Closing network.
Starting program at 0xffffffff802d0000
**Exception 8: EPC=FFFFFFFF802D003C, Cause=0000900C
(TLBMissWr)
                RA=FFFFFFFF9FC0086C,
VAddr=0000000000000000

        0  ($00) = 0000000000000000     AT ($01) =
0000000000000000
        v0 ($02) = 0000000000000080     v1 ($03) =
0000000000000003
        a0 ($04) = FFFFFFFF81F07FF0     a1 ($05) =
0000000000000000
        a2 ($06) = FFFFFFFF9FC008E8     a3 ($07) =
0000000043464531
        t0 ($08) = FFFFFFFF802D0000     t1 ($09) =
FFFFFFFF81F01DB8
        t2 ($10) = FFFFFFFFA0008000     t3 ($11) =
0000000000008000
        t4 ($12) = 0000000000000000     t5 ($13) =
FFFFFFFF81F18E60
        t6 ($14) = FFFFFFFF81F14A20     t7 ($15) =
000000000000000A
        s0 ($16) = FFFFFFFF9FC0086C     s1 ($17) =
FFFFFFFF81F01D20
        s2 ($18) = FFFFFFFF820036F8     s3 ($19) =
FFFFFFFF81F00000
        s4 ($20) = FFFFFFFF820036E8     s5 ($21) =
FFFFFFFFFFFFFFFF
        s6 ($22) = 0000000000000000     s7 ($23) =
0000000000000000
        t8 ($24) = 0000000010000000     t9 ($25) =
FFFFFFFF9FC46430
        k0 ($26) = FFFFFFFF81F22E28     k1 ($27) =
FFFFFFFF81F1F098
        gp ($28) = FFFFFFFF81F07FF0     sp ($29) =
FFFFFFFF82003550
        fp ($30) = 0000000000000000     ra ($31) =
FFFFFFFF9FC0086C



The code where the exception occurs is:
ffffffff802d0000 <kernel_entry>:
ffffffff802d0000:       400c6000        mfc0   
t0,c0_status
ffffffff802d0004:       3c011000        lui    
at,0x1000
ffffffff802d0008:       3421009f        ori    
at,at,0x9f
ffffffff802d000c:       01816025        or     
t0,t0,at
ffffffff802d0010:       398c001f        xori   
t0,t0,0x1f
ffffffff802d0014:       408c6000        mtc0   
t0,c0_status
ffffffff802d0018:       000000c0        sll    
zero,zero,0x3
ffffffff802d001c:       37bd000f        ori    
sp,sp,0xf
ffffffff802d0020:       3bbd000f        xori   
sp,sp,0xf
ffffffff802d0024:       3c0c0000        lui     t0,0x0
ffffffff802d0028:       3c010000        lui     at,0x0
ffffffff802d002c:       658c0000        daddiu 
t0,t0,0
ffffffff802d0030:       64210000        daddiu 
at,at,0
ffffffff802d0034:       000c603c        dsll32 
t0,t0,0x0
ffffffff802d0038:       0181602d        daddu  
t0,t0,at
ffffffff802d003c:       fd800000        sd     
zero,0(t0) 
ffffffff802d0040:       3c0d0000        lui     t1,0x0
ffffffff802d0044:       3c010000        lui     at,0x0
ffffffff802d0048:       65ad0000        daddiu 
t1,t1,0
ffffffff802d004c:       6421fff8        daddiu 
at,at,-8
ffffffff802d0050:       000d683c        dsll32 
t1,t1,0x0
ffffffff802d0054:       01a1682d        daddu  
t1,t1,at
ffffffff802d0058:       658c0008        daddiu 
t0,t0,8
ffffffff802d005c:       158dfffe        bne    
t0,t1,ffffffff802d0058 <__init_begin+0x58>
ffffffff802d0060:       fd800000        sd     
zero,0(t0)
ffffffff802d0064:       3c1c0000        lui     gp,0x0
ffffffff802d0068:       3c010000        lui     at,0x0


A 32 bit kernel loads and boot with no problems on the
same board. The board design is based on Sentosa. The
boot loader is CFE. The kernel version is 2.4.28

Please advice.
 
Thank,
  Michael




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
