Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Apr 2014 23:17:47 +0200 (CEST)
Received: from mx1.redhat.com ([209.132.183.28]:2707 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6831267AbaD3VRo2zDYl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 30 Apr 2014 23:17:44 +0200
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3ULHe5j027739
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Apr 2014 17:17:40 -0400
Received: from dhcp-26-207.brq.redhat.com (vpn-62-241.rdu2.redhat.com [10.10.62.241])
        by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s3ULHZpm004202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Wed, 30 Apr 2014 17:17:38 -0400
Date:   Wed, 30 Apr 2014 23:19:03 +0200
From:   Alexander Gordeev <agordeev@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/MSI: Phase out pci_enable_msi_block()
Message-ID: <20140430211902.GA5550@dhcp-26-207.brq.redhat.com>
References: <cover.1397458024.git.agordeev@redhat.com>
 <0b08613dc17cd608c1babc1f42b8919f60e1093f.1397458024.git.agordeev@redhat.com>
 <20140414120921.GA32132@dhcp-26-207.brq.redhat.com>
 <20140414132834.GA9164@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140414132834.GA9164@dhcp-26-207.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Return-Path: <agordeev@redhat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40000
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

On Mon, Apr 14, 2014 at 03:28:34PM +0200, Alexander Gordeev wrote:
> There are no users of pci_enable_msi_block() function have
> left. Obsolete it in favor of pci_enable_msi_range() and
> pci_enable_msi_exact() functions.

Hi Bjorn,

How about this one?

Thanks!

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
