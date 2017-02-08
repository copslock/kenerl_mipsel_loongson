Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 10:39:50 +0100 (CET)
Received: from resqmta-ch2-02v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:34]:47892
        "EHLO resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991359AbdBHJjkuUV6S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 10:39:40 +0100
Received: from resomta-ch2-10v.sys.comcast.net ([69.252.207.106])
        by resqmta-ch2-02v.sys.comcast.net with SMTP
        id bOilcYLcXWRJ0bOiuc3Do8; Wed, 08 Feb 2017 09:39:36 +0000
Received: from [192.168.1.13] ([73.201.78.97])
        by resomta-ch2-10v.sys.comcast.net with SMTP
        id bOirc1OMmpXWBbOiscufAT; Wed, 08 Feb 2017 09:39:35 +0000
Subject: Re: [PATCH 12/12] MIPS: PCI: Fix IP27 for the PCI_PROBE_ONLY case
To:     Bjorn Helgaas <bhelgaas@google.com>
References: <20170207061356.8270-1-kumba@gentoo.org>
 <20170207061356.8270-13-kumba@gentoo.org>
 <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux/MIPS <linux-mips@linux-mips.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <eafc94c6-1931-e2ce-7e03-d84d8e181e81@gentoo.org>
Date:   Wed, 8 Feb 2017 04:39:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAErSpo6yKAE1_c1eZJapnjD1g0pocyOxed3_Eumdp_026uhDuA@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------4C5C23CE0FF9E9C9F06872E4"
X-CMAE-Envelope: MS4wfMkNtCs/eg3msFzsBU5lwkMBxr0syRGhl4Ymye5eD97l8ckosFresmVBxcB4dVkXhiOhDKpFzBDlEpME+Pj7hsp9oUqkt4GppBlGTltErbsdBgeLYWJI
 c708TJN8rm15o+8X4lW5CSNQpItdEBgVltCdp7VJw1I39XWgpen6a+y4LXTtDHbW92+JX1feXmCxEcxESMf2C6RO1+TtALR2HsQQGNEZHFoSJS1q6lddBq39
 sTDZn63jRfi7vsjv+qxfNa3yWdM1JPQnq1sA3W/tpzpLuNYXOo655qnam5w2YNr+VUOXDAzmSV3Zcn4+/vg3fw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56731
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

This is a multi-part message in MIME format.
--------------4C5C23CE0FF9E9C9F06872E4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 02/07/2017 13:29, Bjorn Helgaas wrote:
> Hi Joshua,
> 
> First of all, apologies for breaking IP27 and the inconvenience this
> caused you.  And thanks a lot for tracking down the problem and
> proposing a solution!

Eh, don't worry, IP27's been broken and unbroken over the years.  These systems
are becoming difficult to find intact, so these breaks tend to go unnoticed.


> On Tue, Feb 7, 2017 at 12:13 AM, Joshua Kinard <kumba@gentoo.org> wrote:
>> From: Joshua Kinard <kumba@gentoo.org>
>>
>> Commit 046136170a56 changed things such that setting PCI_PROBE_ONLY
>> will now explicitly claim PCI resources instead of skipping the sizing
>> of the bridges and assigning resources.  This is okay for IP30's PCI
>> code, which doesn't use physical address space to access I/O resources.
>>
>> However, IP27 is completely different in this regard.  Instead of using
>> ioremapped addresses for I/O, IP27 has a dedicated address range,
>> 0x92xxxxxxxxxxxxxx, that is used for all I/O access.  Since this is
>> uncached physical address space, the generic MIPS PCI code will not
>> probe it correctly and thus, the original behavior of PCI_PROBE_ONLY
>> needs to be restored only for the IP27 platform to bypass this logic
>> and have working PCI, at least for the IO6/IO6G board that houses the
>> base devices, until a better solution is found.
> 
> It sounds like there's something different about how ioremap() works
> on these platforms and PCI probing is tripping over that.  I'd really
> like to understand more about this difference to see if we can
> converge that instead of adding back the PCI_PROBE_ONLY usage.

I'd need to go and dig around in the IP27 headers again for this machine to see
what ioremap() is actually doing, but I *think* it returns uncached physical
addresses in most instances because of a special feature of the CPU, the
R10000-family, which makes uncached access very fast.  I think only the IP27
platform uses this capability.  Other R1x0-based systems don't (although, I
might be wrong about IP27's successor in IP35).


> Drivers shouldn't know whether they're running on IP27 or IP30, and
> they should be using ioremap() in both cases.  Does ioremap() work
> differently on IP27 and IP30?  Does this have something to do with
> plat_ioremap() or fixup_bigphys_addr()?

I believe most drivers won't know about this change.  The patch I proposed
modifies two files very specific to MIPS and SGI systems, one being the PCI
module for "legacy" MIPS systems, and the newly-proposed generic BRIDGE driver
(created by an earlier patch in this patch series).

The BRIDGE ASIC (and its cousin, the XBRIDGE) are only used on SGI systems and
they provide a translation layer from Crosstalk address space (Xtalk, the
system interconnect bus) to PCI devices by translating PCI ops into something
understood by the rest of the system.  BRIDGE is the only thing that needs to
get setup correctly, and then, I think, other drivers should be unaware of the
magic going on behind the scenes.

That said, it's still a hack that I proposed.  IP27 has long had issues with
PCI because it uses addresses differently.  I'm no expert in these systems --
just a hobby of mine I do in my free time -- but I'll refer you to these two
documents, which are archive copies since SGI retired Techpubs last year:

Origin™ and Onyx2™ Theory of Operations Manual:
http://csweb.cs.wfu.edu/~torgerse/Kokua/SGI/007-3439-002/sgi_html/index.html

Origin™ and Onyx2™ Programmer's Reference Manual
http://csweb.cs.wfu.edu/~torgerse/Kokua/SGI/007-3410-001/sgi_html/ch02.html#id5437809

The whole setup is extremely modular, so each node gets a static, fixed portion
of physical address space, regardless if that node is actually present or not.
By setting various bits in the upper part of a memory address, you can do
various things on specific nodes.  See Chapter 1 in the programmer's manual for
the details.

The address space in question here, 0x9200000000000000, is how you tell the HUB
(system controller for each node board) to access I/O space and talk to the
device peripherals.  Since this is physical address space, there's no need to
ioremap, so I think deep in the IP27 headers, ioremap just falls through and
returns one of these physical address, then you add in the needed offsets (node
number, crosstalk port, and PCI address) to get to the device you're trying to
reach.

IP30, SGI Octane, is similar in that it's like a single-node IP27 system.  It
has a HEART as a system controller instead of a HUB, but also uses Crosstalk
devices.  Documentation for the system doesn't really exist -- work on it has
been done via manual reverse engineering by people way better than I at this.
I've just been maintaining the code in external patches over the years.

I think the addresses on that platform *might* also be physical addresses, but
with no documentation on HEART, it's unknown if HEART treats certain address
spaces in special ways like HUB does.


> Is there any chance you can collect complete dmesg logs and
> /proc/iomem contents from IP27 and IP30?  Maybe "lspci -vv" output,
> too?  I'm not sure where to look to understand the ioremap() behavior.

Due to the size, I'll attach the dmesg and lspci outputs from both platforms as
text files, and inline /proc/iomem.  There are three dmesg files for IP27.  One
is a normal boot with enough patches to make PCI work.  Another is without the
PCI_PROBE_ONLY flag and my hack, so it will try to size/assign the resources,
and the last is with PCI_PROBE_ONLY and my hack, so it will try to "claim" the
resources only.  For the last two, each results in different error paths.

A note about IP30, since that's part of an external patch set, the dmesg output
is a little different, as it is using the newer BRIDGE/Xtalk code I just sent
in as patches.  IP27's dmesg output won't be using my full patchset in this
test, so it'll more closely resemble what you'd get out of the existing
mainline code.

Also, IP30 doesn't use the PCI_PROBE_ONLY thing anymore.  This causes
/proc/iomem to be far more detailed than it used to be.

IP30's /proc/iomem:
    00000000-00003fff : reserved
    1d200000-1d9fffff : Bridge MEM
      d080000000-d080003fff : 0001:00:03.0
      1d204000-1d204fff : 0001:00:02.0
      1d205000-1d205fff : 0001:00:02.1
      1d206000-1d206fff : 0001:00:02.2
      1d207000-1d2070ff : 0001:00:02.3
      1d207100-1d20717f : 0001:00:01.0
    1f200000-1f9fffff : Bridge MEM
      f080100000-f0801fffff : 0000:00:02.0
      f080010000-f08001ffff : 0000:00:00.0
      f080030000-f08003ffff : 0000:00:01.0
      f080000000-f080000fff : 0000:00:00.0
      f080020000-f080020fff : 0000:00:01.0
    20004000-209b8fff : reserved
      20004000-206acb13 : Kernel code
      206acb14-208affff : Kernel data
    209b9000-20efffff : System RAM
    20f00000-20ffffff : System RAM
    21000000-9fffffff : System RAM
    f080100000-f0801fffff : ioc3

IP27's /proc/iomem (from the working boot):
    0f600000-0f6fffff : ioc3
      0f680000-0f687fff : rtc-m48t35
    0fa00000-0fafffff : ioc3
    920000000b200000-920000000b9fffff : Bridge MEM
    920000000c200000-920000000c9fffff : Bridge MEM
    920000000f200000-920000000f9fffff : Bridge MEM
      920000000f620170-920000000f620177 : serial
      920000000f620178-920000000f62017f : serial
    920000000fa20170-920000000fa20177 : serial
    920000000fa20178-920000000fa2017f : serial


> What exactly is the PCI probe failure without this patch?  If you have
> a console log (with "ignore_loglevel") it might have a clue, too.
> 
>> Fixes: 046136170a56 ("MIPS/PCI: Claim bus resources on PCI_PROBE_ONLY set-ups")
>> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> ---
>>  arch/mips/pci/pci-bridge.c | 15 +++++++++++++++
>>  arch/mips/pci/pci-legacy.c | 15 +++++++++++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/arch/mips/pci/pci-bridge.c b/arch/mips/pci/pci-bridge.c
>> index 9df13ce313b5..af7073dba36b 100644
>> --- a/arch/mips/pci/pci-bridge.c
>> +++ b/arch/mips/pci/pci-bridge.c
>> @@ -62,6 +62,21 @@ bridge_probe(nasid_t nasid, int widget_id, int masterwid)
>>         unsigned long offset = NODE_OFFSET(nasid);
>>         struct bridge_controller *bc;
>>
>> +#ifdef CONFIG_SGI_IP27
> 
> I don't know how MIPS multi-platform support works.  If you enable
> CONFIG_SGI_IP27, does that mean the resulting kernel will *only* run
> on IP27?  Or can you enable several platforms, e.g., SGI_IP22,
> SGI_IP27, SGI_IP28, SGI_IP32, etc., and end up with a kernel that will
> boot on any of those platforms?  From Kconfig, it looks like these
> options are not mutually exclusive, so my guess is maybe the latter?
> 
> If so, I would think whatever we do should be based on a run-time test
> for SGI_IP27 instead of a compile-time test.

Kernels are platform-specific for the SGI machines.  So you need a different
kernel for IP22, IP27, IP30, IP32, etc.  Sometimes, different CPU's in a system
needs a different kernel as well (e.g., IP32 w/ R5000 versus IP32 w/ RM7000,
different kernels for each).

