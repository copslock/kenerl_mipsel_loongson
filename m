Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Apr 2014 14:09:48 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:24415 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834681AbaDNMHhxQhkv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 Apr 2014 14:07:37 +0200
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3EC7YOn009353
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Apr 2014 08:07:34 -0400
Received: from dhcp-26-207.brq.redhat.com (dhcp-26-119.brq.redhat.com [10.34.26.119])
        by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s3EC7U03014567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Mon, 14 Apr 2014 08:07:32 -0400
Date:   Mon, 14 Apr 2014 14:09:22 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/MSI: Phase out pci_enable_msi_block()
Message-ID: <20140414120921.GA32132@dhcp-26-207.brq.redhat.com>
References: <cover.1397458024.git.agordeev@redhat.com>
 <0b08613dc17cd608c1babc1f42b8919f60e1093f.1397458024.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b08613dc17cd608c1babc1f42b8919f60e1093f.1397458024.git.agordeev@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39796
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agordeev@redhat.com
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

On Mon, Apr 14, 2014 at 09:14:07AM +0200, Alexander Gordeev wrote:
> @@ -1244,7 +1241,7 @@ static inline void pcie_set_ecrc_checking(struct pci_dev *dev) { }
>  static inline void pcie_ecrc_get_policy(char *str) { }
>  #endif
>  
> -#define pci_enable_msi(pdev)	pci_enable_msi_block(pdev, 1)
> +#define pci_enable_msi(pdev)	pci_enable_msi_range(pdev, 1, 1)

Self-Nack, it should have been pci_enable_msi_exact(pdev, 1) ^^^

>  #ifdef CONFIG_HT_IRQ
>  /* The functions a driver should call */

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
