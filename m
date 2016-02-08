Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Feb 2016 18:30:52 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012163AbcBHRatPzO5Y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Feb 2016 18:30:49 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id D65C7201EC;
        Mon,  8 Feb 2016 17:30:47 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24492014A;
        Mon,  8 Feb 2016 17:30:45 +0000 (UTC)
Date:   Mon, 8 Feb 2016 11:30:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Joe Perches <joe@perches.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        devicetree@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 14/15] dt-bindings: mips: img,boston: Document
 img,boston binding
Message-ID: <20160208173043.GA348@rob-hp-laptop>
References: <1454499045-5020-1-git-send-email-paul.burton@imgtec.com>
 <1454499045-5020-15-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454499045-5020-15-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51858
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

On Wed, Feb 03, 2016 at 11:30:44AM +0000, Paul Burton wrote:
> Add documentation for the simple img,boston devicetree binding & the
> boot protocol used to pass the devicetree to the kernel.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/mips/img/boston.txt | 15 +++++++++++++++
>  MAINTAINERS                                           |  5 +++++
>  2 files changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/img/boston.txt

Acked-by: Rob Herring <robh@kernel.org>
