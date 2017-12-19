Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Dec 2017 21:09:34 +0100 (CET)
Received: from mail.free-electrons.com ([62.4.15.54]:59284 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994649AbdLSUJ1bso1u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Dec 2017 21:09:27 +0100
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 7766520741; Tue, 19 Dec 2017 21:09:15 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 506A8206FC;
        Tue, 19 Dec 2017 21:09:15 +0100 (CET)
Date:   Tue, 19 Dec 2017 21:09:15 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/13] MIPS: mscc: Add initial support for Microsemi
 MIPS SoCs
Message-ID: <20171219200915.GP15162@piout.net>
References: <20171208154618.20105-1-alexandre.belloni@free-electrons.com>
 <20171208154618.20105-10-alexandre.belloni@free-electrons.com>
 <CANc+2y4BroVz4eZOeb_ygYH42kg4WPP0y_t4OUuVd50OBSDgXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANc+2y4BroVz4eZOeb_ygYH42kg4WPP0y_t4OUuVd50OBSDgXQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Hi,

On 19/12/2017 at 20:27:02 +0530, PrasannaKumar Muralidharan wrote:
> Given the fact that setup code is very small and most of it is generic
> code I strongly believe that it is plausible to make use of generic
> code completely. Please have a look at [1] and [2].
> 
> 1. https://patchwork.kernel.org/patch/9655699/
> 2. https://patchwork.kernel.org/patch/9655697/
> 
> PS: My rb tag stays if this could not be done immediately.
> 

I think we had that discussion on the previous version:
https://www.linux-mips.org/archives/linux-mips/2017-11/msg00532.html

I can't test on the sead3 so I'd prefer not changing its code right now.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
