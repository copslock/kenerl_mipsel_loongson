Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 18:37:49 +0200 (CEST)
Received: from kymasys.com ([64.62.140.43]:34370 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6835104Ab3FJQhfo21Bi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 18:37:35 +0200
Received: from ::ffff:75.40.23.192 ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Mon, 10 Jun 2013 09:37:24 -0700
Subject: Re: [PATCH 00/31] KVM/MIPS: Implement hardware virtualization via the MIPS-VZ extensions.
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
From:   Sanjay Lal <sanjayl@kymasys.com>
In-Reply-To: <51B50E87.2060501@gmail.com>
Date:   Mon, 10 Jun 2013 09:37:30 -0700
Cc:     Gleb Natapov <gleb@redhat.com>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>, kvm@vger.kernel.org,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <1CA521E6-00F2-4992-9F90-5B408C80C9B1@kymasys.com>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com> <51B26974.5000306@caviumnetworks.com> <20130609073115.GE4725@redhat.com> <51B50E87.2060501@gmail.com>
To:     David Daney <david.s.daney@gmail.com>
X-Mailer: Apple Mail (2.1283)
Return-Path: <sanjayl@kymasys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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


On Jun 9, 2013, at 4:23 PM, David Daney wrote:

> On 06/09/2013 12:31 AM, Gleb Natapov wrote:
>> On Fri, Jun 07, 2013 at 04:15:00PM -0700, David Daney wrote:
>>> I should also add that I will shortly send patches for the kvm tool
>>> required to drive this VM as well as a small set of patches that
>>> create a para-virtualized MIPS/Linux guest kernel.
>>> 
>>> The idea is that because there is no standard SMP linux system, we
>>> create a standard para-virtualized system that uses a handful of
>>> hypercalls, but mostly just uses virtio devices.  It has no emulated
>>> real hardware (no 8250 UART, no emulated legacy anything...)
>>> 
>> Virtualization is useful for running legacy code. Why dismiss support
>> for non pv guests so easily?
> 
> Just because we create standard PV system devices, doesn't preclude emulating real hardware.  In fact Sanjay Lal's work includes QEMU support for doing just this for a MIPS malta board.  I just wanted a very simple system I could implement with the kvm tool in a couple of days, so that is what I initially did.
> 
> The problem is that almost nobody has real malta boards, they are really only of interest because QEMU implements a virtual malta board.
> 
> Personally, I see the most interesting us cases of MIPS KVM being a deployment platform for new services, so legacy support is not so important to me.  That doesn't mean that other people wouldn't want some sort of legacy support.  The problem with 'legacy' on MIPS is that there are hundreds of legacies to choose from (Old SGI and DEC hardware, various network hardware from many different vendors, etc.).  Which would you choose?
> 
>>  How different MIPS SMP systems are?
> 
> o Old SGI heavy metal (several different system architectures).
> 
> o Cavium OCTEON SMP SoCs.
> 
> o Broadcom (several flavors) SoCs
> 
> o Loongson
> 
> 
> Come to think of it, Emulating SGI hardware might be an interesting case.  There may be old IRIX systems and applications that could be running low on real hardware.  Some of those systems take up a whole room and draw a lot of power.  They might run faster and at much lower power consumption on a modern 48-Way SMP SoC based system.
> 
>>  What
>> about running non pv UP systems?
> 
> See above.  I think this is what Sanjay Lal is doing.


The KVM implementation from MIPS (currently in mainline) supports UP systems in trap and emulate mode.  The patch set I posted earlier adding VZ support also supports SMP.  We leverage the Malta board emulation in QEMU to offer full non-PV virtualization:

UP system: Malta board with a MIPS 24K processor
SMP system: Malta board with a 1074K CMP processor cluster with a GIC.

When it comes to PV/non-PV support, I see the two implementations as complementary.  If people want full legacy system emulation without any kernel modifications, then they can run the full QEMU/KVM stack, while people interested in pure PV solutions can run the lkvm version.

Regards
Sanjay
