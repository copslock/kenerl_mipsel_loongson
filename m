Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 19:39:04 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:51181 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825884Ab3DKRjDZYZ2a (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Apr 2013 19:39:03 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KiWkIPwH14yI; Thu, 11 Apr 2013 19:38:16 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 4040A280420;
        Thu, 11 Apr 2013 19:38:11 +0200 (CEST)
Message-ID: <5166F546.5010906@openwrt.org>
Date:   Thu, 11 Apr 2013 19:39:18 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: implement pcibios_get_phb_of_node
References: <1365098483-26821-1-git-send-email-juhosg@openwrt.org> <1365098483-26821-2-git-send-email-juhosg@openwrt.org> <CAErSpo4ih-Kgp4LxX1MDodac-eoPo=Mu1d6ex8oNnaEEc_GQnw@mail.gmail.com> <5166F39C.1050907@openwrt.org> <CAErSpo454_bkXa1Uy70_dv9SSnofxYNPyxR=W7X-QmaxxGNO5g@mail.gmail.com>
In-Reply-To: <CAErSpo454_bkXa1Uy70_dv9SSnofxYNPyxR=W7X-QmaxxGNO5g@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36082
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.04.11. 19:35 keltezéssel, Bjorn Helgaas írta:

> Thanks for checking these out!  I put them in my "next" branch and
> pushed it, so they should appear in v3.10.

Great. Thank you!

-Gabor