The one *slight* exception is Indy and Indigo2, where one Indigo2 model is just
a larger Indy (both are IP22).  There's two other Indigo2 variants out there
though, the rare Indigo2 Power (IP26) and the Indigo2 Impact (IP28).  These
classify as distinctly-different systems, mostly, and thus need their own
kernels (not that anyone's written code for IP26 yet, but I digress).

Other MIPS platforms may be a bit different.  I can only speak for the SGI
platforms right now.  You can see where all the fun is at...


>> +       /*
>> +        * Commit 046136170a56 changed things such that setting PCI_PROBE_ONLY
>> +        * will now explicitly claim PCI resources instead of skipping the
>> +        * sizing of the bridges and assigning resources.  This is okay for
>> +        * the IP30's PCI code, which uses normal, ioremapped addresses to
>> +        * do I/O.  IP27, however, is different and uses a hardware-specific
>> +        * address range of 0x92xxxxxxxxxxxxxx for all I/O access.  As such,
>> +        * the generic MIPS PCI code will not probe correctly and thus make
>> +        * PCI on IP27 completely unusable.  Thus, we must restore the
>> +        * original logic only for IP27 until a better solution can be found.
>> +        */
>> +       pci_set_flags(PCI_PROBE_ONLY);
>> +#endif
>> +
>>         /* XXX: Temporary until the IP27 "mega update". */
>>         bc = &bridges[num_bridges];
>>         if (!num_bridges)
>> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
>> index 68268bbb15b8..5590af4f367f 100644
>> --- a/arch/mips/pci/pci-legacy.c
>> +++ b/arch/mips/pci/pci-legacy.c
>> @@ -107,6 +107,20 @@ static void pcibios_scanbus(struct pci_controller *hose)
>>                 need_domain_info = 1;
>>         }
>>
>> +#ifdef CONFIG_SGI_IP27
>> +       /*
>> +        * Commit 046136170a56 changed things such that setting PCI_PROBE_ONLY
>> +        * will now explicitly claim PCI resources instead of skipping the
>> +        * sizing of the bridges and assigning resources.  This is okay for
>> +        * the IP30's PCI code, which uses normal, ioremapped addresses to
>> +        * do I/O.  IP27, however, is different and uses a hardware-specific
>> +        * address range of 0x92xxxxxxxxxxxxxx for all I/O access.  As such,
>> +        * the generic MIPS PCI code will not probe correctly and thus make
>> +        * PCI on IP27 completely unusable.  Thus, we must restore the
>> +        * original logic only for IP27 until a better solution can be found.
>> +        */
>> +       if (!pci_has_flag(PCI_PROBE_ONLY)) {
>> +#else
>>         /*
>>          * We insert PCI resources into the iomem_resource and
>>          * ioport_resource trees in either pci_bus_claim_resources()
>> @@ -115,6 +129,7 @@ static void pcibios_scanbus(struct pci_controller *hose)
>>         if (pci_has_flag(PCI_PROBE_ONLY)) {
>>                 pci_bus_claim_resources(bus);
>>         } else {
>> +#endif
>>                 pci_bus_size_bridges(bus);
>>                 pci_bus_assign_resources(bus);
>>         }
>> --
>> 2.11.1
>>
> 


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic

--------------4C5C23CE0FF9E9C9F06872E4
Content-Type: text/plain; charset=UTF-8;
 name="ip30-dmesg-20170208.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ip30-dmesg-20170208.txt"

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA0LjkuOC1taXBzZ2l0LTIwMTYxMjE2IChy
b290QGhlbGNhcmF4ZSkgKGdjYyB2ZXJzaW9uIDYuMy4wIChHZW50b28gSGFyZGVuZWQgNi4z
LjAgcDEuMCkgKSAjMSBTTVAgU2F0IEZlYiA0IDIxOjAxOjM3IEVTVCAyMDE3DQpbICAgIDAu
MDAwMDAwXSBBUkNIOiBTR0ktSVAzMA0KWyAgICAwLjAwMDAwMF0gUFJPTUxJQjogQVJDIGZp
cm13YXJlIFZlcnNpb24gNjQgUmV2aXNpb24gMA0KWyAgICAwLjAwMDAwMF0gYm9vdGNvbnNv
bGUgW2Vhcmx5X2ltcGFjdDBdIGVuYWJsZWQNClsgICAgMC4wMDAwMDBdIENQVTAgcmV2aXNp
b24gaXM6IDAwMDAwZjI0IChSMTQwMDApDQpbICAgIDAuMDAwMDAwXSBGUFUgcmV2aXNpb24g
aXM6IDAwMDAwOTAwDQpbICAgIDAuMDAwMDAwXSBDaGVja2luZyBmb3IgdGhlIG11bHRpcGx5
L3NoaWZ0IGJ1Zy4uLg0KWyAgICAwLjAwMDAwMF0gbm8uDQpbICAgIDAuMDAwMDAwXSBDaGVj
a2luZyBmb3IgdGhlIGRhZGRpdSBidWcuLi4NClsgICAgMC4wMDAwMDBdIG5vLg0KWyAgICAw
LjAwMDAwMF0gRGV0ZWN0ZWQgMjA0OE1CIG9mIHBoeXNpY2FsIG1lbW9yeS4NClsgICAgMC4w
MDAwMDBdIElQMzA6IENQVTA6IDYwMCBNSHogQ1BVIGRldGVjdGVkLg0KWyAgICAwLjAwMDAw
MF0gRGV0ZXJtaW5lZCBwaHlzaWNhbCBSQU0gbWFwOg0KWyAgICAwLjAwMDAwMF0gIG1lbW9y
eTogMDAwMDAwMDAwMDAwNDAwMCBAIDAwMDAwMDAwMDAwMDAwMDAgKHJlc2VydmVkKQ0KWyAg
ICAwLjAwMDAwMF0gIG1lbW9yeTogMDAwMDAwMDAwMDliNTAwMCBAIDAwMDAwMDAwMjAwMDQw
MDAgKHJlc2VydmVkKQ0KWyAgICAwLjAwMDAwMF0gIG1lbW9yeTogMDAwMDAwMDAwMDU0NzAw
MCBAIDAwMDAwMDAwMjA5YjkwMDAgKHVzYWJsZSkNClsgICAgMC4wMDAwMDBdICBtZW1vcnk6
IDAwMDAwMDAwMDAxMDAwMDAgQCAwMDAwMDAwMDIwZjAwMDAwIChST00gZGF0YSkNClsgICAg
MC4wMDAwMDBdICBtZW1vcnk6IDAwMDAwMDAwN2YwMDAwMDAgQCAwMDAwMDAwMDIxMDAwMDAw
ICh1c2FibGUpDQpbICAgIDAuMDAwMDAwXSAgbWVtb3J5OiAwMDAwMDAwMDAwOGIwMDAwIEAg
MDAwMDAwMDAyMDAwMDAwMCAodXNhYmxlKQ0KWyAgICAwLjAwMDAwMF0gY21hOiBSZXNlcnZl
ZCA1MTIgTWlCIGF0IDB4MDAwMDAwMDA4MDAwMDAwMA0KWyAgICAwLjAwMDAwMF0gSVAzMDog
U2xvdDogMCwgUHJJRDogMDAwMDBmMjQsIFBoeUlEOiAwLCBWaXJ0SUQ6IDANClsgICAgMC4w
MDAwMDBdIElQMzA6IFNsb3Q6IDEsIFBySUQ6IDAwMDAwZjI0LCBQaHlJRDogMSwgVmlydElE
OiAxDQpbICAgIDAuMDAwMDAwXSBJUDMwOiBEZXRlY3RlZCAyIENQVShzKSBwcmVzZW50Lg0K
WyAgICAwLjAwMDAwMF0gUHJpbWFyeSBpbnN0cnVjdGlvbiBjYWNoZSAzMmtCLCBWSVBULCAy
LXdheSwgbGluZXNpemUgNjQgYnl0ZXMuDQpbICAgIDAuMDAwMDAwXSBQcmltYXJ5IGRhdGEg
Y2FjaGUgMzJrQiwgMi13YXksIFZJUFQsIG5vIGFsaWFzZXMsIGxpbmVzaXplIDMyIGJ5dGVz
DQpbICAgIDAuMDAwMDAwXSBVbmlmaWVkIHNlY29uZGFyeSBjYWNoZSAyMDQ4a0IgMi13YXks
IGxpbmVzaXplIDEyOCBieXRlcy4NClsgICAgMC4wMDAwMDBdIFpvbmUgcmFuZ2VzOg0KWyAg
ICAwLjAwMDAwMF0gICBETUEzMiAgICBbbWVtIDB4MDAwMDAwMDAyMDAwMDAwMC0weDAwMDAw
MDAwZmZmZmZmZmZdDQpbICAgIDAuMDAwMDAwXSAgIE5vcm1hbCAgIGVtcHR5DQpbICAgIDAu
MDAwMDAwXSBNb3ZhYmxlIHpvbmUgc3RhcnQgZm9yIGVhY2ggbm9kZQ0KWyAgICAwLjAwMDAw
MF0gRWFybHkgbWVtb3J5IG5vZGUgcmFuZ2VzDQpbICAgIDAuMDAwMDAwXSAgIG5vZGUgICAw
OiBbbWVtIDB4MDAwMDAwMDAyMDAwMDAwMC0weDAwMDAwMDAwMjA5YWZmZmZdDQpbICAgIDAu
MDAwMDAwXSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDAyMDljMDAwMC0weDAwMDAwMDAw
OWZmZmZmZmZdDQpbICAgIDAuMDAwMDAwXSBJbml0bWVtIHNldHVwIG5vZGUgMCBbbWVtIDB4
MDAwMDAwMDAyMDAwMDAwMC0weDAwMDAwMDAwOWZmZmZmZmZdDQpbICAgIDAuMDAwMDAwXSBP
biBub2RlIDAgdG90YWxwYWdlczogMzI3NjcNClsgICAgMC4wMDAwMDBdIGZyZWVfYXJlYV9p
bml0X25vZGU6IG5vZGUgMCwgcGdkYXQgYTgwMDAwMDAyMDg2YTMwMCwgbm9kZV9tZW1fbWFw
IGE4MDAwMDAwMjA5ZDAzMDANClsgICAgMC4wMDAwMDBdICAgRE1BMzIgem9uZTogMzIgcGFn
ZXMgdXNlZCBmb3IgbWVtbWFwDQpbICAgIDAuMDAwMDAwXSAgIERNQTMyIHpvbmU6IDAgcGFn
ZXMgcmVzZXJ2ZWQNClsgICAgMC4wMDAwMDBdICAgRE1BMzIgem9uZTogMzI3NjcgcGFnZXMs
IExJRk8gYmF0Y2g6MQ0KWyAgICAwLjAwMDAwMF0gcGVyY3B1OiBFbWJlZGRlZCAxIHBhZ2Vz
L2NwdSBAYTgwMDAwMDAyMGMwMDAwMCBzMzQzMzYgcjAgZDMxMjAwIHU2NTUzNg0KWyAgICAw
LjAwMDAwMF0gcGNwdS1hbGxvYzogczM0MzM2IHIwIGQzMTIwMCB1NjU1MzYgYWxsb2M9MSo2
NTUzNg0KWyAgICAwLjAwMDAwMF0gcGNwdS1hbGxvYzogWzBdIDAgWzBdIDENClsgICAgMC4w
MDAwMDBdIEJ1aWx0IDEgem9uZWxpc3RzIGluIFpvbmUgb3JkZXIsIG1vYmlsaXR5IGdyb3Vw
aW5nIG9mZi4gIFRvdGFsIHBhZ2VzOiAzMjczNQ0KWyAgICAwLjAwMDAwMF0gS2VybmVsIGNv
bW1hbmQgbGluZTogcm9vdD14aW8oMClwY2koMTUpc2NzaSgwKWRpc2soMSlyZGlzaygwKXBh
cnRpdGlvbigwKSBjb25zb2xlPXR0eTAgcm9vdD0vZGV2L21kMCBjb25zb2xlYmxhbms9MA0K
WyAgICAwLjAwMDAwMF0gUElEIGhhc2ggdGFibGUgZW50cmllczogNDA5NiAob3JkZXI6IC0x
LCAzMjc2OCBieXRlcykNClsgICAgMC4wMDAwMDBdIERlbnRyeSBjYWNoZSBoYXNoIHRhYmxl
IGVudHJpZXM6IDI2MjE0NCAob3JkZXI6IDUsIDIwOTcxNTIgYnl0ZXMpDQpbICAgIDAuMDAw
MDAwXSBJbm9kZS1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEzMTA3MiAob3JkZXI6IDQs
IDEwNDg1NzYgYnl0ZXMpDQpbICAgIDAuMDAwMDAwXSBNZW1vcnk6IDE1NTYyODhLLzIwOTcw
ODhLIGF2YWlsYWJsZSAoNjgxN0sga2VybmVsIGNvZGUsIDY4N0sgcndkYXRhLCAxMzQ4SyBy
b2RhdGEsIDMyMEsgaW5pdCwgNzM5SyBic3MsIDE2NTEySyByZXNlcnZlZCwgNTI0Mjg4SyBj
bWEtcmVzZXJ2ZWQpDQpbICAgIDAuMDAwMDAwXSBIaWVyYXJjaGljYWwgUkNVIGltcGxlbWVu
dGF0aW9uLg0KWyAgICAwLjAwMDAwMF0gIEJ1aWxkLXRpbWUgYWRqdXN0bWVudCBvZiBsZWFm
IGZhbm91dCB0byA2NC4NClsgICAgMC4wMDAwMDBdIE5SX0lSUVM6MTI4DQpbICAgIDAuMDAw
MDAwXSBJUDMwOiBIRUFSVCBpbnRlcnJ1cHQgY29udHJvbGxlciBpbml0aWFsaXplZC4NClsg
ICAgMC4wMDAwMDBdIGNsb2Nrc291cmNlOiBIRUFSVDogbWFzazogMHhmZmZmZmZmZmZmZmZm
IG1heF9jeWNsZXM6IDB4MmUyMDQ5Y2RhLCBtYXhfaWRsZV9uczogNDQwNzk1MjAyNjI4IG5z
DQpbICAgIDAuMDAwMDA2XSBzY2hlZF9jbG9jazogNTIgYml0cyBhdCAxMk1IeiwgcmVzb2x1
dGlvbiA4MG5zLCB3cmFwcyBldmVyeSA0Mzk4MDQ2NTExMDgwbnMNClsgICAgMC4wMDA1NTBd
IGNsb2Nrc291cmNlOiBNSVBTOiBtYXNrOiAweGZmZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZm
ZmZmZmYsIG1heF9pZGxlX25zOiA2MzY5NjQ1Mzk2IG5zDQpbICAgIDAuMDAxMDg2XSBzY2hl
ZF9jbG9jazogMzIgYml0cyBhdCAzMDBNSHosIHJlc29sdXRpb24gM25zLCB3cmFwcyBldmVy
eSA3MTU2OTA0OTU4bnMNClsgICAgMC4wMDI1MjBdIENvbnNvbGU6IGNvbG91ciBkdW1teSBk
ZXZpY2UgODB4MjUNClsgICAgMC4wMDI4NzVdIGNvbnNvbGUgW3R0eTBdIGVuYWJsZWQNClsg
ICAgMC4wMDMxODVdIGJvb3Rjb25zb2xlIFtlYXJseV9pbXBhY3QwXSBkaXNhYmxlZA0KWyAg
ICAwLjAwMzU3M10gQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4uLiA4OTguNjYgQm9nb01JUFMg
KGxwaj00NDkzMzEyKQ0KWyAgICAwLjA5MDY4OV0gcGlkX21heDogZGVmYXVsdDogMzI3Njgg
bWluaW11bTogMzAxDQpbICAgIDAuMDkxNTU0XSBNb3VudC1jYWNoZSBoYXNoIHRhYmxlIGVu
dHJpZXM6IDgxOTIgKG9yZGVyOiAwLCA2NTUzNiBieXRlcykNClsgICAgMC4wOTE1NzNdIE1v
dW50cG9pbnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA4MTkyIChvcmRlcjogMCwgNjU1
MzYgYnl0ZXMpDQpbICAgIDAuMDkzODUyXSBDaGVja2luZyBmb3IgdGhlIGRhZGRpIGJ1Zy4u
Lg0KWyAgICAwLjA5Mzg3MV0gbm8uDQpbICAgIDYuNzYwMzg1XSBQcmltYXJ5IGluc3RydWN0
aW9uIGNhY2hlIDMya0IsIFZJUFQsIDItd2F5LCBsaW5lc2l6ZSA2NCBieXRlcy4NClsgICAg
Ni43NjAzOTddIFByaW1hcnkgZGF0YSBjYWNoZSAzMmtCLCAyLXdheSwgVklQVCwgbm8gYWxp
YXNlcywgbGluZXNpemUgMzIgYnl0ZXMNClsgICAgNi43NjA0MDJdIFVuaWZpZWQgc2Vjb25k
YXJ5IGNhY2hlIDIwNDhrQiAyLXdheSwgbGluZXNpemUgMTI4IGJ5dGVzLg0KWyAgIDE0LjI2
NDE5MV0gSVAzMDogQ1BVMTogNjAwIE1IeiBDUFUgZGV0ZWN0ZWQuDQpbICAgMTQuMjY0MjM1
XSBDUFUxIHJldmlzaW9uIGlzOiAwMDAwMGYyNCAoUjE0MDAwKQ0KWyAgIDE0LjI2NDIzOF0g
RlBVIHJldmlzaW9uIGlzOiAwMDAwMDkwMA0KWyAgICAwLjIzMDk2M10gU3luY2hyb25pemUg
Y291bnRlcnMgZm9yIENQVSAxOg0KWyAgICAwLjIzMDk2M10gZG9uZS4NClsgICAgMC4yMzEy
MzRdIEJyb3VnaHQgdXAgMiBDUFVzDQpbICAgIDAuMjMyNzQ5XSBkZXZ0bXBmczogaW5pdGlh
bGl6ZWQNClsgICAgMC4yMzM3NDddIGNsb2Nrc291cmNlOiBqaWZmaWVzOiBtYXNrOiAweGZm
ZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiAxOTExMjYwNDQ2
Mjc1MDAwMCBucw0KWyAgICAwLjIzNjIwNV0geG9yOiBtZWFzdXJpbmcgc29mdHdhcmUgY2hl
Y2tzdW0gc3BlZWQNClsgICAgMC4zMzA5NTFdICAgIDhyZWdzICAgICA6ICAgODUxLjIwMCBN
Qi9zZWMNClsgICAgMC40MzEwMzZdICAgIDhyZWdzX3ByZWZldGNoOiAgIDgwNi40MDAgTUIv
c2VjDQpbICAgIDAuNTMxMTk4XSAgICAzMnJlZ3MgICAgOiAgIDcyOS42MDAgTUIvc2VjDQpb
ICAgIDAuNjMxMjY5XSAgICAzMnJlZ3NfcHJlZmV0Y2g6ICAgNzQ4LjgwMCBNQi9zZWMNClsg
ICAgMC42MzEyOTldIHhvcjogdXNpbmcgZnVuY3Rpb246IDhyZWdzICg4NTEuMjAwIE1CL3Nl
YykNClsgICAgMC42MzIzNTZdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYN
ClsgICAgMC42NzEzMDBdIGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIGxhZGRlcg0KWyAgICAw
LjcxMTMyM10gY3B1aWRsZTogdXNpbmcgZ292ZXJub3IgbWVudQ0KWyAgICAwLjcxMTQ2N10g
eHRhbGs6bjAvZiBicmlkZ2Ugd2lkZ2V0IChyZXYgRCkgcmVnaXN0ZXJlZCBhcyBhIHBsYXRm
b3JtIGRldmljZS4NClsgICAgMC43MTE1NDRdIHh0YWxrOm4wL2QgYnJpZGdlIHdpZGdldCAo
cmV2IEMpIHJlZ2lzdGVyZWQgYXMgYSBwbGF0Zm9ybSBkZXZpY2UuDQpbICAgIDAuNzExNjE3
XSB4dGFsazpuMC9jIGltcGFjdCB3aWRnZXQgKHJldiBCKSByZWdpc3RlcmVkIGFzIGEgcGxh
dGZvcm0gZGV2aWNlLg0KWyAgICAwLjcxMTY5MF0geHRhbGs6bjAvOCBoZWFydCB3aWRnZXQg
KHJldiBGKSByZWdpc3RlcmVkIGFzIGEgcGxhdGZvcm0gZGV2aWNlLg0KWyAgICAwLjk2MTY0
MF0gcmFpZDY6IGludDY0eDEgIGdlbigpICAgMzIzIE1CL3MNClsgICAgMS4xMzE4NDBdIHJh
aWQ2OiBpbnQ2NHgxICB4b3IoKSAgIDEyMCBNQi9zDQpbICAgIDEuMzAxNzUzXSByYWlkNjog
aW50NjR4MiAgZ2VuKCkgICA0NjggTUIvcw0KWyAgICAxLjM0MTk1NV0gcmFuZG9tOiBmYXN0
IGluaXQgZG9uZQ0KWyAgICAxLjQ3MjAyM10gcmFpZDY6IGludDY0eDIgIHhvcigpICAgMTYx
IE1CL3MNClsgICAgMS42NDIwODBdIHJhaWQ2OiBpbnQ2NHg0ICBnZW4oKSAgIDQxNiBNQi9z
DQpbICAgIDEuODEyMTk0XSByYWlkNjogaW50NjR4NCAgeG9yKCkgICAxNjMgTUIvcw0KWyAg
ICAxLjk4MjI1M10gcmFpZDY6IGludDY0eDggIGdlbigpICAgMzQyIE1CL3MNClsgICAgMi4x
NTI1MzZdIHJhaWQ2OiBpbnQ2NHg4ICB4b3IoKSAgIDEzMyBNQi9zDQpbICAgIDIuMTUyNTU4
XSByYWlkNjogdXNpbmcgYWxnb3JpdGhtIGludDY0eDIgZ2VuKCkgNDY4IE1CL3MNClsgICAg
Mi4xNTI1NzhdIHJhaWQ2OiAuLi4uIHhvcigpIDE2MSBNQi9zLCBybXcgZW5hYmxlZA0KWyAg
ICAyLjE1MjU5N10gcmFpZDY6IHVzaW5nIGludHgxIHJlY292ZXJ5IGFsZ29yaXRobQ0KWyAg
ICAyLjE1Mjk4OF0gU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQNClsgICAgMi4xNTMxMTZd
IHBwc19jb3JlOiBMaW51eFBQUyBBUEkgdmVyLiAxIHJlZ2lzdGVyZWQNClsgICAgMi4xNTMx
MzhdIHBwc19jb3JlOiBTb2Z0d2FyZSB2ZXIuIDUuMy42IC0gQ29weXJpZ2h0IDIwMDUtMjAw
NyBSb2RvbGZvIEdpb21ldHRpIDxnaW9tZXR0aUBsaW51eC5pdD4NClsgICAgMi4xNTMxODhd
IFBUUCBjbG9jayBzdXBwb3J0IHJlZ2lzdGVyZWQNClsgICAgMi4xNTQwNzFdIGNsb2Nrc291
cmNlOiBTd2l0Y2hlZCB0byBjbG9ja3NvdXJjZSBIRUFSVA0KWyAgICAyLjE1NDQ4M10gRlMt
Q2FjaGU6IExvYWRlZA0KWyAgICAyLjE1NDcyM10gQ2FjaGVGaWxlczogTG9hZGVkDQpbICAg
IDIuMTYyMDkxXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDINClsgICAgMi4x
NjI3NTNdIFRDUCBlc3RhYmxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRl
cjogMSwgMTMxMDcyIGJ5dGVzKQ0KWyAgICAyLjE2MzM5Nl0gVENQIGJpbmQgaGFzaCB0YWJs
ZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6IDIsIDI2MjE0NCBieXRlcykNClsgICAgMi4xNjQ0
MDNdIFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0YWJsaXNoZWQgMTYzODQgYmlu
ZCAxNjM4NCkNClsgICAgMi4xNjQ2MTldIFVEUCBoYXNoIHRhYmxlIGVudHJpZXM6IDIwNDgg
KG9yZGVyOiAwLCA2NTUzNiBieXRlcykNClsgICAgMi4xNjQ4OTJdIFVEUC1MaXRlIGhhc2gg
dGFibGUgZW50cmllczogMjA0OCAob3JkZXI6IDAsIDY1NTM2IGJ5dGVzKQ0KWyAgICAyLjE2
NTQxMl0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxDQpbICAgIDIuMTY2MDAx
XSBSUEM6IFJlZ2lzdGVyZWQgbmFtZWQgVU5JWCBzb2NrZXQgdHJhbnNwb3J0IG1vZHVsZS4N
ClsgICAgMi4xNjYwMjddIFJQQzogUmVnaXN0ZXJlZCB1ZHAgdHJhbnNwb3J0IG1vZHVsZS4N
ClsgICAgMi4xNjYwNDddIFJQQzogUmVnaXN0ZXJlZCB0Y3AgdHJhbnNwb3J0IG1vZHVsZS4N
ClsgICAgMi4xNjYwNjZdIFJQQzogUmVnaXN0ZXJlZCB0Y3AgTkZTdjQuMSBiYWNrY2hhbm5l
bCB0cmFuc3BvcnQgbW9kdWxlLg0KWyAgICAyLjE2NjA5M10gUENJOiBDTFMgMCBieXRlcywg
ZGVmYXVsdCAxMjgNClsgICAgMi4xNjY3MjhdIGZ1dGV4IGhhc2ggdGFibGUgZW50cmllczog
NTEyIChvcmRlcjogMCwgNjU1MzYgYnl0ZXMpDQpbICAgIDIuMTY3MjUwXSB3b3JraW5nc2V0
OiB0aW1lc3RhbXBfYml0cz00NiBtYXhfb3JkZXI9MTUgYnVja2V0X29yZGVyPTANClsgICAg
Mi4xNjc0MDldIHpidWQ6IGxvYWRlZA0KWyAgICAyLjE2ODcyNV0gRExNIGluc3RhbGxlZA0K
WyAgICAyLjE2ODc5MF0gc3F1YXNoZnM6IHZlcnNpb24gNC4wICgyMDA5LzAxLzMxKSBQaGls
bGlwIExvdWdoZXINClsgICAgMi4xNjkzNjRdIE5GUzogUmVnaXN0ZXJpbmcgdGhlIGlkX3Jl
c29sdmVyIGtleSB0eXBlDQpbICAgIDIuMTY5NDIwXSBLZXkgdHlwZSBpZF9yZXNvbHZlciBy
ZWdpc3RlcmVkDQpbICAgIDIuMTY5NDQyXSBLZXkgdHlwZSBpZF9sZWdhY3kgcmVnaXN0ZXJl
ZA0KWyAgICAyLjE2OTQ3Ml0gSW5zdGFsbGluZyBrbmZzZCAoY29weXJpZ2h0IChDKSAxOTk2
IG9raXJAbW9uYWQuc3diLmRlKS4NClsgICAgMi4xNzAyMTRdIGVmczogMS4wYSAtIGh0dHA6
Ly9hZXNjaGkuY2guZXUub3JnL2Vmcy8NClsgICAgMi4xNzAyNzldIFNHSSBYRlMgd2l0aCBB
Q0xzLCBzZWN1cml0eSBhdHRyaWJ1dGVzLCByZWFsdGltZSwgbm8gZGVidWcgZW5hYmxlZA0K
WyAgICAyLjE4MTI3NF0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAzOA0KWyAg
ICAyLjE4MTM4M10gQmxvY2sgbGF5ZXIgU0NTSSBnZW5lcmljIChic2cpIGRyaXZlciB2ZXJz
aW9uIDAuNCBsb2FkZWQgKG1ham9yIDI1MSkNClsgICAgMi4xODE0MjJdIGlvIHNjaGVkdWxl
ciBub29wIHJlZ2lzdGVyZWQNClsgICAgMi4xODE0NDNdIGlvIHNjaGVkdWxlciBkZWFkbGlu
ZSByZWdpc3RlcmVkDQpbICAgIDIuMTgxNDY4XSBpbyBzY2hlZHVsZXIgYmZxIHJlZ2lzdGVy
ZWQgKGRlZmF1bHQpDQpbICAgIDIuMTgxNDg5XSBCRlEgSS9PLXNjaGVkdWxlcjogdjhyNw0K
WyAgICAyLjE4MTY2OF0gcGNpX2hvdHBsdWc6IFBDSSBIb3QgUGx1ZyBQQ0kgQ29yZSB2ZXJz
aW9uOiAwLjUNClsgICAgMi4yMjMyMjNdIENvbnNvbGU6IHN3aXRjaGluZyB0byBjb2xvdXIg
ZnJhbWUgYnVmZmVyIGRldmljZSAxNjB4NjQNClsgICAgMi4yNTU3NjZdIGZiMDogSW1wYWN0
U1IgMVJTUyBmcmFtZSBidWZmZXIgZGV2aWNlDQpbICAgIDIuMzE3Mzg0XSBTZXJpYWw6IDgy
NTAvMTY1NTAgZHJpdmVyLCA0IHBvcnRzLCBJUlEgc2hhcmluZyBlbmFibGVkDQpbICAgIDIu
MzI3OTg4XSBsb29wOiBtb2R1bGUgbG9hZGVkDQpbICAgIDIuMzI4ODUxXSBtb3VzZWRldjog
UFMvMiBtb3VzZSBkZXZpY2UgY29tbW9uIGZvciBhbGwgbWljZQ0KWyAgICAyLjMyOTUzNl0g
bWQ6IHJhaWQ2IHBlcnNvbmFsaXR5IHJlZ2lzdGVyZWQgZm9yIGxldmVsIDYNClsgICAgMi4z
Mjk3NTJdIG1kOiByYWlkNSBwZXJzb25hbGl0eSByZWdpc3RlcmVkIGZvciBsZXZlbCA1DQpb
ICAgIDIuMzI5OTYxXSBtZDogcmFpZDQgcGVyc29uYWxpdHkgcmVnaXN0ZXJlZCBmb3IgbGV2
ZWwgNA0KWyAgICAyLjMzMDMzNl0gUENJIGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAwOjAwDQpb
ICAgIDIuMzMwNTIxXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0g
MHgxZjIwMDAwMC0weDFmOWZmZmZmXQ0KWyAgICAyLjMzMDc5NF0gcGNpX2J1cyAwMDAwOjAw
OiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4MWZhMDAwMDAtMHgxZmJmZmZmZl0NClsgICAg
Mi4zMzEwNjhdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2J1cyAwMC1m
Zl0NClsgICAgMi4zMzEzMzBdIHBjaSAwMDAwOjAwOjAwLjA6IFsxMDc3OjEwMjBdIHR5cGUg
MDAgY2xhc3MgMHgwMTAwMDANClsgICAgMi4zMzEzNzhdIHBjaSAwMDAwOjAwOjAwLjA6IHJl
ZyAweDEwOiBbaW8gIDB4MjAwMDAwLTB4MjAwMGZmXQ0KWyAgICAyLjMzMTQwMl0gcGNpIDAw
MDA6MDA6MDAuMDogcmVnIDB4MTQ6IFttZW0gMHgwMDIwMDAwMC0weDAwMjAwZmZmXQ0KWyAg
ICAyLjMzMTQ4M10gcGNpIDAwMDA6MDA6MDAuMDogcmVnIDB4MzA6IFttZW0gMHgwMDIxMDAw
MC0weDAwMjFmZmZmIHByZWZdDQpbICAgIDIuMzMxNzA0XSBwY2kgMDAwMDowMDowMS4wOiBb
MTA3NzoxMDIwXSB0eXBlIDAwIGNsYXNzIDB4MDEwMDAwDQpbICAgIDIuMzMxNzM4XSBwY2kg
MDAwMDowMDowMS4wOiByZWcgMHgxMDogW2lvICAweDQwMDAwMC0weDQwMDBmZl0NClsgICAg
Mi4zMzE3NjFdIHBjaSAwMDAwOjAwOjAxLjA6IHJlZyAweDE0OiBbbWVtIDB4MDA0MDAwMDAt
MHgwMDQwMGZmZl0NClsgICAgMi4zMzE4NDNdIHBjaSAwMDAwOjAwOjAxLjA6IHJlZyAweDMw
OiBbbWVtIDB4MDA0MTAwMDAtMHgwMDQxZmZmZiBwcmVmXQ0KWyAgICAyLjMzMjAzMF0gcGNp
IDAwMDA6MDA6MDIuMDogWzEwYTk6MDAwM10gdHlwZSAwMCBjbGFzcyAweGZmMDAwMA0KWyAg
ICAyLjMzMjA2OF0gcGNpIDAwMDA6MDA6MDIuMDogcmVnIDB4MTA6IFttZW0gMHgwMDUwMDAw
MC0weDAwNWZmZmZmXQ0KWyAgICAyLjMzMjM0NV0gcGNpIDAwMDA6MDA6MDMuMDogWzEwYTk6
MDAwNV0gdHlwZSAwMCBjbGFzcyAweDAwMDAwMA0KWyAgICAyLjMzMjM3N10gcGNpIDAwMDA6
MDA6MDMuMDogcmVnIDB4MTA6IFttZW0gMHgwMDYwMDAwMC0weDAwNjAxZmZmXQ0KWyAgICAy
LjMzMjcyN10gcGNpIDAwMDA6MDA6MDIuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHgxZjIw
MDAwMC0weDFmMmZmZmZmXQ0KWyAgICAyLjMzMzAxMV0gcGNpIDAwMDA6MDA6MDAuMDogQkFS
IDY6IGFzc2lnbmVkIFttZW0gMHgxZjMwMDAwMC0weDFmMzBmZmZmIHByZWZdDQpbICAgIDIu
MzMzMjk4XSBwY2kgMDAwMDowMDowMS4wOiBCQVIgNjogYXNzaWduZWQgW21lbSAweDFmMzEw
MDAwLTB4MWYzMWZmZmYgcHJlZl0NClsgICAgMi4zMzM1ODJdIHBjaSAwMDAwOjAwOjAwLjA6
IEJBUiAxOiBhc3NpZ25lZCBbbWVtIDB4MWYzMjAwMDAtMHgxZjMyMGZmZl0NClsgICAgMi4z
MzM4NTZdIHBjaSAwMDAwOjAwOjAxLjA6IEJBUiAxOiBhc3NpZ25lZCBbbWVtIDB4MWYzMjEw
MDAtMHgxZjMyMWZmZl0NClsgICAgMi4zMzQxODFdIHBjaSAwMDAwOjAwOjAwLjA6IEJBUiAw
OiBhc3NpZ25lZCBbaW8gIDB4MWZhMDAwMDAtMHgxZmEwMDBmZl0NClsgICAgMi4zMzQ0NTZd
IHBjaSAwMDAwOjAwOjAxLjA6IEJBUiAwOiBhc3NpZ25lZCBbaW8gIDB4MWZhMDA0MDAtMHgx
ZmEwMDRmZl0NClsgICAgMi4zMzQ3OTVdIHFsYTEyODA6IFFMQTEwNDAgZm91bmQgb24gUENJ
IGJ1cyAwLCBkZXYgMA0KWyAgICAyLjMzNTAxNl0gaXAzMC1icmlkZ2U6IDAwMDA6MDA6MDAu
MCBCYXIgMCB3aXRoIHNpemUgMHgwMDAwMDEwMCBhdCBidXMgMHgwMDAwMDAwMCB2bWEgMHgw
MDAwMDBmMTAwMDAwMDAwIGlzIERpcmVjdCBJL08uDQpbICAgIDIuMzM1NDM1XSBpcDMwLWJy
aWRnZTogMDAwMDowMDowMC4wIEJhciAxIHdpdGggc2l6ZSAweDAwMDAxMDAwIGF0IGJ1cyAw
eDAwMDAwMDAwIHZtYSAweDAwMDAwMGYwODAwMDAwMDAgaXMgRGlyZWN0IDY0LWJpdC4NClsg
ICAgMi4zMzU4NjJdIGlwMzAtYnJpZGdlOiAwMDAwOjAwOjAwLjAgQmFyIDYgd2l0aCBzaXpl
IDB4MDAwMTAwMDAgYXQgYnVzIDB4MDAwMTAwMDAgdm1hIDB4MDAwMDAwZjA4MDAxMDAwMCBp
cyBEaXJlY3QgNjQtYml0Lg0KWyAgICAyLjMzNjI4N10gUENJOiBFbmFibGluZyBkZXZpY2Ug
MDAwMDowMDowMC4wICgwMDA2IC0+IDAwMDcpDQpbICAgIDIuMzM3MDQ0XSBzY3NpKDApOiBF
bmFibGluZyB2Y2hhbm5lbCBvbiBCUklER0UgZm9yIFNHSS9NSVBTDQpbICAgIDIuNzM4NzA0
XSByYW5kb206IGNybmcgaW5pdCBkb25lDQpbICAgIDIuOTIzNDE2XSBzY3NpKDA6MCk6IFJl
c2V0dGluZyBTQ1NJIEJVUw0KWyAgICA2LjAwNDA4N10gc2NzaSBob3N0MDogUUxvZ2ljIFFM
QTEwNDAgUENJIHRvIFNDU0kgSG9zdCBBZGFwdGVyDQogICAgICAgICAgICAgICAgICAgICAg
RmlybXdhcmUgdmVyc2lvbjogIDcuNjUuMDYsIERyaXZlciB2ZXJzaW9uIDMuMjcuMQ0KWyAg
ICA2LjAxMDc4OF0gcWxhMTI4MDogUUxBMTA0MCBmb3VuZCBvbiBQQ0kgYnVzIDAsIGRldiAx
DQpbICAgIDYuMDExMDM5XSBpcDMwLWJyaWRnZTogMDAwMDowMDowMS4wIEJhciAwIHdpdGgg
c2l6ZSAweDAwMDAwMTAwIGF0IGJ1cyAweDAwMDAwMTAwIHZtYSAweDAwMDAwMGYxMDAwMDAx
MDAgaXMgRGlyZWN0IEkvTy4NClsgICAgNi4wMTE0NjRdIGlwMzAtYnJpZGdlOiAwMDAwOjAw
OjAxLjAgQmFyIDEgd2l0aCBzaXplIDB4MDAwMDEwMDAgYXQgYnVzIDB4MDAwMjAwMDAgdm1h
IDB4MDAwMDAwZjA4MDAyMDAwMCBpcyBEaXJlY3QgNjQtYml0Lg0KWyAgICA2LjAxMTg5NV0g
aXAzMC1icmlkZ2U6IDAwMDA6MDA6MDEuMCBCYXIgNiB3aXRoIHNpemUgMHgwMDAxMDAwMCBh
dCBidXMgMHgwMDAzMDAwMCB2bWEgMHgwMDAwMDBmMDgwMDMwMDAwIGlzIERpcmVjdCA2NC1i
aXQuDQpbICAgIDYuMDEyMzI0XSBQQ0k6IEVuYWJsaW5nIGRldmljZSAwMDAwOjAwOjAxLjAg
KDAwMDYgLT4gMDAwNykNClsgICAxMy4xODU2NDNdIHNjc2kgMDowOjE6MDogRGlyZWN0LUFj
Y2VzcyAgICAgSUJNLUVTWFMgU1Q5NzM0MDFMQyAgICBGTiBCNDFEIFBROiAwIEFOU0k6IDQN
ClsgICAxMy4xODY3NzFdIHNjc2koMDowOjE6MCk6DQpbICAgMTMuMTg2ODg5XSAgU3luYzog
cGVyaW9kIDEwLCBvZmZzZXQgMTINClsgICAxMy4xODcwNTNdICwgV2lkZQ0KWyAgIDEzLjE4
NzA4OV0gLCBUYWdnZWQgcXVldWluZzogZGVwdGggMzENCg0KWyAgIDEzLjk2MjEwNV0gc2Nz
aSAwOjA6MjowOiBEaXJlY3QtQWNjZXNzICAgICBJQk0tRVNYUyBTVDk3MzQwMUxDICAgIEZO
IEI0MUQgUFE6IDAgQU5TSTogNA0KWyAgIDEzLjk2MzA5NV0gc2NzaSgwOjA6MjowKToNClsg
ICAxMy45NjMyMTJdICBTeW5jOiBwZXJpb2QgMTAsIG9mZnNldCAxMg0KWyAgIDEzLjk3Mjkz
NF0gLCBXaWRlDQpbICAgMTMuOTczMDk4XSAsIFRhZ2dlZCBxdWV1aW5nOiBkZXB0aCAzMQ0K
DQpbICAgMTQuMTc1MTUzXSBzY3NpIDA6MDozOjA6IERpcmVjdC1BY2Nlc3MgICAgIElCTS1F
U1hTIFNUOTczNDAxTEMgICAgRk4gQjQxRCBQUTogMCBBTlNJOiA0DQpbICAgMTQuMTg2NzE1
XSBzY3NpKDA6MDozOjApOg0KWyAgIDE0LjE4NjgzN10gIFN5bmM6IHBlcmlvZCAxMCwgb2Zm
c2V0IDEyDQpbICAgMTQuMTk3NTQ2XSAsIFdpZGUNClsgICAxNC4xOTc3MTJdICwgVGFnZ2Vk
IHF1ZXVpbmc6IGRlcHRoIDMxDQoNClsgICAxNC41MTE2MjFdIHNjc2koMTowKTogUmVzZXR0
aW5nIFNDU0kgQlVTDQpbICAgMTkuMDQ0MzE1XSBzY3NpIGhvc3QxOiBRTG9naWMgUUxBMTA0
MCBQQ0kgdG8gU0NTSSBIb3N0IEFkYXB0ZXINCiAgICAgICAgICAgICAgICAgICAgICBGaXJt
d2FyZSB2ZXJzaW9uOiAgNy42NS4wNiwgRHJpdmVyIHZlcnNpb24gMy4yNy4xDQpbICAgMTku
MDcwOTI1XSBpcDMwLWJyaWRnZTogMDAwMDowMDowMi4wIEJhciAwIHdpdGggc2l6ZSAweDAw
MTAwMDAwIGF0IGJ1cyAweDAwMTAwMDAwIHZtYSAweDAwMDAwMGYwODAxMDAwMDAgaXMgRGly
ZWN0IDY0LWJpdC4NClsgICAyMS4xOTQwMzldIGlvYzM6IHBhcnQ6IFswMzAtMDg5MS0wMDNd
LCBzZXJpYWw6IFtLQkI3MzFdID0+IGNsYXNzIElQMzAgU3lzdGVtIEJvYXJkDQpbICAgMjEu
MjA3MDEzXSBpb2MzLWV0aDogRXRoZXJuZXQgYWRkcmVzcyBpcyAwODowMDo2OTowZToxMTow
Yy4NClsgICAyMS4yMTg3MTFdIElPQzMgMDAwMDowMDowMi4wIGV0aDA6IGxpbmsgdXAsIDEw
ME1icHMsIGZ1bGwtZHVwbGV4LCBscGEgMHgwNUUxDQpbICAgMjEuMjI5NDQ5XSBldGgwOiBV
c2luZyBQSFkgMSwgdmVuZG9yIDB4MTVmNDIsIG1vZGVsIDIsIHJldiAzLg0KWyAgIDIxLjI0
MDIxNV0gZXRoMDogSU9DMyBTU1JBTSBoYXMgMTI4IGtieXRlLg0KWyAgIDIxLjI1MTY2Nl0g
cnRjLWRzMTY4NSBydGMtZHMxNjg1OiBydGMgY29yZTogcmVnaXN0ZXJlZCBydGMtZHMxNjg1
IGFzIHJ0YzANClsgICAyMS4yODc1NjVdIDAwMDA6MDA6MDIuMDogdHR5UzAgYXQgSU9DMyAw
eGYwODAxMjAxNzggKGlycSA9IDAsIGJhc2VfYmF1ZCA9IDQ1ODMzMykgaXMgYSAxNjU1MEEN
ClsgICAyMS4zMTkwODddIDAwMDA6MDA6MDIuMDogdHR5UzEgYXQgSU9DMyAweGYwODAxMjAx
NzAgKGlycSA9IDAsIGJhc2VfYmF1ZCA9IDQ1ODMzMykgaXMgYSAxNjU1MEENClsgICAyMS4z
MzAwNzldIElPQzMgTWFzdGVyIERyaXZlciBsb2FkZWQgZm9yIDAwMDA6MDA6MDIuMA0KWyAg
IDIxLjM0MDk1MV0gUENJIGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAxOjAwDQpbICAgMjEuMzUx
NjU3XSBwY2lfYnVzIDAwMDE6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0gMHgxZDIwMDAw
MC0weDFkOWZmZmZmXQ0KWyAgIDIxLjM2MjY1NV0gcGNpX2J1cyAwMDAxOjAwOiByb290IGJ1
cyByZXNvdXJjZSBbaW8gIDB4MWRhMDAwMDAtMHgxZGJmZmZmZl0NClsgICAyMS4zNzM1MDJd
IHBjaV9idXMgMDAwMTowMDogcm9vdCBidXMgcmVzb3VyY2UgW2J1cyAwMS1mZl0NClsgICAy
MS4zODQyMDRdIHBjaSAwMDAxOjAwOjAxLjA6IFsxMWZlOjA4MGVdIHR5cGUgMDAgY2xhc3Mg
MHgwNzgwMDANClsgICAyMS4zODQyNTFdIHBjaSAwMDAxOjAwOjAxLjA6IHJlZyAweDEwOiBb
bWVtIDB4MDAyMDAwMDAtMHgwMDIwMDA3Zl0NClsgICAyMS4zODQyNzRdIHBjaSAwMDAxOjAw
OjAxLjA6IHJlZyAweDE0OiBbaW8gIDB4MjAwMDAwLTB4MjAwMDdmXQ0KWyAgIDIxLjM4NDI5
N10gcGNpIDAwMDE6MDA6MDEuMDogcmVnIDB4MTg6IFtpbyAgMHgyMDQwMDAtMHgyMDQwZmZd
DQpbICAgMjEuMzg0NTc4XSBwY2kgMDAwMTowMDowMi4wOiBbMTBiOTo1MjM3XSB0eXBlIDAw
IGNsYXNzIDB4MGMwMzEwDQpbICAgMjEuMzg0NjE4XSBwY2kgMDAwMTowMDowMi4wOiByZWcg
MHgxMDogW21lbSAweDAwMzAwMDAwLTB4MDAzMDBmZmZdDQpbICAgMjEuMzg0Nzc4XSBwY2kg
MDAwMTowMDowMi4wOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQxIEQzaG90IEQzY29sZA0K
WyAgIDIxLjM4NDk1MV0gcGNpIDAwMDE6MDA6MDIuMTogWzEwYjk6NTIzN10gdHlwZSAwMCBj
bGFzcyAweDBjMDMxMA0KWyAgIDIxLjM4NDk4N10gcGNpIDAwMDE6MDA6MDIuMTogcmVnIDB4
MTA6IFttZW0gMHgwMDAwMDAwMC0weDAwMDAwZmZmXQ0KWyAgIDIxLjM4NTEyNl0gcGNpIDAw
MDE6MDA6MDIuMTogUE1FIyBzdXBwb3J0ZWQgZnJvbSBEMCBEMSBEM2hvdCBEM2NvbGQNClsg
ICAyMS4zODUyOTFdIHBjaSAwMDAxOjAwOjAyLjI6IFsxMGI5OjUyMzddIHR5cGUgMDAgY2xh
c3MgMHgwYzAzMTANClsgICAyMS4zODUzMjddIHBjaSAwMDAxOjAwOjAyLjI6IHJlZyAweDEw
OiBbbWVtIDB4MDAwMDAwMDAtMHgwMDAwMGZmZl0NClsgICAyMS4zODU0NjZdIHBjaSAwMDAx
OjAwOjAyLjI6IFBNRSMgc3VwcG9ydGVkIGZyb20gRDAgRDEgRDNob3QgRDNjb2xkDQpbICAg
MjEuMzg1NjM2XSBwY2kgMDAwMTowMDowMi4zOiBbMTBiOTo1MjM5XSB0eXBlIDAwIGNsYXNz
IDB4MGMwMzIwDQpbICAgMjEuMzg1Njc2XSBwY2kgMDAwMTowMDowMi4zOiByZWcgMHgxMDog
W21lbSAweDAwMDAwMDAwLTB4MDAwMDAwZmZdDQpbICAgMjEuMzg1ODI4XSBwY2kgMDAwMTow
MDowMi4zOiBQTUUjIHN1cHBvcnRlZCBmcm9tIEQwIEQzaG90IEQzY29sZA0KWyAgIDIxLjM4
NjAwNF0gcGNpIDAwMDE6MDA6MDMuMDogWzEwYTk6MDAwOV0gdHlwZSAwMCBjbGFzcyAweDAy
MDAwMA0KWyAgIDIxLjM4NjAzOV0gcGNpIDAwMDE6MDA6MDMuMDogcmVnIDB4MTA6IFttZW0g
MHgwMDQwMDAwMC0weDAwNDAzZmZmXQ0KWyAgIDIxLjM4NjM5NV0gcGNpIDAwMDE6MDA6MDMu
MDogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHgxZDIwMDAwMC0weDFkMjAzZmZmXQ0KWyAgIDIx
LjM5NzAxOF0gcGNpIDAwMDE6MDA6MDIuMDogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHgxZDIw
NDAwMC0weDFkMjA0ZmZmXQ0KWyAgIDIxLjQwNzU1Ml0gcGNpIDAwMDE6MDA6MDIuMTogQkFS
IDA6IGFzc2lnbmVkIFttZW0gMHgxZDIwNTAwMC0weDFkMjA1ZmZmXQ0KWyAgIDIxLjQxNzk0
NV0gcGNpIDAwMDE6MDA6MDIuMjogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHgxZDIwNjAwMC0w
eDFkMjA2ZmZmXQ0KWyAgIDIxLjQyODE4NV0gcGNpIDAwMDE6MDA6MDEuMDogQkFSIDI6IGFz
c2lnbmVkIFtpbyAgMHgxZGEwMDAwMC0weDFkYTAwMGZmXQ0KWyAgIDIxLjQzODMyMV0gcGNp
IDAwMDE6MDA6MDIuMzogQkFSIDA6IGFzc2lnbmVkIFttZW0gMHgxZDIwNzAwMC0weDFkMjA3
MGZmXQ0KWyAgIDIxLjQ0ODM3M10gcGNpIDAwMDE6MDA6MDEuMDogQkFSIDA6IGFzc2lnbmVk
IFttZW0gMHgxZDIwNzEwMC0weDFkMjA3MTdmXQ0KWyAgIDIxLjQ1ODQzM10gcGNpIDAwMDE6
MDA6MDEuMDogQkFSIDE6IGFzc2lnbmVkIFtpbyAgMHgxZGEwMDQwMC0weDFkYTAwNDdmXQ0K
WyAgIDIxLjQ2ODY0Nl0gYWNlbmljLmM6IHYwLjkyIDA4LzA1LzIwMDIgIEplcyBTb3JlbnNl
biwgbGludXgtYWNlbmljQFN1blNJVEUuZGsNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBodHRwOi8vaG9tZS5jZXJuLmNoL35qZXMvZ2lnZS9hY2VuaWMu
aHRtbA0KWyAgIDIxLjQ4ODk0N10gaXAzMC1icmlkZ2U6IDAwMDE6MDA6MDMuMCBCYXIgMCB3
aXRoIHNpemUgMHgwMDAwNDAwMCBhdCBidXMgMHgwMDAwMDAwMCB2bWEgMHgwMDAwMDBkMDgw
MDAwMDAwIGlzIERpcmVjdCA2NC1iaXQuDQpbICAgMjEuNDk5NTkyXSAwMDAxOjAwOjAzLjA6
IFNHSSBBY2VOSUMNClsgICAyMS40OTk4MDRdIEdpZ2FiaXQgRXRoZXJuZXQgYXQgMHhkMDgw
MDAwMDAwLA0KWyAgIDIxLjUxMDM2OV0gaXJxIDQNClsgICAyMS41MjEzODddICAgVGlnb24g
SUkgKFJldi4gNiksIEZpcm13YXJlOiAwLjAuMCwNClsgICAyMS41MjY5NDVdIE1BQzogMDg6
MDA6Njk6MTQ6Njk6OWMNClsgICAyMS41Mzc2ODJdICAgUENJIGNhY2hlIGxpbmUgc2l6ZSBz
ZXQgaW5jb3JyZWN0bHkgKDAgYnl0ZXMpIGJ5IEJJT1MvRlcsDQpbICAgMjEuNTM4MDMxXSBj
b3JyZWN0aW5nIHRvIDEyOA0KWyAgIDIxLjU0OTAyMl0gICBQQ0kgYnVzIHdpZHRoOiA2NCBi
aXRzLCBzcGVlZDogMzNNSHosIGxhdGVuY3k6IDY0IGNsa3MNClsgICAyMS42MDkyNDRdIDAw
MDE6MDA6MDMuMDogRmlybXdhcmUgdXAgYW5kIHJ1bm5pbmcNClsgICAyMS42MjE4MzRdIE5F
VDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMjYNClsgICAyMS42MzM3NDFdIE5FVDog
UmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTANClsgICAyMS42NDY5OTddIHNpdDogSVB2
NiwgSVB2NCBhbmQgTVBMUyBvdmVyIElQdjQgdHVubmVsaW5nIGRyaXZlcg0KWyAgIDIxLjY1
OTIyOF0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNw0KWyAgIDIxLjY3MDUz
OV0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSA0DQpbICAgMjEuNjgxOTk1XSA4
MDIxcTogODAyLjFRIFZMQU4gU3VwcG9ydCB2MS44DQpbICAgMjEuNjkzNjM5XSBzY3RwOiBI
YXNoIHRhYmxlcyBjb25maWd1cmVkIChiaW5kIDQwOTYvNDA5NikNClsgICAyMS43MDUxMDdd
IEtleSB0eXBlIGRuc19yZXNvbHZlciByZWdpc3RlcmVkDQpbICAgMjEuNzE3NjQ3XSBydGMt
ZHMxNjg1IHJ0Yy1kczE2ODU6IHNldHRpbmcgc3lzdGVtIGNsb2NrIHRvIDIwMTctMDItMDgg
MDY6MjY6MTMgVVRDICgxNDg2NTM1MTczKQ0KWyAgIDIxLjg0NzA5MF0gaW5wdXQ6IEFUIFJh
dyBTZXQgMiBrZXlib2FyZCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAwMDA6MDA6MDIuMC9z
ZXJpbzAvaW5wdXQvaW5wdXQwDQpbICAgMjIuMDc3ODE3XSBpbnB1dDogSW1QUy8yIExvZ2l0
ZWNoIFdoZWVsIE1vdXNlIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDowMi4wL3Nl
cmlvMS9pbnB1dC9pbnB1dDINClsgICAyMy41OTMzMDZdIHNkIDA6MDoxOjA6IFtzZGFdIDE0
MzM3NDAwMCA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogKDczLjQgR0IvNjguNCBHaUIpDQpb
ICAgMjMuNjA1Mjc5XSBzZCAwOjA6MjowOiBbc2RiXSAxNDMzNzQwMDAgNTEyLWJ5dGUgbG9n
aWNhbCBibG9ja3M6ICg3My40IEdCLzY4LjQgR2lCKQ0KWyAgIDIzLjYwNTM1MF0gc2QgMDow
OjM6MDogW3NkY10gMTQzMzc0MDAwIDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzOiAoNzMuNCBH
Qi82OC40IEdpQikNClsgICAyMy42MDg1NTJdIHNkIDA6MDoxOjA6IFtzZGFdIFdyaXRlIFBy
b3RlY3QgaXMgb2ZmDQpbICAgMjMuNjA4NTYyXSBzZCAwOjA6MTowOiBbc2RhXSBNb2RlIFNl
bnNlOiBiMyAwMCAxMCAwOA0KWyAgIDIzLjYwODczNl0gc2QgMDowOjM6MDogW3NkY10gV3Jp
dGUgUHJvdGVjdCBpcyBvZmYNClsgICAyMy42MDg3NDZdIHNkIDA6MDozOjA6IFtzZGNdIE1v
ZGUgU2Vuc2U6IGIzIDAwIDEwIDA4DQpbICAgMjMuNjEwODMyXSBzZCAwOjA6MTowOiBbc2Rh
XSBXcml0ZSBjYWNoZTogZGlzYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIHN1cHBvcnRz
IERQTyBhbmQgRlVBDQpbICAgMjMuNjExMDE5XSBzZCAwOjA6MzowOiBbc2RjXSBXcml0ZSBj
YWNoZTogZGlzYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIHN1cHBvcnRzIERQTyBhbmQg
RlVBDQpbICAgMjMuNjMwNTIwXSAgc2RjOiBzZGMxIHNkYzIgc2RjMyBzZGM0IHNkYzUgc2Rj
NiBzZGM5IHNkYzExDQpbICAgMjMuNjM0NTI3XSAgc2RhOiBzZGExIHNkYTIgc2RhMyBzZGE0
IHNkYTUgc2RhNiBzZGE5IHNkYTExDQpbICAgMjMuNjQxNzU3XSBzZCAwOjA6MzowOiBbc2Rj
XSBBdHRhY2hlZCBTQ1NJIGRpc2sNClsgICAyMy42NDM2NTVdIHNkIDA6MDoxOjA6IFtzZGFd
IEF0dGFjaGVkIFNDU0kgZGlzaw0KWyAgIDIzLjcyMDcxNV0gc2QgMDowOjI6MDogW3NkYl0g
V3JpdGUgUHJvdGVjdCBpcyBvZmYNClsgICAyMy43MzEyNzZdIHNkIDA6MDoyOjA6IFtzZGJd
IE1vZGUgU2Vuc2U6IGIzIDAwIDEwIDA4DQpbICAgMjMuNzM1MjI2XSBzZCAwOjA6MjowOiBb
c2RiXSBXcml0ZSBjYWNoZTogZGlzYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIHN1cHBv
cnRzIERQTyBhbmQgRlVBDQpbICAgMjMuNzY3Njg2XSAgc2RiOiBzZGIxIHNkYjIgc2RiMyBz
ZGI0IHNkYjUgc2RiNiBzZGI5IHNkYjExDQpbICAgMjMuNzg2OTg3XSBzZCAwOjA6MjowOiBb
c2RiXSBBdHRhY2hlZCBTQ1NJIGRpc2sNClsgICAyNy43NzgwMzhdIGV0aDE6IE9wdGljYWwg
bGluayBVUCAoRnVsbCBEdXBsZXgsIEZsb3cgQ29udHJvbDogVFggUlgpDQpbICAgMjkuNDU0
MjQwXSBtZDogV2FpdGluZyBmb3IgYWxsIGRldmljZXMgdG8gYmUgYXZhaWxhYmxlIGJlZm9y
ZSBhdXRvZGV0ZWN0DQpbICAgMjkuNDY0OTYwXSBtZDogSWYgeW91IGRvbid0IHVzZSByYWlk
LCB1c2UgcmFpZD1ub2F1dG9kZXRlY3QNClsgICAyOS40NzY0MjBdIG1kOiBBdXRvZGV0ZWN0
aW5nIFJBSUQgYXJyYXlzLg0KWyAgIDI5LjYxODg2NV0gbWQ6IFNjYW5uZWQgMTUgYW5kIGFk
ZGVkIDE1IGRldmljZXMuDQpbICAgMjkuNjI5NTc5XSBtZDogYXV0b3J1biAuLi4NClsgICAy
OS42NDAwNzNdIG1kOiBjb25zaWRlcmluZyBzZGI2IC4uLg0KWyAgIDI5LjY1MDM5M10gbWQ6
ICBhZGRpbmcgc2RiNiAuLi4NClsgICAyOS42NjAzNTJdIG1kOiBzZGI1IGhhcyBkaWZmZXJl
bnQgVVVJRCB0byBzZGI2DQpbICAgMjkuNjcwMjcyXSBtZDogc2RiNCBoYXMgZGlmZmVyZW50
IFVVSUQgdG8gc2RiNg0KWyAgIDI5LjY3OTk4NF0gbWQ6IHNkYjMgaGFzIGRpZmZlcmVudCBV
VUlEIHRvIHNkYjYNClsgICAyOS42ODk1MTRdIG1kOiBzZGIxIGhhcyBkaWZmZXJlbnQgVVVJ
RCB0byBzZGI2DQpbICAgMjkuNjk4OTA3XSBtZDogIGFkZGluZyBzZGE2IC4uLg0KWyAgIDI5
LjcwODE1MV0gbWQ6IHNkYTUgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYjYNClsgICAyOS43
MTcyOTNdIG1kOiBzZGE0IGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGI2DQpbICAgMjkuNzI2
NDM0XSBtZDogc2RhMyBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RiNg0KWyAgIDI5LjczNTM2
Nl0gbWQ6IHNkYTEgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYjYNClsgICAyOS43NDQxNTBd
IG1kOiAgYWRkaW5nIHNkYzYgLi4uDQpbICAgMjkuNzUyNzYyXSBtZDogc2RjNSBoYXMgZGlm
ZmVyZW50IFVVSUQgdG8gc2RiNg0KWyAgIDI5Ljc2MTU2MV0gbWQ6IHNkYzQgaGFzIGRpZmZl
cmVudCBVVUlEIHRvIHNkYjYNClsgICAyOS43NzAyNjRdIG1kOiBzZGMzIGhhcyBkaWZmZXJl
bnQgVVVJRCB0byBzZGI2DQpbICAgMjkuNzc4Nzg4XSBtZDogc2RjMSBoYXMgZGlmZmVyZW50
IFVVSUQgdG8gc2RiNg0KWyAgIDI5Ljc4ODEyNV0gbWQ6IGNyZWF0ZWQgbWQ0DQpbICAgMjku
Nzk2NTgyXSBtZDogYmluZDxzZGM2Pg0KWyAgIDI5LjgwNTE3NF0gbWQ6IGJpbmQ8c2RhNj4N
ClsgICAyOS44MTM2NjNdIG1kOiBiaW5kPHNkYjY+DQpbICAgMjkuODIyMTU5XSBtZDogcnVu
bmluZzoNClsgICAyOS44MjIzMDddIDxzZGI2Pg0KWyAgIDI5LjgzMDczN10gPHNkYTY+DQpb
ICAgMjkuODMwODgzXSA8c2RjNj4NCg0KWyAgIDI5Ljg0ODgxMV0gbWQvcmFpZDptZDQ6IGRl
dmljZSBzZGI2IG9wZXJhdGlvbmFsIGFzIHJhaWQgZGlzayAxDQpbICAgMjkuODU3MzEwXSBt
ZC9yYWlkOm1kNDogZGV2aWNlIHNkYTYgb3BlcmF0aW9uYWwgYXMgcmFpZCBkaXNrIDANClsg
ICAyOS44NjU1NTZdIG1kL3JhaWQ6bWQ0OiBkZXZpY2Ugc2RjNiBvcGVyYXRpb25hbCBhcyBy
YWlkIGRpc2sgMg0KWyAgIDI5Ljg3NTY1Nl0gbWQvcmFpZDptZDQ6IGFsbG9jYXRlZCA0OTM4
NmtCDQpbICAgMjkuODgzNDYyXSBtZC9yYWlkOm1kNDogcmFpZCBsZXZlbCA1IGFjdGl2ZSB3
aXRoIDMgb3V0IG9mIDMgZGV2aWNlcywgYWxnb3JpdGhtIDINClsgICAyOS44OTEyMjNdIFJB
SUQgY29uZiBwcmludG91dDoNClsgICAyOS44OTEyMzBdICAtLS0gbGV2ZWw6NSByZDozIHdk
OjMNClsgICAyOS44OTEyMzZdICBkaXNrIDAsIG86MSwgZGV2OnNkYTYNClsgICAyOS44OTEy
NDFdICBkaXNrIDEsIG86MSwgZGV2OnNkYjYNClsgICAyOS44OTEyNDZdICBkaXNrIDIsIG86
MSwgZGV2OnNkYzYNClsgICAyOS45MzA0NDRdIGNyZWF0ZWQgYml0bWFwICgxIHBhZ2VzKSBm
b3IgZGV2aWNlIG1kNA0KWyAgIDI5Ljk0MjIyMF0gbWQ0OiBiaXRtYXAgaW5pdGlhbGl6ZWQg
ZnJvbSBkaXNrOiByZWFkIDEgcGFnZXMsIHNldCAwIG9mIDUgYml0cw0KWyAgIDI5Ljk1NTE4
OF0gbWQ0OiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDIyNjM2MTM0NDAN
ClsgICAyOS45NjI3OTFdIG1kOiBjb25zaWRlcmluZyBzZGI1IC4uLg0KWyAgIDI5Ljk3MDQx
Ml0gbWQ6ICBhZGRpbmcgc2RiNSAuLi4NClsgICAyOS45NzgwMTVdIG1kOiBzZGI0IGhhcyBk
aWZmZXJlbnQgVVVJRCB0byBzZGI1DQpbICAgMjkuOTg1NjMxXSBtZDogc2RiMyBoYXMgZGlm
ZmVyZW50IFVVSUQgdG8gc2RiNQ0KWyAgIDI5Ljk5MzEwMF0gbWQ6IHNkYjEgaGFzIGRpZmZl
cmVudCBVVUlEIHRvIHNkYjUNClsgICAzMC4wMDA2MDJdIG1kOiAgYWRkaW5nIHNkYTUgLi4u
DQpbICAgMzAuMDA4MDIxXSBtZDogc2RhNCBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RiNQ0K
WyAgIDMwLjAxNTQ1N10gbWQ6IHNkYTMgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYjUNClsg
ICAzMC4wMjI3MjddIG1kOiBzZGExIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGI1DQpbICAg
MzAuMDI5NzkyXSBtZDogIGFkZGluZyBzZGM1IC4uLg0KWyAgIDMwLjAzNjYxM10gbWQ6IHNk
YzQgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYjUNClsgICAzMC4wNDMzMjZdIG1kOiBzZGMz
IGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGI1DQpbICAgMzAuMDQ5Nzg1XSBtZDogc2RjMSBo
YXMgZGlmZmVyZW50IFVVSUQgdG8gc2RiNQ0KWyAgIDMwLjA1Njk3NF0gbWQ6IGNyZWF0ZWQg
bWQzDQpbICAgMzAuMDYzMzMyXSBtZDogYmluZDxzZGM1Pg0KWyAgIDMwLjA2OTc3N10gbWQ6
IGJpbmQ8c2RhNT4NClsgICAzMC4wNzYwODddIG1kOiBiaW5kPHNkYjU+DQpbICAgMzAuMDgy
MjM1XSBtZDogcnVubmluZzoNClsgICAzMC4wODI0MDNdIDxzZGI1Pg0KWyAgIDMwLjA4ODUz
Ml0gPHNkYTU+DQpbICAgMzAuMDg4Njc3XSA8c2RjNT4NCg0KWyAgIDMwLjEwMTczNl0gbWQv
cmFpZDptZDM6IGRldmljZSBzZGI1IG9wZXJhdGlvbmFsIGFzIHJhaWQgZGlzayAxDQpbICAg
MzAuMTA3OTU0XSBtZC9yYWlkOm1kMzogZGV2aWNlIHNkYTUgb3BlcmF0aW9uYWwgYXMgcmFp
ZCBkaXNrIDANClsgICAzMC4xMTQyMzhdIG1kL3JhaWQ6bWQzOiBkZXZpY2Ugc2RjNSBvcGVy
YXRpb25hbCBhcyByYWlkIGRpc2sgMg0KWyAgIDMwLjEyMjU3MF0gbWQvcmFpZDptZDM6IGFs
bG9jYXRlZCA0OTM4NmtCDQpbICAgMzAuMTI4NzM4XSBtZC9yYWlkOm1kMzogcmFpZCBsZXZl
bCA1IGFjdGl2ZSB3aXRoIDMgb3V0IG9mIDMgZGV2aWNlcywgYWxnb3JpdGhtIDINClsgICAz
MC4xMzQ4MDNdIFJBSUQgY29uZiBwcmludG91dDoNClsgICAzMC4xMzQ4MDldICAtLS0gbGV2
ZWw6NSByZDozIHdkOjMNClsgICAzMC4xMzQ4MTRdICBkaXNrIDAsIG86MSwgZGV2OnNkYTUN
ClsgICAzMC4xMzQ4MTldICBkaXNrIDEsIG86MSwgZGV2OnNkYjUNClsgICAzMC4xMzQ4MjRd
ICBkaXNrIDIsIG86MSwgZGV2OnNkYzUNClsgICAzMC4xMzUzNjhdIGNyZWF0ZWQgYml0bWFw
ICgxIHBhZ2VzKSBmb3IgZGV2aWNlIG1kMw0KWyAgIDMwLjE0MTc3MF0gbWQzOiBiaXRtYXAg
aW5pdGlhbGl6ZWQgZnJvbSBkaXNrOiByZWFkIDEgcGFnZXMsIHNldCAwIG9mIDkgYml0cw0K
WyAgIDMwLjE1MTgyMV0gbWQzOiBkZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRv
IDQ3MTQxMzU1NTINClsgICAzMC4xNTc5MjldIG1kOiBjb25zaWRlcmluZyBzZGI0IC4uLg0K
WyAgIDMwLjE2Mzg5NF0gbWQ6ICBhZGRpbmcgc2RiNCAuLi4NClsgICAzMC4xNjk4NTVdIG1k
OiBzZGIzIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGI0DQpbICAgMzAuMTc1ODE4XSBtZDog
c2RiMSBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RiNA0KWyAgIDMwLjE4MTY2OV0gbWQ6ICBh
ZGRpbmcgc2RhNCAuLi4NClsgICAzMC4xODc1NTZdIG1kOiBzZGEzIGhhcyBkaWZmZXJlbnQg
VVVJRCB0byBzZGI0DQpbICAgMzAuMTkzNDcyXSBtZDogc2RhMSBoYXMgZGlmZmVyZW50IFVV
SUQgdG8gc2RiNA0KWyAgIDMwLjE5OTM4Nl0gbWQ6ICBhZGRpbmcgc2RjNCAuLi4NClsgICAz
MC4yMDUyNjFdIG1kOiBzZGMzIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGI0DQpbICAgMzAu
MjExMjY2XSBtZDogc2RjMSBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RiNA0KWyAgIDMwLjIx
ODA3NV0gbWQ6IGNyZWF0ZWQgbWQyDQpbICAgMzAuMjIzOTQyXSBtZDogYmluZDxzZGM0Pg0K
WyAgIDMwLjIyOTk2M10gbWQ6IGJpbmQ8c2RhND4NClsgICAzMC4yMzU4NTZdIG1kOiBiaW5k
PHNkYjQ+DQpbICAgMzAuMjQxNzM4XSBtZDogcnVubmluZzoNClsgICAzMC4yNDE5MTBdIDxz
ZGI0Pg0KWyAgIDMwLjI0Nzc4M10gPHNkYTQ+DQpbICAgMzAuMjQ3OTI3XSA8c2RjND4NCg0K
WyAgIDMwLjI2MDczOV0gbWQvcmFpZDptZDI6IGRldmljZSBzZGI0IG9wZXJhdGlvbmFsIGFz
IHJhaWQgZGlzayAxDQpbICAgMzAuMjY2OTIyXSBtZC9yYWlkOm1kMjogZGV2aWNlIHNkYTQg
b3BlcmF0aW9uYWwgYXMgcmFpZCBkaXNrIDANClsgICAzMC4yNzMxNDddIG1kL3JhaWQ6bWQy
OiBkZXZpY2Ugc2RjNCBvcGVyYXRpb25hbCBhcyByYWlkIGRpc2sgMg0KWyAgIDMwLjI4MTU0
Ml0gbWQvcmFpZDptZDI6IGFsbG9jYXRlZCA0OTM4NmtCDQpbICAgMzAuMjg3Nzk5XSBtZC9y
YWlkOm1kMjogcmFpZCBsZXZlbCA1IGFjdGl2ZSB3aXRoIDMgb3V0IG9mIDMgZGV2aWNlcywg
YWxnb3JpdGhtIDINClsgICAzMC4yOTQxNjhdIFJBSUQgY29uZiBwcmludG91dDoNClsgICAz
MC4yOTQxNzNdICAtLS0gbGV2ZWw6NSByZDozIHdkOjMNClsgICAzMC4yOTQxNzldICBkaXNr
IDAsIG86MSwgZGV2OnNkYTQNClsgICAzMC4yOTQxODVdICBkaXNrIDEsIG86MSwgZGV2OnNk
YjQNClsgICAzMC4yOTQxOTBdICBkaXNrIDIsIG86MSwgZGV2OnNkYzQNClsgICAzMC4yOTQ3
NTldIGNyZWF0ZWQgYml0bWFwICgxIHBhZ2VzKSBmb3IgZGV2aWNlIG1kMg0KWyAgIDMwLjMw
MTYwM10gbWQyOiBiaXRtYXAgaW5pdGlhbGl6ZWQgZnJvbSBkaXNrOiByZWFkIDEgcGFnZXMs
IHNldCAwIG9mIDIwNCBiaXRzDQpbICAgMzAuMzE0ODUzXSBtZDI6IGRldGVjdGVkIGNhcGFj
aXR5IGNoYW5nZSBmcm9tIDAgdG8gMTA5NTIxNDAzOTA0DQpbICAgMzAuMzIxNjU3XSBtZDog
Y29uc2lkZXJpbmcgc2RiMyAuLi4NClsgICAzMC4zMjg0NzhdIG1kOiAgYWRkaW5nIHNkYjMg
Li4uDQpbICAgMzAuMzM1MjIwXSBtZDogc2RiMSBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2Ri
Mw0KWyAgIDMwLjM0MTk4MF0gbWQ6ICBhZGRpbmcgc2RhMyAuLi4NClsgICAzMC4zNDg3OTJd
IG1kOiBzZGExIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGIzDQpbICAgMzAuMzU1NzM4XSBt
ZDogIGFkZGluZyBzZGMzIC4uLg0KWyAgIDMwLjM2MjU2Nl0gbWQ6IHNkYzEgaGFzIGRpZmZl
cmVudCBVVUlEIHRvIHNkYjMNClsgICAzMC4zNzAxODldIG1kOiBjcmVhdGVkIG1kMQ0KWyAg
IDMwLjM3Njc5NF0gbWQ6IGJpbmQ8c2RjMz4NClsgICAzMC4zODMzNDZdIG1kOiBiaW5kPHNk
YTM+DQpbICAgMzAuMzg5NzY1XSBtZDogYmluZDxzZGIzPg0KWyAgIDMwLjM5NTk1MV0gbWQ6
IHJ1bm5pbmc6DQpbICAgMzAuMzk2MTAyXSA8c2RiMz4NClsgICAzMC40MDIyMTBdIDxzZGEz
Pg0KWyAgIDMwLjQwMjM3NF0gPHNkYzM+DQoNClsgICAzMC40MTU3ODldIG1kL3JhaWQ6bWQx
OiBkZXZpY2Ugc2RiMyBvcGVyYXRpb25hbCBhcyByYWlkIGRpc2sgMQ0KWyAgIDMwLjQyMjI3
Nl0gbWQvcmFpZDptZDE6IGRldmljZSBzZGEzIG9wZXJhdGlvbmFsIGFzIHJhaWQgZGlzayAw
DQpbICAgMzAuNDI4ODIyXSBtZC9yYWlkOm1kMTogZGV2aWNlIHNkYzMgb3BlcmF0aW9uYWwg
YXMgcmFpZCBkaXNrIDINClsgICAzMC40MzczNTFdIG1kL3JhaWQ6bWQxOiBhbGxvY2F0ZWQg
NDkzODZrQg0KWyAgIDMwLjQ0Mzg1MV0gbWQvcmFpZDptZDE6IHJhaWQgbGV2ZWwgNSBhY3Rp
dmUgd2l0aCAzIG91dCBvZiAzIGRldmljZXMsIGFsZ29yaXRobSAyDQpbICAgMzAuNDUwNDk4
XSBSQUlEIGNvbmYgcHJpbnRvdXQ6DQpbICAgMzAuNDUwNTA0XSAgLS0tIGxldmVsOjUgcmQ6
MyB3ZDozDQpbICAgMzAuNDUwNTA5XSAgZGlzayAwLCBvOjEsIGRldjpzZGEzDQpbICAgMzAu
NDUwNTE0XSAgZGlzayAxLCBvOjEsIGRldjpzZGIzDQpbICAgMzAuNDUwNTE5XSAgZGlzayAy
LCBvOjEsIGRldjpzZGMzDQpbICAgMzAuNDUxMDY2XSBjcmVhdGVkIGJpdG1hcCAoMSBwYWdl
cykgZm9yIGRldmljZSBtZDENClsgICAzMC40NTgxNTBdIG1kMTogYml0bWFwIGluaXRpYWxp
emVkIGZyb20gZGlzazogcmVhZCAxIHBhZ2VzLCBzZXQgMCBvZiA0NCBiaXRzDQpbICAgMzAu
NDc4NjU1XSBtZDE6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8gMjM2MjIw
NTc5ODQNClsgICAzMC40ODU2NjhdIG1kOiBjb25zaWRlcmluZyBzZGIxIC4uLg0KWyAgIDMw
LjQ5Mjc0Nl0gbWQ6ICBhZGRpbmcgc2RiMSAuLi4NClsgICAzMC40OTk4MjBdIG1kOiAgYWRk
aW5nIHNkYTEgLi4uDQpbICAgMzAuNTA2ODMzXSBtZDogIGFkZGluZyBzZGMxIC4uLg0KWyAg
IDMwLjUxMzgyM10gbWQ6IGNyZWF0ZWQgbWQwDQpbICAgMzAuNTIwODkwXSBtZDogYmluZDxz
ZGMxPg0KWyAgIDMwLjUyNzk2OV0gbWQ6IGJpbmQ8c2RhMT4NClsgICAzMC41MzQ4NDFdIG1k
OiBiaW5kPHNkYjE+DQpbICAgMzAuNTQxNjM0XSBtZDogcnVubmluZzoNClsgICAzMC41NDE4
MDRdIDxzZGIxPg0KWyAgIDMwLjU0ODQzN10gPHNkYTE+DQpbICAgMzAuNTQ4NTgxXSA8c2Rj
MT4NCg0KWyAgIDMwLjU2MzEzMV0gbWQvcmFpZDptZDA6IGRldmljZSBzZGIxIG9wZXJhdGlv
bmFsIGFzIHJhaWQgZGlzayAxDQpbICAgMzAuNTcwMTU0XSBtZC9yYWlkOm1kMDogZGV2aWNl
IHNkYTEgb3BlcmF0aW9uYWwgYXMgcmFpZCBkaXNrIDANClsgICAzMC41NzcwNjZdIG1kL3Jh
aWQ6bWQwOiBkZXZpY2Ugc2RjMSBvcGVyYXRpb25hbCBhcyByYWlkIGRpc2sgMg0KWyAgIDMw
LjU4NTkyNF0gbWQvcmFpZDptZDA6IGFsbG9jYXRlZCA0OTM4NmtCDQpbICAgMzAuNTkyNTYw
XSBtZC9yYWlkOm1kMDogcmFpZCBsZXZlbCA1IGFjdGl2ZSB3aXRoIDMgb3V0IG9mIDMgZGV2
aWNlcywgYWxnb3JpdGhtIDINClsgICAzMC41OTkyMDJdIFJBSUQgY29uZiBwcmludG91dDoN
ClsgICAzMC41OTkyMDddICAtLS0gbGV2ZWw6NSByZDozIHdkOjMNClsgICAzMC41OTkyMTNd
ICBkaXNrIDAsIG86MSwgZGV2OnNkYTENClsgICAzMC41OTkyMThdICBkaXNrIDEsIG86MSwg
ZGV2OnNkYjENClsgICAzMC41OTkyMjNdICBkaXNrIDIsIG86MSwgZGV2OnNkYzENClsgICAz
MC41OTk3OTBdIGNyZWF0ZWQgYml0bWFwICgxIHBhZ2VzKSBmb3IgZGV2aWNlIG1kMA0KWyAg
IDMwLjYwNjk3OV0gbWQwOiBiaXRtYXAgaW5pdGlhbGl6ZWQgZnJvbSBkaXNrOiByZWFkIDEg
cGFnZXMsIHNldCA3IG9mIDggYml0cw0KWyAgIDMwLjYyMjgyMF0gbWQwOiBkZXRlY3RlZCBj
YXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDQyOTQ3MDUxNTINClsgICAzMC42Mjk2OTNdIG1k
OiAuLi4gYXV0b3J1biBET05FLg0KWyAgIDMxLjYzNDAxMF0gWEZTIChtZDApOiBNb3VudGlu
ZyBWNCBGaWxlc3lzdGVtDQpbICAgMzQuMTcwMzAyXSBYRlMgKG1kMCk6IEVuZGluZyBjbGVh
biBtb3VudA0KWyAgIDM0LjE3NzQ4Ml0gVkZTOiBNb3VudGVkIHJvb3QgKHhmcyBmaWxlc3lz
dGVtKSByZWFkb25seSBvbiBkZXZpY2UgOTowLg0KWyAgIDM0LjE4NzM1NV0gZGV2dG1wZnM6
IG1vdW50ZWQNClsgICAzNC4xOTU0ODVdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6
IDMyMEsgKGE4MDAwMDAwMjA4YjAwMDAgLSBhODAwMDAwMDIwOTAwMDAwKQ0KWyAgIDM0LjIw
Mjg1OV0gVGhpcyBhcmNoaXRlY3R1cmUgZG9lcyBub3QgaGF2ZSBrZXJuZWwgbWVtb3J5IHBy
b3RlY3Rpb24uDQpbICAgNDYuNTc1NDE2XSB1ZGV2ZFs1OTNdOiBzdGFydGluZyB2ZXJzaW9u
IDMuMi4xDQpbICAgNDcuMjYwMDYxXSB1ZGV2ZFs1OTNdOiBzcGVjaWZpZWQgZ3JvdXAgJ3Zp
ZGVvJyB1bmtub3duDQpbICAgNDcuMjYxMDYxXSB1ZGV2ZFs1OTNdOiBzcGVjaWZpZWQgZ3Jv
dXAgJ3RhcGUnIHVua25vd24NClsgICA0Ny4zNzgxMTRdIHVkZXZkWzU5NF06IHN0YXJ0aW5n
IGV1ZGV2LTMuMi4xDQpbICAgNDcuODQ5MTk0XSB1ZGV2ZFs1OTRdOiBzcGVjaWZpZWQgZ3Jv
dXAgJ3ZpZGVvJyB1bmtub3duDQpbICAgNDcuODUwMjA2XSB1ZGV2ZFs1OTRdOiBzcGVjaWZp
ZWQgZ3JvdXAgJ3RhcGUnIHVua25vd24NClsgICA1MS44NjcyOThdIEFkZGluZyAxMDQ4NTEy
ayBzd2FwIG9uIC9kZXYvc2RhMi4gIFByaW9yaXR5OjEgZXh0ZW50czoxIGFjcm9zczoxMDQ4
NTEyaw0KWyAgIDUxLjg4MzM0Ml0gQWRkaW5nIDEwNDg1MTJrIHN3YXAgb24gL2Rldi9zZGIy
LiAgUHJpb3JpdHk6MSBleHRlbnRzOjEgYWNyb3NzOjEwNDg1MTJrDQpbICAgNTEuOTA2MzE1
XSBBZGRpbmcgMTA0ODUxMmsgc3dhcCBvbiAvZGV2L3NkYzIuICBQcmlvcml0eToxIGV4dGVu
dHM6MSBhY3Jvc3M6MTA0ODUxMmsNClsgICA1Mi4yNzM5OThdIFhGUyAobWQxKTogTW91bnRp
bmcgVjUgRmlsZXN5c3RlbQ0KWyAgIDU0LjM1NjI5MF0gWEZTIChtZDEpOiBFbmRpbmcgY2xl
YW4gbW91bnQNClsgICA1NC4zNzg2NDddIFhGUyAobWQyKTogTW91bnRpbmcgVjUgRmlsZXN5
c3RlbQ0KWyAgIDU0Ljg3Nzc2Ml0gWEZTIChtZDIpOiBFbmRpbmcgY2xlYW4gbW91bnQNClsg
ICA1NC45MzQ2NDhdIFhGUyAobWQzKTogTW91bnRpbmcgVjUgRmlsZXN5c3RlbQ0KWyAgIDU1
LjQwMjQwMl0gWEZTIChtZDMpOiBFbmRpbmcgY2xlYW4gbW91bnQNClsgICA1NS40MTgyNTBd
IFhGUyAobWQ0KTogTW91bnRpbmcgVjUgRmlsZXN5c3RlbQ0KWyAgIDU1Ljk1MDI5MF0gWEZT
IChtZDQpOiBFbmRpbmcgY2xlYW4gbW91bnQNCg==
--------------4C5C23CE0FF9E9C9F06872E4
Content-Type: text/plain; charset=UTF-8;
 name="ip30-lspci-20170208.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ip30-lspci-20170208.txt"

MDAwMDowMDowMC4wIFNDU0kgc3RvcmFnZSBjb250cm9sbGVyOiBRTG9naWMgQ29ycC4gSVNQ
MTAyMCBGYXN0LXdpZGUgU0NTSSAocmV2IDA1KQ0KICAgICAgICBDb250cm9sOiBJL08rIE1l
bSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0
ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBEaXNJTlR4LQ0KICAgICAgICBTdGF0dXM6IENhcC0g
NjZNSHotIFVERi0gRmFzdEIyQi0gUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxU
QWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5UeC0NCiAgICAgICAgTGF0ZW5jeTog
NjQsIENhY2hlIExpbmUgU2l6ZTogMjU2IGJ5dGVzDQogICAgICAgIEludGVycnVwdDogcGlu
IEEgcm91dGVkIHRvIElSUSAwDQogICAgICAgIFJlZ2lvbiAwOiBJL08gcG9ydHMgYXQgZjEw
MDAwMDAwMCBbc2l6ZT0yNTddDQogICAgICAgIFJlZ2lvbiAxOiBbdmlydHVhbF0gTWVtb3J5
IGF0IGYwODAwMDAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NDA5N10N
CiAgICAgICAgUmVnaW9uIDI6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9u
LXByZWZldGNoYWJsZSkgW3NpemU9Ml0NCiAgICAgICAgUmVnaW9uIDM6IE1lbW9yeSBhdCA8
dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9Ml0NCiAgICAg
ICAgUmVnaW9uIDQ6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZl
dGNoYWJsZSkgW3NpemU9Ml0NCiAgICAgICAgUmVnaW9uIDU6IE1lbW9yeSBhdCA8dW5hc3Np
Z25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9Ml0NCiAgICAgICAgRXhw
YW5zaW9uIFJPTSBhdCBmMDgwMDEwMDAwIFtkaXNhYmxlZF0gW3NpemU9NjU1MzddDQogICAg
ICAgIEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBxbGExMjgwDQpsc3BjaTogVW5hYmxlIHRvIGxv
YWQgbGlia21vZCByZXNvdXJjZXM6IGVycm9yIC0xMg0KDQowMDAwOjAwOjAxLjAgU0NTSSBz
dG9yYWdlIGNvbnRyb2xsZXI6IFFMb2dpYyBDb3JwLiBJU1AxMDIwIEZhc3Qtd2lkZSBTQ1NJ
IChyZXYgMDUpDQogICAgICAgIENvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWND
eWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RC
MkItIERpc0lOVHgtDQogICAgICAgIFN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJC
LSBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLSBJTlR4LQ0KICAgICAgICBMYXRlbmN5OiA2NCwgQ2FjaGUgTGluZSBTaXpl
OiAyNTYgYnl0ZXMNCiAgICAgICAgSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDEN
CiAgICAgICAgUmVnaW9uIDA6IEkvTyBwb3J0cyBhdCBmMTAwMDAwMTAwIFtzaXplPTI1N10N
CiAgICAgICAgUmVnaW9uIDE6IE1lbW9yeSBhdCBmMDgwMDIwMDAwICgzMi1iaXQsIG5vbi1w
cmVmZXRjaGFibGUpIFtzaXplPTQwOTddDQogICAgICAgIFJlZ2lvbiAyOiBNZW1vcnkgYXQg
PHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAg
ICAgIFJlZ2lvbiAzOiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVm
ZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiA0OiBNZW1vcnkgYXQgPHVuYXNz
aWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAgIFJl
Z2lvbiA1OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFi
bGUpIFtzaXplPTJdDQogICAgICAgIEV4cGFuc2lvbiBST00gYXQgZjA4MDAzMDAwMCBbZGlz
YWJsZWRdIFtzaXplPTY1NTM3XQ0KICAgICAgICBLZXJuZWwgZHJpdmVyIGluIHVzZTogcWxh
MTI4MA0KDQowMDAwOjAwOjAyLjAgVW5hc3NpZ25lZCBjbGFzcyBbZmYwMF06IFNpbGljb24g
R3JhcGhpY3MgSW50bC4gQ29ycC4gSU9DMyBJL08gY29udHJvbGxlciAocmV2IDAxKQ0KICAg
ICAgICBDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUtIE1lbVdJTlYt
IFZHQVNub29wLSBQYXJFcnIrIFN0ZXBwaW5nLSBTRVJSKyBGYXN0QjJCLSBEaXNJTlR4LQ0K
ICAgICAgICBTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIyQisgUGFyRXJyLSBERVZT
RUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8UEVSUi0gSU5U
eC0NCiAgICAgICAgTGF0ZW5jeTogNjQNCiAgICAgICAgSW50ZXJydXB0OiBwaW4gQSByb3V0
ZWQgdG8gSVJRIDINCiAgICAgICAgUmVnaW9uIDA6IE1lbW9yeSBhdCBmMDgwMTAwMDAwICgz
Mi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTEwNDg1NzddDQogICAgICAgIFJlZ2lv
biAxOiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUp
IFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiAyOiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgz
Mi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiAzOiBN
ZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXpl
PTJdDQogICAgICAgIFJlZ2lvbiA0OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQs
IG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiA1OiBNZW1vcnkg
YXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQog
ICAgICAgIEV4cGFuc2lvbiBST00gYXQgPHVuYXNzaWduZWQ+IFtkaXNhYmxlZF0gW3NpemU9
Ml0NCiAgICAgICAgS2VybmVsIGRyaXZlciBpbiB1c2U6IElPQzMNCg0KMDAwMDowMDowMy4w
IE5vbi1WR0EgdW5jbGFzc2lmaWVkIGRldmljZTogU2lsaWNvbiBHcmFwaGljcyBJbnRsLiBD
b3JwLiBSQUQgQXVkaW8gKHJldiBjMCkNCiAgICAgICAgQ29udHJvbDogSS9PLSBNZW0rIEJ1
c01hc3RlcisgU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGlu
Zy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0NCiAgICAgICAgU3RhdHVzOiBDYXAtIDY2TUh6
LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPXNsb3cgPlRBYm9ydCsgPFRBYm9ydC0g
PE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQ0KICAgICAgICBMYXRlbmN5OiAyNTUNCiAg
ICAgICAgUmVnaW9uIDA6IE1lbW9yeSBhdCAwMDYwMDAwMCAoMzItYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbc2l6ZT04MTkzXQ0KICAgICAgICBSZWdpb24gMTogTWVtb3J5IGF0IDx1bmFz
c2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBS
ZWdpb24gMjogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hh
YmxlKSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gMzogTWVtb3J5IGF0IDx1bmFzc2lnbmVk
PiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24g
NDogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBb
c2l6ZT0yXQ0KICAgICAgICBSZWdpb24gNTogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzIt
Yml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBFeHBhbnNpb24gUk9N
IGF0IDx1bmFzc2lnbmVkPiBbZGlzYWJsZWRdIFtzaXplPTJdDQoNCjAwMDE6MDA6MDEuMCBD
b21tdW5pY2F0aW9uIGNvbnRyb2xsZXI6IENvbXRyb2wgQ29ycG9yYXRpb24gRGV2aWNlIDA4
MGUgKHJldiAwMSkNCiAgICAgICAgU3Vic3lzdGVtOiBDb210cm9sIENvcnBvcmF0aW9uIERl
dmljZSAwODBlDQogICAgICAgIENvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXItIFNwZWND
eWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RC
MkItIERpc0lOVHgtDQogICAgICAgIFN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJC
KyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLSBJTlR4LQ0KICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJ
UlEgMA0KICAgICAgICBSZWdpb24gMDogTWVtb3J5IGF0IDFkMjA3MTAwICgzMi1iaXQsIG5v
bi1wcmVmZXRjaGFibGUpIFtzaXplPTEyOV0NCiAgICAgICAgUmVnaW9uIDE6IEkvTyBwb3J0
cyBhdCAxZGEwMDQwMCBbc2l6ZT0xMjldDQogICAgICAgIFJlZ2lvbiAyOiBJL08gcG9ydHMg
YXQgMWRhMDAwMDAgW3NpemU9MjU3XQ0KICAgICAgICBSZWdpb24gMzogTWVtb3J5IGF0IDx1
bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAg
ICBSZWdpb24gNDogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gNTogTWVtb3J5IGF0IDx1bmFzc2ln
bmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBFeHBh
bnNpb24gUk9NIGF0IDx1bmFzc2lnbmVkPiBbZGlzYWJsZWRdIFtzaXplPTJdDQoNCjAwMDE6
MDA6MDIuMCBVU0IgY29udHJvbGxlcjogVUxpIEVsZWN0cm9uaWNzIEluYy4gVVNCIDEuMSBD
b250cm9sbGVyIChyZXYgMDMpIChwcm9nLWlmIDEwIFtPSENJXSkNCiAgICAgICAgU3Vic3lz
dGVtOiBVTGkgRWxlY3Ryb25pY3MgSW5jLiBBU1JvY2sgOTM5RHVhbC1TQVRBMiBNb3RoZXJi
b2FyZA0KICAgICAgICBDb250cm9sOiBJL08rIE1lbSsgQnVzTWFzdGVyKyBTcGVjQ3ljbGUt
IE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0QjJCLSBE
aXNJTlR4LQ0KICAgICAgICBTdGF0dXM6IENhcCsgNjZNSHorIFVERi0gRmFzdEIyQisgUGFy
RXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJSLSA8
UEVSUi0gSU5UeC0NCiAgICAgICAgTGF0ZW5jeTogMTYgKDIwMDAwbnMgbWF4KQ0KICAgICAg
ICBJbnRlcnJ1cHQ6IHBpbiBCIHJvdXRlZCB0byBJUlEgMA0KICAgICAgICBSZWdpb24gMDog
TWVtb3J5IGF0IDFkMjA0MDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTQw
OTddDQogICAgICAgIFJlZ2lvbiAxOiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQs
IG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiAyOiBNZW1vcnkg
YXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQog
ICAgICAgIFJlZ2lvbiAzOiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1w
cmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiA0OiBNZW1vcnkgYXQgPHVu
YXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAg
IFJlZ2lvbiA1OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRj
aGFibGUpIFtzaXplPTJdDQogICAgICAgIEV4cGFuc2lvbiBST00gYXQgPHVuYXNzaWduZWQ+
IFtkaXNhYmxlZF0gW3NpemU9Ml0NCiAgICAgICAgQ2FwYWJpbGl0aWVzOiBbNjBdIFBvd2Vy
IE1hbmFnZW1lbnQgdmVyc2lvbiAyDQogICAgICAgICAgICAgICAgRmxhZ3M6IFBNRUNsay0g
RFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDErLEQyLSxEM2hvdCssRDNj
b2xkKykNCiAgICAgICAgICAgICAgICBTdGF0dXM6IEQwIE5vU29mdFJzdC0gUE1FLUVuYWJs
ZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0NCg0KMDAwMTowMDowMi4xIFVTQiBjb250cm9sbGVy
OiBVTGkgRWxlY3Ryb25pY3MgSW5jLiBVU0IgMS4xIENvbnRyb2xsZXIgKHJldiAwMykgKHBy
b2ctaWYgMTAgW09IQ0ldKQ0KICAgICAgICBTdWJzeXN0ZW06IFVMaSBFbGVjdHJvbmljcyBJ
bmMuIEFTUm9jayA5MzlEdWFsLVNBVEEyIE1vdGhlcmJvYXJkDQogICAgICAgIENvbnRyb2w6
IEkvTy0gTWVtLSBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBh
ckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtDQogICAgICAgIFN0YXR1
czogQ2FwKyA2Nk1IeisgVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRB
Ym9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQ0KICAgICAgICBJ
bnRlcnJ1cHQ6IHBpbiBDIHJvdXRlZCB0byBJUlEgMA0KICAgICAgICBSZWdpb24gMDogTWVt
b3J5IGF0IDFkMjA1MDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0g
W3NpemU9NDA5N10NCiAgICAgICAgUmVnaW9uIDE6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4g
KDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yXQ0KICAgICAg
ICBSZWdpb24gMjogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0
Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiAzOiBNZW1vcnkg
YXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0g
W3NpemU9Ml0NCiAgICAgICAgUmVnaW9uIDQ6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMy
LWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yXQ0KICAgICAgICBS
ZWdpb24gNTogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hh
YmxlKSBbZGlzYWJsZWRdIFtzaXplPTJdDQogICAgICAgIEV4cGFuc2lvbiBST00gYXQgPHVu
YXNzaWduZWQ+IFtkaXNhYmxlZF0gW3NpemU9Ml0NCiAgICAgICAgQ2FwYWJpbGl0aWVzOiBb
NjBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyDQogICAgICAgICAgICAgICAgRmxhZ3M6
IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCssRDErLEQyLSxE
M2hvdCssRDNjb2xkKykNCiAgICAgICAgICAgICAgICBTdGF0dXM6IEQwIE5vU29mdFJzdC0g
UE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0NCg0KMDAwMTowMDowMi4yIFVTQiBj
b250cm9sbGVyOiBVTGkgRWxlY3Ryb25pY3MgSW5jLiBVU0IgMS4xIENvbnRyb2xsZXIgKHJl
diAwMykgKHByb2ctaWYgMTAgW09IQ0ldKQ0KICAgICAgICBTdWJzeXN0ZW06IFVMaSBFbGVj
dHJvbmljcyBJbmMuIEFTUm9jayA5MzlEdWFsLVNBVEEyIE1vdGhlcmJvYXJkDQogICAgICAg
IENvbnRyb2w6IEkvTy0gTWVtLSBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdB
U25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtDQogICAg
ICAgIFN0YXR1czogQ2FwKyA2Nk1IeisgVURGLSBGYXN0QjJCKyBQYXJFcnItIERFVlNFTD1t
ZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQ0K
ICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBEIHJvdXRlZCB0byBJUlEgMA0KICAgICAgICBSZWdp
b24gMDogTWVtb3J5IGF0IDFkMjA2MDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtk
aXNhYmxlZF0gW3NpemU9NDA5N10NCiAgICAgICAgUmVnaW9uIDE6IE1lbW9yeSBhdCA8dW5h
c3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0y
XQ0KICAgICAgICBSZWdpb24gMjogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBu
b24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiAz
OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtk
aXNhYmxlZF0gW3NpemU9Ml0NCiAgICAgICAgUmVnaW9uIDQ6IE1lbW9yeSBhdCA8dW5hc3Np
Z25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yXQ0K
ICAgICAgICBSZWdpb24gNTogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24t
cHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTJdDQogICAgICAgIEV4cGFuc2lvbiBS
T00gYXQgPHVuYXNzaWduZWQ+IFtkaXNhYmxlZF0gW3NpemU9Ml0NCiAgICAgICAgQ2FwYWJp
bGl0aWVzOiBbNjBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAyDQogICAgICAgICAgICAg
ICAgRmxhZ3M6IFBNRUNsay0gRFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMCss
RDErLEQyLSxEM2hvdCssRDNjb2xkKykNCiAgICAgICAgICAgICAgICBTdGF0dXM6IEQwIE5v
U29mdFJzdC0gUE1FLUVuYWJsZS0gRFNlbD0wIERTY2FsZT0wIFBNRS0NCg0KMDAwMTowMDow
Mi4zIFVTQiBjb250cm9sbGVyOiBVTGkgRWxlY3Ryb25pY3MgSW5jLiBVU0IgMi4wIENvbnRy
b2xsZXIgKHJldiAwMSkgKHByb2ctaWYgMjAgW0VIQ0ldKQ0KICAgICAgICBTdWJzeXN0ZW06
IFVMaSBFbGVjdHJvbmljcyBJbmMuIEFTUm9jayA5MzlEdWFsLVNBVEEyIE1vdGhlcmJvYXJk
DQogICAgICAgIENvbnRyb2w6IEkvTy0gTWVtLSBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVt
V0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lO
VHgtDQogICAgICAgIFN0YXR1czogQ2FwKyA2Nk1IeisgVURGLSBGYXN0QjJCKyBQYXJFcnIt
IERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJS
LSBJTlR4LQ0KICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMA0KICAg
ICAgICBSZWdpb24gMDogTWVtb3J5IGF0IDFkMjA3MDAwICgzMi1iaXQsIG5vbi1wcmVmZXRj
aGFibGUpIFtkaXNhYmxlZF0gW3NpemU9MjU3XQ0KICAgICAgICBSZWdpb24gMTogTWVtb3J5
IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRd
IFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiAyOiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgz
Mi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0gW3NpemU9Ml0NCiAgICAgICAg
UmVnaW9uIDM6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNo
YWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gNDogTWVtb3J5IGF0
IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRdIFtz
aXplPTJdDQogICAgICAgIFJlZ2lvbiA1OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1i
aXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0gW3NpemU9Ml0NCiAgICAgICAgRXhw
YW5zaW9uIFJPTSBhdCA8dW5hc3NpZ25lZD4gW2Rpc2FibGVkXSBbc2l6ZT0yXQ0KICAgICAg
ICBDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDINCiAgICAg
ICAgICAgICAgICBGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVudD0wbUEg
UE1FKEQwKyxEMS0sRDItLEQzaG90KyxEM2NvbGQrKQ0KICAgICAgICAgICAgICAgIFN0YXR1
czogRDAgTm9Tb2Z0UnN0LSBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQ0KICAg
ICAgICBDYXBhYmlsaXRpZXM6IFs1OF0gRGVidWcgcG9ydDogQkFSPTEgb2Zmc2V0PTAwOTAN
Cg0KMDAwMTowMDowMy4wIEV0aGVybmV0IGNvbnRyb2xsZXI6IFNpbGljb24gR3JhcGhpY3Mg
SW50bC4gQ29ycC4gQWNlTklDIEdpZ2FiaXQgRXRoZXJuZXQgKHJldiAwMSkNCiAgICAgICAg
U3Vic3lzdGVtOiBTaWxpY29uIEdyYXBoaWNzIEludGwuIENvcnAuIEFjZU5JQyBHaWdhYml0
IEV0aGVybmV0DQogICAgICAgIENvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWND
eWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RC
MkItIERpc0lOVHgtDQogICAgICAgIFN0YXR1czogQ2FwLSA2Nk1IeisgVURGLSBGYXN0QjJC
KyBQYXJFcnItIERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNF
UlItIDxQRVJSLSBJTlR4LQ0KICAgICAgICBMYXRlbmN5OiA2NCAoMTYwMDBucyBtaW4pLCBD
YWNoZSBMaW5lIFNpemU6IDEyOCBieXRlcw0KICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBBIHJv
dXRlZCB0byBJUlEgNA0KICAgICAgICBSZWdpb24gMDogW3ZpcnR1YWxdIE1lbW9yeSBhdCBk
MDgwMDAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTE2Mzg1XQ0KICAg
ICAgICBSZWdpb24gMTogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJl
ZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gMjogTWVtb3J5IGF0IDx1bmFz
c2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBS
ZWdpb24gMzogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hh
YmxlKSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gNDogTWVtb3J5IGF0IDx1bmFzc2lnbmVk
PiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24g
NTogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBb
c2l6ZT0yXQ0KICAgICAgICBFeHBhbnNpb24gUk9NIGF0IDx1bmFzc2lnbmVkPiBbZGlzYWJs
ZWRdIFtzaXplPTJdDQogICAgICAgIEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBhY2VuaWMNCg==
--------------4C5C23CE0FF9E9C9F06872E4
Content-Type: text/plain; charset=UTF-8;
 name="ip27-lspci-20170208.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ip27-lspci-20170208.txt"

MDAwMTowMDowMC4wIFVuYXNzaWduZWQgY2xhc3MgW2ZmMDBdOiBTaWxpY29uIEdyYXBoaWNz
IEludGwuIENvcnAuIExpbmMgSS9PIGNvbnRyb2xsZXINCiAgICAgICAgQ29udHJvbDogSS9P
LSBNZW0tIEJ1c01hc3Rlci0gU3BlY0N5Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJy
LSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0gRGlzSU5UeC0NCiAgICAgICAgU3RhdHVzOiBD
YXAtIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0
LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItIElOVHgtDQogICAgICAgIE5VTUEg
bm9kZTogMA0KICAgICAgICBSZWdpb24gMDogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzIt
Yml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTEzNDIxNzcyOV0NCiAg
ICAgICAgUmVnaW9uIDE6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXBy
ZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gMjogTWVt
b3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJs
ZWRdIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiAzOiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+
ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0gW3NpemU9Ml0NCiAgICAg
ICAgUmVnaW9uIDQ6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZl
dGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gNTogTWVtb3J5
IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRd
IFtzaXplPTJdDQogICAgICAgIEV4cGFuc2lvbiBST00gYXQgPHVuYXNzaWduZWQ+IFtkaXNh
YmxlZF0gW3NpemU9Ml0NCmxzcGNpOiBVbmFibGUgdG8gbG9hZCBsaWJrbW9kIHJlc291cmNl
czogZXJyb3IgLTEyDQoNCjAwMDE6MDA6MDEuMCBVbmFzc2lnbmVkIGNsYXNzIFtmZjAwXTog
U2lsaWNvbiBHcmFwaGljcyBJbnRsLiBDb3JwLiBMaW5jIEkvTyBjb250cm9sbGVyDQogICAg
ICAgIENvbnRyb2w6IEkvTy0gTWVtLSBCdXNNYXN0ZXItIFNwZWNDeWNsZS0gTWVtV0lOVi0g
VkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lOVHgtDQog
ICAgICAgIFN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnItIERFVlNF
TD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4
LQ0KICAgICAgICBOVU1BIG5vZGU6IDANCiAgICAgICAgUmVnaW9uIDA6IE1lbW9yeSBhdCA8
dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6
ZT0xMzQyMTc3MjldDQogICAgICAgIFJlZ2lvbiAxOiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+
ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0gW3NpemU9Ml0NCiAgICAg
ICAgUmVnaW9uIDI6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZl
dGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gMzogTWVtb3J5
IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRd
IFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiA0OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgz
Mi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtkaXNhYmxlZF0gW3NpemU9Ml0NCiAgICAgICAg
UmVnaW9uIDU6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNo
YWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yXQ0KICAgICAgICBFeHBhbnNpb24gUk9NIGF0IDx1
bmFzc2lnbmVkPiBbZGlzYWJsZWRdIFtzaXplPTJdDQoNCjAwMDI6MDA6MDAuMCBTQ1NJIHN0
b3JhZ2UgY29udHJvbGxlcjogUUxvZ2ljIENvcnAuIElTUDEwMjAgRmFzdC13aWRlIFNDU0kg
KHJldiAwNSkNCiAgICAgICAgQ29udHJvbDogSS9PKyBNZW0rIEJ1c01hc3RlcisgU3BlY0N5
Y2xlLSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIy
Qi0gRGlzSU5UeC0NCiAgICAgICAgU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZhc3RCMkIt
IFBhckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VS
Ui0gPFBFUlItIElOVHgtDQogICAgICAgIExhdGVuY3k6IDY0LCBDYWNoZSBMaW5lIFNpemU6
IDI1NiBieXRlcw0KICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgMQ0K
ICAgICAgICBOVU1BIG5vZGU6IDANCiAgICAgICAgUmVnaW9uIDA6IEkvTyBwb3J0cyBhdCBm
MjAwMDAwIFtzaXplPTI1N10NCiAgICAgICAgUmVnaW9uIDE6IE1lbW9yeSBhdCAwZjIwMDAw
MCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT00MDk3XQ0KICAgICAgICBSZWdp
b24gMjogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gMzogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAo
MzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gNDog
TWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6
ZT0yXQ0KICAgICAgICBSZWdpb24gNTogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0
LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBFeHBhbnNpb24gUk9NIGF0
IDx1bmFzc2lnbmVkPiBbZGlzYWJsZWRdIFtzaXplPTY1NTM3XQ0KICAgICAgICBLZXJuZWwg
ZHJpdmVyIGluIHVzZTogcWxhMTI4MA0KDQowMDAyOjAwOjAxLjAgU0NTSSBzdG9yYWdlIGNv
bnRyb2xsZXI6IFFMb2dpYyBDb3JwLiBJU1AxMDIwIEZhc3Qtd2lkZSBTQ1NJIChyZXYgMDUp
DQogICAgICAgIENvbnRyb2w6IEkvTysgTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVt
V0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItIERpc0lO
VHgtDQogICAgICAgIFN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJCLSBQYXJFcnIt
IERFVlNFTD1tZWRpdW0gPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJS
LSBJTlR4LQ0KICAgICAgICBMYXRlbmN5OiA2NCwgQ2FjaGUgTGluZSBTaXplOiAyNTYgYnl0
ZXMNCiAgICAgICAgSW50ZXJydXB0OiBwaW4gQSByb3V0ZWQgdG8gSVJRIDINCiAgICAgICAg
TlVNQSBub2RlOiAwDQogICAgICAgIFJlZ2lvbiAwOiBJL08gcG9ydHMgYXQgZjQwMDAwMCBb
c2l6ZT0yNTddDQogICAgICAgIFJlZ2lvbiAxOiBNZW1vcnkgYXQgMGY0MDAwMDAgKDMyLWJp
dCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9NDA5N10NCiAgICAgICAgUmVnaW9uIDI6IE1l
bW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9
Ml0NCiAgICAgICAgUmVnaW9uIDM6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwg
bm9uLXByZWZldGNoYWJsZSkgW3NpemU9Ml0NCiAgICAgICAgUmVnaW9uIDQ6IE1lbW9yeSBh
dCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9Ml0NCiAg
ICAgICAgUmVnaW9uIDU6IE1lbW9yeSBhdCA8dW5hc3NpZ25lZD4gKDMyLWJpdCwgbm9uLXBy
ZWZldGNoYWJsZSkgW3NpemU9Ml0NCiAgICAgICAgRXhwYW5zaW9uIFJPTSBhdCA8dW5hc3Np
Z25lZD4gW2Rpc2FibGVkXSBbc2l6ZT02NTUzN10NCiAgICAgICAgS2VybmVsIGRyaXZlciBp
biB1c2U6IHFsYTEyODANCg0KMDAwMjowMDowMi4wIFVuYXNzaWduZWQgY2xhc3MgW2ZmMDBd
OiBTaWxpY29uIEdyYXBoaWNzIEludGwuIENvcnAuIElPQzMgSS9PIGNvbnRyb2xsZXIgKHJl
diAwMSkNCiAgICAgICAgQ29udHJvbDogSS9PLSBNZW0rIEJ1c01hc3RlcisgU3BlY0N5Y2xl
LSBNZW1XSU5WLSBWR0FTbm9vcC0gUGFyRXJyLSBTdGVwcGluZy0gU0VSUi0gRmFzdEIyQi0g
RGlzSU5UeC0NCiAgICAgICAgU3RhdHVzOiBDYXAtIDY2TUh6LSBVREYtIEZhc3RCMkIrIFBh
ckVyci0gREVWU0VMPW1lZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0g
PFBFUlItIElOVHgtDQogICAgICAgIExhdGVuY3k6IDI1NQ0KICAgICAgICBJbnRlcnJ1cHQ6
IHBpbiBBIHJvdXRlZCB0byBJUlEgMw0KICAgICAgICBOVU1BIG5vZGU6IDANCiAgICAgICAg
UmVnaW9uIDA6IE1lbW9yeSBhdCAwZjYwMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT0xMDQ4NTc3XQ0KICAgICAgICBSZWdpb24gMTogTWVtb3J5IGF0IDx1bmFzc2ln
bmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBSZWdp
b24gMjogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gMzogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAo
MzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBSZWdpb24gNDog
TWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6
ZT0yXQ0KICAgICAgICBSZWdpb24gNTogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0
LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0yXQ0KICAgICAgICBFeHBhbnNpb24gUk9NIGF0
IDx1bmFzc2lnbmVkPiBbZGlzYWJsZWRdIFtzaXplPTJdDQogICAgICAgIEtlcm5lbCBkcml2
ZXIgaW4gdXNlOiBpb2MzLWV0aA0KDQowMDAyOjAwOjA2LjAgVW5hc3NpZ25lZCBjbGFzcyBb
ZmYwMF06IFNpbGljb24gR3JhcGhpY3MgSW50bC4gQ29ycC4gSU9DMyBJL08gY29udHJvbGxl
ciAocmV2IDAxKQ0KICAgICAgICBDb250cm9sOiBJL08tIE1lbSsgQnVzTWFzdGVyKyBTcGVj
Q3ljbGUtIE1lbVdJTlYtIFZHQVNub29wLSBQYXJFcnItIFN0ZXBwaW5nLSBTRVJSLSBGYXN0
QjJCLSBEaXNJTlR4LQ0KICAgICAgICBTdGF0dXM6IENhcC0gNjZNSHotIFVERi0gRmFzdEIy
QisgUGFyRXJyLSBERVZTRUw9bWVkaXVtID5UQWJvcnQtIDxUQWJvcnQtIDxNQWJvcnQtID5T
RVJSLSA8UEVSUi0gSU5UeC0NCiAgICAgICAgTGF0ZW5jeTogMjU1DQogICAgICAgIEludGVy
cnVwdDogcGluIEEgcm91dGVkIHRvIElSUSA0DQogICAgICAgIE5VTUEgbm9kZTogMA0KICAg
ICAgICBSZWdpb24gMDogTWVtb3J5IGF0IDBmYTAwMDAwICgzMi1iaXQsIG5vbi1wcmVmZXRj
aGFibGUpIFtzaXplPTEwNDg1NzddDQogICAgICAgIFJlZ2lvbiAxOiBNZW1vcnkgYXQgPHVu
YXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAg
IFJlZ2lvbiAyOiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRj
aGFibGUpIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiAzOiBNZW1vcnkgYXQgPHVuYXNzaWdu
ZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAgIFJlZ2lv
biA0OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUp
IFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiA1OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgz
Mi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTJdDQogICAgICAgIEV4cGFuc2lvbiBS
T00gYXQgPHVuYXNzaWduZWQ+IFtkaXNhYmxlZF0gW3NpemU9Ml0NCiAgICAgICAgS2VybmVs
IGRyaXZlciBpbiB1c2U6IGlvYzMtZXRoDQoNCjAwMDI6MDA6MDcuMCBOb24tVkdBIHVuY2xh
c3NpZmllZCBkZXZpY2U6IFNpbGljb24gR3JhcGhpY3MgSW50bC4gQ29ycC4gUkFEIEF1ZGlv
IChyZXYgNzApDQogICAgICAgIENvbnRyb2w6IEkvTy0gTWVtLSBCdXNNYXN0ZXItIFNwZWND
eWNsZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RC
MkItIERpc0lOVHgtDQogICAgICAgIFN0YXR1czogQ2FwLSA2Nk1Iei0gVURGLSBGYXN0QjJC
KyBQYXJFcnItIERFVlNFTD1zbG93ID5UQWJvcnQrIDxUQWJvcnQtIDxNQWJvcnQtID5TRVJS
LSA8UEVSUi0gSU5UeC0NCiAgICAgICAgTlVNQSBub2RlOiAwDQogICAgICAgIFJlZ2lvbiAw
OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtk
aXNhYmxlZF0gW3NpemU9ODE5M10NCiAgICAgICAgUmVnaW9uIDE6IE1lbW9yeSBhdCA8dW5h
c3NpZ25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0y
XQ0KICAgICAgICBSZWdpb24gMjogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBu
b24tcHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTJdDQogICAgICAgIFJlZ2lvbiAz
OiBNZW1vcnkgYXQgPHVuYXNzaWduZWQ+ICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtk
aXNhYmxlZF0gW3NpemU9Ml0NCiAgICAgICAgUmVnaW9uIDQ6IE1lbW9yeSBhdCA8dW5hc3Np
Z25lZD4gKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yXQ0K
ICAgICAgICBSZWdpb24gNTogTWVtb3J5IGF0IDx1bmFzc2lnbmVkPiAoMzItYml0LCBub24t
cHJlZmV0Y2hhYmxlKSBbZGlzYWJsZWRdIFtzaXplPTJdDQogICAgICAgIEV4cGFuc2lvbiBS
T00gYXQgPHVuYXNzaWduZWQ+IFtkaXNhYmxlZF0gW3NpemU9Ml0NCg==
--------------4C5C23CE0FF9E9C9F06872E4
Content-Type: text/plain; charset=UTF-8;
 name="ip27-dmesg-working_pci-20170208.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ip27-dmesg-working_pci-20170208.txt"

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA0LjEwLjAtcmM3IChyb290QGhlbGNhcmF4
ZSkgKGdjYyB2ZXJzaW9uIDYuMy4wIChHZW50b28gSGFyZGVuZWQgNi4zLjAgcDEuMCkgKSAj
MSBTTVAgV2VkIEZlYiA4IDAzOjU1OjA0IEVTVCAyMDE3DQpbICAgIDAuMDAwMDAwXSBBUkNI
OiBTR0ktSVAyNw0KWyAgICAwLjAwMDAwMF0gUFJPTUxJQjogQVJDIGZpcm13YXJlIFZlcnNp
b24gNjQgUmV2aXNpb24gMA0KWyAgICAwLjAwMDAwMF0gRGlzY292ZXJlZCA0IGNwdXMgb24g
MiBub2Rlcw0KWyAgICAwLjAwMDAwMF0gbm9kZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0K
WyAgICAwLjAwMDAwMF0gbm9kZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0KWyAgICAwLjAw
MDAwMF0gbm9kZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0KWyAgICAwLjAwMDAwMF0gbm9k
ZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0KWyAgICAwLjAwMDAwMF0gKioqKioqKioqKioq
KiogVG9wb2xvZ3kgKioqKioqKioqKioqKioqKioqKioNClsgICAgMC4wMDAwMDBdDQpbICAg
IDAuMDAwMDAwXSAwMA0KWyAgICAwLjAwMDAwMF0gMDENCg0KWyAgICAwLjAwMDAwMF0gMDAN
ClsgICAgMC4wMDAwMDBdIDI1NQ0KWyAgICAwLjAwMDAwMF0gMjU1DQoNClsgICAgMC4wMDAw
MDBdIDAxDQpbICAgIDAuMDAwMDAwXSAyNTUNClsgICAgMC4wMDAwMDBdIDI1NQ0KDQpbICAg
IDAuMDAwMDAwXSBib290Y29uc29sZSBbZWFybHkwXSBlbmFibGVkDQpbICAgIDAuMDAwMDAw
XSBDUFUwIHJldmlzaW9uIGlzOiAwMDAwMGYxNCAoUjE0MDAwKQ0KWyAgICAwLjAwMDAwMF0g
RlBVIHJldmlzaW9uIGlzOiAwMDAwMDkwMA0KWyAgICAwLjAwMDAwMF0gQ2hlY2tpbmcgZm9y
IHRoZSBtdWx0aXBseS9zaGlmdCBidWcuLi4gbm8uDQpbICAgIDAuMDAwMDAwXSBDaGVja2lu
ZyBmb3IgdGhlIGRhZGRpdSBidWcuLi4gbm8uDQpbICAgIDAuMDAwMDAwXSBJUDI3OiBSdW5u
aW5nIG9uIG5vZGUgMC4NClsgICAgMC4wMDAwMDBdIE5vZGUgMCBoYXMgYSBwcmltYXJ5IENQ
VSwgQ1BVIGlzIHJ1bm5pbmcuDQpbICAgIDAuMDAwMDAwXSBOb2RlIDAgaGFzIGEgc2Vjb25k
YXJ5IENQVSwgQ1BVIGlzIHJ1bm5pbmcuDQpbICAgIDAuMDAwMDAwXSBNYWNoaW5lIGlzIGlu
IE0gbW9kZS4NClsgICAgMC4wMDAwMDBdIENwdSAwLCBOYXNpZCAweDA6IHBhcnRudW0gMHgw
IGlzDQpbICAgIDAuMDAwMDAwXSBpcyB4Ym93DQpbICAgIDAuMDAwMDAwXSBDcHUgMCwgTmFz
aWQgMHgwLCB3aWRnZXQgMHg4IChwYXJ0bnVtIDB4YzEwMikgaXMNClsgICAgMC4wMDAwMDBd
IENwdSAwLCBOYXNpZCAweDAsIHdpZGdldCAweGIgKHBhcnRudW0gMHhjMDAyKSBpcw0KWyAg
ICAwLjAwMDAwMF0gQ3B1IDAsIE5hc2lkIDB4MCwgd2lkZ2V0IDB4YyAocGFydG51bSAweGMw
MDIpIGlzDQpbICAgIDAuMDAwMDAwXSBDcHUgMCwgTmFzaWQgMHgwLCB3aWRnZXQgMHhkIChw
YXJ0bnVtIDB4YzAwMykgaXMNClsgICAgMC4wMDAwMDBdIENwdSAwLCBOYXNpZCAweDAsIHdp
ZGdldCAweGYgKHBhcnRudW0gMHhjMDAyKSBpcw0KWyAgICAwLjAwMDAwMF0gQ1BVIDAgY2xv
Y2sgaXMgNTAwTUh6Lg0KWyAgICAwLjAwMDAwMF0gRGV0ZXJtaW5lZCBwaHlzaWNhbCBSQU0g
bWFwOg0KWyAgICAwLjAwMDAwMF0gIG1lbW9yeTogMDAwMDAwMDAwMDZlMDAwMCBAIDAwMDAw
MDAwMDAwMTAwMDAgKHVzYWJsZSkNClsgICAgMC4wMDAwMDBdICBtZW1vcnk6IDAwMDAwMDAw
MDAwNTAwMDAgQCAwMDAwMDAwMDAwNmYwMDAwICh1c2FibGUgYWZ0ZXIgaW5pdCkNClsgICAg
MC4wMDAwMDBdIGNtYTogUmVzZXJ2ZWQgNTEyIE1pQiBhdCAweDAwMDAwMDAxZTAwMDAwMDAN
ClsgICAgMC4wMDAwMDBdIFJFUExJQ0FUSU9OOiBPTiBuYXNpZCAwLCBrdGV4dCBmcm9tIG5h
c2lkIDAsIGtkYXRhIGZyb20gbmFzaWQgMA0KWyAgICAwLjAwMDAwMF0gUkVQTElDQVRJT046
IE9OIG5hc2lkIDEsIGt0ZXh0IGZyb20gbmFzaWQgMCwga2RhdGEgZnJvbSBuYXNpZCAwDQpb
ICAgIDAuMDAwMDAwXSBQcmltYXJ5IGluc3RydWN0aW9uIGNhY2hlIDMya0IsIFZJUFQsIDIt
d2F5LCBsaW5lc2l6ZSA2NCBieXRlcy4NClsgICAgMC4wMDAwMDBdIFByaW1hcnkgZGF0YSBj
YWNoZSAzMmtCLCAyLXdheSwgVklQVCwgbm8gYWxpYXNlcywgbGluZXNpemUgMzIgYnl0ZXMN
ClsgICAgMC4wMDAwMDBdIFVuaWZpZWQgc2Vjb25kYXJ5IGNhY2hlIDgxOTJrQiAyLXdheSwg
bGluZXNpemUgMTI4IGJ5dGVzLg0KWyAgICAwLjAwMDAwMF0gWm9uZSByYW5nZXM6DQpbICAg
IDAuMDAwMDAwXSAgIE5vcm1hbCAgIFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAw
MDFmZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdIE1vdmFibGUgem9uZSBzdGFydCBmb3IgZWFj
aCBub2RlDQpbICAgIDAuMDAwMDAwXSBFYXJseSBtZW1vcnkgbm9kZSByYW5nZXMNClsgICAg
MC4wMDAwMDBdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAw
MDBmZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdICAgbm9kZSAgIDE6IFttZW0gMHgwMDAwMDAw
MTAwMDAwMDAwLTB4MDAwMDAwMDFmZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdIEluaXRtZW0g
c2V0dXAgbm9kZSAwIFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDBmZmZmZmZm
Zl0NClsgICAgMC4wMDAwMDBdIE9uIG5vZGUgMCB0b3RhbHBhZ2VzOiA2NTUzNg0KWyAgICAw
LjAwMDAwMF0gZnJlZV9hcmVhX2luaXRfbm9kZTogbm9kZSAwLCBwZ2RhdCBhODAwMDAwMDAw
N2YwMDAwLCBub2RlX21lbV9tYXAgYTgwMDAwMDAwMTAwMDAwMA0KWyAgICAwLjAwMDAwMF0g
ICBOb3JtYWwgem9uZTogNjQgcGFnZXMgdXNlZCBmb3IgbWVtbWFwDQpbICAgIDAuMDAwMDAw
XSAgIE5vcm1hbCB6b25lOiAwIHBhZ2VzIHJlc2VydmVkDQpbICAgIDAuMDAwMDAwXSAgIE5v
cm1hbCB6b25lOiA2NTUzNiBwYWdlcywgTElGTyBiYXRjaDoxDQpbICAgIDAuMDAwMDAwXSBJ
bml0bWVtIHNldHVwIG5vZGUgMSBbbWVtIDB4MDAwMDAwMDEwMDAwMDAwMC0weDAwMDAwMDAx
ZmZmZmZmZmZdDQpbICAgIDAuMDAwMDAwXSBPbiBub2RlIDEgdG90YWxwYWdlczogNjU1MzYN
ClsgICAgMC4wMDAwMDBdIGZyZWVfYXJlYV9pbml0X25vZGU6IG5vZGUgMSwgcGdkYXQgYTgw
MDAwMDEwMDAzMDAwMCwgbm9kZV9tZW1fbWFwIGE4MDAwMDAxMDAwNTAwMDANClsgICAgMC4w
MDAwMDBdICAgTm9ybWFsIHpvbmU6IDY0IHBhZ2VzIHVzZWQgZm9yIG1lbW1hcA0KWyAgICAw
LjAwMDAwMF0gICBOb3JtYWwgem9uZTogMCBwYWdlcyByZXNlcnZlZA0KWyAgICAwLjAwMDAw
MF0gICBOb3JtYWwgem9uZTogNjU1MzYgcGFnZXMsIExJRk8gYmF0Y2g6MQ0KWyAgICAwLjAw
MDAwMF0gcGVyY3B1OiBFbWJlZGRlZCAyIHBhZ2VzL2NwdSBAYTgwMDAwMDAwMTQzMDAwMCBz
NjAwNjQgcjAgZDcxMDA4IHUxMzEwNzINClsgICAgMC4wMDAwMDBdIHBjcHUtYWxsb2M6IHM2
MDA2NCByMCBkNzEwMDggdTEzMTA3MiBhbGxvYz0yKjY1NTM2DQpbICAgIDAuMDAwMDAwXSBw
Y3B1LWFsbG9jOiBbMF0gMCBbMF0gMSBbMF0gMiBbMF0gMw0KWyAgICAwLjAwMDAwMF0gQnVp
bHQgMiB6b25lbGlzdHMgaW4gTm9kZSBvcmRlciwgbW9iaWxpdHkgZ3JvdXBpbmcgb24uICBU
b3RhbCBwYWdlczogMTMwOTQ0DQpbICAgIDAuMDAwMDAwXSBQb2xpY3kgem9uZTogTm9ybWFs
DQpbICAgIDAuMDAwMDAwXSBLZXJuZWwgY29tbWFuZCBsaW5lOiByb290PWRrc2MoMCwxLDAp
IGNvbnNvbGU9dHR5UzAsOTYwMCByb290PS9kZXYvbWQwDQpbICAgIDAuMDAwMDAwXSBQSUQg
aGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogLTEsIDMyNzY4IGJ5dGVzKQ0KWyAg
ICAwLjAwMDAwMF0gTWVtb3J5OiA3ODQ2Nzg0Sy84Mzg4NjA4SyBhdmFpbGFibGUgKDUxNzJL
IGtlcm5lbCBjb2RlLCA2NzhLIHJ3ZGF0YSwgMTExNksgcm9kYXRhLCAzMjBLIGluaXQsIDcw
MEsgYnNzLCAxNzUzNksgcmVzZXJ2ZWQsIDUyNDI4OEsgY21hLXJlc2VydmVkKQ0KWyAgICAw
LjAwMDAwMF0gSGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4NClsgICAgMC4wMDAw
MDBdICBCdWlsZC10aW1lIGFkanVzdG1lbnQgb2YgbGVhZiBmYW5vdXQgdG8gNjQuDQpbICAg
IDAuMDAwMDAwXSAgUkNVIHJlc3RyaWN0aW5nIENQVXMgZnJvbSBOUl9DUFVTPTY0IHRvIG5y
X2NwdV9pZHM9NC4NClsgICAgMC4wMDAwMDBdIFJDVTogQWRqdXN0aW5nIGdlb21ldHJ5IGZv
ciByY3VfZmFub3V0X2xlYWY9NjQsIG5yX2NwdV9pZHM9NA0KWyAgICAwLjAwMDAwMF0gTlJf
SVJRUzoyNTYNClsgICAgMC4wMDAwMDBdIGNsb2Nrc291cmNlOiBIVUItUlQ6IG1hc2s6IDB4
ZmZmZmZmZmZmZmZmZiBtYXhfY3ljbGVzOiAweDEyNzM1MGI4OCwgbWF4X2lkbGVfbnM6IDE3
NjMxODA4MDg0ODAgbnMNClsgICAgMC4wMDAwMTJdIHNjaGVkX2Nsb2NrOiA1MiBiaXRzIGF0
IDEyNTBrSHosIHJlc29sdXRpb24gODAwbnMsIHdyYXBzIGV2ZXJ5IDQzOTgwNDY1MTA4MDBu
cw0KWyAgICAwLjEwMzE3NV0gQ29uc29sZTogY29sb3VyIGR1bW15IGRldmljZSA4MHgyNQ0K
WyAgICAwLjE1NjI0NF0gQ2FsaWJyYXRpbmcgZGVsYXkgbG9vcC4uLiA3NDkuNTYgQm9nb01J
UFMgKGxwaj0zNzQ3ODQwKQ0KWyAgICAwLjMxODQ5Nl0gcGlkX21heDogZGVmYXVsdDogMzI3
NjggbWluaW11bTogMzAxDQpbICAgIDAuMzc4MzI0XSBEZW50cnkgY2FjaGUgaGFzaCB0YWJs
ZSBlbnRyaWVzOiAxMDQ4NTc2IChvcmRlcjogNywgODM4ODYwOCBieXRlcykNClsgICAgMC41
Nzc5MzBdIElub2RlLWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTI0Mjg4IChvcmRlcjog
NiwgNDE5NDMwNCBieXRlcykNClsgICAgMC43MjAzOTBdIE1vdW50LWNhY2hlIGhhc2ggdGFi
bGUgZW50cmllczogMTYzODQgKG9yZGVyOiAxLCAxMzEwNzIgYnl0ZXMpDQpbICAgIDAuODAx
MjMzXSBNb3VudHBvaW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVy
OiAxLCAxMzEwNzIgYnl0ZXMpDQpbICAgIDAuOTAwNzgwXSBDaGVja2luZyBmb3IgdGhlIGRh
ZGRpIGJ1Zy4uLiBuby4NClsgICAgMC45NTc4MjhdIHNtcDogQnJpbmdpbmcgdXAgc2Vjb25k
YXJ5IENQVXMgLi4uDQpbICAgIDEuMDEyNzcwXSBQcmltYXJ5IGluc3RydWN0aW9uIGNhY2hl
IDMya0IsIFZJUFQsIDItd2F5LCBsaW5lc2l6ZSA2NCBieXRlcy4NClsgICAgMS4wMTI3ODZd
IFByaW1hcnkgZGF0YSBjYWNoZSAzMmtCLCAyLXdheSwgVklQVCwgbm8gYWxpYXNlcywgbGlu
ZXNpemUgMzIgYnl0ZXMNClsgICAgMS4wMTI3OTRdIFVuaWZpZWQgc2Vjb25kYXJ5IGNhY2hl
IDgxOTJrQiAyLXdheSwgbGluZXNpemUgMTI4IGJ5dGVzLg0KWyAgICAxLjAxNTk1OV0gQ1BV
IDEgY2xvY2sgaXMgNTAwTUh6Lg0KWyAgICAxLjAxNTk4MV0gQ1BVMSByZXZpc2lvbiBpczog
MDAwMDBmMTQgKFIxNDAwMCkNClsgICAgMS4wMTU5ODRdIEZQVSByZXZpc2lvbiBpczogMDAw
MDA5MDANClsgICAgMS4wNTQwNzZdIFByaW1hcnkgaW5zdHJ1Y3Rpb24gY2FjaGUgMzJrQiwg
VklQVCwgMi13YXksIGxpbmVzaXplIDY0IGJ5dGVzLg0KWyAgICAxLjA1NDA5Nl0gUHJpbWFy
eSBkYXRhIGNhY2hlIDMya0IsIDItd2F5LCBWSVBULCBubyBhbGlhc2VzLCBsaW5lc2l6ZSAz
MiBieXRlcw0KWyAgICAxLjA1NDEwNV0gVW5pZmllZCBzZWNvbmRhcnkgY2FjaGUgODE5MmtC
IDItd2F5LCBsaW5lc2l6ZSAxMjggYnl0ZXMuDQpbICAgIDEuMDU3MzMzXSBDcHUgMiwgTmFz
aWQgMHgxOiBwYXJ0bnVtIDB4MCBpcw0KWyAgICAxLjA1NzM1Nl0gaXMgeGJvdw0KWyAgICAx
LjA1NzQwMF0gQ1BVIDIgY2xvY2sgaXMgNTAwTUh6Lg0KWyAgICAxLjA1NzQxN10gQ1BVMiBy
ZXZpc2lvbiBpczogMDAwMDBmMTQgKFIxNDAwMCkNClsgICAgMS4wNTc0MjFdIEZQVSByZXZp
c2lvbiBpczogMDAwMDA5MDANClsgICAgMS4wOTQ0NDBdIFByaW1hcnkgaW5zdHJ1Y3Rpb24g
Y2FjaGUgMzJrQiwgVklQVCwgMi13YXksIGxpbmVzaXplIDY0IGJ5dGVzLg0KWyAgICAxLjA5
NDQ1OV0gUHJpbWFyeSBkYXRhIGNhY2hlIDMya0IsIDItd2F5LCBWSVBULCBubyBhbGlhc2Vz
LCBsaW5lc2l6ZSAzMiBieXRlcw0KWyAgICAxLjA5NDQ2OF0gVW5pZmllZCBzZWNvbmRhcnkg
Y2FjaGUgODE5MmtCIDItd2F5LCBsaW5lc2l6ZSAxMjggYnl0ZXMuDQpbICAgIDEuMDk3NzA0
XSBDUFUgMyBjbG9jayBpcyA1MDBNSHouDQpbICAgIDEuMDk3NzMyXSBDUFUzIHJldmlzaW9u
IGlzOiAwMDAwMGYxNCAoUjE0MDAwKQ0KWyAgICAxLjA5NzczNl0gRlBVIHJldmlzaW9uIGlz
OiAwMDAwMDkwMA0KWyAgICAxLjEzMTI4Nl0gc21wOiBCcm91Z2h0IHVwIDIgbm9kZXMsIDQg
Q1BVcw0KWyAgICAyLjQyNTEwOF0gZGV2dG1wZnM6IGluaXRpYWxpemVkDQpbICAgIDIuNDY0
MjY0XSBjbG9ja3NvdXJjZTogamlmZmllczogbWFzazogMHhmZmZmZmZmZiBtYXhfY3ljbGVz
OiAweGZmZmZmZmZmLCBtYXhfaWRsZV9uczogMTkxMTI2MDQ0NjI3NTAwMDAgbnMNClsgICAg
Mi41ODU5OTFdIHhvcjogbWVhc3VyaW5nIHNvZnR3YXJlIGNoZWNrc3VtIHNwZWVkDQpbICAg
IDIuNzQxOTIwXSAgICA4cmVncyAgICAgOiAgIDcxMC40MDAgTUIvc2VjDQpbICAgIDIuODkw
NTY0XSAgICA4cmVnc19wcmVmZXRjaDogICA2ODQuODAwIE1CL3NlYw0KWyAgICAzLjA0MzM3
N10gICAgMzJyZWdzICAgIDogICA2NTkuMjAwIE1CL3NlYw0KWyAgICAzLjE3MTI3M10gcmFu
ZG9tOiBmYXN0IGluaXQgZG9uZQ0KWyAgICAzLjE5MTk3MV0gICAgMzJyZWdzX3ByZWZldGNo
OiAgIDY0MC4wMDAgTUIvc2VjDQpbICAgIDMuMTkxOTc5XSB4b3I6IHVzaW5nIGZ1bmN0aW9u
OiA4cmVncyAoNzEwLjQwMCBNQi9zZWMpDQpbICAgIDMuMzI5NTUzXSBORVQ6IFJlZ2lzdGVy
ZWQgcHJvdG9jb2wgZmFtaWx5IDE2DQpbICAgIDMuNDQyMDY3XSBjcHVpZGxlOiB1c2luZyBn
b3Zlcm5vciBsYWRkZXINClsgICAgMy41NzE1MzhdIGNwdWlkbGU6IHVzaW5nIGdvdmVybm9y
IG1lbnUNClsgICAgMy45MDc0MDJdIHJhaWQ2OiBpbnQ2NHgxICBnZW4oKSAgIDMwOSBNQi9z
DQpbICAgIDQuMTI3MDg0XSByYWlkNjogaW50NjR4MSAgeG9yKCkgICAgNjIgTUIvcw0KWyAg
ICA0LjM0NjgyNF0gcmFpZDY6IGludDY0eDIgIGdlbigpICAgNDQ0IE1CL3MNClsgICAgNC41
NjY2NTVdIHJhaWQ2OiBpbnQ2NHgyICB4b3IoKSAgIDE1MiBNQi9zDQpbICAgIDQuNzg2MzM2
XSByYWlkNjogaW50NjR4NCAgZ2VuKCkgICAzODcgTUIvcw0KWyAgICA1LjAwNjExMV0gcmFp
ZDY6IGludDY0eDQgIHhvcigpICAgMTQxIE1CL3MNClsgICAgNS4yMjU4NjZdIHJhaWQ2OiBp
bnQ2NHg4ICBnZW4oKSAgIDMxNSBNQi9zDQpbICAgIDUuNDQ1ODQwXSByYWlkNjogaW50NjR4
OCAgeG9yKCkgICAxMTYgTUIvcw0KWyAgICA1LjQ5NTI3M10gcmFpZDY6IHVzaW5nIGFsZ29y
aXRobSBpbnQ2NHgyIGdlbigpIDQ0NCBNQi9zDQpbICAgIDUuNTYwMjA2XSByYWlkNjogLi4u
LiB4b3IoKSAxNTIgTUIvcywgcm13IGVuYWJsZWQNClsgICAgNS42MTg4NTZdIHJhaWQ2OiB1
c2luZyBpbnR4MSByZWNvdmVyeSBhbGdvcml0aG0NClsgICAgNS42NzU5MjRdIFNDU0kgc3Vi
c3lzdGVtIGluaXRpYWxpemVkDQpbICAgIDUuNzIxMjM2XSBQQ0kgaG9zdCBicmlkZ2UgdG8g
YnVzIDAwMDI6MDANClsgICAgNS43Njk3MDRdIHBjaV9idXMgMDAwMjowMDogcm9vdCBidXMg
cmVzb3VyY2UgW21lbSAweDkyMDAwMDAwMGYyMDAwMDAtMHg5MjAwMDAwMDBmOWZmZmZmXQ0K
WyAgICA1Ljg2OTE4Ml0gcGNpX2J1cyAwMDAyOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8g
IDB4OTIwMDAwMDAwZmEwMDAwMC0weDkyMDAwMDAwMGZiZmZmZmZdDQpbICAgIDUuOTY4Njgw
XSBwY2lfYnVzIDAwMDI6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMgMDItZmZdDQpbICAg
IDYuMDM0NzE3XSBwY2kgMDAwMjowMDowMC4wOiBbMTA3NzoxMDIwXSB0eXBlIDAwIGNsYXNz
IDB4MDEwMDAwDQpbICAgIDYuMDM0NzczXSBwY2kgMDAwMjowMDowMC4wOiByZWcgMHgxMDog
W2lvICAweGYyMDAwMDAtMHhmMjAwMGZmXQ0KWyAgICA2LjAzNDgwMF0gcGNpIDAwMDI6MDA6
MDAuMDogcmVnIDB4MTQ6IFttZW0gMHgwZjIwMDAwMC0weDBmMjAwZmZmXQ0KWyAgICA2LjAz
NDg5M10gcGNpIDAwMDI6MDA6MDAuMDogcmVnIDB4MzA6IFttZW0gMHgwMDAwMDAwMC0weDAw
MDBmZmZmIHByZWZdDQpbICAgIDYuMDM1MTc1XSBwY2kgMDAwMjowMDowMS4wOiBbMTA3Nzox
MDIwXSB0eXBlIDAwIGNsYXNzIDB4MDEwMDAwDQpbICAgIDYuMDM1MjEzXSBwY2kgMDAwMjow
MDowMS4wOiByZWcgMHgxMDogW2lvICAweGY0MDAwMDAtMHhmNDAwMGZmXQ0KWyAgICA2LjAz
NTI0MF0gcGNpIDAwMDI6MDA6MDEuMDogcmVnIDB4MTQ6IFttZW0gMHgwZjQwMDAwMC0weDBm
NDAwZmZmXQ0KWyAgICA2LjAzNTMzM10gcGNpIDAwMDI6MDA6MDEuMDogcmVnIDB4MzA6IFtt
ZW0gMHgwMDAwMDAwMC0weDAwMDBmZmZmIHByZWZdDQpbICAgIDYuMDM1NTk5XSBwY2kgMDAw
MjowMDowMi4wOiBbMTBhOTowMDAzXSB0eXBlIDAwIGNsYXNzIDB4ZmYwMDAwDQpbICAgIDYu
MDM1NjQxXSBwY2kgMDAwMjowMDowMi4wOiByZWcgMHgxMDogW21lbSAweDBmNjAwMDAwLTB4
MGY2ZmZmZmZdDQpbICAgIDYuMDM2MDEzXSBwY2kgMDAwMjowMDowNi4wOiBbMTBhOTowMDAz
XSB0eXBlIDAwIGNsYXNzIDB4ZmYwMDAwDQpbICAgIDYuMDM2MDU2XSBwY2kgMDAwMjowMDow
Ni4wOiByZWcgMHgxMDogW21lbSAweDBmYTAwMDAwLTB4MGZhZmZmZmZdDQpbICAgIDYuMDM2
NDAxXSBwY2kgMDAwMjowMDowNy4wOiBbMTBhOTowMDA1XSB0eXBlIDAwIGNsYXNzIDB4MDAw
MDAwDQpbICAgIDYuMDM2NDMzXSBwY2kgMDAwMjowMDowNy4wOiByZWcgMHgxMDogW21lbSAw
eDAwMDAwMDAwLTB4MDAwMDFmZmZdDQpbICAgIDYuMDM2OTMzXSBQQ0kgaG9zdCBicmlkZ2Ug
dG8gYnVzIDAwMDE6MDANClsgICAgNi4wODQzMTFdIHBjaV9idXMgMDAwMTowMDogcm9vdCBi
dXMgcmVzb3VyY2UgW21lbSAweDkyMDAwMDAwMGMyMDAwMDAtMHg5MjAwMDAwMDBjOWZmZmZm
XQ0KWyAgICA2LjE4MzgwM10gcGNpX2J1cyAwMDAxOjAwOiByb290IGJ1cyByZXNvdXJjZSBb
aW8gIDB4OTIwMDAwMDAwY2EwMDAwMC0weDkyMDAwMDAwMGNiZmZmZmZdDQpbICAgIDYuMjgz
Mjk3XSBwY2lfYnVzIDAwMDE6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMgMDEtZmZdDQpb
ICAgIDYuMzQ5MzI5XSBwY2kgMDAwMTowMDowMC4wOiBbMTBhOTowMDAyXSB0eXBlIDAwIGNs
YXNzIDB4ZmYwMDAwDQpbICAgIDYuMzQ5MzY5XSBwY2kgMDAwMTowMDowMC4wOiByZWcgMHgx
MDogW21lbSAweDAwMDAwMDAwLTB4MDdmZmZmZmZdDQpbICAgIDYuMzQ5NzcxXSBwY2kgMDAw
MTowMDowMS4wOiBbMTBhOTowMDAyXSB0eXBlIDAwIGNsYXNzIDB4ZmYwMDAwDQpbICAgIDYu
MzQ5ODExXSBwY2kgMDAwMTowMDowMS4wOiByZWcgMHgxMDogW21lbSAweDAwMDAwMDAwLTB4
MDdmZmZmZmZdDQpbICAgIDYuMzUwMzc2XSBQQ0kgaG9zdCBicmlkZ2UgdG8gYnVzIDAwMDA6
MDANClsgICAgNi4zOTg1MTFdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2Ug
W21lbSAweDkyMDAwMDAwMGIyMDAwMDAtMHg5MjAwMDAwMDBiOWZmZmZmXQ0KWyAgICA2LjQ5
ODAwMl0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbaW8gIDB4OTIwMDAw
MDAwYmEwMDAwMC0weDkyMDAwMDAwMGJiZmZmZmZdDQpbICAgIDYuNTk3NTAwXSBwY2lfYnVz
IDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMgMDAtZmZdDQpbICAgIDYuNjY0NTgw
XSBjbG9ja3NvdXJjZTogU3dpdGNoZWQgdG8gY2xvY2tzb3VyY2UgSFVCLVJUDQpbICAgIDYu
NzM3MzQwXSBORVQ6IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDINClsgICAgNi43ODg2
MzFdIFRDUCBlc3RhYmxpc2hlZCBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjog
MywgNTI0Mjg4IGJ5dGVzKQ0KWyAgICA2Ljg3Nzg2MF0gVENQIGJpbmQgaGFzaCB0YWJsZSBl
bnRyaWVzOiA2NTUzNiAob3JkZXI6IDQsIDEwNDg1NzYgYnl0ZXMpDQpbICAgIDYuOTYxOTM4
XSBUQ1A6IEhhc2ggdGFibGVzIGNvbmZpZ3VyZWQgKGVzdGFibGlzaGVkIDY1NTM2IGJpbmQg
NjU1MzYpDQpbICAgIDcuMDM4Nzk2XSBVRFAgaGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2IChv
cmRlcjogMSwgMTMxMDcyIGJ5dGVzKQ0KWyAgICA3LjExMjY2Nl0gVURQLUxpdGUgaGFzaCB0
YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogMSwgMTMxMDcyIGJ5dGVzKQ0KWyAgICA3LjE5
MTY3OF0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxDQpbICAgIDcuMjQzMDAw
XSBQQ0k6IENMUyAyNTYgYnl0ZXMsIGRlZmF1bHQgMTI4DQpbICAgIDcuMjQ0MDMyXSBmdXRl
eCBoYXNoIHRhYmxlIGVudHJpZXM6IDEwMjQgKG9yZGVyOiAxLCAxMzEwNzIgYnl0ZXMpDQpb
ICAgIDcuMzE5ODk2XSB3b3JraW5nc2V0OiB0aW1lc3RhbXBfYml0cz00MCBtYXhfb3JkZXI9
MTcgYnVja2V0X29yZGVyPTANClsgICAgNy4zOTYxODNdIHpidWQ6IGxvYWRlZA0KWyAgICA3
LjQyODY1MF0gU0dJIFhGUyB3aXRoIEFDTHMsIHNlY3VyaXR5IGF0dHJpYnV0ZXMsIHJlYWx0
aW1lLCBubyBkZWJ1ZyBlbmFibGVkDQpbICAgIDcuNTE5OTY5XSBCbG9jayBsYXllciBTQ1NJ
IGdlbmVyaWMgKGJzZykgZHJpdmVyIHZlcnNpb24gMC40IGxvYWRlZCAobWFqb3IgMjUzKQ0K
WyAgICA3LjYwNzE1MF0gaW8gc2NoZWR1bGVyIG5vb3AgcmVnaXN0ZXJlZA0KWyAgICA3LjY1
NDI2OF0gaW8gc2NoZWR1bGVyIGRlYWRsaW5lIHJlZ2lzdGVyZWQNClsgICAgNy43MDU2NDFd
IGlvIHNjaGVkdWxlciBjZnEgcmVnaXN0ZXJlZCAoZGVmYXVsdCkNClsgICAgNy44MjU5MTld
IFNlcmlhbDogODI1MC8xNjU1MCBkcml2ZXIsIDQgcG9ydHMsIElSUSBzaGFyaW5nIGVuYWJs
ZWQNClsgICAgNy45MTUzMzddIGxvb3A6IG1vZHVsZSBsb2FkZWQNClsgICAgNy45NTEzMzBd
IHFsYTEyODA6IFFMQTEwNDAgZm91bmQgb24gUENJIGJ1cyAwLCBkZXYgMA0KWyAgICA4LjAx
MzAxNV0gUENJOiBFbmFibGluZyBkZXZpY2UgMDAwMjowMDowMC4wICgwMDA2IC0+IDAwMDcp
DQpbICAgIDguNTgzNDg5XSByYW5kb206IGNybmcgaW5pdCBkb25lDQpbICAgIDguODQzNTAw
XSBzY3NpKDA6MCk6IFJlc2V0dGluZyBTQ1NJIEJVUw0KWyAgIDExLjkxNDc4OF0gc2NzaSBo
b3N0MDogUUxvZ2ljIFFMQTEwNDAgUENJIHRvIFNDU0kgSG9zdCBBZGFwdGVyDQogICAgICAg
ICAgICAgICAgICAgICAgRmlybXdhcmUgdmVyc2lvbjogIDcuNjUuMDYsIERyaXZlciB2ZXJz
aW9uIDMuMjcuMQ0KWyAgIDEyLjA2ODkwMl0gcWxhMTI4MDogUUxBMTA0MCBmb3VuZCBvbiBQ
Q0kgYnVzIDAsIGRldiAxDQpbICAgMTIuMTI4ODI0XSBQQ0k6IEVuYWJsaW5nIGRldmljZSAw
MDAyOjAwOjAxLjAgKDAwMDYgLT4gMDAwNykNClsgICAxMi4yNDAwMjNdIHNjc2kgMDowOjE6
MDogRGlyZWN0LUFjY2VzcyAgICAgU0VBR0FURSAgU1gxNTAxNzZMQyAgICAgICBCQTEyIFBR
OiAwIEFOU0k6IDINClsgICAxMi4zMzY4MjFdIHNjc2koMDowOjE6MCk6DQpbICAgMTIuMzM2
ODI4XSAgU3luYzogcGVyaW9kIDEwLCBvZmZzZXQgMTINClsgICAxMi4zNjc5NzBdICwgV2lk
ZQ0KWyAgIDEyLjQxNDA1NF0gLCBUYWdnZWQgcXVldWluZzogZGVwdGggMzENCg0KWyAgIDEy
LjUwNzYxM10gc2NzaSAwOjA6MjowOiBEaXJlY3QtQWNjZXNzICAgICBTRUFHQVRFICBTWDE1
MDE3NkxDICAgICAgIEJBMDggUFE6IDAgQU5TSTogMg0KWyAgIDEyLjYwNDI4OV0gc2NzaSgw
OjA6MjowKToNClsgICAxMi42MDQyOTZdICBTeW5jOiBwZXJpb2QgMTAsIG9mZnNldCAxMg0K
WyAgIDEyLjYzNTU2NF0gLCBXaWRlDQpbICAgMTIuNjgxNjQ4XSAsIFRhZ2dlZCBxdWV1aW5n
OiBkZXB0aCAzMQ0KDQpbICAgMTIuNzc1MTY5XSBzY3NpIDA6MDozOjA6IERpcmVjdC1BY2Nl
c3MgICAgIFNFQUdBVEUgIFNYMTUwMTc2TEMgICAgICAgQkEwOCBQUTogMCBBTlNJOiAyDQpb
ICAgMTIuODcxODQ4XSBzY3NpKDA6MDozOjApOg0KWyAgIDEyLjg3MTg1Nl0gIFN5bmM6IHBl
cmlvZCAxMCwgb2Zmc2V0IDEyDQpbICAgMTIuOTAzMTU5XSAsIFdpZGUNClsgICAxMi45NDky
NDJdICwgVGFnZ2VkIHF1ZXVpbmc6IGRlcHRoIDMxDQpbICAgMTIuOTYxNDMyXSBzY3NpKDE6
MCk6IFJlc2V0dGluZyBTQ1NJIEJVUw0KDQpbICAgMTUuODU4MjkyXSBzY3NpIDA6MDo0OjA6
IERpcmVjdC1BY2Nlc3MgICAgIFNFQUdBVEUgIFNYMTUwMTc2TEMgICAgICAgQkExMSBQUTog
MCBBTlNJOiAyDQpbICAgMTUuOTU0NjU2XSBzY3NpKDA6MDo0OjApOg0KWyAgIDE1Ljk1NDY2
NF0gIFN5bmM6IHBlcmlvZCAxMCwgb2Zmc2V0IDEyDQpbICAgMTUuOTg2MjAxXSAsIFdpZGUN
ClsgICAxNi4wMzIyODZdICwgVGFnZ2VkIHF1ZXVpbmc6IGRlcHRoIDMxDQoNClsgICAxNi4x
MTk0NzJdIHNjc2kgaG9zdDE6IFFMb2dpYyBRTEExMDQwIFBDSSB0byBTQ1NJIEhvc3QgQWRh
cHRlcg0KICAgICAgICAgICAgICAgICAgICAgIEZpcm13YXJlIHZlcnNpb246ICA3LjY1LjA2
LCBEcml2ZXIgdmVyc2lvbiAzLjI3LjENClsgICAxNi4yNzUwNjVdIGNvbnNvbGUgW3R0eVMw
XSBkaXNhYmxlZA0KWyAgIDE2LjMzNjUyOF0gc2VyaWFsODI1MDogdHR5UzAgYXQgTU1JTyAw
eDkyMDAwMDAwMGY2MjAxNzggKGlycSA9IDAsIGJhc2VfYmF1ZCA9IDQ1ODMzMykgaXMgYSAx
NjU1MEENClsgICAxNi40NDI2MTJdIGNvbnNvbGUgW3R0eVMwXSBlbmFibGVkDQpbICAgMTYu
NTI1MzY2XSBib290Y29uc29sZSBbZWFybHkwXSBkaXNhYmxlZA0KWyAgIDE2LjY0NjY1Nl0g
c2VyaWFsODI1MDogdHR5UzEgYXQgTU1JTyAweDkyMDAwMDAwMGY2MjAxNzAgKGlycSA9IDAs
IGJhc2VfYmF1ZCA9IDQ1ODMzMykgaXMgYSAxNjU1MEENClsgICAxNi43NTQ3NDRdIHNjc2kg
MDowOjU6MDogRGlyZWN0LUFjY2VzcyAgICAgU0VBR0FURSAgU1gxNTAxNzZMQyAgICAgICBC
QTExIFBROiAwIEFOU0k6IDINClsgICAxNi44NTUzMTNdIHNjc2koMDowOjU6MCk6DQpbICAg
MTYuODU1MzI5XSAgU3luYzogcGVyaW9kIDEwLCBvZmZzZXQgMTINClsgICAxNi44ODc5NDRd
ICwgV2lkZQ0KWyAgIDE2Ljg4OTczOV0gRm91bmQgRFMxOTgxVSBOSUMNClsgICAxNi44ODk3
NDhdICByZWdpc3RyYXRpb24gbnVtYmVyIDVlOjU3OjAzOjAwOjcwOjVlLCBDUkMgNTINClsg
ICAxNi44ODk3NTBdIC4NClsgICAxNi45MDU5OTVdIEV0aGVybmV0IGFkZHJlc3MgaXMgMDg6
MDA6Njk6MDU6NjQ6NzQuDQpbICAgMTYuOTA3Mzc0XSBpb2MzLWV0aCAwMDAyOjAwOjAyLjAg
ZXRoMDogbGluayB1cCwgMTAwTWJwcywgZnVsbC1kdXBsZXgsIGxwYSAweDhERTENClsgICAx
Ni45MDczODFdIGV0aDA6IFVzaW5nIFBIWSAzMSwgdmVuZG9yIDB4MjAwMDVjMCwgbW9kZWwg
MCwgcmV2IDAuDQpbICAgMTYuOTA3Mzg0XSBldGgwOiBJT0MzIFNTUkFNIGhhcyAxMjgga2J5
dGUuDQpbICAgMTYuOTI5NDMyXSBzZXJpYWw4MjUwOiB0dHlTMiBhdCBNTUlPIDB4OTIwMDAw
MDAwZmEyMDE3OCAoaXJxID0gMCwgYmFzZV9iYXVkID0gNDU4MzMzKSBpcyBhIDE2NTUwQQ0K
WyAgIDE2Ljk1MDMzN10gc2VyaWFsODI1MDogdHR5UzMgYXQgTU1JTyAweDkyMDAwMDAwMGZh
MjAxNzAgKGlycSA9IDAsIGJhc2VfYmF1ZCA9IDQ1ODMzMykgaXMgYSAxNjU1MEENClsgICAx
Ni45NTQwNDhdIE5JQyBzZWFyY2ggZmFpbGVkIChub3QgZmF0YWwpLg0KWyAgIDE2Ljk1NjUw
N10gTklDIHNlYXJjaCBmYWlsZWQgKG5vdCBmYXRhbCkuDQpbICAgMTYuOTU3MDA4XSBGYWls
ZWQgdG8gcmVhZCBNQUMgYWRkcmVzcw0KWyAgIDE2Ljk1NzAxMl0gRXRoZXJuZXQgYWRkcmVz
cyBpcyAwMDowMDowMDowMDowMDowMC4NClsgICAxNi45NTgxMzVdIGlvYzMtZXRoIDAwMDI6
MDA6MDYuMCBldGgxOiBsaW5rIGRvd24NClsgICAxNi45NTgxNDJdIGV0aDE6IFVzaW5nIFBI
WSAzMSwgdmVuZG9yIDB4MCwgbW9kZWwgMCwgcmV2IDAuDQpbICAgMTYuOTU4MTQ1XSBldGgx
OiBJT0MzIFNTUkFNIGhhcyA2NCBrYnl0ZS4NClsgICAxNi45NTkxODVdIE5FVDogUmVnaXN0
ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTcNClsgICAxNi45NTk3MzJdIHJ0Yy1tNDh0MzUgcnRj
LW00OHQzNTogcnRjIGNvcmU6IHJlZ2lzdGVyZWQgbTQ4dDM1IGFzIHJ0YzANClsgICAxOC4w
NzM1MzJdICwgVGFnZ2VkIHF1ZXVpbmc6IGRlcHRoIDMxDQoNClsgICAxOC4xMzY2ODNdIHJ0
Yy1tNDh0MzUgcnRjLW00OHQzNTogc2V0dGluZyBzeXN0ZW0gY2xvY2sgdG8gMjAxNy0wMi0w
OCAwODo1Nzo0NCBVVEMgKDE0ODY1NDQyNjQpDQpbICAgMTguMjQ5MTUyXSBzY3NpIDA6MDo2
OjA6IENELVJPTSAgICAgICAgICAgIFRPU0hJQkEgIENELVJPTSBYTS01NzAxVEEgMDE2NyBQ
UTogMCBBTlNJOiAyDQpbICAgMTguMzQ3MzkxXSBzY3NpKDA6MDo2OjApOg0KWyAgIDE4LjM0
NzM5Nl0gIFN5bmM6IHBlcmlvZCAxMCwgb2Zmc2V0IDEyDQoNClsgICAxOS44NDE5NzNdIHNk
IDA6MDozOjA6IFtzZGNdIDk3NjkzNzU1IDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzOiAoNTAu
MCBHQi80Ni42IEdpQikNClsgICAxOS44NDQ1OThdIHNyIDA6MDo2OjA6IFtzcjBdIHNjc2kt
MSBkcml2ZQ0KWyAgIDE5Ljg0NDYwNl0gY2Ryb206IFVuaWZvcm0gQ0QtUk9NIGRyaXZlciBS
ZXZpc2lvbjogMy4yMA0KWyAgIDE5Ljg0NTMyNF0gc3IgMDowOjY6MDogQXR0YWNoZWQgc2Nz
aSBDRC1ST00gc3IwDQpbICAgMTkuOTM0Njk4XSBzZCAwOjA6MjowOiBbc2RiXSA5NzY5Mzc1
NSA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogKDUwLjAgR0IvNDYuNiBHaUIpDQpbICAgMTku
OTM0ODA3XSBzZCAwOjA6MTowOiBbc2RhXSA5NzY5Mzc1NSA1MTItYnl0ZSBsb2dpY2FsIGJs
b2NrczogKDUwLjAgR0IvNDYuNiBHaUIpDQpbICAgMTkuOTM0OTg2XSBzZCAwOjA6NDowOiBb
c2RkXSA5NzY5Mzc1NSA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogKDUwLjAgR0IvNDYuNiBH
aUIpDQpbICAgMTkuOTM1NTcyXSBzZCAwOjA6NTowOiBbc2RlXSA5NzY5Mzc1NSA1MTItYnl0
ZSBsb2dpY2FsIGJsb2NrczogKDUwLjAgR0IvNDYuNiBHaUIpDQpbICAgMTkuOTM2OTkzXSBz
ZCAwOjA6MjowOiBbc2RiXSBXcml0ZSBQcm90ZWN0IGlzIG9mZg0KWyAgIDE5LjkzNzAwNF0g
c2QgMDowOjI6MDogW3NkYl0gTW9kZSBTZW5zZTogY2IgMDAgMTAgMDgNClsgICAxOS45Mzc1
NTZdIHNkIDA6MDoxOjA6IFtzZGFdIFdyaXRlIFByb3RlY3QgaXMgb2ZmDQpbICAgMTkuOTM3
NTY1XSBzZCAwOjA6MTowOiBbc2RhXSBNb2RlIFNlbnNlOiBjYiAwMCAxMCAwOA0KWyAgIDE5
LjkzNzgwM10gc2QgMDowOjQ6MDogW3NkZF0gV3JpdGUgUHJvdGVjdCBpcyBvZmYNClsgICAx
OS45Mzc4MTJdIHNkIDA6MDo0OjA6IFtzZGRdIE1vZGUgU2Vuc2U6IGNiIDAwIDEwIDA4DQpb
ICAgMTkuOTM4MzEwXSBzZCAwOjA6NTowOiBbc2RlXSBXcml0ZSBQcm90ZWN0IGlzIG9mZg0K
WyAgIDE5LjkzODMyMF0gc2QgMDowOjU6MDogW3NkZV0gTW9kZSBTZW5zZTogY2IgMDAgMTAg
MDgNClsgICAxOS45Mzk5NDhdIHNkIDA6MDoyOjA6IFtzZGJdIFdyaXRlIGNhY2hlOiBkaXNh
YmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwgc3VwcG9ydHMgRFBPIGFuZCBGVUENClsgICAx
OS45NDA0OTZdIHNkIDA6MDoxOjA6IFtzZGFdIFdyaXRlIGNhY2hlOiBkaXNhYmxlZCwgcmVh
ZCBjYWNoZTogZW5hYmxlZCwgc3VwcG9ydHMgRFBPIGFuZCBGVUENClsgICAxOS45NDA5NDRd
IHNkIDA6MDo0OjA6IFtzZGRdIFdyaXRlIGNhY2hlOiBkaXNhYmxlZCwgcmVhZCBjYWNoZTog
ZW5hYmxlZCwgc3VwcG9ydHMgRFBPIGFuZCBGVUENClsgICAxOS45NDEyMTJdIHNkIDA6MDo1
OjA6IFtzZGVdIFdyaXRlIGNhY2hlOiBkaXNhYmxlZCwgcmVhZCBjYWNoZTogZW5hYmxlZCwg
c3VwcG9ydHMgRFBPIGFuZCBGVUENClsgICAyMC4wMDI3NDhdICBzZGE6IHNkYTEgc2RhMiBz
ZGEzIHNkYTQgc2RhNSBzZGE2IHNkYTkgc2RhMTENClsgICAyMC4wMTMwMjBdICBzZGQ6IHNk
ZDEgc2RkMiBzZGQzIHNkZDQgc2RkNSBzZGQ2IHNkZDkgc2RkMTENClsgICAyMC4wMTQzNTRd
ICBzZGI6IHNkYjEgc2RiMiBzZGIzIHNkYjQgc2RiNSBzZGI2IHNkYjkgc2RiMTENClsgICAy
MC4wMjQ1ODhdIHNkIDA6MDo1OjA6IFtzZGVdIEF0dGFjaGVkIFNDU0kgZGlzaw0KWyAgIDIw
LjAyNTI5MV0gc2QgMDowOjE6MDogW3NkYV0gQXR0YWNoZWQgU0NTSSBkaXNrDQpbICAgMjAu
MDI2MTUwXSBzZCAwOjA6MjowOiBbc2RiXSBBdHRhY2hlZCBTQ1NJIGRpc2sNClsgICAyMC4w
MjY1NjldIHNkIDA6MDo0OjA6IFtzZGRdIEF0dGFjaGVkIFNDU0kgZGlzaw0KWyAgIDIxLjQ4
MTEwNF0gc2QgMDowOjM6MDogW3NkY10gV3JpdGUgUHJvdGVjdCBpcyBvZmYNClsgICAyMS41
Mzg4OTVdIHNkIDA6MDozOjA6IFtzZGNdIE1vZGUgU2Vuc2U6IGNiIDAwIDEwIDA4DQpbICAg
MjEuNTQxNzgwXSBzZCAwOjA6MzowOiBbc2RjXSBXcml0ZSBjYWNoZTogZGlzYWJsZWQsIHJl
YWQgY2FjaGU6IGVuYWJsZWQsIHN1cHBvcnRzIERQTyBhbmQgRlVBDQpbICAgMjEuNjk0MjY2
XSAgc2RjOiBzZGMxIHNkYzIgc2RjMyBzZGM0IHNkYzUgc2RjNiBzZGM5IHNkYzExDQpbICAg
MjEuNzcwMzY0XSBzZCAwOjA6MzowOiBbc2RjXSBBdHRhY2hlZCBTQ1NJIGRpc2sNClsgICAy
MS44MjY1MjRdIG1kOiBXYWl0aW5nIGZvciBhbGwgZGV2aWNlcyB0byBiZSBhdmFpbGFibGUg
YmVmb3JlIGF1dG9kZXRlY3QNClsgICAyMS45MDgzOThdIG1kOiBJZiB5b3UgZG9uJ3QgdXNl
IHJhaWQsIHVzZSByYWlkPW5vYXV0b2RldGVjdA0KWyAgIDIxLjk3Nzk5NV0gbWQ6IEF1dG9k
ZXRlY3RpbmcgUkFJRCBhcnJheXMuDQpbICAgMjIuMTEyMDA4XSBtZDogaW52YWxpZCByYWlk
IHN1cGVyYmxvY2sgbWFnaWMgb24gc2RkMw0KWyAgIDIyLjE3Mjk4NF0gbWQ6IHNkZDMgZG9l
cyBub3QgaGF2ZSBhIHZhbGlkIHYwLjkwIHN1cGVyYmxvY2ssIG5vdCBpbXBvcnRpbmchDQpb
ICAgMjIuMjcyNTY1XSBtZDogaW52YWxpZCByYWlkIHN1cGVyYmxvY2sgbWFnaWMgb24gc2Rk
NA0KWyAgIDIyLjMzMzUwOF0gbWQ6IHNkZDQgZG9lcyBub3QgaGF2ZSBhIHZhbGlkIHYwLjkw
IHN1cGVyYmxvY2ssIG5vdCBpbXBvcnRpbmchDQpbICAgMjIuNTQzMDU2XSBtZDogYXV0b3J1
biAuLi4NClsgICAyMi41NzY3MzldIG1kOiBzZGM1IGhhcyBkaWZmZXJlbnQgVVVJRCB0byBz
ZGM2DQpbICAgMjIuNjMxMzYwXSBtZDogc2RjNCBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2Rj
Ng0KWyAgIDIyLjY4NjA1Ml0gbWQ6IHNkYzMgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYzYN
ClsgICAyMi43NDA3MDldIG1kOiBzZGMxIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGM2DQpb
ICAgMjIuNzk1NDQ3XSBtZDogc2RkNSBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RjNg0KWyAg
IDIyLjg1MDA2NF0gbWQ6IHNkYjUgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYzYNClsgICAy
Mi45MDQ3MjRdIG1kOiBzZGI0IGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGM2DQpbICAgMjIu
OTU5MzkyXSBtZDogc2RiMyBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RjNg0KWyAgIDIzLjAx
NDA4Nl0gbWQ6IHNkYjEgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYzYNClsgICAyMy4wNjg3
NDhdIG1kOiBzZGQxIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGM2DQpbICAgMjMuMTIzNDM0
XSBtZDogc2RhNSBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RjNg0KWyAgIDIzLjE3ODA5Ml0g
bWQ6IHNkYTQgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYzYNClsgICAyMy4yMzI3NTJdIG1k
OiBzZGEzIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGM2DQpbICAgMjMuMjg3NDIyXSBtZDog
c2RhMSBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RjNg0KWyAgIDIzLjM0MzY3Ml0gbWQ6IHJ1
bm5pbmc6IDxzZGM2PjxzZGQ2PjxzZGI2PjxzZGE2Pg0KWyAgIDIzLjQwMjYwOV0gbWQvcmFp
ZDptZDQ6IGRldmljZSBzZGM2IG9wZXJhdGlvbmFsIGFzIHJhaWQgZGlzayAyDQpbICAgMjMu
NDczOTYwXSBtZC9yYWlkOm1kNDogZGV2aWNlIHNkYjYgb3BlcmF0aW9uYWwgYXMgcmFpZCBk
aXNrIDENClsgICAyMy41NDUzNThdIG1kL3JhaWQ6bWQ0OiBkZXZpY2Ugc2RhNiBvcGVyYXRp
b25hbCBhcyByYWlkIGRpc2sgMA0KWyAgIDIzLjYyMDY1MV0gbWQvcmFpZDptZDQ6IHJhaWQg
bGV2ZWwgNSBhY3RpdmUgd2l0aCAzIG91dCBvZiAzIGRldmljZXMsIGFsZ29yaXRobSAyDQpb
ICAgMjMuNzMxODk3XSBtZDQ6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDAgdG8g
MTk0MDkxNDE3Ng0KWyAgIDIzLjgwMjQwMV0gbWQ6IHNkYzQgaGFzIGRpZmZlcmVudCBVVUlE
IHRvIHNkYzUNClsgICAyMy44NTcxMTVdIG1kOiBzZGMzIGhhcyBkaWZmZXJlbnQgVVVJRCB0
byBzZGM1DQpbICAgMjMuOTExNzY0XSBtZDogc2RjMSBoYXMgZGlmZmVyZW50IFVVSUQgdG8g
c2RjNQ0KWyAgIDIzLjk2NjQyOF0gbWQ6IHNkZDUgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNk
YzUNClsgICAyNC4wMjExMzNdIG1kOiBzZGI0IGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGM1
DQpbICAgMjQuMDc1NzUzXSBtZDogc2RiMyBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RjNQ0K
WyAgIDI0LjEzMDQ0Ml0gbWQ6IHNkYjEgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYzUNClsg
ICAyNC4xODUxMjZdIG1kOiBzZGQxIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGM1DQpbICAg
MjQuMjM5Nzg1XSBtZDogc2RhNCBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RjNQ0KWyAgIDI0
LjI5NDQ1Ml0gbWQ6IHNkYTMgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYzUNClsgICAyNC4z
NDkxMzddIG1kOiBzZGExIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBzZGM1DQpbICAgMjQuNDA1
MzExXSBtZDogcnVubmluZzogPHNkYzU+PHNkYjU+PHNkYTU+DQpbICAgMjQuNDU3NjM2XSBt
ZC9yYWlkOm1kMzogZGV2aWNlIHNkYzUgb3BlcmF0aW9uYWwgYXMgcmFpZCBkaXNrIDINClsg
ICAyNC41MjkwNjNdIG1kL3JhaWQ6bWQzOiBkZXZpY2Ugc2RiNSBvcGVyYXRpb25hbCBhcyBy
YWlkIGRpc2sgMQ0KWyAgIDI0LjYwMDQ1Nl0gbWQvcmFpZDptZDM6IGRldmljZSBzZGE1IG9w
ZXJhdGlvbmFsIGFzIHJhaWQgZGlzayAwDQpbICAgMjQuNjc1NDMxXSBtZC9yYWlkOm1kMzog
cmFpZCBsZXZlbCA1IGFjdGl2ZSB3aXRoIDMgb3V0IG9mIDMgZGV2aWNlcywgYWxnb3JpdGht
IDINClsgICAyNC43ODkyMjldIG1kMzogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20g
MCB0byA0MDEzNjg2Nzg0DQpbICAgMjQuODU5NjUyXSBtZDogc2RjMyBoYXMgZGlmZmVyZW50
IFVVSUQgdG8gc2RjNA0KWyAgIDI0LjkxNDI5Ml0gbWQ6IHNkYzEgaGFzIGRpZmZlcmVudCBV
VUlEIHRvIHNkYzQNClsgICAyNC45Njg5MzNdIG1kOiBzZGQ1IGhhcyBkaWZmZXJlbnQgVVVJ
RCB0byBzZGM0DQpbICAgMjUuMDIzNjI2XSBtZDogc2RiMyBoYXMgZGlmZmVyZW50IFVVSUQg
dG8gc2RjNA0KWyAgIDI1LjA3ODI3M10gbWQ6IHNkYjEgaGFzIGRpZmZlcmVudCBVVUlEIHRv
IHNkYzQNClsgICAyNS4xMzI5NDBdIG1kOiBzZGQxIGhhcyBkaWZmZXJlbnQgVVVJRCB0byBz
ZGM0DQpbICAgMjUuMTg3NjMzXSBtZDogc2RhMyBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2Rj
NA0KWyAgIDI1LjI0MjI4Nl0gbWQ6IHNkYTEgaGFzIGRpZmZlcmVudCBVVUlEIHRvIHNkYzQN
ClsgICAyNS4yOTg0NTddIG1kOiBydW5uaW5nOiA8c2RjND48c2RiND48c2RhND4NClsgICAy
NS4zNTA5MjRdIG1kL3JhaWQ6bWQyOiBkZXZpY2Ugc2RjNCBvcGVyYXRpb25hbCBhcyByYWlk
IGRpc2sgMg0KWyAgIDI1LjQyMjMzNl0gbWQvcmFpZDptZDI6IGRldmljZSBzZGI0IG9wZXJh
dGlvbmFsIGFzIHJhaWQgZGlzayAxDQpbICAgMjUuNDkzNzQwXSBtZC9yYWlkOm1kMjogZGV2
aWNlIHNkYTQgb3BlcmF0aW9uYWwgYXMgcmFpZCBkaXNrIDANClsgICAyNS41Njg2NjNdIG1k
L3JhaWQ6bWQyOiByYWlkIGxldmVsIDUgYWN0aXZlIHdpdGggMyBvdXQgb2YgMyBkZXZpY2Vz
LCBhbGdvcml0aG0gMg0KWyAgIDI1LjY4MTA1M10gbWQyOiBkZXRlY3RlZCBjYXBhY2l0eSBj
aGFuZ2UgZnJvbSAwIHRvIDgwMDE1MjYxNjk2DQpbICAgMjUuNzUyNTQ0XSBtZDogc2RjMSBo
YXMgZGlmZmVyZW50IFVVSUQgdG8gc2RjMw0KWyAgIDI1LjgwNzI1Ml0gbWQ6IHNkZDUgaGFz
IGRpZmZlcmVudCBVVUlEIHRvIHNkYzMNClsgICAyNS44NjE5MjhdIG1kOiBzZGIxIGhhcyBk
aWZmZXJlbnQgVVVJRCB0byBzZGMzDQpbICAgMjUuOTE2NzI4XSBtZDogc2RkMSBoYXMgZGlm
ZmVyZW50IFVVSUQgdG8gc2RjMw0KWyAgIDI1Ljk3MTM3Nl0gbWQ6IHNkYTEgaGFzIGRpZmZl
cmVudCBVVUlEIHRvIHNkYzMNClsgICAyNi4wMjc0MTZdIG1kOiBydW5uaW5nOiA8c2RjMz48
c2RiMz48c2RhMz4NClsgICAyNi4wNzk4MjRdIG1kL3JhaWQ6bWQxOiBkZXZpY2Ugc2RjMyBv
cGVyYXRpb25hbCBhcyByYWlkIGRpc2sgMg0KWyAgIDI2LjE1MTI4NF0gbWQvcmFpZDptZDE6
IGRldmljZSBzZGIzIG9wZXJhdGlvbmFsIGFzIHJhaWQgZGlzayAxDQpbICAgMjYuMjIyNjY0
XSBtZC9yYWlkOm1kMTogZGV2aWNlIHNkYTMgb3BlcmF0aW9uYWwgYXMgcmFpZCBkaXNrIDAN
ClsgICAyNi4yOTc0NDhdIG1kL3JhaWQ6bWQxOiByYWlkIGxldmVsIDUgYWN0aXZlIHdpdGgg
MyBvdXQgb2YgMyBkZXZpY2VzLCBhbGdvcml0aG0gMg0KWyAgIDI2LjQwMDc2MV0gbWQxOiBk
ZXRlY3RlZCBjYXBhY2l0eSBjaGFuZ2UgZnJvbSAwIHRvIDEyMDA4NTU0NDk2DQpbICAgMjYu
NDcyMjUzXSBtZDogc2RkNSBoYXMgZGlmZmVyZW50IFVVSUQgdG8gc2RjMQ0KWyAgIDI2LjUy
NzQyMl0gbWQ6IHJ1bm5pbmc6IDxzZGMxPjxzZGIxPjxzZGQxPjxzZGExPg0KWyAgIDI2LjU4
NjE2MV0gbWQvcmFpZDptZDA6IGRldmljZSBzZGMxIG9wZXJhdGlvbmFsIGFzIHJhaWQgZGlz
ayAyDQpbICAgMjYuNjU3NTY5XSBtZC9yYWlkOm1kMDogZGV2aWNlIHNkYjEgb3BlcmF0aW9u
YWwgYXMgcmFpZCBkaXNrIDENClsgICAyNi43Mjg5NTZdIG1kL3JhaWQ6bWQwOiBkZXZpY2Ug
c2RhMSBvcGVyYXRpb25hbCBhcyByYWlkIGRpc2sgMA0KWyAgIDI2LjgwNDI0N10gbWQvcmFp
ZDptZDA6IHJhaWQgbGV2ZWwgNSBhY3RpdmUgd2l0aCAzIG91dCBvZiAzIGRldmljZXMsIGFs
Z29yaXRobSAyDQpbICAgMjYuOTA5MjY1XSBtZDA6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5n
ZSBmcm9tIDAgdG8gMTAxOTc0MDE2MA0KWyAgIDI2Ljk3OTcyMl0gbWQ6IG1kMyBhbHJlYWR5
IHJ1bm5pbmcsIGNhbm5vdCBydW4gc2RkNQ0KWyAgIDI3LjAzOTY2Ml0gbWQ6IC4uLiBhdXRv
cnVuIERPTkUuDQpbICAgMjcuMTUxNDY0XSBVREYtZnM6IHdhcm5pbmcgKGRldmljZSBtZDAp
OiB1ZGZfZmlsbF9zdXBlcjogTm8gcGFydGl0aW9uIGZvdW5kICgyKQ0KWyAgIDI3LjI2ODI3
MF0gWEZTIChtZDApOiBNb3VudGluZyBWNSBGaWxlc3lzdGVtDQpbICAgMzAuMDAzNjc5XSBY
RlMgKG1kMCk6IEVuZGluZyBjbGVhbiBtb3VudA0KWyAgIDMwLjA1MjE5Ml0gVkZTOiBNb3Vu
dGVkIHJvb3QgKHhmcyBmaWxlc3lzdGVtKSByZWFkb25seSBvbiBkZXZpY2UgOTowLg0KWyAg
IDMwLjEzNjc5MF0gZGV2dG1wZnM6IG1vdW50ZWQNClsgICAzMC4xNzQyOTddIEZyZWVpbmcg
dW51c2VkIGtlcm5lbCBtZW1vcnk6IDMyMEsNClsgICAzMC4yMjc4OTFdIFRoaXMgYXJjaGl0
ZWN0dXJlIGRvZXMgbm90IGhhdmUga2VybmVsIG1lbW9yeSBwcm90ZWN0aW9uLg0KWyAgIDQw
Ljg2MzE0M10gdWRldmRbNTg1XTogc3RhcnRpbmcgdmVyc2lvbiAzLjIuMQ0KWyAgIDQwLjkz
ODY5M10gdWRldmRbNTg1XTogc3BlY2lmaWVkIGdyb3VwICd2aWRlbycgdW5rbm93bg0KWyAg
IDQwLjkzOTg2Ml0gdWRldmRbNTg1XTogc3BlY2lmaWVkIGdyb3VwICd0YXBlJyB1bmtub3du
DQpbICAgNDAuOTk3OTAwXSB1ZGV2ZFs1ODZdOiBzdGFydGluZyBldWRldi0zLjIuMQ0KWyAg
IDQxLjUxNzU2NF0gdWRldmRbNTg2XTogc3BlY2lmaWVkIGdyb3VwICd2aWRlbycgdW5rbm93
bg0KWyAgIDQxLjUxODc0NV0gdWRldmRbNTg2XTogc3BlY2lmaWVkIGdyb3VwICd0YXBlJyB1
bmtub3duDQpbICAgNDguMDcyNTQwXSBBZGRpbmcgNDQ5NzI4ayBzd2FwIG9uIC9kZXYvc2Rh
Mi4gIFByaW9yaXR5OjEgZXh0ZW50czoxIGFjcm9zczo0NDk3MjhrDQpbICAgNDguMTExMjUy
XSBBZGRpbmcgNDQ5NzI4ayBzd2FwIG9uIC9kZXYvc2RiMi4gIFByaW9yaXR5OjEgZXh0ZW50
czoxIGFjcm9zczo0NDk3MjhrDQpbICAgNDguMjE5MTMyXSBBZGRpbmcgNDQ5NzI4ayBzd2Fw
IG9uIC9kZXYvc2RjMi4gIFByaW9yaXR5OjEgZXh0ZW50czoxIGFjcm9zczo0NDk3MjhrDQpb
ICAgNDguNjg1NDk2XSBYRlMgKG1kMSk6IE1vdW50aW5nIFY1IEZpbGVzeXN0ZW0NClsgICA1
MS4zODgxMTFdIFhGUyAobWQxKTogRW5kaW5nIGNsZWFuIG1vdW50DQpbICAgNTEuNTc3Nzcy
XSBYRlMgKG1kMik6IE1vdW50aW5nIFY1IEZpbGVzeXN0ZW0NClsgICA1NC4zMDAzNTJdIFhG
UyAobWQyKTogRW5kaW5nIGNsZWFuIG1vdW50DQpbICAgNTQuNjAwNzA4XSBYRlMgKG1kMyk6
IE1vdW50aW5nIFY1IEZpbGVzeXN0ZW0NClsgICA1Ny4zODI3ODFdIFhGUyAobWQzKTogRW5k
aW5nIGNsZWFuIG1vdW50DQpbICAgNTcuNDg1NTE2XSBYRlMgKG1kNCk6IE1vdW50aW5nIFY1
IEZpbGVzeXN0ZW0NClsgICA2MC4yMjMwNjhdIFhGUyAobWQ0KTogRW5kaW5nIGNsZWFuIG1v
dW50DQo=
--------------4C5C23CE0FF9E9C9F06872E4
Content-Type: text/plain; charset=UTF-8;
 name="ip27-dmesg-size_assign_pci-20170208.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ip27-dmesg-size_assign_pci-20170208.txt"

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA0LjEwLjAtcmM3IChyb290QGhlbGNhcmF4
ZSkgKGdjYyB2ZXJzaW9uIDYuMy4wIChHZW50b28gSGFyZGVuZWQgNi4zLjAgcDEuMCkgKSAj
MiBTTVAgV2VkIEZlYiA4IDA0OjA3OjExIEVTVCAyMDE3DQpbICAgIDAuMDAwMDAwXSBBUkNI
OiBTR0ktSVAyNw0KWyAgICAwLjAwMDAwMF0gUFJPTUxJQjogQVJDIGZpcm13YXJlIFZlcnNp
b24gNjQgUmV2aXNpb24gMA0KWyAgICAwLjAwMDAwMF0gRGlzY292ZXJlZCA0IGNwdXMgb24g
MiBub2Rlcw0KWyAgICAwLjAwMDAwMF0gbm9kZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0K
WyAgICAwLjAwMDAwMF0gbm9kZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0KWyAgICAwLjAw
MDAwMF0gbm9kZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0KWyAgICAwLjAwMDAwMF0gbm9k
ZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0KWyAgICAwLjAwMDAwMF0gKioqKioqKioqKioq
KiogVG9wb2xvZ3kgKioqKioqKioqKioqKioqKioqKioNClsgICAgMC4wMDAwMDBdDQpbICAg
IDAuMDAwMDAwXSAwMA0KWyAgICAwLjAwMDAwMF0gMDENClsgICAgMC4wMDAwMDBdDQpbICAg
IDAuMDAwMDAwXSAwMA0KWyAgICAwLjAwMDAwMF0gMjU1DQpbICAgIDAuMDAwMDAwXSAyNTUN
ClsgICAgMC4wMDAwMDBdDQpbICAgIDAuMDAwMDAwXSAwMQ0KWyAgICAwLjAwMDAwMF0gMjU1
DQpbICAgIDAuMDAwMDAwXSAyNTUNClsgICAgMC4wMDAwMDBdDQpbICAgIDAuMDAwMDAwXSBi
b290Y29uc29sZSBbZWFybHkwXSBlbmFibGVkDQpbICAgIDAuMDAwMDAwXSBDUFUwIHJldmlz
aW9uIGlzOiAwMDAwMGYxNCAoUjE0MDAwKQ0KWyAgICAwLjAwMDAwMF0gRlBVIHJldmlzaW9u
IGlzOiAwMDAwMDkwMA0KWyAgICAwLjAwMDAwMF0gQ2hlY2tpbmcgZm9yIHRoZSBtdWx0aXBs
eS9zaGlmdCBidWcuLi4gbm8uDQpbICAgIDAuMDAwMDAwXSBDaGVja2luZyBmb3IgdGhlIGRh
ZGRpdSBidWcuLi4gbm8uDQpbICAgIDAuMDAwMDAwXSBJUDI3OiBSdW5uaW5nIG9uIG5vZGUg
MC4NClsgICAgMC4wMDAwMDBdIE5vZGUgMCBoYXMgYSBwcmltYXJ5IENQVSwgQ1BVIGlzIHJ1
bm5pbmcuDQpbICAgIDAuMDAwMDAwXSBOb2RlIDAgaGFzIGEgc2Vjb25kYXJ5IENQVSwgQ1BV
IGlzIHJ1bm5pbmcuDQpbICAgIDAuMDAwMDAwXSBNYWNoaW5lIGlzIGluIE0gbW9kZS4NClsg
ICAgMC4wMDAwMDBdIENwdSAwLCBOYXNpZCAweDA6IHBhcnRudW0gMHgwIGlzDQpbICAgIDAu
MDAwMDAwXSBpcyB4Ym93DQpbICAgIDAuMDAwMDAwXSBDcHUgMCwgTmFzaWQgMHgwLCB3aWRn
ZXQgMHg4IChwYXJ0bnVtIDB4YzEwMikgaXMNClsgICAgMC4wMDAwMDBdIENwdSAwLCBOYXNp
ZCAweDAsIHdpZGdldCAweGIgKHBhcnRudW0gMHhjMDAyKSBpcw0KWyAgICAwLjAwMDAwMF0g
Q3B1IDAsIE5hc2lkIDB4MCwgd2lkZ2V0IDB4YyAocGFydG51bSAweGMwMDIpIGlzDQpbICAg
IDAuMDAwMDAwXSBDcHUgMCwgTmFzaWQgMHgwLCB3aWRnZXQgMHhkIChwYXJ0bnVtIDB4YzAw
MykgaXMNClsgICAgMC4wMDAwMDBdIENwdSAwLCBOYXNpZCAweDAsIHdpZGdldCAweGYgKHBh
cnRudW0gMHhjMDAyKSBpcw0KWyAgICAwLjAwMDAwMF0gQ1BVIDAgY2xvY2sgaXMgNTAwTUh6
Lg0KWyAgICAwLjAwMDAwMF0gRGV0ZXJtaW5lZCBwaHlzaWNhbCBSQU0gbWFwOg0KWyAgICAw
LjAwMDAwMF0gIG1lbW9yeTogMDAwMDAwMDAwMDZlMDAwMCBAIDAwMDAwMDAwMDAwMTAwMDAg
KHVzYWJsZSkNClsgICAgMC4wMDAwMDBdICBtZW1vcnk6IDAwMDAwMDAwMDAwNTAwMDAgQCAw
MDAwMDAwMDAwNmYwMDAwICh1c2FibGUgYWZ0ZXIgaW5pdCkNClsgICAgMC4wMDAwMDBdIGNt
YTogUmVzZXJ2ZWQgNTEyIE1pQiBhdCAweDAwMDAwMDAxZTAwMDAwMDANClsgICAgMC4wMDAw
MDBdIFJFUExJQ0FUSU9OOiBPTiBuYXNpZCAwLCBrdGV4dCBmcm9tIG5hc2lkIDAsIGtkYXRh
IGZyb20gbmFzaWQgMA0KWyAgICAwLjAwMDAwMF0gUkVQTElDQVRJT046IE9OIG5hc2lkIDEs
IGt0ZXh0IGZyb20gbmFzaWQgMCwga2RhdGEgZnJvbSBuYXNpZCAwDQpbICAgIDAuMDAwMDAw
XSBQcmltYXJ5IGluc3RydWN0aW9uIGNhY2hlIDMya0IsIFZJUFQsIDItd2F5LCBsaW5lc2l6
ZSA2NCBieXRlcy4NClsgICAgMC4wMDAwMDBdIFByaW1hcnkgZGF0YSBjYWNoZSAzMmtCLCAy
LXdheSwgVklQVCwgbm8gYWxpYXNlcywgbGluZXNpemUgMzIgYnl0ZXMNClsgICAgMC4wMDAw
MDBdIFVuaWZpZWQgc2Vjb25kYXJ5IGNhY2hlIDgxOTJrQiAyLXdheSwgbGluZXNpemUgMTI4
IGJ5dGVzLg0KWyAgICAwLjAwMDAwMF0gWm9uZSByYW5nZXM6DQpbICAgIDAuMDAwMDAwXSAg
IE5vcm1hbCAgIFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDFmZmZmZmZmZl0N
ClsgICAgMC4wMDAwMDBdIE1vdmFibGUgem9uZSBzdGFydCBmb3IgZWFjaCBub2RlDQpbICAg
IDAuMDAwMDAwXSBFYXJseSBtZW1vcnkgbm9kZSByYW5nZXMNClsgICAgMC4wMDAwMDBdICAg
bm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDBmZmZmZmZmZl0N
ClsgICAgMC4wMDAwMDBdICAgbm9kZSAgIDE6IFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4
MDAwMDAwMDFmZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdIEluaXRtZW0gc2V0dXAgbm9kZSAw
IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDBmZmZmZmZmZl0NClsgICAgMC4w
MDAwMDBdIEluaXRtZW0gc2V0dXAgbm9kZSAxIFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4
MDAwMDAwMDFmZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdIHBlcmNwdTogRW1iZWRkZWQgMiBw
YWdlcy9jcHUgQGE4MDAwMDAwMDE0MzAwMDAgczYwMDY0IHIwIGQ3MTAwOCB1MTMxMDcyDQpb
ICAgIDAuMDAwMDAwXSBCdWlsdCAyIHpvbmVsaXN0cyBpbiBOb2RlIG9yZGVyLCBtb2JpbGl0
eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiAxMzA5NDQNClsgICAgMC4wMDAwMDBdIFBv
bGljeSB6b25lOiBOb3JtYWwNClsgICAgMC4wMDAwMDBdIEtlcm5lbCBjb21tYW5kIGxpbmU6
IHJvb3Q9ZGtzYygwLDEsMCkgY29uc29sZT10dHlTMCw5NjAwIHJvb3Q9L2Rldi9tZDANClsg
ICAgMC4wMDAwMDBdIFBJRCBoYXNoIHRhYmxlIGVudHJpZXM6IDQwOTYgKG9yZGVyOiAtMSwg
MzI3NjggYnl0ZXMpDQpbICAgIDAuMDAwMDAwXSBNZW1vcnk6IDc4NDY3ODRLLzgzODg2MDhL
IGF2YWlsYWJsZSAoNTE3Mksga2VybmVsIGNvZGUsIDY3OEsgcndkYXRhLCAxMTE2SyByb2Rh
dGEsIDMyMEsgaW5pdCwgNzAwSyBic3MsIDE3NTM2SyByZXNlcnZlZCwgNTI0Mjg4SyBjbWEt
cmVzZXJ2ZWQpDQpbICAgIDAuMDAwMDAwXSBIaWVyYXJjaGljYWwgUkNVIGltcGxlbWVudGF0
aW9uLg0KWyAgICAwLjAwMDAwMF0gIEJ1aWxkLXRpbWUgYWRqdXN0bWVudCBvZiBsZWFmIGZh
bm91dCB0byA2NC4NClsgICAgMC4wMDAwMDBdICBSQ1UgcmVzdHJpY3RpbmcgQ1BVcyBmcm9t
IE5SX0NQVVM9NjQgdG8gbnJfY3B1X2lkcz00Lg0KWyAgICAwLjAwMDAwMF0gUkNVOiBBZGp1
c3RpbmcgZ2VvbWV0cnkgZm9yIHJjdV9mYW5vdXRfbGVhZj02NCwgbnJfY3B1X2lkcz00DQpb
ICAgIDAuMDAwMDAwXSBOUl9JUlFTOjI1Ng0KWyAgICAwLjAwMDAwMF0gY2xvY2tzb3VyY2U6
IEhVQi1SVDogbWFzazogMHhmZmZmZmZmZmZmZmZmIG1heF9jeWNsZXM6IDB4MTI3MzUwYjg4
LCBtYXhfaWRsZV9uczogMTc2MzE4MDgwODQ4MCBucw0KWyAgICAwLjAwMDAxMl0gc2NoZWRf
Y2xvY2s6IDUyIGJpdHMgYXQgMTI1MGtIeiwgcmVzb2x1dGlvbiA4MDBucywgd3JhcHMgZXZl
cnkgNDM5ODA0NjUxMDgwMG5zDQpbICAgIDAuMTAzMTgzXSBDb25zb2xlOiBjb2xvdXIgZHVt
bXkgZGV2aWNlIDgweDI1DQpbICAgIDAuMTU2MjU4XSBDYWxpYnJhdGluZyBkZWxheSBsb29w
Li4uIDc0OS41NiBCb2dvTUlQUyAobHBqPTM3NDc4NDApDQpbICAgIDAuMzE4NDk3XSBwaWRf
bWF4OiBkZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAzMDENClsgICAgMC4zNzgzNDddIERlbnRy
eSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEwNDg1NzYgKG9yZGVyOiA3LCA4Mzg4NjA4
IGJ5dGVzKQ0KWyAgICAwLjU3Nzg4OV0gSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVz
OiA1MjQyODggKG9yZGVyOiA2LCA0MTk0MzA0IGJ5dGVzKQ0KWyAgICAwLjcyMDM4MF0gTW91
bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6IDEsIDEzMTA3MiBi
eXRlcykNClsgICAgMC44MDEyMzVdIE1vdW50cG9pbnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRy
aWVzOiAxNjM4NCAob3JkZXI6IDEsIDEzMTA3MiBieXRlcykNClsgICAgMC45MDA3ODhdIENo
ZWNraW5nIGZvciB0aGUgZGFkZGkgYnVnLi4uIG5vLg0KWyAgICAwLjk1Nzg1Ml0gc21wOiBC
cmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAuLi4NClsgICAgMS4wMTI4NTBdIFByaW1hcnkg
aW5zdHJ1Y3Rpb24gY2FjaGUgMzJrQiwgVklQVCwgMi13YXksIGxpbmVzaXplIDY0IGJ5dGVz
Lg0KWyAgICAxLjAxMjg2Nl0gUHJpbWFyeSBkYXRhIGNhY2hlIDMya0IsIDItd2F5LCBWSVBU
LCBubyBhbGlhc2VzLCBsaW5lc2l6ZSAzMiBieXRlcw0KWyAgICAxLjAxMjg3M10gVW5pZmll
ZCBzZWNvbmRhcnkgY2FjaGUgODE5MmtCIDItd2F5LCBsaW5lc2l6ZSAxMjggYnl0ZXMuDQpb
ICAgIDEuMDE2MDQwXSBDUFUgMSBjbG9jayBpcyA1MDBNSHouDQpbICAgIDEuMDE2MDYzXSBD
UFUxIHJldmlzaW9uIGlzOiAwMDAwMGYxNCAoUjE0MDAwKQ0KWyAgICAxLjAxNjA2N10gRlBV
IHJldmlzaW9uIGlzOiAwMDAwMDkwMA0KWyAgICAxLjA1NDE4OV0gUHJpbWFyeSBpbnN0cnVj
dGlvbiBjYWNoZSAzMmtCLCBWSVBULCAyLXdheSwgbGluZXNpemUgNjQgYnl0ZXMuDQpbICAg
IDEuMDU0MjA5XSBQcmltYXJ5IGRhdGEgY2FjaGUgMzJrQiwgMi13YXksIFZJUFQsIG5vIGFs
aWFzZXMsIGxpbmVzaXplIDMyIGJ5dGVzDQpbICAgIDEuMDU0MjE5XSBVbmlmaWVkIHNlY29u
ZGFyeSBjYWNoZSA4MTkya0IgMi13YXksIGxpbmVzaXplIDEyOCBieXRlcy4NClsgICAgMS4w
NTc0NDddIENwdSAyLCBOYXNpZCAweDE6IHBhcnRudW0gMHgwIGlzDQpbICAgIDEuMDU3NDcx
XSBpcyB4Ym93DQpbICAgIDEuMDU3NTEzXSBDUFUgMiBjbG9jayBpcyA1MDBNSHouDQpbICAg
IDEuMDU3NTMyXSBDUFUyIHJldmlzaW9uIGlzOiAwMDAwMGYxNCAoUjE0MDAwKQ0KWyAgICAx
LjA1NzUzNl0gRlBVIHJldmlzaW9uIGlzOiAwMDAwMDkwMA0KWyAgICAxLjA5NDUzMl0gUHJp
bWFyeSBpbnN0cnVjdGlvbiBjYWNoZSAzMmtCLCBWSVBULCAyLXdheSwgbGluZXNpemUgNjQg
Ynl0ZXMuDQpbICAgIDEuMDk0NTUwXSBQcmltYXJ5IGRhdGEgY2FjaGUgMzJrQiwgMi13YXks
IFZJUFQsIG5vIGFsaWFzZXMsIGxpbmVzaXplIDMyIGJ5dGVzDQpbICAgIDEuMDk0NTYwXSBV
bmlmaWVkIHNlY29uZGFyeSBjYWNoZSA4MTkya0IgMi13YXksIGxpbmVzaXplIDEyOCBieXRl
cy4NClsgICAgMS4wOTc3OTVdIENQVSAzIGNsb2NrIGlzIDUwME1Iei4NClsgICAgMS4wOTc4
MjNdIENQVTMgcmV2aXNpb24gaXM6IDAwMDAwZjE0IChSMTQwMDApDQpbICAgIDEuMDk3ODI3
XSBGUFUgcmV2aXNpb24gaXM6IDAwMDAwOTAwDQpbICAgIDEuMTMxMzg3XSBzbXA6IEJyb3Vn
aHQgdXAgMiBub2RlcywgNCBDUFVzDQpbICAgIDIuNDI1MjA3XSBkZXZ0bXBmczogaW5pdGlh
bGl6ZWQNClsgICAgMi40NjQzNzZdIGNsb2Nrc291cmNlOiBqaWZmaWVzOiBtYXNrOiAweGZm
ZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiAxOTExMjYwNDQ2
Mjc1MDAwMCBucw0KWyAgICAyLjU4NjEwNV0geG9yOiBtZWFzdXJpbmcgc29mdHdhcmUgY2hl
Y2tzdW0gc3BlZWQNClsgICAgMi43NDIwMjNdICAgIDhyZWdzICAgICA6ICAgNzEwLjQwMCBN
Qi9zZWMNClsgICAgMi44OTA2NzBdICAgIDhyZWdzX3ByZWZldGNoOiAgIDY4NC44MDAgTUIv
c2VjDQpbICAgIDMuMDQzNDgxXSAgICAzMnJlZ3MgICAgOiAgIDY1OS4yMDAgTUIvc2VjDQpb
ICAgIDMuMTcxMzkwXSByYW5kb206IGZhc3QgaW5pdCBkb25lDQpbICAgIDMuMTkyMDc4XSAg
ICAzMnJlZ3NfcHJlZmV0Y2g6ICAgNjQwLjAwMCBNQi9zZWMNClsgICAgMy4xOTIwODZdIHhv
cjogdXNpbmcgZnVuY3Rpb246IDhyZWdzICg3MTAuNDAwIE1CL3NlYykNClsgICAgMy4zMjk3
NjldIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYNClsgICAgMy40NDIyODFd
IGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIGxhZGRlcg0KWyAgICAzLjU0OTcyNF0gY3B1aWRs
ZTogdXNpbmcgZ292ZXJub3IgbWVudQ0KWyAgICAzLjkwMjIwN10gcmFpZDY6IGludDY0eDEg
IGdlbigpICAgMzA0IE1CL3MNClsgICAgNC4xMjIxOTZdIHJhaWQ2OiBpbnQ2NHgxICB4b3Io
KSAgICA2NCBNQi9zDQpbICAgIDQuMzQxOTM2XSByYWlkNjogaW50NjR4MiAgZ2VuKCkgICA0
NDYgTUIvcw0KWyAgICA0LjU2MTcyMF0gcmFpZDY6IGludDY0eDIgIHhvcigpICAgMTUyIE1C
L3MNClsgICAgNC43ODE0MjhdIHJhaWQ2OiBpbnQ2NHg0ICBnZW4oKSAgIDM4NiBNQi9zDQpb
ICAgIDUuMDAxMjQ1XSByYWlkNjogaW50NjR4NCAgeG9yKCkgICAxNDEgTUIvcw0KWyAgICA1
LjIyMTA4MV0gcmFpZDY6IGludDY0eDggIGdlbigpICAgMzE1IE1CL3MNClsgICAgNS40NDA4
MTRdIHJhaWQ2OiBpbnQ2NHg4ICB4b3IoKSAgIDExNiBNQi9zDQpbICAgIDUuNDkwMjUyXSBy
YWlkNjogdXNpbmcgYWxnb3JpdGhtIGludDY0eDIgZ2VuKCkgNDQ2IE1CL3MNClsgICAgNS41
NTUxODRdIHJhaWQ2OiAuLi4uIHhvcigpIDE1MiBNQi9zLCBybXcgZW5hYmxlZA0KWyAgICA1
LjYxMzgzNl0gcmFpZDY6IHVzaW5nIGludHgxIHJlY292ZXJ5IGFsZ29yaXRobQ0KWyAgICA1
LjY3MDkwOV0gU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQNClsgICAgNS43MTYyMTJdIFBD
SSBob3N0IGJyaWRnZSB0byBidXMgMDAwMjowMA0KWyAgICA1Ljc2NDY4NF0gcGNpX2J1cyAw
MDAyOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4OTIwMDAwMDAwZjIwMDAwMC0weDky
MDAwMDAwMGY5ZmZmZmZdDQpbICAgIDUuODY0MTYzXSBwY2lfYnVzIDAwMDI6MDA6IHJvb3Qg
YnVzIHJlc291cmNlIFtpbyAgMHg5MjAwMDAwMDBmYTAwMDAwLTB4OTIwMDAwMDAwZmJmZmZm
Zl0NClsgICAgNS45NjM2NjNdIHBjaV9idXMgMDAwMjowMDogcm9vdCBidXMgcmVzb3VyY2Ug
W2J1cyAwMi1mZl0NClsgICAgNi4wMzE4MjVdIHBjaSAwMDAyOjAwOjAyLjA6IEJBUiAwOiBu
byBzcGFjZSBmb3IgW21lbSBzaXplIDB4MDAxMDAwMDBdDQpbICAgIDYuMTA5NTU3XSBwY2kg
MDAwMjowMDowMi4wOiBCQVIgMDogZmFpbGVkIHRvIGFzc2lnbiBbbWVtIHNpemUgMHgwMDEw
MDAwMF0NClsgICAgNi4xOTMzNDFdIHBjaSAwMDAyOjAwOjA2LjA6IEJBUiAwOiBubyBzcGFj
ZSBmb3IgW21lbSBzaXplIDB4MDAxMDAwMDBdDQpbICAgIDYuMjcyOTM2XSBwY2kgMDAwMjow
MDowNi4wOiBCQVIgMDogZmFpbGVkIHRvIGFzc2lnbiBbbWVtIHNpemUgMHgwMDEwMDAwMF0N
ClsgICAgNi4zNTY3NDBdIHBjaSAwMDAyOjAwOjAwLjA6IEJBUiA2OiBubyBzcGFjZSBmb3Ig
W21lbSBzaXplIDB4MDAwMTAwMDAgcHJlZl0NClsgICAgNi40NDE1NThdIHBjaSAwMDAyOjAw
OjAwLjA6IEJBUiA2OiBmYWlsZWQgdG8gYXNzaWduIFttZW0gc2l6ZSAweDAwMDEwMDAwIHBy
ZWZdDQpbICAgIDYuNTMwNTgzXSBwY2kgMDAwMjowMDowMS4wOiBCQVIgNjogbm8gc3BhY2Ug
Zm9yIFttZW0gc2l6ZSAweDAwMDEwMDAwIHByZWZdDQpbICAgIDYuNjE1NDE1XSBwY2kgMDAw
MjowMDowMS4wOiBCQVIgNjogZmFpbGVkIHRvIGFzc2lnbiBbbWVtIHNpemUgMHgwMDAxMDAw
MCBwcmVmXQ0KWyAgICA2LjcwNDQ0MF0gcGNpIDAwMDI6MDA6MDAuMDogQkFSIDE6IG5vIHNw
YWNlIGZvciBbbWVtIHNpemUgMHgwMDAwMTAwMF0NClsgICAgNi43ODQwMzZdIHBjaSAwMDAy
OjAwOjAwLjA6IEJBUiAxOiBmYWlsZWQgdG8gYXNzaWduIFttZW0gc2l6ZSAweDAwMDAxMDAw
XQ0KWyAgICA2Ljg2NzgyNF0gcGNpIDAwMDI6MDA6MDEuMDogQkFSIDE6IG5vIHNwYWNlIGZv
ciBbbWVtIHNpemUgMHgwMDAwMTAwMF0NClsgICAgNi45NDc0MjBdIHBjaSAwMDAyOjAwOjAx
LjA6IEJBUiAxOiBmYWlsZWQgdG8gYXNzaWduIFttZW0gc2l6ZSAweDAwMDAxMDAwXQ0KWyAg
ICA3LjAzMTIxMF0gcGNpIDAwMDI6MDA6MDAuMDogQkFSIDA6IG5vIHNwYWNlIGZvciBbaW8g
IHNpemUgMHgwMTAwXQ0KWyAgICA3LjEwNjYyM10gcGNpIDAwMDI6MDA6MDAuMDogQkFSIDA6
IGZhaWxlZCB0byBhc3NpZ24gW2lvICBzaXplIDB4MDEwMF0NClsgICAgNy4xODYyMTVdIHBj
aSAwMDAyOjAwOjAxLjA6IEJBUiAwOiBubyBzcGFjZSBmb3IgW2lvICBzaXplIDB4MDEwMF0N
ClsgICAgNy4yNjE2MjBdIHBjaSAwMDAyOjAwOjAxLjA6IEJBUiAwOiBmYWlsZWQgdG8gYXNz
aWduIFtpbyAgc2l6ZSAweDAxMDBdDQpbICAgIDcuMzQxMzU4XSBQQ0kgaG9zdCBicmlkZ2Ug
dG8gYnVzIDAwMDE6MDANClsgICAgNy4zOTA0NTVdIHBjaV9idXMgMDAwMTowMDogcm9vdCBi
dXMgcmVzb3VyY2UgW21lbSAweDkyMDAwMDAwMGMyMDAwMDAtMHg5MjAwMDAwMDBjOWZmZmZm
XQ0KWyAgICA3LjQ4OTk0NV0gcGNpX2J1cyAwMDAxOjAwOiByb290IGJ1cyByZXNvdXJjZSBb
aW8gIDB4OTIwMDAwMDAwY2EwMDAwMC0weDkyMDAwMDAwMGNiZmZmZmZdDQpbICAgIDcuNTg5
NDQxXSBwY2lfYnVzIDAwMDE6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMgMDEtZmZdDQpb
ICAgIDcuNjU2MzkyXSBwY2kgMDAwMTowMDowMC4wOiBCQVIgMDogbm8gc3BhY2UgZm9yIFtt
ZW0gc2l6ZSAweDA4MDAwMDAwXQ0KWyAgICA3LjczNTAyMl0gcGNpIDAwMDE6MDA6MDAuMDog
QkFSIDA6IGZhaWxlZCB0byBhc3NpZ24gW21lbSBzaXplIDB4MDgwMDAwMDBdDQpbICAgIDcu
ODE4ODA4XSBwY2kgMDAwMTowMDowMS4wOiBCQVIgMDogbm8gc3BhY2UgZm9yIFttZW0gc2l6
ZSAweDA4MDAwMDAwXQ0KWyAgICA3Ljg5ODQwM10gcGNpIDAwMDE6MDA6MDEuMDogQkFSIDA6
IGZhaWxlZCB0byBhc3NpZ24gW21lbSBzaXplIDB4MDgwMDAwMDBdDQpbICAgIDcuOTgyMzE1
XSBQQ0kgaG9zdCBicmlkZ2UgdG8gYnVzIDAwMDA6MDANClsgICAgOC4wMzE0MTZdIHBjaV9i
dXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweDkyMDAwMDAwMGIyMDAwMDAt
MHg5MjAwMDAwMDBiOWZmZmZmXQ0KWyAgICA4LjEzMDkxNF0gcGNpX2J1cyAwMDAwOjAwOiBy
b290IGJ1cyByZXNvdXJjZSBbaW8gIDB4OTIwMDAwMDAwYmEwMDAwMC0weDkyMDAwMDAwMGJi
ZmZmZmZdDQpbICAgIDguMjMwNDEwXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291
cmNlIFtidXMgMDAtZmZdDQpbICAgIDguMjk3NDg3XSBjbG9ja3NvdXJjZTogU3dpdGNoZWQg
dG8gY2xvY2tzb3VyY2UgSFVCLVJUDQpbICAgIDguMzcwMzU4XSBORVQ6IFJlZ2lzdGVyZWQg
cHJvdG9jb2wgZmFtaWx5IDINClsgICAgOC40MjE2MzJdIFRDUCBlc3RhYmxpc2hlZCBoYXNo
IHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogMywgNTI0Mjg4IGJ5dGVzKQ0KWyAgICA4
LjUxMDg4MF0gVENQIGJpbmQgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDQs
IDEwNDg1NzYgYnl0ZXMpDQpbICAgIDguNTk0OTYwXSBUQ1A6IEhhc2ggdGFibGVzIGNvbmZp
Z3VyZWQgKGVzdGFibGlzaGVkIDY1NTM2IGJpbmQgNjU1MzYpDQpbICAgIDguNjcxODIxXSBV
RFAgaGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRlcjogMSwgMTMxMDcyIGJ5dGVzKQ0K
WyAgICA4Ljc0NTY3M10gVURQLUxpdGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA0MDk2IChvcmRl
cjogMSwgMTMxMDcyIGJ5dGVzKQ0KWyAgICA4LjgyNDY5Ml0gTkVUOiBSZWdpc3RlcmVkIHBy
b3RvY29sIGZhbWlseSAxDQpbICAgIDguODc3MDU0XSBmdXRleCBoYXNoIHRhYmxlIGVudHJp
ZXM6IDEwMjQgKG9yZGVyOiAxLCAxMzEwNzIgYnl0ZXMpDQpbICAgIDguOTUzMDAxXSB3b3Jr
aW5nc2V0OiB0aW1lc3RhbXBfYml0cz00MCBtYXhfb3JkZXI9MTcgYnVja2V0X29yZGVyPTAN
ClsgICAgOS4wMjkyMDZdIHpidWQ6IGxvYWRlZA0KWyAgICA5LjA2MTY2MF0gU0dJIFhGUyB3
aXRoIEFDTHMsIHNlY3VyaXR5IGF0dHJpYnV0ZXMsIHJlYWx0aW1lLCBubyBkZWJ1ZyBlbmFi
bGVkDQpbICAgIDkuMTUzNTYwXSBCbG9jayBsYXllciBTQ1NJIGdlbmVyaWMgKGJzZykgZHJp
dmVyIHZlcnNpb24gMC40IGxvYWRlZCAobWFqb3IgMjUzKQ0KWyAgICA5LjI0MDcwN10gaW8g
c2NoZWR1bGVyIG5vb3AgcmVnaXN0ZXJlZA0KWyAgICA5LjI4NzgwOV0gaW8gc2NoZWR1bGVy
IGRlYWRsaW5lIHJlZ2lzdGVyZWQNClsgICAgOS4zMzkxODhdIGlvIHNjaGVkdWxlciBjZnEg
cmVnaXN0ZXJlZCAoZGVmYXVsdCkNClsgICAgOS40NjAwMThdIFNlcmlhbDogODI1MC8xNjU1
MCBkcml2ZXIsIDQgcG9ydHMsIElSUSBzaGFyaW5nIGVuYWJsZWQNClsgICAxMy4zNTM5OTBd
IGxvb3A6IG1vZHVsZSBsb2FkZWQNClsgICAxMy4zODk5OTldIHFsYTEyODA6IFFMQTEwNDAg
Zm91bmQgb24gUENJIGJ1cyAwLCBkZXYgMA0KWyAgIDEzLjQ1MjMwNF0gcWxhMTI4MCAwMDAy
OjAwOjAwLjA6IGNhbid0IGlvcmVtYXAgQkFSIDE6IFs/Pz8gMHgwMDAwMDAwMCBmbGFncyAw
eDBdDQpbICAgMTMuNTQxNjkxXSBxbGExMjgwOiBVbmFibGUgdG8gbWFwIEkvTyBtZW1vcnkN
ClsgICAxMy41OTQzMzJdIHFsYTEyODA6IFFMQTEwNDAgZm91bmQgb24gUENJIGJ1cyAwLCBk
ZXYgMQ0KWyAgIDEzLjY1NjQwMl0gcWxhMTI4MCAwMDAyOjAwOjAxLjA6IGNhbid0IGlvcmVt
YXAgQkFSIDE6IFs/Pz8gMHgwMDAwMDAwMCBmbGFncyAweDBdDQpbICAgMTMuNzQ1OTE2XSBx
bGExMjgwOiBVbmFibGUgdG8gbWFwIEkvTyBtZW1vcnkNClsgICAxMy44MDkyNTZdIERhdGEg
YnVzIGVycm9yLCBlcGMgPT0gYTgwMDAwMDAwMDNmZGI3NCwgcmEgPT0gYTgwMDAwMDAwMDNm
ZTRmMA0KWyAgIDEzLjg5MTEzN10gT29wc1sjMV06DQpbICAgMTMuOTE4MzcyXSBDUFU6IDAg
UElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA0LjEwLjAtcmM3ICMyDQpbICAg
MTMuOTkzNzcxXSB0YXNrOiBhODAwMDAwMGUwNzdkYzgwIHRhc2suc3RhY2s6IGE4MDAwMDAw
ZTA3ODAwMDANClsgICAxNC4wNjQ5ODhdICQgMCAgIDogMDAwMDAwMDAwMDAwMDAwMCBmZmZm
ZmZmZjk0MDAxY2UwIDAwMDAwMDAwMDAwODAwYzAgZmZmZmZmZmZlZmZmZmZmZg0KWyAgIDE0
LjE2MTM0Ml0gJCA0ICAgOiA5MjAwMDAwMDAwMDIwMTc4IGZmZmZmZmZmOTQwMDFjZTEgZmZm
ZmZmZmZhODAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwDQpbICAgMTQuMjU3Njk3XSAkIDggICA6
IDAwMDAwMDAwMDAwMDAwMDEgYTgwMDAwMDFjMDlkNDA3MCBhODAwMDAwMWMwOWQ0MDYwIGZm
ZmZmZmZmZmZmZmZmZmYNClsgICAxNC4zNTQwNTFdICQxMiAgIDogMDAwMDAwMDAwMDAwMDAw
MCBhODAwMDAwMDAwMzJmMWVjIDAwMDAwMDAwMDAwMDAwMDAgYTgwMDAwMDBlMDc4ZmQ3NA0K
WyAgIDE0LjQ1MDQwNl0gJDE2ICAgOiA5MjAwMDAwMDAwMDAwMDAwIGE4MDAwMDAxYzA4YjQ4
MDAgMDAwMDAwMDAwMDAyMDAwMCBhODAwMDAwMWMwOWQ0NzAwDQpbICAgMTQuNTQ2NzYxXSAk
MjAgICA6IDAwMDAwMDAwMDAwMDAwMDAgYTgwMDAwMDAwMDdlMDAwMCBhODAwMDAwMWMwOWQ0
MDAwIGE4MDAwMDAwMDA2ZjA0NWMNClsgICAxNC42NDMxMTZdICQyNCAgIDogMDAwMDAwMDAw
MDAwMDAwMCAwMDAwMDAwMDAwNjgwMDAwDQpbICAgMTQuNzM5NDcyXSAkMjggICA6IGE4MDAw
MDAwZTA3ODAwMDAgYTgwMDAwMDBlMDc4ZmMzMCBhODAwMDAwMDAwNzYwMDAwIGE4MDAwMDAw
MDAzZmU0ZjANClsgICAxNC44MzU4MjddIEhpICAgIDogMDAwMDAwMDAwMDAwMDAwMA0KWyAg
IDE0Ljg3ODc2OF0gTG8gICAgOiAwMDAwMDAwMDAwMDBiNDAwDQpbICAgMTQuOTIxNzI0XSBl
cGMgICA6IGE4MDAwMDAwMDAzZmRiNzQgaW9jM19wcm9iZSsweDFkYy8weGRhMA0KWyAgIDE0
Ljk4ODc0NF0gcmEgICAgOiBhODAwMDAwMDAwM2ZlNGYwIGlvYzNfcHJvYmUrMHhiNTgvMHhk
YTANClsgICAxNS4wNTU3NjddIFN0YXR1czogOTQwMDFjZTMgS1ggU1ggVVggS0VSTkVMIEVY
TCBJRQ0KWyAgIDE1LjExNTQ2N10gQ2F1c2UgOiAwMDAwZDAxYyAoRXhjQ29kZSAwNykNClsg
ICAxNS4xNjM2NDRdIFBySWQgIDogMDAwMDBmMTQgKFIxNDAwMCkNClsgICAxNS4yMDc2MzZd
IFByb2Nlc3Mgc3dhcHBlci8wIChwaWQ6IDEsIHRocmVhZGluZm89YTgwMDAwMDBlMDc4MDAw
MCwgdGFzaz1hODAwMDAwMGUwNzdkYzgwLCB0bHM9MDAwMDAwMDAwMDAwMDAwMCkNClsgICAx
NS4zMzAxNjldIFN0YWNrIDogYTgwMDAwMDFjMDZiNjk3OCBhODAwMDAwMWMwZDZjYzYwIGE4
MDAwMDAxYzA4YjQ4MDAgYTgwMDAwMDFjMDhiNDgwMA0KWyAgIDE1LjQyNjUyNF0gICAgICAg
ICBhODAwMDAwMDAwNmEyZGMwIGE4MDAwMDAwMDA2OTZiZDAgMDAwMDAwMDAwMDAwMDAwMCBh
ODAwMDAwMDAwN2UwMDAwDQpbICAgMTUuNTIyODc5XSAgICAgICAgIGE4MDAwMDAwMDA2YTJl
MjggYTgwMDAwMDAwMDZmMDQ1YyBhODAwMDAwMDAwNzYwMDAwIGE4MDAwMDAwMDAzNzFmOTQN
ClsgICAxNS42MTkyMzRdICAgICAgICAgYTgwMDAwMDFjMDhiNDg5OCBhODAwMDAwMDAwMzcy
YTI4IGE4MDAwMDAwMDA2YTJkYzAgYTgwMDAwMDFjMDhiNDgwMA0KWyAgIDE1LjcxNTU4OF0g
ICAgICAgICBhODAwMDAwMDAwNTg4NTUwIGE4MDAwMDAwMDAzYzI4MjQgYTgwMDAwMDAwMDYy
YTQxMCBhODAwMDAwMDAwN2QwMDAwDQpbICAgMTUuODExOTQ0XSAgICAgICAgIGE4MDAwMDAx
YzA4YjQ4OTggYTgwMDAwMDAwMDdlMDAwMCAwMDAwMDAwMDAwMDAwMDAwIGE4MDAwMDAwMDAz
YzJlNTgNClsgICAxNS45MDgyOThdICAgICAgICAgYTgwMDAwMDFjMDhiNDg5OCBhODAwMDAw
MDAwNmEyZTI4IGE4MDAwMDAxYzA4YjQ4ZjggYTgwMDAwMDAwMDY5NmJkMA0KWyAgIDE2LjAw
NDY1M10gICAgICAgICBhODAwMDAwMDAwNzFiZjMwIGE4MDAwMDAwMDA3NjAwMDAgMDAwMDAw
MDAwMDAwMDAwNyBhODAwMDAwMDAwM2MzMGM4DQpbICAgMTYuMTAxMDA4XSAgICAgICAgIDAw
MDAwMDAwMDAwMDAwMDAgYTgwMDAwMDAwMDZhMmUyOCBhODAwMDAwMDAwM2MyZmQ4IGE4MDAw
MDAwMDAzYzBjYTQNClsgICAxNi4xOTczNjRdICAgICAgICAgYTgwMDAwMDBlMDkzYTBhMCBh
ODAwMDAwMWMwNzA4NTY4IGE4MDAwMDAwMDA2YTJlMjggYTgwMDAwMDFjMGQxOWYwMA0KWyAg
IDE2LjI5MzcxOF0gICAgICAgICAuLi4NClsgICAxNi4zMjMwNDZdIENhbGwgVHJhY2U6DQpb
ICAgMTYuMzUyMzc2XSBbPGE4MDAwMDAwMDAzZmRiNzQ+XSBpb2MzX3Byb2JlKzB4MWRjLzB4
ZGEwDQpbICAgMTYuNDE1MjMyXSBbPGE4MDAwMDAwMDAzNzFmOTQ+XSBsb2NhbF9wY2lfcHJv
YmUrMHgyYy8weDk4DQpbICAgMTYuNDgxMjAxXSBbPGE4MDAwMDAwMDAzNzJhMjg+XSBwY2lf
ZGV2aWNlX3Byb2JlKzB4MTQwLzB4MWI4DQpbICAgMTYuNTUwMzI1XSBbPGE4MDAwMDAwMDAz
YzJlNTg+XSByZWFsbHlfcHJvYmUrMHgxYjAvMHgzMzANClsgICAxNi42MTUyNTldIFs8YTgw
MDAwMDAwMDNjMzBjOD5dIF9fZHJpdmVyX2F0dGFjaCsweGYwLzB4ZjgNClsgICAxNi42ODEy
NDhdIFs8YTgwMDAwMDAwMDNjMGNhND5dIGJ1c19mb3JfZWFjaF9kZXYrMHg2Yy8weGI4DQpb
ICAgMTYuNzQ4MjcyXSBbPGE4MDAwMDAwMDAzYzE5NjA+XSBidXNfYWRkX2RyaXZlcisweDFj
OC8weDMzMA0KWyAgIDE2LjgxNTMwMV0gWzxhODAwMDAwMDAwM2MzZDM0Pl0gZHJpdmVyX3Jl
Z2lzdGVyKzB4ODQvMHgxNTANClsgICAxNi44ODIzNDBdIFs8YTgwMDAwMDAwMDZmMTA5Yz5d
IGRvX29uZV9pbml0Y2FsbCsweGM0LzB4MWI0DQpbICAgMTYuOTQ5MzYwXSBbPGE4MDAwMDAw
MDA2ZjE0Nzg+XSBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDJlYy8weDNlOA0KWyAgIDE3LjAy
MjY3NV0gWzxhODAwMDAwMDAwNTFmZGQwPl0ga2VybmVsX2luaXQrMHgxMC8weDFjMA0KWyAg
IDE3LjA4NTUxOV0gWzxhODAwMDAwMDAwMDI1OTY4Pl0gcmV0X2Zyb21fa2VybmVsX3RocmVh
ZCsweDE0LzB4MWMNClsgICAxNy4xNTg4MjNdIENvZGU6IDhlMDIwMDM0ICAwMjA0MjAyZCAg
YWUwMDAwNTggPDhlMDIwMDU4PiBhZTAwMDA1YyAgOGUwMjAwNWMgIDhlMDIwMGI4ICAwMDQz
MTAyNCAgYWUwMjAwYjgNClsgICAxNy4yNzYxMjJdDQpbICAgMTcuMjk0MDQ5XSAtLS1bIGVu
ZCB0cmFjZSAwMjcxNjRhZDM4ODNiNGMxIF0tLS0NClsgICAxNy4zNDk0ODVdIEtlcm5lbCBw
YW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24NClsgICAxNy40MTIzMjBdIFJl
Ym9vdCBzdGFydGVkIGZyb20gQ1BVIDANCg==
--------------4C5C23CE0FF9E9C9F06872E4
Content-Type: text/plain;
 name="ip27-dmesg-claim_pci-20170208.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ip27-dmesg-claim_pci-20170208.txt"

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA0LjEwLjAtcmM3IChyb290QGhlbGNhcmF4
ZSkgKGdjYyB2ZXJzaW9uIDYuMy4wIChHZW50b28gSGFyZGVuZWQgNi4zLjAgcDEuMCkgKSAj
MyBTTVAgV2VkIEZlYiA4IDA0OjEzOjIxIEVTVCAyMDE3DQpbICAgIDAuMDAwMDAwXSBBUkNI
OiBTR0ktSVAyNw0KWyAgICAwLjAwMDAwMF0gUFJPTUxJQjogQVJDIGZpcm13YXJlIFZlcnNp
b24gNjQgUmV2aXNpb24gMA0KWyAgICAwLjAwMDAwMF0gRGlzY292ZXJlZCA0IGNwdXMgb24g
MiBub2Rlcw0KWyAgICAwLjAwMDAwMF0gbm9kZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0K
WyAgICAwLjAwMDAwMF0gbm9kZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0KWyAgICAwLjAw
MDAwMF0gbm9kZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0KWyAgICAwLjAwMDAwMF0gbm9k
ZV9kaXN0YW5jZTogcm91dGVyX2EgTlVMTA0KWyAgICAwLjAwMDAwMF0gKioqKioqKioqKioq
KiogVG9wb2xvZ3kgKioqKioqKioqKioqKioqKioqKioNClsgICAgMC4wMDAwMDBdDQpbICAg
IDAuMDAwMDAwXSAwMA0KWyAgICAwLjAwMDAwMF0gMDENClsgICAgMC4wMDAwMDBdDQpbICAg
IDAuMDAwMDAwXSAwMA0KWyAgICAwLjAwMDAwMF0gMjU1DQpbICAgIDAuMDAwMDAwXSAyNTUN
ClsgICAgMC4wMDAwMDBdDQpbICAgIDAuMDAwMDAwXSAwMQ0KWyAgICAwLjAwMDAwMF0gMjU1
DQpbICAgIDAuMDAwMDAwXSAyNTUNClsgICAgMC4wMDAwMDBdDQpbICAgIDAuMDAwMDAwXSBi
b290Y29uc29sZSBbZWFybHkwXSBlbmFibGVkDQpbICAgIDAuMDAwMDAwXSBDUFUwIHJldmlz
aW9uIGlzOiAwMDAwMGYxNCAoUjE0MDAwKQ0KWyAgICAwLjAwMDAwMF0gRlBVIHJldmlzaW9u
IGlzOiAwMDAwMDkwMA0KWyAgICAwLjAwMDAwMF0gQ2hlY2tpbmcgZm9yIHRoZSBtdWx0aXBs
eS9zaGlmdCBidWcuLi4gbm8uDQpbICAgIDAuMDAwMDAwXSBDaGVja2luZyBmb3IgdGhlIGRh
ZGRpdSBidWcuLi4gbm8uDQpbICAgIDAuMDAwMDAwXSBJUDI3OiBSdW5uaW5nIG9uIG5vZGUg
MC4NClsgICAgMC4wMDAwMDBdIE5vZGUgMCBoYXMgYSBwcmltYXJ5IENQVSwgQ1BVIGlzIHJ1
bm5pbmcuDQpbICAgIDAuMDAwMDAwXSBOb2RlIDAgaGFzIGEgc2Vjb25kYXJ5IENQVSwgQ1BV
IGlzIHJ1bm5pbmcuDQpbICAgIDAuMDAwMDAwXSBNYWNoaW5lIGlzIGluIE0gbW9kZS4NClsg
ICAgMC4wMDAwMDBdIENwdSAwLCBOYXNpZCAweDA6IHBhcnRudW0gMHgwIGlzDQpbICAgIDAu
MDAwMDAwXSBpcyB4Ym93DQpbICAgIDAuMDAwMDAwXSBDcHUgMCwgTmFzaWQgMHgwLCB3aWRn
ZXQgMHg4IChwYXJ0bnVtIDB4YzEwMikgaXMNClsgICAgMC4wMDAwMDBdIENwdSAwLCBOYXNp
ZCAweDAsIHdpZGdldCAweGIgKHBhcnRudW0gMHhjMDAyKSBpcw0KWyAgICAwLjAwMDAwMF0g
Q3B1IDAsIE5hc2lkIDB4MCwgd2lkZ2V0IDB4YyAocGFydG51bSAweGMwMDIpIGlzDQpbICAg
IDAuMDAwMDAwXSBDcHUgMCwgTmFzaWQgMHgwLCB3aWRnZXQgMHhkIChwYXJ0bnVtIDB4YzAw
MykgaXMNClsgICAgMC4wMDAwMDBdIENwdSAwLCBOYXNpZCAweDAsIHdpZGdldCAweGYgKHBh
cnRudW0gMHhjMDAyKSBpcw0KWyAgICAwLjAwMDAwMF0gQ1BVIDAgY2xvY2sgaXMgNTAwTUh6
Lg0KWyAgICAwLjAwMDAwMF0gRGV0ZXJtaW5lZCBwaHlzaWNhbCBSQU0gbWFwOg0KWyAgICAw
LjAwMDAwMF0gIG1lbW9yeTogMDAwMDAwMDAwMDZlMDAwMCBAIDAwMDAwMDAwMDAwMTAwMDAg
KHVzYWJsZSkNClsgICAgMC4wMDAwMDBdICBtZW1vcnk6IDAwMDAwMDAwMDAwNTAwMDAgQCAw
MDAwMDAwMDAwNmYwMDAwICh1c2FibGUgYWZ0ZXIgaW5pdCkNClsgICAgMC4wMDAwMDBdIGNt
YTogUmVzZXJ2ZWQgNTEyIE1pQiBhdCAweDAwMDAwMDAxZTAwMDAwMDANClsgICAgMC4wMDAw
MDBdIFJFUExJQ0FUSU9OOiBPTiBuYXNpZCAwLCBrdGV4dCBmcm9tIG5hc2lkIDAsIGtkYXRh
IGZyb20gbmFzaWQgMA0KWyAgICAwLjAwMDAwMF0gUkVQTElDQVRJT046IE9OIG5hc2lkIDEs
IGt0ZXh0IGZyb20gbmFzaWQgMCwga2RhdGEgZnJvbSBuYXNpZCAwDQpbICAgIDAuMDAwMDAw
XSBQcmltYXJ5IGluc3RydWN0aW9uIGNhY2hlIDMya0IsIFZJUFQsIDItd2F5LCBsaW5lc2l6
ZSA2NCBieXRlcy4NClsgICAgMC4wMDAwMDBdIFByaW1hcnkgZGF0YSBjYWNoZSAzMmtCLCAy
LXdheSwgVklQVCwgbm8gYWxpYXNlcywgbGluZXNpemUgMzIgYnl0ZXMNClsgICAgMC4wMDAw
MDBdIFVuaWZpZWQgc2Vjb25kYXJ5IGNhY2hlIDgxOTJrQiAyLXdheSwgbGluZXNpemUgMTI4
IGJ5dGVzLg0KWyAgICAwLjAwMDAwMF0gWm9uZSByYW5nZXM6DQpbICAgIDAuMDAwMDAwXSAg
IE5vcm1hbCAgIFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDFmZmZmZmZmZl0N
ClsgICAgMC4wMDAwMDBdIE1vdmFibGUgem9uZSBzdGFydCBmb3IgZWFjaCBub2RlDQpbICAg
IDAuMDAwMDAwXSBFYXJseSBtZW1vcnkgbm9kZSByYW5nZXMNClsgICAgMC4wMDAwMDBdICAg
bm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDBmZmZmZmZmZl0N
ClsgICAgMC4wMDAwMDBdICAgbm9kZSAgIDE6IFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4
MDAwMDAwMDFmZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdIEluaXRtZW0gc2V0dXAgbm9kZSAw
IFttZW0gMHgwMDAwMDAwMDAwMDAwMDAwLTB4MDAwMDAwMDBmZmZmZmZmZl0NClsgICAgMC4w
MDAwMDBdIEluaXRtZW0gc2V0dXAgbm9kZSAxIFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4
MDAwMDAwMDFmZmZmZmZmZl0NClsgICAgMC4wMDAwMDBdIHBlcmNwdTogRW1iZWRkZWQgMiBw
YWdlcy9jcHUgQGE4MDAwMDAwMDE0MzAwMDAgczYwMDY0IHIwIGQ3MTAwOCB1MTMxMDcyDQpb
ICAgIDAuMDAwMDAwXSBCdWlsdCAyIHpvbmVsaXN0cyBpbiBOb2RlIG9yZGVyLCBtb2JpbGl0
eSBncm91cGluZyBvbi4gIFRvdGFsIHBhZ2VzOiAxMzA5NDQNClsgICAgMC4wMDAwMDBdIFBv
bGljeSB6b25lOiBOb3JtYWwNClsgICAgMC4wMDAwMDBdIEtlcm5lbCBjb21tYW5kIGxpbmU6
IHJvb3Q9ZGtzYygwLDEsMCkgY29uc29sZT10dHlTMCw5NjAwIHJvb3Q9L2Rldi9tZDANClsg
ICAgMC4wMDAwMDBdIFBJRCBoYXNoIHRhYmxlIGVudHJpZXM6IDQwOTYgKG9yZGVyOiAtMSwg
MzI3NjggYnl0ZXMpDQpbICAgIDAuMDAwMDAwXSBNZW1vcnk6IDc4NDY3ODRLLzgzODg2MDhL
IGF2YWlsYWJsZSAoNTE3Mksga2VybmVsIGNvZGUsIDY3OEsgcndkYXRhLCAxMTE2SyByb2Rh
dGEsIDMyMEsgaW5pdCwgNzAwSyBic3MsIDE3NTM2SyByZXNlcnZlZCwgNTI0Mjg4SyBjbWEt
cmVzZXJ2ZWQpDQpbICAgIDAuMDAwMDAwXSBIaWVyYXJjaGljYWwgUkNVIGltcGxlbWVudGF0
aW9uLg0KWyAgICAwLjAwMDAwMF0gIEJ1aWxkLXRpbWUgYWRqdXN0bWVudCBvZiBsZWFmIGZh
bm91dCB0byA2NC4NClsgICAgMC4wMDAwMDBdICBSQ1UgcmVzdHJpY3RpbmcgQ1BVcyBmcm9t
IE5SX0NQVVM9NjQgdG8gbnJfY3B1X2lkcz00Lg0KWyAgICAwLjAwMDAwMF0gUkNVOiBBZGp1
c3RpbmcgZ2VvbWV0cnkgZm9yIHJjdV9mYW5vdXRfbGVhZj02NCwgbnJfY3B1X2lkcz00DQpb
ICAgIDAuMDAwMDAwXSBOUl9JUlFTOjI1Ng0KWyAgICAwLjAwMDAwMF0gY2xvY2tzb3VyY2U6
IEhVQi1SVDogbWFzazogMHhmZmZmZmZmZmZmZmZmIG1heF9jeWNsZXM6IDB4MTI3MzUwYjg4
LCBtYXhfaWRsZV9uczogMTc2MzE4MDgwODQ4MCBucw0KWyAgICAwLjAwMDAxMl0gc2NoZWRf
Y2xvY2s6IDUyIGJpdHMgYXQgMTI1MGtIeiwgcmVzb2x1dGlvbiA4MDBucywgd3JhcHMgZXZl
cnkgNDM5ODA0NjUxMDgwMG5zDQpbICAgIDAuMTAzMTY4XSBDb25zb2xlOiBjb2xvdXIgZHVt
bXkgZGV2aWNlIDgweDI1DQpbICAgIDAuMTU2MjQ4XSBDYWxpYnJhdGluZyBkZWxheSBsb29w
Li4uIDc0OS41NiBCb2dvTUlQUyAobHBqPTM3NDc4NDApDQpbICAgIDAuMzE4NDk2XSBwaWRf
bWF4OiBkZWZhdWx0OiAzMjc2OCBtaW5pbXVtOiAzMDENClsgICAgMC4zNzgzMTRdIERlbnRy
eSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDEwNDg1NzYgKG9yZGVyOiA3LCA4Mzg4NjA4
IGJ5dGVzKQ0KWyAgICAwLjU3Nzg3OV0gSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVz
OiA1MjQyODggKG9yZGVyOiA2LCA0MTk0MzA0IGJ5dGVzKQ0KWyAgICAwLjcyMDM5MF0gTW91
bnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAxNjM4NCAob3JkZXI6IDEsIDEzMTA3MiBi
eXRlcykNClsgICAgMC44MDEyMzRdIE1vdW50cG9pbnQtY2FjaGUgaGFzaCB0YWJsZSBlbnRy
aWVzOiAxNjM4NCAob3JkZXI6IDEsIDEzMTA3MiBieXRlcykNClsgICAgMC45MDA3ODJdIENo
ZWNraW5nIGZvciB0aGUgZGFkZGkgYnVnLi4uIG5vLg0KWyAgICAwLjk1Nzg1M10gc21wOiBC
cmluZ2luZyB1cCBzZWNvbmRhcnkgQ1BVcyAuLi4NClsgICAgMS4wMTI4NjRdIFByaW1hcnkg
aW5zdHJ1Y3Rpb24gY2FjaGUgMzJrQiwgVklQVCwgMi13YXksIGxpbmVzaXplIDY0IGJ5dGVz
Lg0KWyAgICAxLjAxMjg4MF0gUHJpbWFyeSBkYXRhIGNhY2hlIDMya0IsIDItd2F5LCBWSVBU
LCBubyBhbGlhc2VzLCBsaW5lc2l6ZSAzMiBieXRlcw0KWyAgICAxLjAxMjg4OF0gVW5pZmll
ZCBzZWNvbmRhcnkgY2FjaGUgODE5MmtCIDItd2F5LCBsaW5lc2l6ZSAxMjggYnl0ZXMuDQpb
ICAgIDEuMDE2MDUzXSBDUFUgMSBjbG9jayBpcyA1MDBNSHouDQpbICAgIDEuMDE2MDc2XSBD
UFUxIHJldmlzaW9uIGlzOiAwMDAwMGYxNCAoUjE0MDAwKQ0KWyAgICAxLjAxNjA4MF0gRlBV
IHJldmlzaW9uIGlzOiAwMDAwMDkwMA0KWyAgICAxLjA1NDIwMF0gUHJpbWFyeSBpbnN0cnVj
dGlvbiBjYWNoZSAzMmtCLCBWSVBULCAyLXdheSwgbGluZXNpemUgNjQgYnl0ZXMuDQpbICAg
IDEuMDU0MjIwXSBQcmltYXJ5IGRhdGEgY2FjaGUgMzJrQiwgMi13YXksIFZJUFQsIG5vIGFs
aWFzZXMsIGxpbmVzaXplIDMyIGJ5dGVzDQpbICAgIDEuMDU0MjI5XSBVbmlmaWVkIHNlY29u
ZGFyeSBjYWNoZSA4MTkya0IgMi13YXksIGxpbmVzaXplIDEyOCBieXRlcy4NClsgICAgMS4w
NTc0NTddIENwdSAyLCBOYXNpZCAweDE6IHBhcnRudW0gMHgwIGlzDQpbICAgIDEuMDU3NDgw
XSBpcyB4Ym93DQpbICAgIDEuMDU3NTIzXSBDUFUgMiBjbG9jayBpcyA1MDBNSHouDQpbICAg
IDEuMDU3NTQwXSBDUFUyIHJldmlzaW9uIGlzOiAwMDAwMGYxNCAoUjE0MDAwKQ0KWyAgICAx
LjA1NzU0NF0gRlBVIHJldmlzaW9uIGlzOiAwMDAwMDkwMA0KWyAgICAxLjA5NDU0MF0gUHJp
bWFyeSBpbnN0cnVjdGlvbiBjYWNoZSAzMmtCLCBWSVBULCAyLXdheSwgbGluZXNpemUgNjQg
Ynl0ZXMuDQpbICAgIDEuMDk0NTU5XSBQcmltYXJ5IGRhdGEgY2FjaGUgMzJrQiwgMi13YXks
IFZJUFQsIG5vIGFsaWFzZXMsIGxpbmVzaXplIDMyIGJ5dGVzDQpbICAgIDEuMDk0NTY4XSBV
bmlmaWVkIHNlY29uZGFyeSBjYWNoZSA4MTkya0IgMi13YXksIGxpbmVzaXplIDEyOCBieXRl
cy4NClsgICAgMS4wOTc4MDFdIENQVSAzIGNsb2NrIGlzIDUwME1Iei4NClsgICAgMS4wOTc4
MzBdIENQVTMgcmV2aXNpb24gaXM6IDAwMDAwZjE0IChSMTQwMDApDQpbICAgIDEuMDk3ODMz
XSBGUFUgcmV2aXNpb24gaXM6IDAwMDAwOTAwDQpbICAgIDEuMTMxMzc5XSBzbXA6IEJyb3Vn
aHQgdXAgMiBub2RlcywgNCBDUFVzDQpbICAgIDIuNDI1MjA1XSBkZXZ0bXBmczogaW5pdGlh
bGl6ZWQNClsgICAgMi40NjQzNzFdIGNsb2Nrc291cmNlOiBqaWZmaWVzOiBtYXNrOiAweGZm
ZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiAxOTExMjYwNDQ2
Mjc1MDAwMCBucw0KWyAgICAyLjU4NjEwMF0geG9yOiBtZWFzdXJpbmcgc29mdHdhcmUgY2hl
Y2tzdW0gc3BlZWQNClsgICAgMi43NDE5NTddICAgIDhyZWdzICAgICA6ICAgNzEwLjQwMCBN
Qi9zZWMNClsgICAgMi44OTA1NzVdICAgIDhyZWdzX3ByZWZldGNoOiAgIDY4NC44MDAgTUIv
c2VjDQpbICAgIDMuMDQzMzM0XSAgICAzMnJlZ3MgICAgOiAgIDY1OS4yMDAgTUIvc2VjDQpb
ICAgIDMuMTcxMzc4XSByYW5kb206IGZhc3QgaW5pdCBkb25lDQpbICAgIDMuMTkxOTcxXSAg
ICAzMnJlZ3NfcHJlZmV0Y2g6ICAgNjQwLjAwMCBNQi9zZWMNClsgICAgMy4xOTE5NzldIHhv
cjogdXNpbmcgZnVuY3Rpb246IDhyZWdzICg3MTAuNDAwIE1CL3NlYykNClsgICAgMy4zMjk2
NjBdIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTYNClsgICAgMy40NDIxNzdd
IGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIGxhZGRlcg0KWyAgICAzLjUzOTYxMF0gY3B1aWRs
ZTogdXNpbmcgZ292ZXJub3IgbWVudQ0KWyAgICAzLjg2MjEzMF0gcmFpZDY6IGludDY0eDEg
IGdlbigpICAgMzA0IE1CL3MNClsgICAgNC4wODIyNTldIHJhaWQ2OiBpbnQ2NHgxICB4b3Io
KSAgICA2NSBNQi9zDQpbICAgIDQuMzAxOTk2XSByYWlkNjogaW50NjR4MiAgZ2VuKCkgICA0
NDUgTUIvcw0KWyAgICA0LjUyMTgwM10gcmFpZDY6IGludDY0eDIgIHhvcigpICAgMTUyIE1C
L3MNClsgICAgNC43NDE1OTZdIHJhaWQ2OiBpbnQ2NHg0ICBnZW4oKSAgIDM4NyBNQi9zDQpb
ICAgIDQuOTYxNDYzXSByYWlkNjogaW50NjR4NCAgeG9yKCkgICAxNDEgTUIvcw0KWyAgICA1
LjE4MTI0MV0gcmFpZDY6IGludDY0eDggIGdlbigpICAgMzE1IE1CL3MNClsgICAgNS40MDEx
MDRdIHJhaWQ2OiBpbnQ2NHg4ICB4b3IoKSAgIDExNiBNQi9zDQpbICAgIDUuNDUwNTU2XSBy
YWlkNjogdXNpbmcgYWxnb3JpdGhtIGludDY0eDIgZ2VuKCkgNDQ1IE1CL3MNClsgICAgNS41
MTU0OTBdIHJhaWQ2OiAuLi4uIHhvcigpIDE1MiBNQi9zLCBybXcgZW5hYmxlZA0KWyAgICA1
LjU3NDE0MV0gcmFpZDY6IHVzaW5nIGludHgxIHJlY292ZXJ5IGFsZ29yaXRobQ0KWyAgICA1
LjYzMTIxN10gU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQNClsgICAgNS42NzY1MDhdIFBD
SSBob3N0IGJyaWRnZSB0byBidXMgMDAwMjowMA0KWyAgICA1LjcyNDk4OV0gcGNpX2J1cyAw
MDAyOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4OTIwMDAwMDAwZjIwMDAwMC0weDky
MDAwMDAwMGY5ZmZmZmZdDQpbICAgIDUuODI0NDY3XSBwY2lfYnVzIDAwMDI6MDA6IHJvb3Qg
YnVzIHJlc291cmNlIFtpbyAgMHg5MjAwMDAwMDBmYTAwMDAwLTB4OTIwMDAwMDAwZmJmZmZm
Zl0NClsgICAgNS45MjM5NjZdIHBjaV9idXMgMDAwMjowMDogcm9vdCBidXMgcmVzb3VyY2Ug
W2J1cyAwMi1mZl0NClsgICAgNS45OTIwOTldIHBjaSAwMDAyOjAwOjAwLjA6IGNhbid0IGNs
YWltIEJBUiAwIFtpbyAgMHhmMjAwMDAwLTB4ZjIwMDBmZl06IG5vIGNvbXBhdGlibGUgYnJp
ZGdlIHdpbmRvdw0KWyAgICA2LjEwMjMzMF0gcGNpIDAwMDI6MDA6MDAuMDogY2FuJ3QgY2xh
aW0gQkFSIDEgW21lbSAweDBmMjAwMDAwLTB4MGYyMDBmZmZdOiBubyBjb21wYXRpYmxlIGJy
aWRnZSB3aW5kb3cNClsgICAgNi4yMTY0ODRdIHBjaSAwMDAyOjAwOjAwLjA6IGNhbid0IGNs
YWltIEJBUiA2IFttZW0gMHgwMDAwMDAwMC0weDAwMDBmZmZmIHByZWZdOiBubyBjb21wYXRp
YmxlIGJyaWRnZSB3aW5kb3cNClsgICAgNi4zMzU4OTRdIHBjaSAwMDAyOjAwOjAxLjA6IGNh
bid0IGNsYWltIEJBUiAwIFtpbyAgMHhmNDAwMDAwLTB4ZjQwMDBmZl06IG5vIGNvbXBhdGli
bGUgYnJpZGdlIHdpbmRvdw0KWyAgICA2LjQ0Nzk0Nl0gcGNpIDAwMDI6MDA6MDEuMDogY2Fu
J3QgY2xhaW0gQkFSIDEgW21lbSAweDBmNDAwMDAwLTB4MGY0MDBmZmZdOiBubyBjb21wYXRp
YmxlIGJyaWRnZSB3aW5kb3cNClsgICAgNi41NjIxMDVdIHBjaSAwMDAyOjAwOjAxLjA6IGNh
bid0IGNsYWltIEJBUiA2IFttZW0gMHgwMDAwMDAwMC0weDAwMDBmZmZmIHByZWZdOiBubyBj
b21wYXRpYmxlIGJyaWRnZSB3aW5kb3cNClsgICAgNi42ODE1MDFdIHBjaSAwMDAyOjAwOjAy
LjA6IGNhbid0IGNsYWltIEJBUiAwIFttZW0gMHgwZjYwMDAwMC0weDBmNmZmZmZmXTogbm8g
Y29tcGF0aWJsZSBicmlkZ2Ugd2luZG93DQpbICAgIDYuNzk1NjYxXSBwY2kgMDAwMjowMDow
Ni4wOiBjYW4ndCBjbGFpbSBCQVIgMCBbbWVtIDB4MGZhMDAwMDAtMHgwZmFmZmZmZl06IG5v
IGNvbXBhdGlibGUgYnJpZGdlIHdpbmRvdw0KWyAgICA2LjkwOTgyMV0gcGNpIDAwMDI6MDA6
MDcuMDogY2FuJ3QgY2xhaW0gQkFSIDAgW21lbSAweDAwMDAwMDAwLTB4MDAwMDFmZmZdOiBu
byBjb21wYXRpYmxlIGJyaWRnZSB3aW5kb3cNClsgICAgNy4wMjQxMTRdIFBDSSBob3N0IGJy
aWRnZSB0byBidXMgMDAwMTowMA0KWyAgICA3LjA3MzIwMF0gcGNpX2J1cyAwMDAxOjAwOiBy
b290IGJ1cyByZXNvdXJjZSBbbWVtIDB4OTIwMDAwMDAwYzIwMDAwMC0weDkyMDAwMDAwMGM5
ZmZmZmZdDQpbICAgIDcuMTcyNzA0XSBwY2lfYnVzIDAwMDE6MDA6IHJvb3QgYnVzIHJlc291
cmNlIFtpbyAgMHg5MjAwMDAwMDBjYTAwMDAwLTB4OTIwMDAwMDAwY2JmZmZmZl0NClsgICAg
Ny4yNzIyMDBdIHBjaV9idXMgMDAwMTowMDogcm9vdCBidXMgcmVzb3VyY2UgW2J1cyAwMS1m
Zl0NClsgICAgNy4zMzkxNDhdIHBjaSAwMDAxOjAwOjAwLjA6IGNhbid0IGNsYWltIEJBUiAw
IFttZW0gMHgwMDAwMDAwMC0weDA3ZmZmZmZmXTogbm8gY29tcGF0aWJsZSBicmlkZ2Ugd2lu
ZG93DQpbICAgIDcuNDUyMzQ2XSBwY2kgMDAwMTowMDowMS4wOiBjYW4ndCBjbGFpbSBCQVIg
MCBbbWVtIDB4MDAwMDAwMDAtMHgwN2ZmZmZmZl06IG5vIGNvbXBhdGlibGUgYnJpZGdlIHdp
bmRvdw0KWyAgICA3LjU2NjYyNV0gUENJIGhvc3QgYnJpZGdlIHRvIGJ1cyAwMDAwOjAwDQpb
ICAgIDcuNjE1NzMzXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0g
MHg5MjAwMDAwMDBiMjAwMDAwLTB4OTIwMDAwMDAwYjlmZmZmZl0NClsgICAgNy43MTUyMzJd
IHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2UgW2lvICAweDkyMDAwMDAwMGJh
MDAwMDAtMHg5MjAwMDAwMDBiYmZmZmZmXQ0KWyAgICA3LjgxNDcyMF0gcGNpX2J1cyAwMDAw
OjAwOiByb290IGJ1cyByZXNvdXJjZSBbYnVzIDAwLWZmXQ0KWyAgICA3Ljg4MTc5MF0gY2xv
Y2tzb3VyY2U6IFN3aXRjaGVkIHRvIGNsb2Nrc291cmNlIEhVQi1SVA0KWyAgICA3Ljk1NDYx
NV0gTkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAyDQpbICAgIDguMDA1OTM1XSBU
Q1AgZXN0YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiA2NTUzNiAob3JkZXI6IDMsIDUy
NDI4OCBieXRlcykNClsgICAgOC4wOTUxOTFdIFRDUCBiaW5kIGhhc2ggdGFibGUgZW50cmll
czogNjU1MzYgKG9yZGVyOiA0LCAxMDQ4NTc2IGJ5dGVzKQ0KWyAgICA4LjE3OTI2NF0gVENQ
OiBIYXNoIHRhYmxlcyBjb25maWd1cmVkIChlc3RhYmxpc2hlZCA2NTUzNiBiaW5kIDY1NTM2
KQ0KWyAgICA4LjI1NjEzMF0gVURQIGhhc2ggdGFibGUgZW50cmllczogNDA5NiAob3JkZXI6
IDEsIDEzMTA3MiBieXRlcykNClsgICAgOC4zMjk5NzVdIFVEUC1MaXRlIGhhc2ggdGFibGUg
ZW50cmllczogNDA5NiAob3JkZXI6IDEsIDEzMTA3MiBieXRlcykNClsgICAgOC40MDkwMDBd
IE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMQ0KWyAgICA4LjQ2MTM2MF0gZnV0
ZXggaGFzaCB0YWJsZSBlbnRyaWVzOiAxMDI0IChvcmRlcjogMSwgMTMxMDcyIGJ5dGVzKQ0K
WyAgICA4LjUzNzMzNl0gd29ya2luZ3NldDogdGltZXN0YW1wX2JpdHM9NDAgbWF4X29yZGVy
PTE3IGJ1Y2tldF9vcmRlcj0wDQpbICAgIDguNjEzNTEwXSB6YnVkOiBsb2FkZWQNClsgICAg
OC42NDU5NzFdIFNHSSBYRlMgd2l0aCBBQ0xzLCBzZWN1cml0eSBhdHRyaWJ1dGVzLCByZWFs
dGltZSwgbm8gZGVidWcgZW5hYmxlZA0KWyAgICA4LjczNzcyNF0gQmxvY2sgbGF5ZXIgU0NT
SSBnZW5lcmljIChic2cpIGRyaXZlciB2ZXJzaW9uIDAuNCBsb2FkZWQgKG1ham9yIDI1MykN
ClsgICAgOC44MjQ5MDldIGlvIHNjaGVkdWxlciBub29wIHJlZ2lzdGVyZWQNClsgICAgOC44
NzIwMDZdIGlvIHNjaGVkdWxlciBkZWFkbGluZSByZWdpc3RlcmVkDQpbICAgIDguOTIzMzc3
XSBpbyBzY2hlZHVsZXIgY2ZxIHJlZ2lzdGVyZWQgKGRlZmF1bHQpDQpbICAgIDkuMDQzNjI0
XSBTZXJpYWw6IDgyNTAvMTY1NTAgZHJpdmVyLCA0IHBvcnRzLCBJUlEgc2hhcmluZyBlbmFi
bGVkDQpbICAgIDkuMTMzMDg0XSBsb29wOiBtb2R1bGUgbG9hZGVkDQpbICAgIDkuMTY5MTIz
XSBxbGExMjgwOiBRTEExMDQwIGZvdW5kIG9uIFBDSSBidXMgMCwgZGV2IDANClsgICAgOS4y
MzA3NzZdIFBDSTogRW5hYmxpbmcgZGV2aWNlIDAwMDI6MDA6MDAuMCAoMDAwNiAtPiAwMDA3
KQ0KWyAgICA5LjI5OTQ4OV0gcWxhMTI4MCAwMDAyOjAwOjAwLjA6IGNhbid0IGlvcmVtYXAg
QkFSIDE6IFttZW0gc2l6ZSAweDAwMDAxMDAwXQ0KWyAgICA5LjM4MzY0NF0gcWxhMTI4MDog
VW5hYmxlIHRvIG1hcCBJL08gbWVtb3J5DQpbICAgIDkuNDM2MzAzXSBxbGExMjgwOiBRTEEx
MDQwIGZvdW5kIG9uIFBDSSBidXMgMCwgZGV2IDENClsgICAgOS40OTc4MDddIFBDSTogRW5h
YmxpbmcgZGV2aWNlIDAwMDI6MDA6MDEuMCAoMDAwNiAtPiAwMDA3KQ0KWyAgICA5LjU2NjM4
OV0gcWxhMTI4MCAwMDAyOjAwOjAxLjA6IGNhbid0IGlvcmVtYXAgQkFSIDE6IFttZW0gc2l6
ZSAweDAwMDAxMDAwXQ0KWyAgICA5LjY1MDcxM10gcWxhMTI4MDogVW5hYmxlIHRvIG1hcCBJ
L08gbWVtb3J5DQpbICAgIDkuODcyMzAyXSBjb25zb2xlIFt0dHlTMF0gZW5hYmxlZGSmWyAg
ICA5Ljc2NjIzOF0gc2VyaWFsODI1MDogdHR5UzAgYXQgTU1JTyAweDkyMDAwMDAwMGY2MjAx
NzggKGlycSA9IDAsIGJhc2VfYmF1ZCA9IDQ1ODMzMykgaXMgYSAxNjU1MEENClsgICAgOS44
NzIzMDJdIGNvbnNvbGUgW3R0eVMwXSBlbmFibGVkDQpbICAgIDkuOTU1MDY3XSBib290Y29u
c29sZSBbZWFybHkwXSBkaXNhYmxlZA0KWyAgICA5Ljk1NTA2N10gYm9vdGNvbnNvbGUgW2Vh
cmx5MF0gZGlzYWJsZWQNClsgICAxMC4wNzMwMDBdIHNlcmlhbDgyNTA6IHR0eVMxIGF0IE1N
SU8gMHg5MjAwMDAwMDBmNjIwMTcwIChpcnEgPSAwLCBiYXNlX2JhdWQgPSA0NTgzMzMpIGlz
IGEgMTY1NTBBDQpbICAgMTAuMjE2MTAwXSBGb3VuZCBEUzE5ODFVIE5JQw0KWyAgIDEwLjIx
NjExMl0gIHJlZ2lzdHJhdGlvbiBudW1iZXIgNWU6NTc6MDM6MDA6NzA6NWUsIENSQyA1Mg0K
WyAgIDEwLjI1MTkyMl0gLg0KWyAgIDEwLjM1MzEyOV0gRXRoZXJuZXQgYWRkcmVzcyBpcyAw
ODowMDo2OTowNTo2NDo3NC4NClsgICAxMC40MTIxNjZdIGlvYzMtZXRoIDAwMDI6MDA6MDIu
MCBldGgwOiBsaW5rIHVwLCAxMDBNYnBzLCBmdWxsLWR1cGxleCwgbHBhIDB4OERFMQ0KWyAg
IDEwLjUwMjM1Nl0gZXRoMDogVXNpbmcgUEhZIDMxLCB2ZW5kb3IgMHgyMDAwNWMwLCBtb2Rl
bCAwLCByZXYgMC4NClsgICAxMC41NzU4NjNdIGV0aDA6IElPQzMgU1NSQU0gaGFzIDEyOCBr
Ynl0ZS4NClsgICAxMC42NDY5OTFdIHNlcmlhbDgyNTA6IHR0eVMyIGF0IE1NSU8gMHg5MjAw
MDAwMDBmYTIwMTc4IChpcnEgPSAwLCBiYXNlX2JhdWQgPSA0NTgzMzMpIGlzIGEgMTY1NTBB
DQpbICAgMTAuNzc1OTUwXSBzZXJpYWw4MjUwOiB0dHlTMyBhdCBNTUlPIDB4OTIwMDAwMDAw
ZmEyMDE3MCAoaXJxID0gMCwgYmFzZV9iYXVkID0gNDU4MzMzKSBpcyBhIDE2NTUwQQ0KWyAg
IDEwLjg4NzcxNl0gTklDIHNlYXJjaCBmYWlsZWQgKG5vdCBmYXRhbCkuDQpbICAgMTAuOTM5
NTYxXSBOSUMgc2VhcmNoIGZhaWxlZCAobm90IGZhdGFsKS4NClsgICAxMC45ODk0MzRdIEZh
aWxlZCB0byByZWFkIE1BQyBhZGRyZXNzDQpbICAgMTEuMDM0NjEyXSBFdGhlcm5ldCBhZGRy
ZXNzIGlzIDAwOjAwOjAwOjAwOjAwOjAwLg0KWyAgIDExLjA5MzUzNl0gaW9jMy1ldGggMDAw
MjowMDowNi4wIGV0aDE6IGxpbmsgZG93bg0KWyAgIDExLjE1MDIzN10gZXRoMTogVXNpbmcg
UEhZIDMxLCB2ZW5kb3IgMHgwLCBtb2RlbCAwLCByZXYgMC4NClsgICAxMS4yMTc0OTZdIGV0
aDE6IElPQzMgU1NSQU0gaGFzIDY0IGtieXRlLg0KWyAgIDExLjI2NzkyOF0gTkVUOiBSZWdp
c3RlcmVkIHByb3RvY29sIGZhbWlseSAxNw0KWyAgIDExLjMyMjEwNl0gcnRjLW00OHQzNSBy
dGMtbTQ4dDM1OiBydGMgY29yZTogcmVnaXN0ZXJlZCBtNDh0MzUgYXMgcnRjMA0KWyAgIDEx
LjQwMjM2MF0gcnRjLW00OHQzNSBydGMtbTQ4dDM1OiBzZXR0aW5nIHN5c3RlbSBjbG9jayB0
byAyMDE3LTAyLTA4IDA5OjEzOjU1IFVUQyAoMTQ4NjU0NTIzNSkNClsgICAxMS41MDkyMjBd
IG1kOiBXYWl0aW5nIGZvciBhbGwgZGV2aWNlcyB0byBiZSBhdmFpbGFibGUgYmVmb3JlIGF1
dG9kZXRlY3QNClsgICAxMS41OTEwNjBdIG1kOiBJZiB5b3UgZG9uJ3QgdXNlIHJhaWQsIHVz
ZSByYWlkPW5vYXV0b2RldGVjdA0KWyAgIDExLjY2MDc4MF0gbWQ6IEF1dG9kZXRlY3Rpbmcg
UkFJRCBhcnJheXMuDQpbICAgMTEuNzEwMTY4XSBtZDogYXV0b3J1biAuLi4NClsgICAxMS43
NDM4ODhdIG1kOiAuLi4gYXV0b3J1biBET05FLg0KWyAgIDExLjc4NDgwNF0gaXNvZnNfZmls
bF9zdXBlcjogYnJlYWQgZmFpbGVkLCBkZXY9bWQwLCBpc29fYmxrbnVtPTE2LCBibG9jaz0z
Mg0KWyAgIDExLjg3MDY5NV0gVURGLWZzOiBlcnJvciAoZGV2aWNlIG1kMCk6IHVkZl9yZWFk
X3RhZ2dlZDogcmVhZCBmYWlsZWQsIGJsb2NrPTI1NiwgbG9jYXRpb249MjU2DQpbICAgMTEu
OTczNzQ3XSBVREYtZnM6IGVycm9yIChkZXZpY2UgbWQwKTogdWRmX3JlYWRfdGFnZ2VkOiBy
ZWFkIGZhaWxlZCwgYmxvY2s9NTEyLCBsb2NhdGlvbj01MTINClsgICAxMi4wNzcwOTFdIFVE
Ri1mczogZXJyb3IgKGRldmljZSBtZDApOiB1ZGZfcmVhZF90YWdnZWQ6IHJlYWQgZmFpbGVk
LCBibG9jaz0yNTYsIGxvY2F0aW9uPTI1Ng0KWyAgIDEyLjE3OTk5OV0gVURGLWZzOiBlcnJv
ciAoZGV2aWNlIG1kMCk6IHVkZl9yZWFkX3RhZ2dlZDogcmVhZCBmYWlsZWQsIGJsb2NrPTUx
MiwgbG9jYXRpb249NTEyDQpbICAgMTIuMjgyODI0XSBVREYtZnM6IHdhcm5pbmcgKGRldmlj
ZSBtZDApOiB1ZGZfZmlsbF9zdXBlcjogTm8gcGFydGl0aW9uIGZvdW5kICgxKQ0KWyAgIDEy
LjM3NTEyOF0gVkZTOiBDYW5ub3Qgb3BlbiByb290IGRldmljZSAibWQwIiBvciB1bmtub3du
LWJsb2NrKDksMCk6IGVycm9yIC01DQpbICAgMTIuNDYyMjQ1XSBQbGVhc2UgYXBwZW5kIGEg
Y29ycmVjdCAicm9vdD0iIGJvb3Qgb3B0aW9uOyBoZXJlIGFyZSB0aGUgYXZhaWxhYmxlIHBh
cnRpdGlvbnM6DQpbICAgMTIuNTYzMDE4XSBLZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzog
VkZTOiBVbmFibGUgdG8gbW91bnQgcm9vdCBmcyBvbiB1bmtub3duLWJsb2NrKDksMCkNClsg
ICAxMi42NjI2OTVdIFJlYm9vdCBzdGFydGVkIGZyb20gQ1BVIDANClsgICAxMi43MDY4NDRd
IC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KWyAgIDEyLjc2MjQ4M10g
V0FSTklORzogQ1BVOiAwIFBJRDogMSBhdCBrZXJuZWwvc21wLmM6NDA1IHNtcF9jYWxsX2Z1
bmN0aW9uX21hbnkrMHgxOGMvMHg0MzANClsgICAxMi44NjEwMjBdIENQVTogMCBQSUQ6IDEg
Q29tbTogc3dhcHBlci8wIE5vdCB0YWludGVkIDQuMTAuMC1yYzcgIzMNClsgICAxMi45MzY1
MjZdIFN0YWNrIDogMDAwMDAwMDAwMDAwMDAwNiBhODAwMDAwMDAwNzcxNGEyIDAwMDAwMDAw
MDAwMDAwMDAgYTgwMDAwMDAwMDA5ZWQ1OA0KWyAgIDEzLjAzMjk4MF0gICAgICAgICBmZmZm
ZmZmZjk0MDAxY2UwIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCBhODAwMDAw
MDAwNzcwMDAwDQpbICAgMTMuMTI5NDQwXSAgICAgICAgIGE4MDAwMDAwMDA2N2JjZjcgYTgw
MDAwMDAwMDYxMGE1MCBhODAwMDAwMGUwNzcyODgwIDAwMDAwMDAwMDAwMDAwMDANClsgICAx
My4yMjU5MDBdICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMSBhODAwMDAwMDAwNzY5NjcwIGE4
MDAwMDAwMDAwMzA0NjAgMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDEzLjMyMjM2MF0gICAgICAg
ICBhODAwMDAwMDAwNjcwMDAwIGE4MDAwMDAwMDAxMDIyOTggYTgwMDAwMDBlMDc4ZmI3OCBh
ODAwMDAwMDAwMDQ5NGRjDQpbICAgMTMuNDE4ODIwXSAgICAgICAgIGZmZmZmZmZmOTQwMDFj
ZTAgYTgwMDAwMDAwMDBhMDlhMCAwMDAwMDAwMDAwMDAwMGYzIGE4MDAwMDAwMDA2MTBhNTAN
ClsgICAxMy41MTUyNzldICAgICAgICAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDAwMDAw
MDAxIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDEzLjYxMTc0MF0g
ICAgICAgICAwMDAwMDAwMDAwMDAwMDAwIGE4MDAwMDAwZTA3OGZhYzAgMDAwMDAwMDAwMDAw
MDAwMCBhODAwMDAwMDAwMzFlNmVjDQpbICAgMTMuNzA4MTk5XSAgICAgICAgIDAwMDAwMDAw
MDAwMDAwMDAgMDAwMDAwMDAwMDAwMDAwMCAwMDAwMDAwMDAwMDAwMDAwIDAwZmZmZmZmOTQw
MDFjZTANClsgICAxMy44MDQ2NjBdICAgICAgICAgYTgwMDAwMDAwMDY5MDAwMCBhODAwMDAw
MDAwMDJiYjg4IDAwMDAwMDAwMDAwMDAwMDAgYTgwMDAwMDAwMDMxZTZlYw0KWyAgIDEzLjkw
MTEyMF0gICAgICAgICAuLi4NClsgICAxMy45MzA1NTJdIENhbGwgVHJhY2U6DQpbICAgMTMu
OTU5OTk1XSBbPGE4MDAwMDAwMDAwMmJiODg+XSBzaG93X3N0YWNrKzB4ODgvMHhiOA0KWyAg
IDE0LjAyMDg1NF0gWzxhODAwMDAwMDAwMzFlNmVjPl0gZHVtcF9zdGFjaysweGFjLzB4ZTAN
ClsgICAxNC4wODE2ODddIFs8YTgwMDAwMDAwMDA0OThhND5dIF9fd2FybisweDE0NC8weDE2
OA0KWyAgIDE0LjE0MDQ0NF0gWzxhODAwMDAwMDAwMGNlODZjPl0gc21wX2NhbGxfZnVuY3Rp
b25fbWFueSsweDE4Yy8weDQzMA0KWyAgIDE0LjIxNTk1N10gWzxhODAwMDAwMDAwMGNlYjQ4
Pl0gc21wX2NhbGxfZnVuY3Rpb24rMHgzOC8weDQ4DQpbICAgMTQuMjg0MTM3XSBbPGE4MDAw
MDAwMDAwMWVjMTg+XSBpcDI3X21hY2hpbmVfcmVzdGFydCsweDMwLzB4NTANClsgICAxNC4z
NTU0NjJdIFs8YTgwMDAwMDAwMDAyOWVhND5dIG1hY2hpbmVfcmVzdGFydCsweDM0LzB4OTAN
ClsgICAxNC40MjE1NTJdIFs8YTgwMDAwMDAwMDEwMjBjYz5dIHBhbmljKzB4MjljLzB4MzI0
DQpbICAgMTQuNDc5MjY4XSBbPGE4MDAwMDAwMDA2ZjFjMWM+XSBtb3VudF9ibG9ja19yb290
KzB4NDE4LzB4NDQ0DQpbICAgMTQuNTQ4NDg4XSBbPGE4MDAwMDAwMDA2ZjFmMmM+XSBwcmVw
YXJlX25hbWVzcGFjZSsweDIxYy8weDI5NA0KWyAgIDE0LjYxODc2NF0gWzxhODAwMDAwMDAw
NmYxNTQ0Pl0ga2VybmVsX2luaXRfZnJlZWFibGUrMHgzYjgvMHgzZTgNClsgICAxNC42OTIx
ODddIFs8YTgwMDAwMDAwMDUxZmRmMD5dIGtlcm5lbF9pbml0KzB4MTAvMHgxYzANClsgICAx
NC43NTUxMjRdIFs8YTgwMDAwMDAwMDAyNTk2OD5dIHJldF9mcm9tX2tlcm5lbF90aHJlYWQr
MHgxNC8weDFjDQpbICAgMTQuODI4NTQyXSAtLS1bIGVuZCB0cmFjZSA2ODkxYzIzNmM0ZWZl
YTU0IF0tLS0NCg==
--------------4C5C23CE0FF9E9C9F06872E4--
