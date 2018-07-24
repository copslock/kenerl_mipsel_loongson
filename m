Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jul 2018 15:11:43 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:52652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994002AbeGXNLgoyzMB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Jul 2018 15:11:36 +0200
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AD5620875;
        Tue, 24 Jul 2018 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532437890;
        bh=ZbqDJKeq58If8A+a5JAw0oIyX+jmylv6EzSkZrCKJ4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E7FfNi7rwW4Ank8UpoHk7rAfkyR2iNDuH3d8RhidG4eqauToeRaaQYrp95Q8goUw5
         dKmUCjdlD0LopPSP8ZBPZU5JU0bjebVrdchRXko4bSsmed0swsff+djlVx8/lpGRNB
         sAPaenFZShDTU/eEkyg2KlErCv2syFCic5nvknvQ=
Date:   Tue, 24 Jul 2018 18:41:21 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Paul Burton <paul.burton@mips.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 00/18] JZ4780 DMA patchset v3
Message-ID: <20180724131121.GE3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180723175846.udmjtkx7fsaf52wa@pburton-laptop>
 <1532430574.2610.0@smtp.crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532430574.2610.0@smtp.crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vkoul@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vkoul@kernel.org
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

On 24-07-18, 13:09, Paul Cercueil wrote:
> Hi,
> 
> Le lun. 23 juil. 2018 à 19:58, Paul Burton <paul.burton@mips.com> a écrit :
> > Hi Paul & Vinod,
> > 
> > On Sat, Jul 21, 2018 at 01:06:25PM +0200, Paul Cercueil wrote:
> > >  This is the version 3 of my jz4780-dma driver update patchset.
> > > 
> > >  Apologies to the DMA people, the v2 of this patchset did not make
> > > it to
> > >  their mailing-list; see the bottom of this email for a description
> > > of
> > >  what happened in v2.
> > > 
> > >  Changelog from v2 to v3:
> > > 
> > >  - Modified the devicetree bindings to comply with the specification
> > > 
> > >  - New patch [06/18] allows the JZ4780 DMA driver to be compiled
> > > within a
> > >    generic MIPS kernel.
> > 
> > Would you prefer to take the MIPS .dts changes in patches 16-18 through
> > the DMA tree with the rest of the series?
> 
> I think it would make sense yes.

okay will do so when the series is merged

-- 
~Vinod
