Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 May 2004 02:42:00 +0100 (BST)
Received: from web13601.mail.yahoo.com ([IPv6:::ffff:216.136.175.112]:59550
	"HELO web13601.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8226041AbUE2Blq>; Sat, 29 May 2004 02:41:46 +0100
Message-ID: <20040529014144.37378.qmail@web13601.mail.yahoo.com>
Received: from [63.150.34.78] by web13601.mail.yahoo.com via HTTP; Fri, 28 May 2004 18:41:44 PDT
Date: Fri, 28 May 2004 18:41:44 -0700 (PDT)
From: SCR <king_903@yahoo.com>
Subject: mips-4kc pci issue
To: linux-mips@linux-mips.org
Cc: king_903@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <king_903@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: king_903@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello,
I am new to the list, I am having problem with PCI
buscard. first the kernel I am using 2.4.18, and CPU
is
ADMTECK 5120 4KC core. When there is no card installed
I can read and write pci host bridge registers, but
when I install the card all the registers gets
corropted on the host side and target gets unreliable
registers value. This pci bus does not have a IDSEL
signal going to the target. Also I read different
value from the bus if I pluging different card. Cards
have a TI and Atheros chipset.
First Reg value without any card:

00-51201317 04-04000007 08-06000000 0c-00008000
10-f0000000
14-ff000001 18-00000000 1c-00000000 20-00000000
24-00000000
28-00000000 2c-00000000 30-00000000 34-00000000
38-00000000
3c-00000000
Found 00:00 [1317/5120] 000600 00
/ # more /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 1317:5120 (rev 0).
      Master Capable.  Latency=128.
      Non-prefetchable 32 bit memory at 0xf0000000
[0xffffffff].
      I/O at 0xff000000 [0xfeffffff].
Sencond Conf. Reg when WG511T pluged in.
Scanning bus 00, I/O 0x11500000:0x115ffff0, Mem
0x11400000:0x11500000
00:00.0 Class 0013: 1317:0000 (rev 8c)
        Mem at 0x11400000 [size=0xf7f0]
        Mem at 0x1140f7f0 [size=0xf7f0]
        Mem at 0x11420000 [size=0xf7f0]
        Mem at 0x1142f800 [size=0xf7e0]
00:02.0 Class 0200: 2000:0013 (rev 01)
        Mem at 0x11440000 [size=0x10000]
Scanning bus 00
00-00000044 04-00000804 08-02900000 0c-0000080c
10-00000810
14-00000814 18-00000000 1c-0000081c 20-00000000
24-00000824
28-00000000 2c-0000082c 30-4b001385 34-00000834
38-00000044
3c-0000083c
Found 00:00 [0800/0000] 000013 0a
PCI: device 00:00.0 has unknown header type 0a,
ignoring.
00-0013168c 04-02900000 08-02000001 0c-00000810
10-00000000
14-00000000 18-00000000 1c-00000000 20-00000000
24-00000000
28-00005001 2c-4b001385 30-00000000 34-00000044
38-00000000
3c-1c0a0100
Found 00:10 [168c/0013] 000200 00

/ # more /proc/pci
PCI devices found:
  Bus  0, device   2, function  0:
    Class 0200: PCI device 168c:0013 (rev 1).
      IRQ 6.
      Master Capable.  Latency=168.  Min Gnt=10.Max
Lat=28.
      Non-prefetchable 32 bit memory at 0x0 [0xffff].


Now with TI chipset:
Autoconfig PCI channel 0x801c360c
Scanning bus 00, I/O 0x11500000:0x115ffff0, Mem
0x11400000:0x11500000
00:00.0 Class 0600: 1317:5120
        Mem unavailable -- skipping
        I/O unavailable -- skipping
00:02.0 Class 0280: 104c:9066
        Mem at 0x11400000 [size=0x2000]
        Mem at 0x11420000 [size=0x20000]
00-51201317 04-04000007 08-06000000 0c-00008000
10-f0000000
14-ff000001 18-00000000 1c-00000000 20-00000000
24-00000000
28-00000000 2c-00000000 30-00000000 34-00000000
38-00000000
3c-00000000
Found 00:00 [1317/5120] 000600 00
00-9066104c 04-02100007 08-02800000 0c-00008004
10-00000000
14-00000000 18-00000000 1c-00000000 20-00000000
24-00000000
28-00001c02 2c-12001259 30-00000000 34-00000040
38-00000000
3c-00000100
Found 00:10 [104c/9066] 000280 00

/ # more /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 1317:5120 (rev 0).
      Master Capable.  Latency=128.
      Non-prefetchable 32 bit memory at 0xf0000000
[0xffffffff].
      I/O at 0xff000000 [0xfeffffff].
  Bus  0, device   2, function  0:
    Class 0280: PCI device 104c:9066 (rev 0).
      IRQ 6.
      Master Capable.  Latency=128.
      Non-prefetchable 32 bit memory at 0x0 [0x1fff].
      Non-prefetchable 32 bit memory at 0x0 [0x1ffff].

My question Why I am getting this behaviour, I tried
to read and write from the registers with card pluged
in but not much luck either, I would appretiate your
help.
Please let me know what I could be missing.

Thanks,
_Shahrom 



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
