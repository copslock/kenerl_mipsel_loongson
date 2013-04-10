Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Apr 2013 18:58:35 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:56320 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822672Ab3DJQ6enlQ0b (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 10 Apr 2013 18:58:34 +0200
Message-ID: <51659902.2080505@phrozen.org>
Date:   Wed, 10 Apr 2013 18:53:22 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: implement pcibios_get_phb_of_node
References: <1365098483-26821-1-git-send-email-juhosg@openwrt.org> <1365098483-26821-2-git-send-email-juhosg@openwrt.org> <CAErSpo4ih-Kgp4LxX1MDodac-eoPo=Mu1d6ex8oNnaEEc_GQnw@mail.gmail.com>
In-Reply-To: <CAErSpo4ih-Kgp4LxX1MDodac-eoPo=Mu1d6ex8oNnaEEc_GQnw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

On 10/04/13 18:31, Bjorn Helgaas wrote:
> On Thu, Apr 4, 2013 at 12:01 PM, Gabor Juhos<juhosg@openwrt.org>  wrote:
>> The of_node field of the device assigned to a
>> PCI bus is used during scanning of the PCI bus.
>> However on MIPS, the of_node field is assigned
>> only after the bus has been scanned.
>>
>> Implement the architecture specific version of
>> 'pcibios_get_phb_of_node'. Which ensures that the
>> PCI driver core will initialize the of_node field
>> before starting the scan.
>>
>> Also remove the local assignment of bus->dev.of_node,
>> it is not needed after the patch.
>>
>> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
>
> I removed the __weak annotation from include/linux/pci.h and applied
> this patch to my pci/gabor-get-of-node.  Give it a try and make sure
> it solves your problem.  If so, and Ralph approves, I can push both
> for v3.10.  It should appear at
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/gabor-get-of-node
> soon.
>
> Or if you prefer, you can take them through the MIPS tree.
>
> Bjorn

Hi,

having them go via the PCI tree is fine. I will mark them as "Other 
Subsystem" in our Patchwork

	John
