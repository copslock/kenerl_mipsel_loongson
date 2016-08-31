Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Aug 2016 18:19:08 +0200 (CEST)
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33226 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992058AbcHaQTAxxxpE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Aug 2016 18:19:00 +0200
Received: by mail-oi0-f68.google.com with SMTP id s207so5047170oie.0;
        Wed, 31 Aug 2016 09:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U430GLrinhmYPiZp5JXJDV/P2x4PGn4PCM5vWRlQTv4=;
        b=Egr5Bori0Lpb8rqx3u0kGZON2CaC4XTT1p4F2bH27LOkmUZo9/ma33ocEBBGFVM5ma
         cbKMud3pXDSzSMKVSCny5atrwzVFCyB1w0Vud3EsPRvtysqIl3WrWcK1H3AEvxDbpp/N
         +rvKkUQCz6YisYYNDQ72favMZGN9+0O8EhDFmIY7eTtAYapgQi5dP3sZO7e/uajlj0DT
         G7nvMnUWTQueaROFpCxjnWzvb+IoEwd3pcT/Efy232dA783xR0NvR6ls5eM82HKNdIMJ
         DDFNs+aGQ30H9yXS8b0iF/VGg1QghY0/WeM7tOUyplodxokR98POUPysL9hKW1oKORoS
         JaOw==
X-Gm-Message-State: AE9vXwOdt67q0ijL4ZIbzStlgGDleGDdTv+zd/TCWwHvdwV0oQTUKXwWkU+yugmTqrLeYQ==
X-Received: by 10.157.35.4 with SMTP id j4mr11085537otb.38.1472660335115;
        Wed, 31 Aug 2016 09:18:55 -0700 (PDT)
Received: from localhost (c-73-166-181-108.hsd1.tx.comcast.net. [73.166.181.108])
        by smtp.gmail.com with ESMTPSA id v41sm236958otd.3.2016.08.31.09.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 09:18:54 -0700 (PDT)
Date:   Wed, 31 Aug 2016 11:18:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 16/19] dt-bindings: img-ascii-lcd: Document a binding
 for simple ASCII LCDs
Message-ID: <20160831161853.GA14407@rob-hp-laptop>
References: <20160826141751.13121-1-paul.burton@imgtec.com>
 <20160826141751.13121-17-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160826141751.13121-17-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54899
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

On Fri, Aug 26, 2016 at 03:17:48PM +0100, Paul Burton wrote:
> Add documentation for a devicetree binding for the simple ASCII LCD
> displays found on development boards such as the MIPS Boston, MIPS Malta
> & MIPS SEAD3 from Imagination Technologies.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> 
> ---
> 
> Changes in v2:
> - Fix filename & path in MAINTAINERS
> 
>  .../devicetree/bindings/auxdisplay/img-ascii-lcd.txt    | 17 +++++++++++++++++
>  MAINTAINERS                                             |  5 +++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/auxdisplay/img-ascii-lcd.txt

Acked-by: Rob Herring <robh@kernel.org>
