Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2014 16:08:35 +0200 (CEST)
Received: from helium.waldemar-brodkorb.de ([89.238.66.15]:53014 "EHLO
        helium.waldemar-brodkorb.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817327AbaENOIdD0Mm- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 May 2014 16:08:33 +0200
Received: by helium.waldemar-brodkorb.de (Postfix, from userid 1000)
        id 295D7109A8; Wed, 14 May 2014 16:08:32 +0200 (CEST)
Date:   Wed, 14 May 2014 16:08:31 +0200
From:   Waldemar Brodkorb <wbx@openadk.org>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     linux-mips@linux-mips.org, florian@openwrt.org, nbd@openwrt.org,
        phil@nwl.cc
Subject: Re: pci problem with rb532
Message-ID: <20140514140831.GP618@waldemar-brodkorb.de>
Reply-To: Waldemar Brodkorb <mail@waldemar-brodkorb.de>
References: <20140510213508.GC618@waldemar-brodkorb.de>
 <53711FDD.6090905@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53711FDD.6090905@openwrt.org>
X-Operating-System: Linux 3.2.0-4-amd64 x86_64
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <wbx@openadk.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40100
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wbx@openadk.org
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

Hi Gabor,
Gabor Juhos wrote,

> Hi Waldemar,
> 
> > I recently had a need for a small DHCP/NFS server and resurvived my
> > old Mikrotik RB532 board. Sadly the PCI registration is broken and
> > the VIA Rhine network ports didn't work.
> 
> Please try the attached patch without reverting the aforementioned change.
> 
> Thanks,
> Gabor

Patch works great! Tested with 3.14.4. Thanks.

I have another issue regarding serial console, sth between 3.14.4
and 3.15-rc5. Still bisecting...

best regards
 Waldemar
