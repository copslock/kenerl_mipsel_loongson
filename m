Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Oct 2016 06:51:17 +0200 (CEST)
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:59952 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990864AbcJQEvKRXTbf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Oct 2016 06:51:10 +0200
Received: from resomta-ch2-08v.sys.comcast.net ([69.252.207.104])
        by resqmta-ch2-06v.sys.comcast.net with SMTP
        id vzt9bsmoP2Nhqvzt9bbIJj; Mon, 17 Oct 2016 04:51:03 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-08v.sys.comcast.net with SMTP
        id vzt8bzfk6930Jvzt8btyYP; Mon, 17 Oct 2016 04:51:03 +0000
To:     Linux/MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Joshua Kinard <kumba@gentoo.org>
Subject: IP27's I/O addressing
Message-ID: <80537976-d7f9-790e-5c76-6b6063fb059e@gentoo.org>
Date:   Mon, 17 Oct 2016 00:50:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNsWlPqxGDHkTLWTP91T42NRLLTMKS6uOaDN+iBnG42k3A/c7tFWfugrpjwiyxX77QsGe8em3ZlvCqwgptyiSSrB+MqOxtISh059vnFyBOFPFjOv3i+K
 XUMoU+EAeBjYyojsuClMD287VwB7xbCztg8E3+mTo02Zx0ASJmGAVJJrysaYmA49W1cHotsvzypXcQOFv0GBxVPMOUS6ulv0zT5T0g/dIGU316hKEZUiQ8XB
 sVYZqhPkEJZtsetu4Q0iRA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55439
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

Building off my last message on IP27's issues with PCI_PROBE_ONLY, getting
annoyed at IOC3, I discovered that an SGI-branded Tigon-II 1Gbps ethernet card
works fine in the Octane (called an AceNIC).  However, the exact same card does
not play well in an IP27 because attempting to probe the card results in a data
bus error:

[   41.779116] PCI host bridge to bus 0000:00
[   41.827659] pci_bus 0000:00: root bus resource [mem
0x920000000b200000-0x920000000b9fffff]
[   41.927164] pci_bus 0000:00: root bus resource [io
0x920000000ba00000-0x920000000bbfffff]
[   42.026636] pci_bus 0000:00: root bus resource [bus 00-ff]
[   42.093667] acenic.c: v0.92 08/05/2002  Jes Sorensen, linux-acenic@SunSITE.dk
[   42.093667]
http://home.cern.ch/~jes/gige/acenic.html
[   42.268604] PCI: Enabling device 0000:00:02.0 (0000 -> 0002)
[   42.336720] 0000:00:02.0: SGI AceNIC Gigabit Ethernet at 0x00400000, irq 1
[   42.429812] Slice B got dbe at 0xa80000000047a738
[   42.484468] Hub information:
[   42.519032] ERR_INT_PEND = 0x100000
[   42.560925] Hub has valid error information:
[   42.612246] Overrun is set.   Error stack may contain additional information.
[   42.697079] Hub error address is 02400208
[   42.745258] Incoming message command 0x9e
[   42.793435] Supplemental field of incoming message is 0x7f8
[   42.860464] T5 Rn (for RRB only) is 0x0
[   42.906547] Error type is Uncached Partial Read PRERR
[   42.967312] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.2-mipsgit-20161016 #1
[   43.055275] task: a8000000fe69ca80 task.stack: a8000000fe6a0000
[   43.126487] $ 0   : 0000000000000000 ffffffff94005ce0 9200000000400000
0000000000000004
[   43.222841] $ 4   : 000000000080a0b8 ffffffff94005ce1 0000000000000002
0000000000dd0000
[   43.319195] $ 8   : 0000000000dd0000 0000000000000000 00000000000000a5
0000000000dd0000
[   43.415550] $12   : 0000000000d90000 0000000000dd0000 0000000000dd0000
0000000000000020
[   43.511905] $16   : a8000001fc7a7000 0000000000000000 a8000001fcfd3098
a8000001fcfd3000
[   43.608260] $20   : a800000000de0000 0000000000000000 a800000000890000
a8000000008544bc
[   43.704614] $24   : 0000000000d90000 0000000000dd0000
[   43.800970] $28   : a8000000fe6a0000 a8000000fe6a3a70 a800000000889330
a80000000047a72c
[   43.897326] Hi    : 0000000000000001
[   43.940268] Lo    : 0000000000000000
[   43.983256] epc   : a80000000047a738 acenic_probe_one+0x36c/0x1964
[   44.057588] ra    : a80000000047a72c acenic_probe_one+0x360/0x1964
[   44.131929] Status: 94005ce3 KX SX UX KERNEL EXL IE
[   44.191631] Cause : 0000901c (ExcCode 07)
[   44.239808] PrId  : 00000f14 (R14000)

[snip at TLB dump]


GDB examination (take 0xa80000000047a738 and back up 4 bytes to
0xa80000000047a734):

(gdb) l *0xa80000000047a734
0xa80000000047a734 is in acenic_probe_one
(drivers/net/ethernet/alteon/acenic.c:562).
557
558             printk("Gigabit Ethernet at 0x%08lx, ", dev->base_addr);
559             printk("irq %d\n", pdev->irq);
560
561     #ifdef CONFIG_ACENIC_OMIT_TIGON_I
562             if ((readl(&ap->regs->HostCtrl) >> 28) == 4) {
563                     printk(KERN_ERR "%s: Driver compiled without Tigon I"
564                            " support - NIC disabled\n", dev->name);
565                     goto fail_uninit;
566             }
(gdb)


I'm learning that this machine doesn't like you to randomly poke at various I/O
addresses, which will trigger a HUB error.  The only safe way to access I/O
reliably on this platform, other than the IO6 devices on widget 0xf, is to use
get_dbe() and put_dbe() from asm/paccess.h, which gracefully handle the data
bus error this machine sometimes likes to throw back.  However, I don't think
trying to wrap all read[bwl]/write[bwl] calls to use get/put_dbe is a
reasonable fix.

Anyone else out there that's played around on an IP27 machine have a clue
what's going on in these instances?  I'm not running into any kind of access
control mechanism, am I?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
