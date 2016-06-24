Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2016 01:24:41 +0200 (CEST)
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:56031 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012495AbcFXXYjlWd0a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Jun 2016 01:24:39 +0200
Received: from resomta-po-14v.sys.comcast.net ([96.114.154.238])
        by resqmta-po-12v.sys.comcast.net with SMTP
        id GaSYbiaW3GpVBGaSebnDRi; Fri, 24 Jun 2016 23:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1466810672;
        bh=pXX6kQe67VQew2QdEjlte7/ufnW5D7+7UJsUi97c9fw=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=g3cSE4HMOW0jY56cumx8imSgO+jH2lC5raNBnbADzQvZtccP0OloUdMNd6ZqoZTix
         aHjY2vK8tdc9BlCnUGznCGtdhNwwBtaEUYTubjelbm/Pb9vq1Jow42aRIHlhlkQvdR
         9ZrPIW52n1cxpEm7XMdAQ3tODCcStddVmAhzPZuozA9QcCVRHUuyNah9mjYymhi6Uu
         UHA1SvpIp/r755M5IloL0ufHQ0DPmn/P+uaPvIBbZYVgrqWdeQgyhGF+tslAApmiOx
         zfWaLusJvQo31D6Gnay75wJdw/E85SMx0ix4fBuBJX9PM2PUHZ/6BxwMk3BCapGjib
         bijMt8nP5mSSQ==
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-po-14v.sys.comcast.net with comcast
        id AnQW1t00G0w5D3801nQXmi; Fri, 24 Jun 2016 23:24:32 +0000
Subject: Re: [PATCH] PCI: PCI_PROBE_ONLY clean-up
To:     linux-mips@linux-mips.org
References: <20160623221441.3154.31310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20160624155021.GD5930@linux-mips.org>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <3048f087-cdec-66ff-e2f0-25ae6717b407@gentoo.org>
Date:   Fri, 24 Jun 2016 19:24:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160624155021.GD5930@linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54166
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

On 06/24/2016 11:50, Ralf Baechle wrote:
> On Thu, Jun 23, 2016 at 05:16:47PM -0500, Bjorn Helgaas wrote:
> 
>> Lorenzo is changing the PCI_PROBE_ONLY case so the BARs and windows remain
>> immutable, but we insert the resources into the iomem_resource tree.
>>
>> The ideal thing would be to remove the use of PCI_PROBE_ONLY completely,
>> and allow Linux to program BARs as necessary.  If the firmware *has*
>> programmed the BARs, we don't change them unless we find something broken,
>> so in most cases PCI_PROBE_ONLY is unnecessary.
>>
>> There are several MIPS platforms (bcm1480, ip27, sb1250, virtio_guest, xlp,
>> xlr) that set PCI_PROBE_ONLY for reasons I don't know.  These were added
>> by:
>>
>>   bcm1480
>>     Andrew Isaacson <adi@broadcom.com>
>>     dc41f94f7709 ("Support for the BCM1480 on-chip PCI-X bridge.")
>>
>>   ip27
>>     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>>     96173a6c4ebc ("[MIPS] IP27: misc fixes")
> 
> Afair  I did originally implement the IP27 use of PCI_PROBE_ONLY.  The
> problem is that it was not possible for the kernel to assign resources
> properly on an IP27.  Also that would invalidate firmware configuration
> information, so we had to live with whatever the firmware (mis)configured
> for us.  Afair - it's a darn long time ...  I think the reasoning for
> the BCM1480 was similar but Andy will hopefully recall the details.

I'm not onto 4.7 yet, but I've got some major rework of the BRIDGE code that's
solved the resource assignment bit in IP27 (including being able to kzalloc the
bridge_controller struct now).  Can try this change out with the changes I've
done to see if everything still works, or if IP27 (and maybe IP30) still
require this flag, or if it can be implemented in another way.


-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
