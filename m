Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Sep 2013 17:13:04 +0200 (CEST)
Received: from frisell.zx2c4.com ([192.95.5.64]:56589 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6815821Ab3IBPNBujxVQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 2 Sep 2013 17:13:01 +0200
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :date:message-id:subject:from:to:content-type; s=mail; bh=pn71+H
        tqo+fXlRNLjmspFbOA9D4=; b=dRLE0j4pes+/rarV4mU8lltmm66gpZwLiPm2sh
        pwuUztPHLMkn390pvta/uqfANxo6BqNdXJO39xJ8bnm0fq5/ElfbPmb0QMZ8dfjo
        TVSEC2QGkcZ5GgIo+VFfivnSjLchhRZLf3YFgu66OPTUAaT4pymcJydKVt917sOn
        BhDM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=zx2c4.com; h=mime-version
        :date:message-id:subject:from:to:content-type; q=dns; s=mail; b=
        LDvxWRAHe/6DnisEj+U5g0iNOUZmFmlZXmAML09C78sMe8L+kDyDLSVyH9l+OjFi
        zQedeALxjiFz+u/6xp4sBXv0fMRIvgxYtSpERCl8wNmvb/cdCWie5UUfUSyDKhST
        0Z1PmtZFWvo2w0wo4aKaQistg/EeYp/ZMnBAgxvUq1M=
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id aaa1a455;
        TLS version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=YES;
        for <linux-mips@linux-mips.org>;
        Mon, 2 Sep 2013 15:12:46 +0000 (UTC)
Received: by mail-vc0-f171.google.com with SMTP id ij15so3032471vcb.2
        for <linux-mips@linux-mips.org>; Mon, 02 Sep 2013 08:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=qX8Dxyo/uu9YD8GSiZat/IhMhxnuD697ijq1NrRn//Q=;
        b=Cpk4+JBeVoHfhWlZrKww63YxyNLUOSHKwk3/tAcALR3RhF4Sbn3kE4omdx1o0meV3e
         GVIrgIrDVlPq6+35H/6BsKj5diYGVR1m6qHRtHrNep3XcySd9ZZD5CZpyXhm8o7Rthgd
         HLJzL0+IdWQr6+IF+fCt8pKgV1liQMUm2hmmj/q8ob7sVKnuiNmymlJ2rMKHvxzj1/mO
         LTWlVnwr3nVAtmHfILiFEtVgDQi2+9dmtmOZvBA+BIcwyjydGLwszCCL5rXMRL4ebytZ
         mbtDxCbhhniMj4WhjW1yP3W4oP2R5YTXkPOxnQLWUrR5QEnZR61oFdKDOOqtmvqh9Nws
         vN0g==
MIME-Version: 1.0
X-Received: by 10.58.211.227 with SMTP id nf3mr6299363vec.20.1378134769574;
 Mon, 02 Sep 2013 08:12:49 -0700 (PDT)
Received: by 10.52.233.69 with HTTP; Mon, 2 Sep 2013 08:12:49 -0700 (PDT)
Date:   Mon, 2 Sep 2013 17:12:49 +0200
Message-ID: <CAHmME9ppVfYd6u+9iMFeTO1s11okAJ7Jm=hp+iE3FdLTTcCNJA@mail.gmail.com>
Subject: irq 117 on ubiquiti edge router lite
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37738
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

This in dmesg:

[23445.403750] eth1: Link down
[23458.403670] eth1: 1000 Mbps Full duplex, port  1, queue  1
[23458.783708] Port 1 receive error code 13, packet dropped
[26480.721940] eth1: Link down
[26531.771659] eth1: 1000 Mbps Full duplex, port  1, queue  1
[26579.791046] eth1: Link down
[26588.800965] eth1: 1000 Mbps Full duplex, port  1, queue  1
[26819.609340] eth1: Link down
[31274.667444] eth1: 1000 Mbps Full duplex, port  1, queue  1
[31322.667065] eth1: Link down
[31330.667067] eth1: 1000 Mbps Full duplex, port  1, queue  1
[32164.811581] eth1: Link down
[57045.491647] eth1: 1000 Mbps Full duplex, port  1, queue  1
[57093.491287] eth1: Link down
[57101.491285] eth1: 1000 Mbps Full duplex, port  1, queue  1
[66948.037898] eth0: Link down
[66950.037930] eth0: 1000 Mbps Full duplex, port  0, queue  0
[80961.645249] eth1: Link down
[80964.645273] eth1: 1000 Mbps Full duplex, port  1, queue  1
[81012.644926] eth1: Link down
[81020.644939] eth1: 1000 Mbps Full duplex, port  1, queue  1
[81952.639152] eth1: Link down
[81955.638949] eth1: 1000 Mbps Full duplex, port  1, queue  1
[81967.638844] eth1: Link down
[81968.638918] eth1: 1000 Mbps Full duplex, port  1, queue  1
[82002.638594] eth1: Link down
[82011.638596] eth1: 1000 Mbps Full duplex, port  1, queue  1
[83814.236186] eth0: Link down
[83816.236256] eth0: 1000 Mbps Full duplex, port  0, queue  0
[83817.191824] irq 117: nobody cared (try booting with the "irqpoll" option)
[83817.191846] CPU: 0 PID: 30079 Comm: syslog-ng Not tainted 3.11.0-rc7 #1
[83817.191852] Stack : 0000000000000000 0000000000000000
0000000000000000 0000000000000000
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 800000041bc7b9b0 0000000000000000 ffffffff8111f9bc
          0000000000000000 0000000000000000 0000000000000000 0000000000000000
          0000000000000000 ffffffff8111f9bc 0000000000000000 0000000000000000
          ...
[83817.191979] Call Trace:[<ffffffff8111f9bc>] 0xffffffff8111f9bc
[83817.191993] [<ffffffff8111f9bc>] 0xffffffff8111f9bc
[83817.191999] [<ffffffff817b76c0>] 0xffffffff817b76c0
[83817.192005] [<ffffffff811ab494>] 0xffffffff811ab494
[83817.192011] [<ffffffff811abaac>] 0xffffffff811abaac
[83817.192017] [<ffffffff811a8df4>] 0xffffffff811a8df4
[83817.192023] [<ffffffff811a8f88>] 0xffffffff811a8f88
[83817.192029] [<ffffffff811ac500>] 0xffffffff811ac500
[83817.192035] [<ffffffff811a8514>] 0xffffffff811a8514
[83817.192040] [<ffffffff8111d588>] 0xffffffff8111d588
[83817.192046] [<ffffffff8110470c>] 0xffffffff8110470c
[83817.192052] [<ffffffff8111b82c>] 0xffffffff8111b82c
[83817.192059] [<ffffffff81222f98>] 0xffffffff81222f98
[83817.192065] [<ffffffff8117dd30>] 0xffffffff8117dd30
[83817.192071] [<ffffffff81222da0>] 0xffffffff81222da0
[83817.192077] [<ffffffff811755a0>] 0xffffffff811755a0
[83817.192082] [<ffffffff81222db4>] 0xffffffff81222db4
[83817.192089] [<ffffffff81222fec>] 0xffffffff81222fec
[83817.192094] [<ffffffff81120588>] 0xffffffff81120588
[83817.192100] [<ffffffff81128204>] 0xffffffff81128204

[83817.192109] handlers:
[83817.192115] [<ffffffff815a88d8>] 0xffffffff815a88d8
[83817.192120] Disabling IRQ #117
[83817.193987] Port 0 receive error code 13, packet dropped
[94879.162304] eth0: Link down
[94881.162294] eth0: 1000 Mbps Full duplex, port  0, queue  0
[99150.294267] eth1: Link down
[99157.294237] eth1: 1000 Mbps Full duplex, port  1, queue  1
[99205.293905] eth1: Link down
[99214.293847] eth1: 1000 Mbps Full duplex, port  1, queue  1
[113454.590455] eth0: Link down
[113457.590427] eth0: 1000 Mbps Full duplex, port  0, queue  0
[115977.672677] eth1: Link down
[150787.491677] eth1: 1000 Mbps Full duplex, port  1, queue  1
[150835.491359] eth1: Link down
[150843.491285] eth1: 1000 Mbps Full duplex, port  1, queue  1
[168703.246601] eth0: Link down
[168707.246587] eth0: 1000 Mbps Full duplex, port  0, queue  0
[184439.144289] eth0: Link down
[184441.144268] eth0: 1000 Mbps Full duplex, port  0, queue  0
[217255.030944] eth1: Link down
[228842.841401] eth0: Link down
[228845.841372] eth0: 1000 Mbps Full duplex, port  0, queue  0
[252201.801043] eth1: 1000 Mbps Full duplex, port  1, queue  1
[252249.800711] eth1: Link down
[252258.800656] eth1: 1000 Mbps Full duplex, port  1, queue  1
[252258.980955] Port 1 receive error code 13, packet dropped
[252795.707110] eth0: Link down
[252799.707021] eth0: 1000 Mbps Full duplex, port  0, queue  0
[253201.704256] eth0: Link down
[253203.704327] eth0: 1000 Mbps Full duplex, port  0, queue  0
[255807.686358] eth0: Link down
[255809.686399] eth0: 1000 Mbps Full duplex, port  0, queue  0
[290130.527772] eth1: Link down
[299955.388776] eth0: Link down
[299958.388747] eth0: 1000 Mbps Full duplex, port  0, queue  0
[319732.369558] eth1: 1000 Mbps Full duplex, port  1, queue  1
[319780.369196] eth1: Link down
[319789.369144] eth1: 1000 Mbps Full duplex, port  1, queue  1
[330728.215335] eth0: Link down
[330731.215319] eth0: 1000 Mbps Full duplex, port  0, queue  0
[345111.118886] eth0: Link down
[345114.118903] eth0: 1000 Mbps Full duplex, port  0, queue  0
[345114.124123] Port 0 receive error code 13, packet dropped


martino zx2c4 # uname -a
Linux martino 3.11.0-rc7 #1 SMP Tue Aug 27 15:08:21 CEST 2013 mips64
Cavium Octeon+ V0.1 UBNT_E100 (CN5020p1.1-500-SCP) GNU/Linux
martino zx2c4 # cat /proc/cpuinfo
system type             : UBNT_E100 (CN5020p1.1-500-SCP)
machine                 : Unknown
processor               : 0
cpu model               : Cavium Octeon+ V0.1
BogoMIPS                : 1000.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 64
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 2, address/irw mask: [0x0ffc, 0x0ffb]
isa                     : mips1 mips2 mips3 mips4 mips5 mips64r2
ASEs implemented        :
shadow register sets    : 1
kscratch registers      : 0
core                    : 0
VCED exceptions         : not available
VCEI exceptions         : not available

processor               : 1
cpu model               : Cavium Octeon+ V0.1
BogoMIPS                : 1000.00
wait instruction        : yes
microsecond timers      : yes
tlb_entries             : 64
extra interrupt vector  : yes
hardware watchpoint     : yes, count: 2, address/irw mask: [0x0ffc, 0x0ffb]
isa                     : mips1 mips2 mips3 mips4 mips5 mips64r2
ASEs implemented        :
shadow register sets    : 1
kscratch registers      : 0
core                    : 1
VCED exceptions         : not available
VCEI exceptions         : not available
