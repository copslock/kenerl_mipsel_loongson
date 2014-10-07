Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 18:21:42 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:39745 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010725AbaJGQVlSFf-w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 18:21:41 +0200
Received: by mail-ob0-f177.google.com with SMTP id uy5so5688241obc.36
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 09:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/S9ld/v9IRe2TGu1eVonTVy5PAK6Pny6Ukc3sN8k8Kk=;
        b=gqAFtE3lHXbH/A3RoVueMll07nzq2/QPVvfxLPvzjZ9XiKTXBAGBxAB5G5SYY5WO0t
         NJ3lbfjWLuayQfVcFVQ4b5v3qCq0lr2E/oc1aW2sDXLYsCFGySj/GkowcQMWWZiHU8pX
         v3FZGegnWirtyV6pnyPXPP6Pq7lLGG1O8Wy+WVqyXXNt6WbSME1naKZwDt6vQG3mhYJ7
         csp46gxjBFEgkxKDiA4kbmTH/OdaP/0KROJB3YVN+yHkQjmLfWRFtIVxEuBTAJuQeqmn
         1DGMYwnyjj3rmHqiDHLyA4pDBOWF5pPtWq2UR6FQGe7CJETQXE0FOVTKH/fKkrn9sB/r
         PeFQ==
X-Gm-Message-State: ALoCoQnfgd12oFH1zt8RCXEYBfzp1iCgg4GK7z0kG8yKSKypk1x2VAPgR/nXP/TUPXHvxAi5PN3t
X-Received: by 10.60.94.167 with SMTP id dd7mr5483036oeb.4.1412698892569;
        Tue, 07 Oct 2014 09:21:32 -0700 (PDT)
Received: from [192.168.1.12] (cpe-72-182-51-248.austin.res.rr.com. [72.182.51.248])
        by mx.google.com with ESMTPSA id h1sm12365224obw.21.2014.10.07.09.21.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 07 Oct 2014 09:21:31 -0700 (PDT)
Message-ID: <543412F7.8040909@landley.net>
Date:   Tue, 07 Oct 2014 11:21:11 -0500
From:   Rob Landley <rob@landley.net>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
CC:     adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 05/44] mfd: as3722: Drop reference to pm_power_off from
 devicetree bindings
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net> <1412659726-29957-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1412659726-29957-6-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43066
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
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

On 10/07/14 00:28, Guenter Roeck wrote:
> Devicetree bindings are supposed to be operating system independent
> and should thus not describe how a specific functionality is implemented
> in Linux.

So your argument is that linux/Documentation/devicetree/bindings should
not be specific to Linux. Merely hosted in the Linux kernel source
repository.

Well that's certainly a point of view.

Rob
