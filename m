Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f86DFvE16545
	for linux-mips-outgoing; Thu, 6 Sep 2001 06:15:57 -0700
Received: from delta.ds2.pg.gda.pl (delta.ds2.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f86DFld16537
	for <linux-mips@oss.sgi.com>; Thu, 6 Sep 2001 06:15:52 -0700
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id PAA00046;
	Thu, 6 Sep 2001 15:17:12 +0200 (MET DST)
Date: Thu, 6 Sep 2001 15:17:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Stephen Frost <sfrost@snowman.net>
cc: linux-mips@fnet.fr, linux-mips@oss.sgi.com
Subject: Re: linux 2.4.8: The DECstation 5000/2x0 NVRAM module driver
In-Reply-To: <20010906083444.W11136@ns>
Message-ID: <Pine.GSO.3.96.1010906144712.28792C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 6 Sep 2001, Stephen Frost wrote:

> 	Welp, I've got a DECstation 5000/200 but no clue what (if any)
> 	NVRAM module it has.  How can I find out? :)  I havn't booted
> 	the thing up in quite a while so I'm not even sure it's exactly
> 	functional, but I've been looking for an excuse to play with it.

 An NVRAM module is placed in a memory slot, usually the 15th, as that's
what DEC supports.  It differs from RAM modules visibly -- it has two
green LEDs and a lithium battery (mine is orange, which makes it easily
recognizable; I'm not sure if the color is a rule). 

 In a configuration dump it's marked explicitly as a "Presto-NVR" module
if placed in the 15th slot.  This is an example of a `cnfg 3' output from
my /240 system -- you would need to type `cnfg 7' for your /200: 

>>cnfg 3
 3: KN03-AA  DEC      V5.1b    TCF0  (352 MB,   1 MB NVRAM)
                                     (enet: 08-00-2b-1e-3b-78)
                                     (SCSI = 7)
            ---------------------------------------------------
            DEV   PID                VID        REV    SCSI DEV
            ===== ================== ========== ====== ========

        dcache( 64 KB), icache( 64 KB)
        mem( 0):  a0000000:a1ffffff  ( 32 MB)
        mem( 1):  a2000000:a3ffffff  ( 32 MB)
        mem( 2):  a4000000:a5ffffff  ( 32 MB)
        mem( 3):  a6000000:a67fffff  (  8 MB)
        mem( 4):  a8000000:a87fffff  (  8 MB)
        mem( 5):  aa000000:aa7fffff  (  8 MB)
        mem( 6):  ac000000:ac7fffff  (  8 MB)
        mem( 7):  ae000000:afffffff  ( 32 MB)
        mem( 8):  b0000000:b1ffffff  ( 32 MB)
        mem( 9):  b2000000:b3ffffff  ( 32 MB)
        mem(10):  b4000000:b5ffffff  ( 32 MB)
        mem(11):  b6000000:b7ffffff  ( 32 MB)
        mem(12):  b8000000:b9ffffff  ( 32 MB)
        mem(13):  ba000000:bbffffff  ( 32 MB)
        mem(14):  bc000000:bc0fffff  (  1 MB)     Presto-NVR

        mem(14):  valid, batt OK, unarmed
>>

 Note that there exists a TURBOchannel NVRAM module, namely the PMTNV-AA. 
This driver doesn't intend to support it. 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
