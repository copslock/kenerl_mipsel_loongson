Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 05:25:26 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:48043 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992362AbeGKDZTPrCB0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 Jul 2018 05:25:19 +0200
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w6B3PAC9027262
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 10 Jul 2018 20:25:10 -0700 (PDT)
Received: from [128.224.162.148] (128.224.162.148) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.399.0; Tue, 10 Jul 2018
 20:25:09 -0700
To:     <ralf@linux-mips.org>, <paul.burton@mips.com>, <jhogan@kernel.org>
CC:     <linux-mips@linux-mips.org>
From:   Rui Wang <rui.wang@windriver.com>
Subject: pci_resource_to_user exports wrong region size on mips
Message-ID: <4bcefc31-a62e-17ba-eb10-a3cd4e8bd06c@windriver.com>
Date:   Wed, 11 Jul 2018 11:25:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Return-Path: <Rui.Wang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rui.wang@windriver.com
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

Hi all,

I use a mips board cav-octeon3 with 4.1.21 kernel. And there is a pci 
ethernet card plugged in the board. When I run command "lspci -vv", the 
following information listed:

----------------------------------------------------------------------------------

01:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet 
Controller (rev 06)
     Subsystem: Intel Corporation PRO/1000 PT Dual Port Server Adapter
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Interrupt: pin A routed to IRQ 369
     Region 0: Memory at 11b00f0000000 (32-bit, non-prefetchable) 
[disabled] [size=128K]
     Region 1: Memory at 11b00f0020000 (32-bit, non-prefetchable) 
[disabled] [size=128K]
     Region 2: I/O ports at 1000 [disabled] [size=33]
     Region 3: Memory at <unassigned> (32-bit, non-prefetchable) 
[disabled] [size=2]
     Region 4: Memory at <unassigned> (32-bit, non-prefetchable) 
[disabled] [size=2]
     Region 5: Memory at <unassigned> (32-bit, non-prefetchable) 
[disabled] [size=2]
     Expansion ROM at <unassigned> [disabled] [size=2]
     Capabilities: [c8] Power Management version 2
         Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold-)
         Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=1 PME-
     Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
         Address: 0000000000000000  Data: 0000
     Capabilities: [e0] Express (v1) Endpoint, MSI 00
         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 <64us
             ExtTag- AttnBtn- AttnInd- PwrInd- RBE- FLReset-
         DevCtl:    Report errors: Correctable- Non-Fatal- Fatal- 
Unsupported-
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 512 bytes
         DevSta:    CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #4, Speed 2.5GT/s, Width x4, ASPM L0s, Exit 
Latency L0s <4us, L1 <64us
             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
         LnkCtl:    ASPM Disabled; RCB 64 bytes Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ 
DLActive- BWMgmt- ABWMgmt-
     Capabilities: [100 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         AERCap:    First Error Pointer: 14, GenCap- CGenEn- ChkCap- ChkEn-
     Capabilities: [140 v1] Device Serial Number 00-15-17-ff-ff-de-15-e8

----------------------------------------------------------------------------------

As we can see, Region 2 has a size of 33, which is obviously wrong, 
because the size should be the power of 2. And Region3 to Region5 should 
not have existed.

I do some research myself and finally I find that the lspci use the 
information from sysfs, which is exported by the function 
"resource_show", and the region size is calculated by 
"pci_resource_to_user". On mips platform, the micro 
HAVE_ARCH_PCI_RESOURCE_TO_USER is defined, so the function 
"pci_resource_to_user" in "arch/mips/include/asm/pci.h" is called.

----------------------------------------------------------------------------------

static inline resource_size_t resource_size(const struct resource *res)
{
     return res->end - res->start + 1;
}

static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
         const struct resource *rsrc, resource_size_t *start,
         resource_size_t *end)
{
     phys_addr_t size = resource_size(rsrc);

     *start = fixup_bigphys_addr(rsrc->start, size);
     *end = rsrc->start + size;
}

----------------------------------------------------------------------------------

In that function, the "size" is set to "end - start + 1", this is all 
right. And "start" is actually set to "rsrc->start".

What confused me is that the "end" is set to "start + size".

If we replace the "size" to "end - start + 1", then the "end" is 
actually set to "start + end - start + 1", which is "end + 1".

I think this is the reason why the region size is 33 rather then 32.

I have checked the latest kernel, but the code is still like that. Is 
this a feature I don not understand or just a bug.

Thanks,

Rui Wang
