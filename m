Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2018 20:13:56 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46744 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994693AbeHTSNsPwH3n (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2018 20:13:48 +0200
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so27412665oie.13
        for <linux-mips@linux-mips.org>; Mon, 20 Aug 2018 11:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZmsWosXsvIxR1tmiJQX/h//SH9j70MVeptZTwfibUc=;
        b=c8zu4cfpq1CHgDHj01atOrTGVRvpIIw3Ti5GHFBSKJ+cfPF2icxzE1Jfsyz5jBt4jo
         /FFsgCOc6MaEZsBFc2nW80G8KDNT8PQeXYFY0FJTeuZAre9XXskmZEV+uqxchyXa8xPt
         lQziLeN2F5UKDf9P8bRpNKSp9XsN1H73rEeuOyfyCJsKqemnG4a8hUxNnWdgOxRXaGW1
         EehE6kI1MQvqNNMNQw2AUByFMrRwKF6It2miizPnDcwqP2czWbxnmvKFqyeK4P+kdINN
         H+LNIA9WhSWPL41lL+Yj147ULzXO7R6+sgZ3CsIZuST2ObesCtOJLLdUUfX4g6++c6Qw
         1GqA==
X-Gm-Message-State: AOUpUlGSTp7tnq2FSTgXMnF1gEBamk7ukufSp4PUHsuSDoc7CWvOif9q
        k8p+sqoKbEhEtZNSIH2ueQ==
X-Google-Smtp-Source: AA+uWPxTfTLi1uQbM095Z0Ve08QtKZlc95fFF2hAjVdtvBzawOwAETnYZ/4ACiii7HFUFK1Fp16GKw==
X-Received: by 2002:aca:c257:: with SMTP id s84-v6mr16167966oif.104.1534788822132;
        Mon, 20 Aug 2018 11:13:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5-v6sm6302212oia.57.2018.08.20.11.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 11:13:41 -0700 (PDT)
Date:   Mon, 20 Aug 2018 13:13:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v4 4/7] i2c: designware: document MSCC Ocelot bindings
Message-ID: <20180820181341.GA982@bogus>
References: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
 <20180816084521.16289-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816084521.16289-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65663
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

On Thu, Aug 16, 2018 at 10:45:18AM +0200, Alexandre Belloni wrote:
> Document bindings for the Microsemi Ocelot integration of the Designware
> I2C controller.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

No need to re-spin just for the subject.

Reviewed-by: Rob Herring <robh@kernel.org>
