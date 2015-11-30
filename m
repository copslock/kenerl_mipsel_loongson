Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 19:57:53 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:38455 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006508AbbK3S5vHMpiE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2015 19:57:51 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 711A820591;
        Mon, 30 Nov 2015 18:57:46 +0000 (UTC)
Received: from rob-hp-laptop (72-48-98-129.dyn.grandenetworks.net [72.48.98.129])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1AE2058A;
        Mon, 30 Nov 2015 18:57:44 +0000 (UTC)
Date:   Mon, 30 Nov 2015 12:57:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Tejun Heo <tj@kernel.org>,
        Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        devicetree@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 02/28] dt-bindings: ascii-lcd: Document a binding for
 simple ASCII LCDs
Message-ID: <20151130185742.GA28127@rob-hp-laptop>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
 <1448900513-20856-3-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448900513-20856-3-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <robh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50214
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

On Mon, Nov 30, 2015 at 04:21:27PM +0000, Paul Burton wrote:
> Add documentation for a devicetree binding for simple memory-mapped
> ASCII LCD displays, such as those found on the Imagination Technologies
> Boston & Malta development boards.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  Documentation/devicetree/bindings/ascii-lcd.txt | 10 ++++++++++

This should go under bindings/display/.

>  MAINTAINERS                                     |  5 +++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/ascii-lcd.txt
> 
> diff --git a/Documentation/devicetree/bindings/ascii-lcd.txt b/Documentation/devicetree/bindings/ascii-lcd.txt
> new file mode 100644
> index 0000000..40ae536
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ascii-lcd.txt
> @@ -0,0 +1,10 @@
> +Binding for simple memory-mapped ASCII LCD displays

Presumably, this is a binding for the controller, not the actual 
display. You need to more fully describe what the h/w looks like here. 
Like what is the interface between the controller and display?

Rob

> +
> +Required properties:
> +- compatible : should be one of:
> +    "img,boston-lcd"
> +    "mti,malta-lcd"
> +- reg : memory region locating the device registers
> +
> +The layout of the registers & properties of the display are determined
> +from the compatible string, making this binding somewhat trivial.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cba790b..1e2b74b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1782,6 +1782,11 @@ S:	Maintained
>  F:	Documentation/hwmon/asc7621
>  F:	drivers/hwmon/asc7621.c
>  
> +ASCII LCD DRIVER
> +M:	Paul Burton <paul.burton@imgtec.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/ascii-lcd.txt
> +
>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>  M:	Corentin Chary <corentin.chary@gmail.com>
>  L:	acpi4asus-user@lists.sourceforge.net
> -- 
> 2.6.2
> 
