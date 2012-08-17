Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Aug 2012 19:36:36 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36373 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903458Ab2HQRgb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Aug 2012 19:36:31 +0200
Received: by pbbrq8 with SMTP id rq8so3854583pbb.36
        for <multiple recipients>; Fri, 17 Aug 2012 10:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=pHu1u9K2k9daHpg0+z7kryrl0ilVKJndHCBiqWfnNq0=;
        b=KDL8r1bUwGQxHWxkxXYHlnkWZU42r/XEuL2ZYv+KZ4/vpg1E1vGEuCTcUaAk0i51m+
         o9YLOFBqckCfSFQMh8so0eQ/WXzPnBQ16JWZX/KIhNhE7aLNhIvpUF+RVdOOZBjFq7N9
         UslygXEL9j0Uj8HRmpTZ7cLBQlv2PRQGufoMsHanluooRjKJmOv36hnqfcKvvQ5QDkae
         m2+mOfesRle2aN6+kI7bsQtbm7pFH89gz8b+Clgw5iEOZKbPZTk/wqcXe66cSRzS0AeC
         SeypIxAzHCoMGa2MvFJ9c+MFKldn9Dw2zI2oadsAo9ivyuG6dWOYjlWRbfkxI+sIG8AW
         5pTQ==
Received: by 10.68.228.100 with SMTP id sh4mr13285202pbc.45.1345224984524;
        Fri, 17 Aug 2012 10:36:24 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id pa6sm5307770pbc.47.2012.08.17.10.36.22
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 10:36:23 -0700 (PDT)
Message-ID: <502E8115.90507@gmail.com>
Date:   Fri, 17 Aug 2012 10:36:21 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-pci@vger.kernel.org
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: PCI Section mismatch error in linux-next.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

For MIPS, Thierry Reding's patch in linux-next (PCI: Keep 
pci_fixup_irqs() around after init) causes:

WARNING: vmlinux.o(.text+0x22c784): Section mismatch in reference from 
the function pci_fixup_irqs() to the function 
.init.text:pcibios_update_irq()

The MIPS implementation of pcibios_update_irq() is __init, so there is 
conflict with the removal of __init from pci_fixup_irqs() and 
pdev_fixup_irq().

Can you guys either remove the patch from linux-next, or improve it to 
also fix up any architecture implementations of pdev_update_irq()?


Thanks,
David Daney
