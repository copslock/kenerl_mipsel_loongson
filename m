Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Jul 2017 18:06:28 +0200 (CEST)
Received: from mail-yw0-f195.google.com ([209.85.161.195]:32928 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991119AbdGXQGUDTAHQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Jul 2017 18:06:20 +0200
Received: by mail-yw0-f195.google.com with SMTP id u207so1337786ywc.0;
        Mon, 24 Jul 2017 09:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ev8NgEkazvZQ1vhj3qHEpgGFuxHgg2VinIrYv4M75Ns=;
        b=uWO3AS/16UZBVWJZKx6C+DAi+RcRNNTeoX5ZyAkEkmV6IfNz+uPrkrQ2cem+oxykPy
         /XeWgC8iz2WszPamiSyg24wbuNtdLLWqYtLuAoKWQJ1h1llHgtPDeSineHBXDahuxwEQ
         5VkaXFW26NU2Xb5ql59uBZBYYii+4aml/o/SyBBAOTDH7/kTq0muU9M2wXoQNYfDbXXf
         j8kKpznJeLLXTerQGH1I82zLiancdKksMZz13QfDCxJl46QmElquHSEwxDRKPjqK1XWR
         V0JlsOKFq1/3GTKJNRw4RoYrK+OG6krij8Nt2tFMkFVU1ctKaVqiziPI3s3amkx4Vu7A
         3J3w==
X-Gm-Message-State: AIVw113Xkid3xW9tOwRPi8cThcwfnF+YAF5jiB/8GnA0hZUVrEOCMp4Z
        5H9c48TTI+3ccw==
X-Received: by 10.37.211.9 with SMTP id e9mr6680483ybf.269.1500912373121;
        Mon, 24 Jul 2017 09:06:13 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id n187sm4178975ywf.76.2017.07.24.09.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Jul 2017 09:06:12 -0700 (PDT)
Date:   Mon, 24 Jul 2017 11:06:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Sullivan <nathan.sullivan@ni.com>
Cc:     ralf@linux-mips.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] MIPS: NI 169445 board support
Message-ID: <20170724160611.65chl7z36nlvv4ii@rob-hp-laptop>
References: <1500402549-12090-1-git-send-email-nathan.sullivan@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500402549-12090-1-git-send-email-nathan.sullivan@ni.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59227
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

On Tue, Jul 18, 2017 at 01:29:09PM -0500, Nathan Sullivan wrote:
> Support the National Instruments 169445 board.
> 
> Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
> ---
> Changes since v5:
> 
> - make device tree addresses on the internal bus relative, and compile with
>   W=2 to be sure they are in the right format.
> 
>  Documentation/devicetree/bindings/mips/ni.txt   |   7 ++
>  MAINTAINERS                                     |   8 ++
>  arch/mips/boot/dts/Makefile                     |   1 +
>  arch/mips/boot/dts/ni/169445.dts                | 100 ++++++++++++++++++++++++
>  arch/mips/boot/dts/ni/Makefile                  |   7 ++
>  arch/mips/configs/generic/board-ni169445.config |  27 +++++++
>  arch/mips/generic/Kconfig                       |   6 ++
>  arch/mips/generic/vmlinux.its.S                 |  25 ++++++
>  8 files changed, 181 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/ni.txt
>  create mode 100644 arch/mips/boot/dts/ni/169445.dts
>  create mode 100644 arch/mips/boot/dts/ni/Makefile
>  create mode 100644 arch/mips/configs/generic/board-ni169445.config

Acked-by: Rob Herring <robh@kernel.org>
