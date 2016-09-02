Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Sep 2016 14:38:42 +0200 (CEST)
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35289 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbcIBMien0UUY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Sep 2016 14:38:34 +0200
Received: by mail-oi0-f66.google.com with SMTP id 2so4246078oif.2;
        Fri, 02 Sep 2016 05:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/dXprD/TJPk+A0GTFGb3lBKZDhIyDVHAsNZpumqANRI=;
        b=fWz2KcpGDjrv1bU6F5TCvL7XAyELonE7Ta8Oq1B64fF5ZRyGkUst4ZeJDzf5N30ew6
         DTjpd/gvAS17qpXYO80kxThH0etdvunHy3Nnv7d/rbyLx32BJVh9W1pZpZ7gLjOI5xRy
         j2tz0QF+HKXASzMmxMafDUaOWH9ZXhA18PprnbEqJLqPC6XjYLaepVu0hZXXqJwjeNPv
         DEPNbeSav3WsTL7xsuu/gRqso5Ni7ekRI5TKosE5kVJMWmSHGXzUQbOUhONpXh5tlG1+
         zNVV6uEHziVnncmfyqJqXFNibLAuzhWy3cPj1unQtxY+LYNHi1+SLN5O8GL3CRHpS8Hz
         NaXA==
X-Gm-Message-State: AE9vXwP+4DwTkG5d2gBZtmNTb5hns/YKs8Ba2UApzA5QHasJEXetzSagCkHxnaQgQgaL7A==
X-Received: by 10.202.216.8 with SMTP id p8mr19978294oig.140.1472819909106;
        Fri, 02 Sep 2016 05:38:29 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id t43sm2404433ott.14.2016.09.02.05.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Sep 2016 05:38:28 -0700 (PDT)
Date:   Fri, 2 Sep 2016 07:38:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/26] dt-bindings: Document mti,mips-cdmm binding
Message-ID: <20160902123828.GA1327@rob-hp-laptop>
References: <20160826153725.11629-1-paul.burton@imgtec.com>
 <20160826153725.11629-14-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160826153725.11629-14-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54989
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

On Fri, Aug 26, 2016 at 04:37:12PM +0100, Paul Burton wrote:
> Document a binding for the MIPS Common Device Memory Map (CDMM) which
> simply allows the device tree to specify where the CDMM registers should
> be mapped.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> ---
> 
>  Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt | 8 ++++++++

Try to find another location for these. Perhaps bindings/bus/? Even 
bindings/mips/ would be better. 

>  1 file changed, 8 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt b/Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt
> new file mode 100644
> index 0000000..5b0fc40
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/mti,mips-cdmm.txt
> @@ -0,0 +1,8 @@
> +Binding for MIPS Common Device Memory Map (CDMM) bus.
> +
> +This binding allows a system to specify where the CDMM registers should be
> +mapped using device tree.
> +
> +Required properties:
> +compatible : Should be "mti,mips-cdmm".
> +regs: Should describe the address & size of the CDMM register region.
> -- 
> 2.9.3
> 
