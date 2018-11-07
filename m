Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Nov 2018 16:54:10 +0100 (CET)
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37332 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991062AbeKGPwiFlMCo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Nov 2018 16:52:38 +0100
Received: by mail-ot1-f67.google.com with SMTP id 40so14944299oth.4
        for <linux-mips@linux-mips.org>; Wed, 07 Nov 2018 07:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=umJZHl8PkfcYCP16RtQI+OUv5ThrkI64xEcobDoYTa0=;
        b=SLYk5oRKT1JBpTNQtMXkQxrms7HbbpG1Urf2fIQUTqMjKChQWQnnGzJMnpOFm+uBqK
         fwwvLLHK3IaTl12ZSZ2utWfJA7EZV9flgDgeidZUcq+w+SSwtsjY7Asc8EhLEW9Dm1DH
         kSFuX+8hrG9J2hXCYxKJPcKAsHBA+s8Xb7kRiAHqheBNYQsd5NPEeQ5GmTGCNim7u0Ym
         zWxKsYJaFjPKowSS8qYwxq7desKEC8xLTsnKd7Iu4mVswoAO7aU9utuyR/saO/H8DrrU
         0vLml9bhCfgcpCb7QbUkob/r+Tepf/ZGM1KRqa8Ku4eNtDWHWFWIHdMGdmcWwk0UB2ot
         TijQ==
X-Gm-Message-State: AGRZ1gLMGIoDSBTcV12tnv9pwBZ34BfipXU7MBGzZ/glPneq+O4EhDe7
        lz65Rb1+NETgQp9B1gkR5Q==
X-Google-Smtp-Source: AJdET5ePTBhfX51uLqN+blXIvSAZdi11LE4jWkJobuh1VcrCXjL9qw8KqGQTp60mUj8O2OIyNnsxOQ==
X-Received: by 2002:a9d:4a21:: with SMTP id h30mr446223otf.280.1541605956890;
        Wed, 07 Nov 2018 07:52:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o62-v6sm340125oia.5.2018.11.07.07.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 07:52:36 -0800 (PST)
Date:   Wed, 7 Nov 2018 09:52:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        aaro.koskinen@iki.fi, jean-philippe.brucker@arm.com,
        john.stultz@linaro.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] of/device: Really only set bus DMA mask when appropriate
Message-ID: <20181107155235.GA18618@bogus>
References: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
 <20181107080335.GA24511@lst.de>
 <22cbe798-612f-8c88-90e7-388202f603cf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22cbe798-612f-8c88-90e7-388202f603cf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67132
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Nov 07, 2018 at 12:56:49PM +0000, Robin Murphy wrote:
> On 2018-11-07 8:03 am, Christoph Hellwig wrote:
> > On Tue, Nov 06, 2018 at 11:54:15AM +0000, Robin Murphy wrote:
> > > of_dma_configure() was *supposed* to be following the same logic as
> > > acpi_dma_configure() and only setting bus_dma_mask if some range was
> > > specified by the firmware. However, it seems that subtlety got lost in
> > > the process of fitting it into the differently-shaped control flow, and
> > > as a result the force_dma==true case ends up always setting the bus mask
> > > to the 32-bit default, which is not what anyone wants.
> > > 
> > > Make sure we only touch it if the DT actually said so.
> > 
> > This looks good, but I think it could really use a comment as the use
> > of ret all the way down the function isn't exactly obvious.
> 
> Fair point.
> 
> > Let me now if you want this picked up through the OF or DMA trees.
> 
> I don't mind either way; I figure I'll wait a bit longer to see if Rob has
> any preference, then resend with the comment and the tags picked up so it
> can hopefully make rc2.

I have other fixes to send, so I can take it.

Rob
