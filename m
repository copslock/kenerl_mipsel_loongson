Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Oct 2013 17:54:25 +0200 (CEST)
Received: from mail-qc0-f170.google.com ([209.85.216.170]:59415 "EHLO
        mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818997Ab3JIPyXB1D80 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Oct 2013 17:54:23 +0200
Received: by mail-qc0-f170.google.com with SMTP id m20so720300qcx.15
        for <multiple recipients>; Wed, 09 Oct 2013 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=T22H+7lmUP5oJvF7/XTtR6fuPRz5lofGA97Y08EWwPA=;
        b=fFWAF9qkB3KZASHjjB2pKZnyjqGHRH3QDLpHct2aHUM4Fr1x+9oL5l0cZ/j9H0kA7h
         qWJ1xBllBB/+9ZDOID4ix9OZAt7btrpfVZaUwOt5RBRGDqxpLNQaoBRUchK2EQ35WsAR
         I3Bu520wnk9fDxK426iLlX12UJdH6l/tcVNIRWyvnUn2PWM9xGl5vDgV95B2q50pPo2p
         piQ+lXnLNsVvrTpbaY8UxRkGQF6EMdVETLQmSz4mtxqnbZ2VJBkno/kb8EGseY1W49pD
         9UreV+h6TciTMzDqza8D4H5VmBdLKOYaE+rokyEmEKEBHNji3pQVHrZCddfzgSXE3MCm
         goTw==
X-Received: by 10.49.51.167 with SMTP id l7mr10455770qeo.52.1381334056599;
        Wed, 09 Oct 2013 08:54:16 -0700 (PDT)
Received: from htj.dyndns.org (207-38-225-25.c3-0.43d-ubr1.qens-43d.ny.cable.rcn.com. [207.38.225.25])
        by mx.google.com with ESMTPSA id r5sm87551010qaj.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 08:54:15 -0700 (PDT)
Date:   Wed, 9 Oct 2013 11:54:13 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Alexander Gordeev <agordeev@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Ellerman <michael@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy King <acking@vmware.com>, Jon Mason <jon.mason@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux390@de.ibm.com, linux-s390@vger.kernel.org, x86@kernel.org,
        linux-ide@vger.kernel.org, iss_storagedev@hp.com,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, e1000-devel@lists.sourceforge.net,
        linux-driver@qlogic.com,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        "VMware, Inc." <pv-drivers@vmware.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 07/77] PCI/MSI: Re-design MSI/MSI-X interrupts
 enablement pattern
Message-ID: <20131009155413.GD22495@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <d8c36203ada6efbfa9f7ce92c2f713ee3b6d6b8d.1380703262.git.agordeev@redhat.com>
 <20131007181749.GB27396@htj.dyndns.org>
 <20131008074826.GD10669@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131008074826.GD10669@dhcp-26-207.brq.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <htejun@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tj@kernel.org
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

Hello, Alexander.

On Tue, Oct 08, 2013 at 09:48:26AM +0200, Alexander Gordeev wrote:
> > If there are many which duplicate the above pattern, it'd probably be
> > worthwhile to provide a helper?  It's usually a good idea to reduce
> > the amount of boilerplate code in drivers.
> 
> I wanted to limit discussion in v1 to as little changes as possible.
> I 'planned' those helper(s) for a separate effort if/when the most
> important change is accepted and soaked a bit.

The thing is doing it this way generates more churns and noises.  Once
the simpler ones live behind a wrapper which can be built on the
existing interface, we can have both reduced cost and more latitude on
the complex cases.

> > If we do things this way, it breaks all drivers using this interface
> > until they're converted, right?
> 
> Right. And the rest of the series does it.

Which breaks bisection which we shouldn't do.

> > Also, it probably isn't the best idea
> > to flip the behavior like this as this can go completely unnoticed (no
> > compiler warning or anything, the same function just behaves
> > differently).  Maybe it'd be a better idea to introduce a simpler
> > interface that most can be converted to?
> 
> Well, an *other* interface is a good idea. What do you mean with the
> simpler here?

I'm still talking about a simpler wrapper for common cases, which is
the important part anyway.

Thanks.

-- 
tejun
