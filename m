Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Oct 2013 18:11:15 +0200 (CEST)
Received: from mail-ee0-f47.google.com ([74.125.83.47]:55053 "EHLO
        mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868649Ab3JCQLJgDOI2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Oct 2013 18:11:09 +0200
Received: by mail-ee0-f47.google.com with SMTP id d49so1202581eek.20
        for <linux-mips@linux-mips.org>; Thu, 03 Oct 2013 09:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=W35J27mlmG+Sr0SCYBUcB6mTZwRinXkhXFvvkeT1UxY=;
        b=fYzo7zZeS84h2GAB1KtD6ZkZE2MaeOhJG6GCAo7hh5v9Mkq7d93R/87kUx+tY8sn4W
         UI0X0c9jXs/e5zgHtMVwYro/vJP6YUfkhJDtdOPIsfuw5vNLQNLh3EiWxjwQk+zcYOq7
         WZz/kAcUOrUQVBZKEw5tCac+WxvC4BKWy2uUP2x91sK4iZW8Ln3LLd04HIeBqB5hcMSz
         VkvSHchkUDdvKATt0hlHFPLQjqxRDbAVSRt0VRWGekyppdpgIrFA6d2VrescNrwUIfTT
         WgzSCYJ8o94kkv600XZJ5ec2W5mrXXYGYRIYgpWXtQAPOo/6UYceqoZoHrzOV/2dxHTx
         mhvQ==
X-Gm-Message-State: ALoCoQnu8mFue0Fg58mMSSNqovQE+ftdn6NrqisJt0ZlEj9+9OUKB8DJ+RCQcdRhBCWnJDXHKXzS
X-Received: by 10.14.88.65 with SMTP id z41mr13648957eee.38.1380816663876;
        Thu, 03 Oct 2013 09:11:03 -0700 (PDT)
Received: from jpm-OptiPlex-GX620 (out.voltaire.com. [193.47.165.251])
        by mx.google.com with ESMTPSA id b45sm17377630eef.4.1969.12.31.16.00.00
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 03 Oct 2013 09:11:02 -0700 (PDT)
Date:   Thu, 3 Oct 2013 19:11:00 +0300
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
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 51/77] mthca: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131003191100.3e3e3bfd@jpm-OptiPlex-GX620>
In-Reply-To: <9d424912ef78993dc75e2af5006cd12913e9e7e7.1380703263.git.agordeev@redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
        <9d424912ef78993dc75e2af5006cd12913e9e7e7.1380703263.git.agordeev@redhat.com>
Organization: Mellanox
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <jackm@dev.mellanox.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38185
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

On Wed,  2 Oct 2013 12:49:07 +0200
Alexander Gordeev <agordeev@redhat.com> wrote:

> Subject: [PATCH RFC 51/77] mthca: Update MSI/MSI-X interrupts
> enablement code Date: Wed,  2 Oct 2013 12:49:07 +0200
> Sender: linux-rdma-owner@vger.kernel.org
> X-Mailer: git-send-email 1.7.7.6
> 
> As result of recent re-design of the MSI/MSI-X interrupts enabling
> pattern this driver has to be updated to use the new technique to
> obtain a optimal number of MSI/MSI-X interrupts required.
> 
> Signed-off-by: Alexander Gordeev <agordeev@redhat.com>
> ---

ACK.

-Jack
