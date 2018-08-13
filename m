Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2018 19:53:29 +0200 (CEST)
Received: from mail-io0-f194.google.com ([209.85.223.194]:42163 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990471AbeHMRx0Ebcrt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2018 19:53:26 +0200
Received: by mail-io0-f194.google.com with SMTP id n18-v6so15593460ioa.9
        for <linux-mips@linux-mips.org>; Mon, 13 Aug 2018 10:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x5e9tAl16mCydrCkCvidtIYtGiM1nInW53c1/S7MUX0=;
        b=aaDF3co8LDxLt5kOY3vDaCl/N7rCnbEEY13JFamjuBMUvaKTrGe8iiu/1Tn0OkSvtw
         aQbDaVGncT8uihyqNwpyeKD0R+NE2i39+p2R+/slZvfq27SIIBX1tNul1qa8AFa/KwfR
         QpCqdQNL6jW4A86vNmBENGFhEs43P6eXXDpUnjjquStyjLzec67/q4lt76Icu3fvsEbu
         HYioHqIExrrNoOsnJGtCthIbfk8YwqAzc5Q2ykh3SBOFDV4riHTDI636jCme1oafnmIp
         Lw7kMDisy0dPBeKH+kd4C1R0CkHPqu5pZRIigO6/l8DPy+h0+JMk79yp0wcZ3/A1cQaj
         RvUw==
X-Gm-Message-State: AOUpUlGbg5Dfl0tn40GwhmQtIXZq+yMKgb7+uN1TSgwvLW2H18o0pDHD
        iruQkVO6LerlZq3/EP62QA==
X-Google-Smtp-Source: AA+uWPypnOKL+VhPETs2lijeBNcTjNw1+9GTsiXscK4C8thsMzX/2rqHxx4+zxmaygNo/PLGhqxAbA==
X-Received: by 2002:a6b:5a08:: with SMTP id o8-v6mr15733584iob.5.1534182799984;
        Mon, 13 Aug 2018 10:53:19 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u68-v6sm6633070ita.36.2018.08.13.10.53.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:53:19 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:53:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Songjun Wu <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 18/18] dt-bindings: serial: lantiq: Add optional
 properties for CCF
Message-ID: <20180813175317.GA31286@rob-hp-laptop>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-19-songjun.wu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180803030237.3366-19-songjun.wu@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65574
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

On Fri, Aug 03, 2018 at 11:02:37AM +0800, Songjun Wu wrote:
> Clocks and clock-names are updated in device tree binding.
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/serial/lantiq_asc.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
