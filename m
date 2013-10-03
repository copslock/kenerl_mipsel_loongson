Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 10:39:43 +0200 (CEST)
Received: from mail-ee0-f51.google.com ([74.125.83.51]:33354 "EHLO
        mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6815748Ab3JCIjkSjyxx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 10:39:40 +0200
Received: by mail-ee0-f51.google.com with SMTP id c1so903532eek.24
        for <linux-mips@linux-mips.org>; Thu, 03 Oct 2013 01:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=WWHccz2axGnBTwWfHs5MpXfTewPausLmkbemoYIVqHM=;
        b=dgcdESWutDz4uKyCe75TiLfr/66bHcgqYoQ+bBM9Yp90NyCdUA62oG6nnIJr4qfTfj
         ASrE5MG4A1vat8EqrJV8gYET4/awbBBWYDH9jzOnQ/eA6ddzCcZ3Ff7NcGWOx314Fa6n
         jEMAN/vkIXmgzsBgML1J187t3CBelGM8ddIlXPEWOoZ5RWv/yMAd0zFf8Vxia8ksTibN
         koO14Fl3AvZCkZWDoa6u3u01NbT1Nb7HLnnUU5EKA4a3k4JGR5zFO0JmsBLOsyH4MqLx
         4H6J6qKpcj/4rWeV36e+v5z83kcDPQ4rRwvLROQ5fXz6S2g9liziHem9VI5PNrLGU+JF
         Plcw==
X-Gm-Message-State: ALoCoQmii0d0L8XXVZvXniz99cdk5+pk6eehfqEZeTghp9kEKyS/0/mUb+dXzv1CTb9ggqCB+Vx+
X-Received: by 10.14.29.67 with SMTP id h43mr10984911eea.7.1380789574832;
        Thu, 03 Oct 2013 01:39:34 -0700 (PDT)
Received: from jpm-OptiPlex-GX620 (out.voltaire.com. [193.47.165.251])
        by mx.google.com with ESMTPSA id d8sm13040053eeh.8.1969.12.31.16.00.00
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 01:39:33 -0700 (PDT)
Date:   Thu, 3 Oct 2013 11:39:32 +0300
From:   Jack Morgenstein <jackm@dev.mellanox.co.il>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux390@de.ibm.com,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org,
        ogerlitz@mellanox.com, eli@mellanox.com
Subject: Re: [PATCH RFC 46/77] mlx4: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131003113932.065b9b63@jpm-OptiPlex-GX620>
In-Reply-To: <b0a9f6f455aa03b7769e6d9cc2e7fdbc06732b2f.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
        <b0a9f6f455aa03b7769e6d9cc2e7fdbc06732b2f.1380703263.git.agordeev@redhat.com>
Organization: Mellanox
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <jackm@dev.mellanox.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jackm@dev.mellanox.co.il
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

On Wed,  2 Oct 2013 12:49:02 +0200
Alexander Gordeev <agordeev@redhat.com> wrote:

> As result of recent re-design of the MSI/MSI-X interrupts enabling
> pattern this driver has to be updated to use the new technique to
> obtain a optimal number of MSI/MSI-X interrupts required.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>

New review -- ACK (i.e., patch is OK), subject to acceptance of patches
05 and 07 of this patch set.

I sent my previous review (NACK) when I was not yet aware that
changes proposed were due to the two earlier patches (mentioned above)
in the current patch set.

The change log here should actually read something like the following:

As a result of changes to the MSI/MSI_X enabling procedures, this driver
must be modified in order to preserve its current msi/msi_x enablement
logic.

-Jack
