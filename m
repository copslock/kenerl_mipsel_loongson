Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Oct 2013 17:30:04 +0200 (CEST)
Received: from mail-ee0-f54.google.com ([74.125.83.54]:46759 "EHLO
        mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6868762Ab3JJP3x5GYSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Oct 2013 17:29:53 +0200
Received: by mail-ee0-f54.google.com with SMTP id e53so1242577eek.41
        for <linux-mips@linux-mips.org>; Thu, 10 Oct 2013 08:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=u/hG9CKC6hvQ818Dqs+h/y6uI3p4GaP0ECjn38Fqldg=;
        b=e9TbiZtOw+qbHk/E1iPtzFDimZtzMZFNsAq21JpKrzyrlw8biU0pP97av40lU1pkPb
         VPUyDoekgWPZdKbobNNrDXEnA0HIhkDELqTC46weE6T06bi7+Ksk4CjhCkWp7CWVRXZj
         TPrDmqMSyf8lYLNFUaif2VCR1/6Xrq2D4lbbWMLUqzGzpBIOdHvwtDwici3SbWrUyTti
         AQeTecXsA/dsxL6o51m9CdNBRPPL5wnGa10n2MyDCgz4lj16Kzo83lWNA7e8I0RXWKSP
         3pnQ8Rcel3VE8WMOOl2VdqrWfkqWa1zi8UoPM9KRcDNUIB+vK47EdHWmsa251o0GNDSm
         jjtQ==
X-Gm-Message-State: ALoCoQk9V/reGNwFpj/R5k++jV+shdFRHLvV1Pg7wQDihoptFvwTeEZudpBjR4zflYmGgQuay4ax
X-Received: by 10.14.8.72 with SMTP id 48mr21379368eeq.25.1381418988475;
        Thu, 10 Oct 2013 08:29:48 -0700 (PDT)
Received: from localhost (out.voltaire.com. [193.47.165.251])
        by mx.google.com with ESMTPSA id a43sm102874723eep.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 08:29:47 -0700 (PDT)
Date:   Thu, 10 Oct 2013 18:29:45 +0300
From:   Eli Cohen <eli@dev.mellanox.co.il>
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
Subject: Re: [PATCH RFC 50/77] mlx5: Update MSI/MSI-X interrupts enablement
 code
Message-ID: <20131010152945.GC7299@mtldesk30>
References: <cover.1380703262.git.agordeev@redhat.com>
 <9650a7dfbcfd5f1da21f7b093665abf4b1041071.1380703263.git.agordeev@redhat.com>
 <20131003071433.GA7299@mtldesk30>
 <20131003194837.GA27636@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131003194837.GA27636@dhcp-26-207.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <eli@dev.mellanox.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: eli@dev.mellanox.co.il
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

On Thu, Oct 03, 2013 at 09:48:39PM +0200, Alexander Gordeev wrote:
> 
> pci_enable_msix() may fail, but it can not return a positive number.
>

That is true according to the current logic but the comment on top of
pci_enable_msix() still says:
"A return of < 0 indicates a failure.  Or a return of > 0 indicates
that driver request is exceeding the number of irqs or MSI-X vectors
available"

So you're counting on an implementation that may change in the future.
I think leaving the code as it is now is safer.
